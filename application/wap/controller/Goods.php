<?php

namespace app\wap\controller;

use app\wap\validate\IDMustBePostiveInt;
use controller\BasicWap;
use think\Db;

/**
 * 商品信息接口
 * Class Goods
 * @package app\wap\controller\api
 * @author 伟彬 <277690572@qq.com>
 * @date: 2018/8/3 16:49
 */
class Goods extends BasicWap
{
    /**
     * 定义当前操作表名
     * @var string
     */
    public $table = 'ShopGoods';

    public function getGoodsByShop(){
        $get = $this->request->get();
        (new IDMustBePostiveInt())->goCheck($get);

        $db = Db::name($this->table);
        $shopWhere = array('id'=>$get['id'],'is_deleted'=>0);
        $shopSql = Db::name('ShopLocation')->field('id')->where($shopWhere)->buildSql(true);
        $db->where("shop_id = {$shopSql}");

        $cateWhere = array('is_deleted'=>0,'status'=>1);
        $cateSql = Db::name('ShopGoodsCate')->field('id')->where($cateWhere)->buildSql(true);
        $db->where("cate_id in {$cateSql}");

        $goodsWhere = array('is_deleted'=>0,'status'=>1);
        $goods = $db->field('id,cate_id,goods_title as name,selling_price as price,goods_desc as description,goods_logo as icon')->where($goodsWhere)->where('package_surp','GT', 0)->select();
        empty($goods) && $this->error('该门店没有商品信息');

        $cateIds = array_column($goods,'cate_id');
        $goodsWithCates = Db::name('ShopGoodsCate')->field('id,cate_title as name')->where("id", "in", $cateIds)->select();
        foreach ($goodsWithCates as $ck => $cv){
            foreach ($goods as $gk => $gv){
                if($gv['cate_id'] == $cv['id']){
                    $goodsWithCates[$ck]['foods'][] = $gv;
                }
            }
        }
        $this->success('success',$goodsWithCates);
    }

}