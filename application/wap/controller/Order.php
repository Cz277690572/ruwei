<?php

namespace app\wap\controller;

use app\wap\service\OrderService;
use app\wap\service\TokenService;
use app\wap\validate\IDMustBePostiveInt;
use app\wap\validate\OrderPlace;
use controller\BasicWap;
use think\Db;

/**
 * 门店订单接口
 * Class Order
 * @package app\wap\controller
 * @author 伟彬 <277690572@qq.com>
 * @date: 2018/8/6 11:13
 */
class Order extends BasicWap
{

    /**
     * 默认每次最多查询的数据量
     * @var int
     */
    protected $listNum = 50;

    /**
     * 通过门店id和会员id
     * 获取会员订单数据
     **/
    public function getOrders()
    {
        $params = app('request')->get();
        (new IDMustBePostiveInt())->goCheck($params);
        // 会员数据获取与检验
        $shop_id = $params['id'];
        $mid = TokenService::getCurrentUid();
        $orders = Db::name('ShopOrder')
            ->field('id,order_no,order_title,order_logo,goods_count,status,pay_price')
            ->where(['shop_id' => $shop_id, 'mid' => $mid, 'is_deleted' => 0])
            ->order('id','desc')
            ->limit(0,$this->listNum)
            ->select();
        empty($orders) && $this->error('没有订单数据');
        foreach ($orders as $k => $v) {
            $orders[$k]['status'] = config('shop.order_status')[$v['status']];
        }
        $this->success('success', $orders);
    }

    /**
     * 通过订单id和会员id
     * 获取订单详情
     */
    public function getDetail()
    {
        $params = app('request')->get();
        (new IDMustBePostiveInt())->goCheck($params);
        $id  = $params['id'];
        $mid = TokenService::getCurrentUid();
        $detail = Db::name('ShopOrder')
            ->field('o.*,e.express_username,e.express_phone,e.express_province,
                e.express_city,e.express_area,e.express_address,e.send_username,
                e.send_phone,e.send_province,e.send_city,e.send_area,
                e.send_address,e.send_at')
            ->alias('o')
            ->join(['shop_order_express e'], 'e.order_no=o.order_no')
            ->where(['o.id' => $id, 'o.mid' => $mid, 'o.is_deleted' => 0])
            ->find();
        empty($detail) && $this->error('订单信息不存在');
        $goodsList = Db::name('ShopOrderGoods')
            ->field('goods_title as name, goods_logo as icon, selling_price as price, number as count')
            ->where('order_no',$detail['order_no'])
            ->select();
        $detail['goodsList'] = $goodsList;
        $detail['status'] = config('shop.order_status')[$detail['status']];
        $this->success('success', $detail);
    }

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

    /**
     * 通过订单id和会员Id
     * 确认收货
     */
    public function receive()
    {
        $params = app('request')->post();
        (new IDMustBePostiveInt())->goCheck($params);
        $id  = $params['id'];
        $mid = TokenService::getCurrentUid();

        $order = Db::name('ShopOrder')
            ->field('status')
            ->where(['id' => $id, 'mid' => $mid, 'is_deleted' => 0])
            ->find();
        empty($order) && $this->error('不存在的订单');

        if($order['status'] != config('shop.delivered'))
        {
            $this->error('还没发货呢，想干嘛？ 或者你已经更新过订单了，不要再刷了');
        }
        $status = config('shop.received');
        $result = Db::name('ShopOrder')
            ->where(['id' => $id, 'mid' => $mid])
            ->update(['status' => $status]);
        empty($result) && $this->error('确认收货失败,请刷新重试！');
        $this->success('success');
    }
}