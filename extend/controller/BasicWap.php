<?php

namespace controller;

use service\ToolsService;

/**
 * 手机接口基础控制器
 * Class BasicWap
 * @package controller
 * @author 伟彬 <277690572@qq.com>
 * @date: 2018/8/3 16:52
 */
class BasicWap
{

    /**
     * 当前请求对象
     * @var \think\Request
     */
    protected $request;

    /**
     * 构造方法
     * BasicApi constructor.
     */
    public function __construct()
    {
        ToolsService::corsOptionsHandler();
        $this->request = app('request');
    }

    /**
     * 返回成功的操作
     * @param mixed $msg 消息内容
     * @param array $data 返回数据
     * @param integer $code 返回代码
     */
    protected function success($msg, $data = [], $code = 1)
    {
        ToolsService::success($msg, $data, $code);
    }

    /**
     * 返回失败的请求
     * @param mixed $msg 消息内容
     * @param array $data 返回数据
     * @param integer $code 返回代码
     */
    protected function error($msg, $data = [], $code = 0)
    {
        ToolsService::error($msg, $data, $code);
    }

}