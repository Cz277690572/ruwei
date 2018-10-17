<?php

namespace app\wap\service;
use service\WechatService;
use think\Db;
use WeChat\Pay;

/**
 * 微信支付数据服务
 * Class WxPayService
 * @package app\wap\service
 * @author 伟彬 <277690572@qq.com>
 * @date: 2018/9/3 9:31
 */
class WxPayService
{
    protected $order;
    protected $shop;
    protected $orderId;
    protected $orderNo;
    protected $out_trade_no;

    public function __construct($orderId)
    {
        if ($orderId)
        {
            $this->orderId = $orderId;
        }
        else
        {
            $this->orderId = null;
        }
    }

    public function pay()
    {
        //订单号可能根本就不存在
        //订单号确实是存在的，但是，订单号和当前用户是不匹配的
        //订单有可能已经被支付过了
        //进行库存量,订单商品价格是否变动检测
        $oStatus = $this->checkOrderValid();
        if (!$oStatus['code'])
        {
            return $oStatus;
        }

        $order = new OrderService();
        $oStockStatus = $order->checkOrderStock($this->orderId);

        if(!$oStockStatus['code'])
        {
            return $oStockStatus;
        }

        if($oStockStatus['goodsPrice'] != $this->order['real_price'])
        {
            return ['code' => 0, 'msg' => '订单中的商品价格已更新，请重新下单，避免错过优惠！'];
        }
        $this->out_trade_no = OrderService::makeOrderNo();
        // 获取微信预支付订单参数，返回前端
        return $this->makeWxPreOrder();
    }

    private function makeWxPreOrder()
    {

        // 公众账号ID	appid
        // 商户号	    mch_id
        // 随机字符串	nonce_str
        // 签名	        sign
        // 签名类型	    sign_type
        // 商品描述	    body
        // 商户订单号	out_trade_no
        // 标价金额	    total_fee
        // 用户标识	    openid
        // 终端IP	    spbill_create_ip
        // 通知地址	    notify_url
        // 交易类型	    trade_type
        $wechat = new Pay(config('wechat.'));
        $openid = TokenService::getCurrentTokenVar('openid');
        $options = [
            'body'             => $this->shop['title'],
            'out_trade_no'     => $this->out_trade_no,
            'total_fee'        => $this->order['real_price']*100,
            'openid'           => $openid,
            'trade_type'       => 'JSAPI',
            'notify_url'       => config('shop.pay_back_url'),
            'spbill_create_ip' => request()->ip(),
        ];
        // 生成预支付订单
        $result = $wechat->createOrder($options);
        if($result['return_code'] !== 'SUCCESS'){
            return ['code' => 0, 'msg' => '支付异常，请稍后重试！'];
        }
        // 记录统一下单接口返回的prepay_id参数值
        $this->recordPreOrder($result['prepay_id']);
        // 创建JSAPI参数签名
        $options = $wechat->createParamsForJsApi($result['prepay_id']);
        $optionJSON = json_encode($options, JSON_UNESCAPED_UNICODE);
        // JSSDK 签名配置
        $configJSON = json_encode(WechatService::webJsSDK(), JSON_UNESCAPED_UNICODE);

        return ['code' => 1, 'msg' => '获取已支付订单成功', 'data' => ['configJSON' => $configJSON, 'optionJSON' => $optionJSON]];
    }

    // 记录预支付订单参数
    private function recordPreOrder($prepay_id)
    {
        Db::name('ShopOrder')
            ->where('id','=', $this->orderId)
            ->update(['pay_no' => $prepay_id, 'pay_at' => date('Y-m-d H:i:s'), 'out_trade_no' => $this->out_trade_no]);
    }

    private function checkOrderValid()
    {
        $this->order = Db::name('ShopOrder')
            ->where(['id' => $this->orderId])
            ->find();
        if (!$this->order)
        {
            return ['code' => 0, 'msg' => '不存在的订单id'];
        }
        if (!TokenService::isValidOperate($this->order['mid']))
        {
            return ['code' => 0, 'msg' => '订单与用户不匹配'];
        }
        if ($this->order['status'] != config('shop.unpaid'))
        {
            return ['code' => 0, 'msg' => '该订单已经支付过了！'];
        }
        $this->orderNo = $this->order['order_no'];
        $this->shop    = Db::name('ShopLocation')
                    ->field('title')
                    ->where(['id' => $this->order['shop_id']])
                    ->find();
        return ['code' => 1, 'msg' => '订单状态检测通过！'];
    }

}