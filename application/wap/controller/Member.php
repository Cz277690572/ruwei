<?php

namespace app\wap\controller;

use app\wap\service\TokenService;
use controller\BasicWap;
use think\Db;

/**
 * 门店会员信息接口
 * Class Member
 * @package app\wap\controller
 * @author 伟彬 <277690572@qq.com>
 * @date: 2018/8/6 11:21
 */
class Member extends BasicWap
{
    public function getAddress()
    {
        $mid = TokenService::getCurrentUid();
        $address = Db::name('ShopMemberAddress')
            ->where(['mid' => $mid, 'status' => 1, 'is_deleted' => 0, 'is_default' => 1])
            ->find();
        empty($address) && $this->error('没有收货地址');
        $this->success('success', $address);
    }
}