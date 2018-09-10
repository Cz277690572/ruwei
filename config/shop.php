<?php
/**
 * @author 伟彬 <277690572@qq.com>
 * @date: 2018/8/31 9:20
 */

return [

    // 门店会员默认收货地址省市区
    'express_province' => '广东省',
    'express_city' => '深圳市',
    'express_area' => '南山区',

    // 门店订单状态
    'order_status' => [
        0 => '订单已失效',
        1 => '未支付',
        2 => '已付款',
        3 => '已发货',
        4 => '已收货',
        5 => '订单已完成'
    ],
    // 待支付
    'unpaid' => 1,
    // 已支付
    'paid' => 2,
    // 已发货
    'delivered' => 3,
    // 已收货
    'received' => 4,
    // 已支付，但库存不足
    'paid_but_out_of' => 8,
    // 支付方式
    'pay_type' => 'wechat微信支付',

    // 微信授权设置，微信使用code换取用户openid
    'login_url' => 'https://api.weixin.qq.com/sns/oauth2/access_token?appid=%s&secret=%s&code=%s&grant_type=authorization_code',
    'get_userinfo_url' => 'https://api.weixin.qq.com/sns/userinfo?access_token=%s&openid=%s&lang=zh_CN',
    'token_expire_in' => 7200,
    'token_salt' => 'XIA_LANG_XIAO_YUAN',

    // 微信支付回调接口Url地址
    'pay_back_url' => 'http://xialangschool.cn/wap/notify/receiveNotify.html',
];
