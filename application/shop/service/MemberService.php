<?php

namespace app\shop\service;

use service\DataService;

/**
 * 会员数据初始化
 * Class MemberService
 * @package app\shop\service
 */
class MemberService
{
    /**
     * 创建会员数据
     * @param array $data 会员数据
     * @return bool
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     */
    public static function create($data)
    {
        return DataService::save('ShopMember', $data, 'id');
    }
}