<?php

namespace app\wap\validate;

use validate\BasicValidate;

/**
 * 参数id验证类
 * Class IDMustBePostiveInt
 * @package app\wap\validate
 * @author 伟彬 <277690572@qq.com>
 * @date: 2018/8/3 18:29
 */
class IDMustBePostiveInt extends BasicValidate
{
    protected $rule = [
        'id' => 'require|isPositiveInteger',
    ];

    protected $message=[
        'id' => 'id必须是正整数'
    ];
}