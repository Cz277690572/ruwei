<?php

namespace app\wap\controller;

use app\wap\service\OrderService;
use app\wap\service\TokenService;
use app\wap\validate\OrderPlace;
use controller\BasicWap;

/**
 * 门店订单接口
 * Class Order
 * @package app\wap\controller
 * @author 伟彬 <277690572@qq.com>
 * @date: 2018/8/6 11:13
 */
class Order extends BasicWap
{
    // 下订单
    public function placeOrder(){

        // 会员数据获取与检验
        $mid = TokenService::getCurrentUid();

        // 接受订单数据
        $params = app('request')->post();

        // 数据校验
        (new OrderPlace())->goCheck($params);

        // 生成订单数据
        $result = (new OrderService())->place($mid, $params);

        if($result['code'])
        {
            $this->success($result['msg'], $result['data']);
        }
        else
        {
            $this->error($result['msg']);
        }
    }


}