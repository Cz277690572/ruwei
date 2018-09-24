<?php

namespace app\wap\controller;

use app\wap\service\MemTokenService;
use app\wap\service\TokenService;
use app\wap\validate\TokenGet;
use app\wap\validate\TokenVerify;
use service\ToolsService;
use think\Controller;

/**
 * 用户令牌
 * Class Token
 * @package app\wap\controller
 * @author 伟彬 <277690572@qq.com>
 * @date: 2018/8/13 10:14
 */
class Token extends Controller
{

    public function getToken(){
        $params = app('request')->get();
        (new TokenGet())->goCheck($params);
        $member = new MemTokenService($params['code']);
        $data['token'] = $member->get();
        $this->success('success',$data);
//        $this->redirect('http://localhost:8080/#/shopList?token='.$data['token'].'&msg=success');
    }

    public function getUid(){
        $uid = TokenService::getCurrentUid();
        $data['uid'] = $uid;
        $this->ok('success',$data);
    }

    public function verify()
    {
        $params = app('request')->post();
        (new TokenVerify())->goCheck($params);
        $res = TokenService::verifyToken($params['token']);
        empty($res) && $this->no('无效token');
        $this->ok('有效token');
    }

    /**
     * 返回成功的操作
     * @param mixed $msg 消息内容
     * @param array $data 返回数据
     * @param integer $code 返回代码
     */
    public function ok($msg, $data = [], $code = 1)
    {
        ToolsService::success($msg, $data, $code);
    }

    /**
     * 返回失败的请求
     * @param mixed $msg 消息内容
     * @param array $data 返回数据
     * @param integer $code 返回代码
     */
    public function no($msg, $data = [], $code = 0)
    {
        ToolsService::error($msg, $data, $code);
    }
}