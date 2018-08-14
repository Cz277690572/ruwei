<?php

namespace app\wap\validate;

use validate\BasicValidate;

/**
 * 参数code校验类
 * Class TokenGet
 * @package app\wap\validate
 * @author 伟彬 <277690572@qq.com>
 * @date: 2018/8/13 10:30
 */
class TokenGet extends BasicValidate
{
    protected $rule = [
        'code' => 'require|isNotEmpty',
    ];

    protected $message = [
        'code' => '必须传入code,才能获取token！',
    ];
}