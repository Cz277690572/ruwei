<?php

namespace app\wap\service;

use service\WechatService;
use think\Db;
/**
 * 消息通知服务类
 * Class NoticeService
 * @package app\wap\service
 * @author 伟彬 <277690572@qq.com>
 * @date: 2018/10/17 12:03
 */
class NoticeService
{
    public function send($order)
    {
        if(!$order){
            return false;
        }

        $orderGoods = Db::name('ShopOrderGoods')
            ->field('goods_title,number')
            ->where('order_id','=', $order['id'])
            ->select();
        $orderExpress = Db::name('ShopOrderExpress')
            ->alias('e')
            ->join('shop_location l','e.shop_id=l.id')
            ->join('shop_member m', 'e.mid=m.id')
            ->field('e.express_username, e.express_phone, e.express_address, l.title, m.openid')
            ->where('e.order_id','=', $order['id'])
            ->find();
        $shopAccount = Db::name('ShopAccount')
            ->field('location_openid,delivery_openid')
            ->where(['shop_id' => $order['shop_id']])
            ->find();
        $sendData = array();
        $sendData['goods'] = '';
        foreach ($orderGoods as $gk => $gv){
            $sendData['goods'] .= $gv['goods_title'].'x'.$gv['number'].',';
        }
        $sendData['goods'] = rtrim($sendData['goods'],',');
        $sendData['member_openid'] = $orderExpress['openid'];
        $sendData['location_openid'] = empty($shopAccount['location_openid']) ? "" : $shopAccount['location_openid'];
        $sendData['delivery_openid'] = empty($shopAccount['delivery_openid']) ? "" : $shopAccount['delivery_openid'];
        $sendData['location_title'] = $orderExpress['title'];
        $sendData['location_id'] = $order['shop_id'];
        $sendData['order_no'] = $order['order_no'];
        $sendData['order_price'] = $order['real_price'];
        $sendData['order_desc'] = "收货人:".$orderExpress['express_username'].",联系电话:".$orderExpress['express_phone'].",地址:".$orderExpress['express_address'];
        if($order['desc']){
            $sendData['order_desc'] .= ",备注:".$order['desc'];
        }else{
            $sendData['order_desc'] .= ",备注:无";
        }

        if(!empty($sendData['location_openid'])){
            $this->sendSeller($sendData);
        }
        if(!empty($sendData['member_openid'])){
            $this->sendMember($sendData);
        }
        if(!empty($sendData['delivery_openid'])){
            $this->sendDelivery($sendData);
        }
        $this->sendAdmin($sendData);
    }

    // 发送订单通知给商家
    protected function sendSeller($sendData)
    {
        $data = array(
            "touser" => $sendData['location_openid'],
            "template_id" => "0G-qVpD8X7YtGBhMd11CH4Xj8PZok9N4g8DXFGYp5xk",
            "url" => "http://www.xialangschool.cn/food",
            "miniprogram" => array(
                "appid" => "",
                "pagepath" => ""
            ),
            "data" => array(
                "first" => array(
                    "value" => "您好，您有新的订单通知！",
                    "color" => "#173177"
                ),
                "keyword1" => array(
                    "value" =>  date('Y-m-d H:i:s'),
                    "color" => "#173177"
                ),
                "keyword2" => array(
                    "value" => $sendData['goods'],
                    "color" => "#173177"
                ),
                "keyword3" => array(
                    "value" => $sendData['order_no'],
                    "color" => "#173177"
                ),
                "remark" => array(
                    "value" => $sendData['order_desc'],
                    "color" => "#173177"
                )
            )
        );
        $res = WechatService::WeChatTemplate()->send($data);
        print_r($res);
    }

    // 发送订单通知给派送员
    protected function sendDelivery($sendData){
        $data = array(
            "touser" => $sendData['delivery_openid'],
            "template_id" => "0G-qVpD8X7YtGBhMd11CH4Xj8PZok9N4g8DXFGYp5xk",
            "url" => "http://www.xialangschool.cn/food",
            "miniprogram" => array(
                "appid" => "",
                "pagepath" => ""
            ),
            "data" => array(
                "first" => array(
                    "value" => "您好，您有新的订单通知！",
                    "color" => "#173177"
                ),
                "keyword1" => array(
                    "value" =>  date('Y-m-d H:i:s'),
                    "color" => "#173177"
                ),
                "keyword2" => array(
                    "value" => $sendData['goods'],
                    "color" => "#173177"
                ),
                "keyword3" => array(
                    "value" => $sendData['order_no'],
                    "color" => "#173177"
                ),
                "remark" => array(
                    "value" => $sendData['order_desc'],
                    "color" => "#173177"
                )
            )
        );
        $res = WechatService::WeChatTemplate()->send($data);
    }

    // 发送订单通知给管理员
    protected function sendAdmin($sendData)
    {
        $data = array(
            "touser" => "oNRCb1aQKm3_LjDD79yIkuZObh5Q",
            "template_id" => "0G-qVpD8X7YtGBhMd11CH4Xj8PZok9N4g8DXFGYp5xk",
            "url" => "http://www.xialangschool.cn/food",
            "miniprogram" => array(
                "appid" => "",
                "pagepath" => ""
            ),
            "data" => array(
                "first" => array(
                    "value" => "您好，您有新的订单通知！",
                    "color" => "#173177"
                ),
                "keyword1" => array(
                    "value" =>  date('Y-m-d H:i:s'),
                    "color" => "#173177"
                ),
                "keyword2" => array(
                    "value" => $sendData['goods'],
                    "color" => "#173177"
                ),
                "keyword3" => array(
                    "value" => $sendData['order_no'],
                    "color" => "#173177"
                ),
                "remark" => array(
                    "value" => $sendData['order_desc'],
                    "color" => "#173177"
                )
            )
        );
        $res = WechatService::WeChatTemplate()->send($data);
    }

    // 发送订单通知给下单用户
    protected function sendMember($sendData)
    {
        $data = array(
            "touser" => $sendData['member_openid'],
            "template_id" => "7TNr7H0ija2SfN3ZWCMsPFIBR3Va4R6KZWHXT09sJUg",
            "url" => "http://www.xialangschool.cn/food",
            "miniprogram" => array(
                "appid" => "",
                "pagepath" => ""
            ),
            "data" => array(
                "first" => array(
                    "value" => "您好，您的订单已支付成功！",
                    "color" => "#173177"
                ),
                "keyword1" => array(
                    "value" => $sendData['order_no'],
                    "color" => "#173177"
                ),
                "keyword2" => array(
                    "value" => $sendData['order_price'],
                    "color" => "#173177"
                ),
                "keyword3" => array(
                    "value" => $sendData['location_title'],
                    "color" => "#173177"
                ),
                "keyword4" => array(
                    "value" => date('Y-m-d H:i:s'),
                    "color" => "#173177"
                ),
                "remark" => array(
                    "value" => "点击查看门店信息",
                    "color" => "#173177"
                )
            )
        );
        $res = WechatService::WeChatTemplate()->send($data);
    }
}