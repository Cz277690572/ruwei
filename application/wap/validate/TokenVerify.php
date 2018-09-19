<?php

namespace app\wap\validate;

use validate\BasicValidate;

/**
 * 参数token校验类
 * Class TokenVerify
 * @package app\wap\validate
 * @author 伟彬 <277690572@qq.com>
 * @date: 2018/8/13 10:30
 */
class TokenVerify extends BasicValidate
{
    protected $rule = [
        'token' => 'require|isNotEmpty',
    ];

    protected $message = [
        'token' => '必须传入token,才能校验！',
    ];
}