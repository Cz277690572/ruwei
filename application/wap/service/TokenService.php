<?php

namespace app\wap\service;

use think\exception\HttpResponseException;
use think\facade\Cache;
use think\Response;

/**
 * token令牌基类
 * Class TokenService
 * @package app\wap\service
 * @author 伟彬 <277690572@qq.com>
 * @date: 2018/8/13 15:14
 */
class TokenService
{

    public static function generateToken()
    {
        // 32个字符组成一组随机字符串
        $randChars = getRandChar(32);
        // 用三组字符串，进行MD5加密
        $timestamp = $_SERVER['REQUEST_TIME_FLOAT'];
        // salt 盐
        $salt = config('wechat.token_salt');
        return md5($randChars.$timestamp.$salt);
    }

    public static function getCurrentUid()
    {
        // token
        $uid = self::getCurrentTokenVar('uid');
        return $uid;
    }

    public static function getCurrentTokenVar($key){
        $token = app('request')->header('token');
        $vars =  Cache::get($token);

        if(!$vars){
            self::error('token已过期或无效！','',403);
        }
        else{
            if(!is_array($vars))
            {
                $vars = json_decode($vars, true);
            }
            if (array_key_exists($key, $vars))
            {
                return $vars[$key];
            }
            else{
                self::error('尝试获取的Token变量不存在！','',403);
            }
        }
    }

    /**
     * Cors Request Header信息
     * @return array
     */
    public static function corsRequestHander()
    {
        return [
            'Access-Control-Allow-Origin'      => request()->header('origin', '*'),
            'Access-Control-Allow-Methods'     => 'GET,POST,OPTIONS',
            'Access-Control-Allow-Credentials' => "true",
        ];
    }

    /**
     * 返回成功的操作
     * @param mixed $msg 消息内容
     * @param array $data 返回数据
     * @param integer $code 返回代码
     */
    public static function success($msg, $data = [], $code = 1)
    {
        $result = ['code' => $code, 'msg' => $msg, 'data' => $data, 'token' => encode(session_name() . '=' . session_id())];
        throw new HttpResponseException(Response::create($result, 'json', 200, self::corsRequestHander()));
    }

    /**
     * 返回失败的请求
     * @param mixed $msg 消息内容
     * @param array $data 返回数据
     * @param integer $code 返回代码
     */
    public static function error($msg, $data = [], $code = 0)
    {
        $result = ['code' => $code, 'msg' => $msg, 'data' => $data, 'token' => encode(session_name() . '=' . session_id())];
        throw new HttpResponseException(Response::create($result, 'json', 200, self::corsRequestHander()));
    }
}