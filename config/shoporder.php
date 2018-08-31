<?php
/**
 * 订单状态
 * @author 伟彬 <277690572@qq.com>
 * @date: 2018/8/31 18:22
 */

return [
    // 待支付
    'unpaid' => 1,

	// 已支付
    'paid' => 2,

	// 已发货
    'delivered' => 3,

    // 已收货
    'received' => 4,

	// 已支付，但库存不足
    'paid_but_out_of' => 8
];