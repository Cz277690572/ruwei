<?php

namespace app\wap\controller;

use app\wap\service\OrderService;
use think\Db;
use think\Exception;
use WeChat\Pay;
/**
 * 支付回调处理
 * Class WxNotify
 * @package app\wap\controller
 * @author 伟彬 <277690572@qq.com>
 * @date: 2018/9/4 11:57
 */
class Notify
{

    public function receiveNotify()
    {
        echo '1111';
        P('1111');
        $wechat = new Pay(config('wechat.'));
        $result = $wechat->getNotify();
        P($result);
        // 库存充足，更新订单状态，扣库存
        // 库存不足，更新订单状态，增加库存扣除异常记录
        if($result['return_code'] == 'SUCCESS')
        {
            Db::startTrans();
            try{
                $order = Db::name('ShopOrder')
                    ->where('order_no', '=', $result['out_trade_no'])
                    ->find();

                if($order['status'] == config('shop.unpaid')){
                    $oService = new OrderService();
                    $oStockStatus = $oService->checkOrderStock($order['id']);
                    if($oStockStatus['code'] == 1)
                    {
                        $this->updateOrderStatus($order['id'], config('shop.paid'));
                        $this->reduceStock($oStockStatus['gStatusArray']);
                    }
                    else{
                        $this->updateOrderStatus($order['id'], config('shop.paid'));
                        $this->recordOrderStock($order['id'], $order['order_no'], '订单已支付，但是库存不足!');
                    }
                }
                Db::commit();
                return true;
            }
            catch (Exception $e)
            {
                Db::rollback();
                return false;
            }
        }
        else
        {
            return true;
        }

    }

    // 记录订单中的商品库存异常
    private function recordOrderStock($orderId, $orderNo, $desc)
    {
        $data['order_id'] = $orderId;
        $data['order_no'] = $orderNo;
        $data['desc']     = $desc;
        Db::name('ShopOrderStock')->insert($data);
    }

    // 减库存
    private function reduceStock($goodsList)
    {
        foreach ($goodsList as $goods)
        {
            Db::name('ShopGoods')
                ->where('id','=', $goods['id'])
                ->inc('package_sale', $goods['counts'])
                ->dec('package_surp', $goods['counts'])
                ->update();
        }
    }

    // 更新订单状态
    private function updateOrderStatus($orderId, $status)
    {
        Db::name('ShopOrder')
            ->where('id','=', $orderId)
            ->update(['status' => $status]);
    }
}