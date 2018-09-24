<?php

namespace app\wap\service;

use service\HttpService;
use think\Db;

/**
 * 会员数据服务
 * Class MemTokenService
 * @package app\wap\service
 * @author 伟彬 <277690572@qq.com>
 * @date: 2018/8/13 10:58
 */
class MemTokenService extends TokenService
{
    protected $code;
    protected $appId;
    protected $appSecret;
    protected $wxLoginUrl;

    public function __construct($code)
    {
        $config = Db::name('SystemConfig')->column('name,value');
        if($config){
            $this->code = $code;
            $this->appId = $config['wechat_appid'];
            $this->appSecret = $config['wechat_appsecret'];
            $this->wxLoginUrl = sprintf(config('shop.login_url'),
                $this->appId,$this->appSecret,$this->code);
        }
    }

    public function get(){
        $result = HttpService::get($this->wxLoginUrl);
//        $wxResult = Array
//        (
//            'access_token' => '12_xjDp7R8BKra4EpGasgQkoLOZkHHDLJEYSlI12yhJR_NErx5WbsJOwAc4U-o6X3gmRrLlfxgTs7DGx6lkE8NYSw',
//            'expires_in' => 7200,
//            'refresh_token' => '12_NJnkE3Qp7cUuRJE3fB8O3Vf6qpBiCuuzsX8OUWyl2euBiFHBsszeFzk_ZjVMRQWTz3K5hhF_k3G3jOSz4v6e2g',
//            'openid' => 'oh-1x53M44u2IBwy0POJ9Fck-Rpc',
//            'scope' => 'snsapi_base '//'snsapi_userinfo'
//        );
        $wxResult = json_decode($result,true);
        if(empty($wxResult)){
            $this->error('获取openId异常，请刷新重试！');
        }
        else
        {
            if(!empty($wxResult['errcode'])){
                $this->error($wxResult['errmsg']);
            }
            else
            {
                if($wxResult['scope'] == 'snsapi_userinfo')
                {
                    // 通过access_token和openid获取用户详细信息
//                    $getUserInfoUrl = 'https://api.weixin.qq.com/sns/userinfo?access_token='.$wxResult['access_token'].'&openid='.$wxResult['openid'].'&lang=zh_CN';
                    $getUserInfoUrl = sprintf(config('shop.get_userinfo_url'), $wxResult['access_token'], $wxResult['openid']);
                    $uInfoJSON = HttpService::get($getUserInfoUrl);
                    $uInfoARR  = json_decode($uInfoJSON, true);
                    if(!empty($uInfoARR['errcode']))
                    {
                        $this->error('获取用户信息异常，请刷新重试！');
                    }
                    else{
                        return $this->grantToken($uInfoARR);
                    }
                }
                else
                {
                    return $this->grantToken($wxResult);
                }
            }
        }
    }

    private function grantToken($wxResult){
        // 拿到openid
        // 数据库里查看一下，这个openid是不是已经存在
        // 如果存在 则不处理，如果不存在那么新增一条user记录
        // 生成令牌，准备缓存数据，写入缓存
        // 把令牌返回到客户端去
        // key: 令牌
        // value: wxResult,uid,scope
        $openid = $wxResult['openid'];
        $member = (array)Db::name('shop_member')->where(['openid'=>$openid])->find();
        if($member){
            $uid = $member['id'];
        }else{
            $data['openid'] = $openid;
            isset($wxResult['nickname']) && $data['nickname'] = $wxResult['nickname'];
            isset($wxResult['sex']) && $data['sex'] = $wxResult['sex'];
            isset($wxResult['unionid']) && $data['unionid'] = $wxResult['unionid'];
            isset($wxResult['headimgurl']) && $data['headimg'] = $wxResult['headimgurl'];
            $uid = Db::name('shop_member')->insertGetId($data);
        }
        $cachedValue = $this->prepareCachedValue($wxResult, $uid);
        $token = $this->saveToCache($cachedValue);
        return $token;
    }

    // 写入缓存
    private function saveToCache($cachedValue){
        $key = self::generateToken();
        $value = json_encode($cachedValue);
        $expire_in = config('shop.token_expire_in');
        $request = cache($key, $value, $expire_in);
        if(!$request){
            $this->error('服务器缓存异常');
        }
        return $key;
    }

    // 准备缓存数据
    private function prepareCachedValue($wxResult, $uid){
        $cachedValue = $wxResult;
        $cachedValue['uid'] = $uid;
        return $cachedValue;
    }


}