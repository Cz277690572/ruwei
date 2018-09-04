<?php

namespace app\wap\controller;

use app\wap\service\WxPayService;
use app\wap\validate\IDMustBePostiveInt;
use controller\BasicWap;

/**
 * 发起订单支付
 * Class Pay
 * @package app\shop\controller
 * @author 伟彬 <277690572@qq.com>
 * @date: 2018/8/31 20:18
 */
class Pay extends BasicWap
{

    public function getPreOrder()
    {

        // 获取订单id参数，参数校验
        // 通过订单id查找订单数据
        // 根据订单商品数据，进行商品库存检测
        // 生成支付参数，返回前端
        // 前端拉起支付
        $params = app('request')->post();
        (new IDMustBePostiveInt())->goCheck($params);

        $wxPay = new WxPayService($params['id']);

        $result = $wxPay->pay();
        empty($result['code']) && $this->error($result['msg']);
        $this->success($result['msg'], $result['data']);
    }
}