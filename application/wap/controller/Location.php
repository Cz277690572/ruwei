<?php

namespace app\wap\controller;

use app\wap\validate\IDMustBePostiveInt;
use controller\BasicWap;
use think\Db;

/**
 * 门店信息查询接口
 * Class Location
 * @package app\wap\controller\api
 * @author 伟彬 <277690572@qq.com>
 * @date: 2018/8/3 16:58
 */
class Location extends BasicWap
{
    /**
     * 定义当前操作表名
     * @var string
     */
    public $table = 'ShopLocation';

    public function getShops(){
        $shops = Db::name($this->table)->where(['is_deleted' => '0'])->select();
        empty($shops) && $this->error('请求的门店不存在！');
        foreach ($shops as $key => $val)
        {
            $shops[$key]['scene'] = explode('|', $val['scene']);
            $shops[$key]['status'] = config('shop.shop_status')[$val['status']];
        }
        $this->success('success',$shops);
    }

    public function getShopById(){
        $get = $this->request->get();
        (new IDMustBePostiveInt())->goCheck($get);
        $shop = Db::name($this->table)->where(['id'=>$get['id'],'is_deleted' => '0','status'=>1])->find();
        empty($shop) && $this->error('请求的门店不存在！');
        $shop['scene'] = explode('|',$shop['scene']);
        $this->success('success',$shop);
    }

}