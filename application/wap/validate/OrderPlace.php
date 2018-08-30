<?php

namespace app\wap\validate;

use validate\BasicValidate;

/**
 * 文件说明
 * Class OrderPlace
 * @package app\wap\validate
 * @author 伟彬 <277690572@qq.com>
 * @date: 2018/8/30 14:26
 */
class OrderPlace extends BasicValidate
{
    protected $rule = [
        'username' => 'require',
        'phone' => 'require|isPhone',
        'address' => 'require',
        'goods' => 'require|_checkGoods'
    ];

    protected $message = [
        'username' => '联系人不能为空!',
        'phone' => '手机号码格式错误！',
        'address' => '收货地址不能为空！',
        'goods' => '商品列表参数错误！'
    ];

    protected $singleRule = [
        'goods_id' => 'require|isPositiveInteger',
        'count' => 'require|isPositiveInteger'
    ];

    protected function _checkGoods($values)
    {
        if(!is_array($values) || empty($values))
        {
            return false;
        }

        foreach ($values as $value)
        {
            $result = $this->_checkGood($value);
            if(!$result)
            {
                return $result;
            }
        }
        return true;
    }

    protected function _checkGood($value)
    {
        $validate = new BasicValidate($this->singleRule);
        $result = $validate->check($value);
        return $result;
    }



}