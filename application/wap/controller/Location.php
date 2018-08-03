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

    public function index(){

    }

    public function getShop(){

        $get = $this->request->get();
        (new IDMustBePostiveInt())->goCheck($get);
        $shop = Db::name($this->table)->where(['id'=>$get['id'],'is_deleted' => '0','status'=>1])->find();
        empty($shop) && $this->error('请求的门店不存在！');
        $this->success('success',$shop);
    }

    public function getGoodsByShop(){
        $get = $this->request->get();
        (new IDMustBePostiveInt())->goCheck($get);

        $shop = Db::name($this->table)->where(['id'=>$get['id'],'is_deleted' => '0','status'=>1])->select();
        empty($shop) && $this->error('请求的门店不存在！');
        $this->success('success',$shop);

//        $get = $this->request->get();
//        $db = Db::name($this->table)->where(['is_deleted' => '0']);
//        if (isset($get['tags_id']) && $get['tags_id'] !== '') {
//            $db->whereLike('tags_id', "%,{$get['tags_id']},%");
//        }
//        if (isset($get['goods_title']) && $get['goods_title'] !== '') {
//            $db->whereLike('goods_title', "%{$get['goods_title']}%");
//        }
//        foreach (['cate_id', 'brand_id'] as $field) {
//            (isset($get[$field]) && $get[$field] !== '') && $db->where($field, $get[$field]);
//        }
//        if (isset($get['create_at']) && $get['create_at'] !== '') {
//            list($start, $end) = explode(' - ', $get['create_at']);
//            $db->whereBetween('create_at', ["{$start} 00:00:00", "{$end} 23:59:59"]);
//        }
//        return parent::_list($db->order('status desc,sort asc,id desc'));
    }
}