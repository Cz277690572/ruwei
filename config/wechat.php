<?php

// +----------------------------------------------------------------------
// | ThinkAdmin
// +----------------------------------------------------------------------
// | 版权所有 2014~2017 广州楚才信息科技有限公司 [ http://www.cuci.cc ]
// +----------------------------------------------------------------------
// | 官方网站: http://think.ctolog.com
// +----------------------------------------------------------------------
// | 开源协议 ( https://mit-license.org )
// +----------------------------------------------------------------------
// | github开源项目：https://github.com/zoujingli/ThinkAdmin
// +----------------------------------------------------------------------

return [
    'service_url' => 'https://service.thinkadmin.top',
    // 下面参数用作微信支付
    'appid'       => 'wx60a43dd8161666d4',
    'mch_id'      => '1332187001',
    'mch_key'     => 'A82DC5BD1F3359081049C568D8502BC5',

    // 微信使用code换取用户openid
    'login_url' => 'https://api.weixin.qq.com/sns/oauth2/access_token?appid=%s&secret=%s&code=%s&grant_type=authorization_code',
    'token_expire_in' => 7200,
    'token_salt' => 'XIA_LANG_XIAO_YUAN',
];