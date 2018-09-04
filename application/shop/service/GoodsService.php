<?php

namespace app\shop\service;

use think\Db;

/**
 * 商品数据服务支持
 * Class ProductService
 * @package app\goods\service
 */
class GoodsService
{

    /**
     * 主商品表数据处理
     * @param array $goodsList
     * @return array
     */
    public static function buildGoodsList(&$goodsList)
    {
        // 商品分类处理
        $cateField = 'id,pid,cate_title,cate_desc';
        $cateWhere = ['status' => '1', 'is_deleted' => '0'];
        $cateList = Db::name('ShopGoodsCate')->where($cateWhere)->order('sort asc,id desc')->column($cateField);
        // 商品门店处理
        $shopWhere = ['status' => '1', 'is_deleted' => '0'];
        $shopField = 'id,logo,scene,title,desc,content';
        $shopList = Db::name('ShopLocation')->where($shopWhere)->order('sort asc,id desc')->column($shopField);
        // 无商品列表时
        if (empty($goodsList)) {
            return ['list' => $goodsList, 'cate' => $cateList, 'shop' => $shopList];
        }
        // 商品数据组装
        foreach ($goodsList as $key => $vo) {
            // 商品门店处理
            $goodsList[$key]['shop'] = isset($shopList[$vo['shop_id']]) ? $shopList[$vo['shop_id']] : [];
            // 商品分类关联
            $goodsList[$key]['cate'] = [];
            if (isset($cateList[$vo['cate_id']])) {
                $goodsList[$key]['cate'][] = ($tcate = $cateList[$vo['cate_id']]);
                while (isset($tcate['pid']) && $tcate['pid'] > 0 && isset($cateList[$tcate['pid']])) {
                    $goodsList[$key]['cate'][] = ($tcate = $cateList[$tcate['pid']]);
                }
                $goodsList[$key]['cate'] = array_reverse($goodsList[$key]['cate']);
            }
        }
        return ['list' => $goodsList, 'cate' => $cateList, 'shop' => $shopList];
    }

    /**
     * 同步更新商品库存及售出
     * @param int $goods_id 商品ID
     * @param int $add_stock_num 入库数量
     * @return array
     * @throws \think\Exception
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     * @throws \think\exception\PDOException
     */
    public static function syncGoodsStock($goods_id,$add_stock_num)
    {
        // 检查商品是否需要更新库存
        $map = ['id' => $goods_id, 'is_deleted' => '0'];
        if (!($goods = Db::name('ShopGoods')->where($map)->find())) {
            return ['code' => 0, 'msg' => '指定商品信息无法同步库存！'];
        }

        // 统计入库信息
        $stockField = 'goods_id,ifnull(sum(goods_stock), 0) goods_stock';
        $stockWhere = ['status' => '1', 'is_deleted' => '0', 'goods_id' => $goods_id];
        $stockList = (array)Db::name('ShopGoodsStock')->field($stockField)->where($stockWhere)->group('goods_id')->select();

        // 更新商品库存 $stock['goods_stock'] 表示入库数量的总和
        foreach ($stockList as $stock) {
            $where = ['id' => $goods_id];
            $package_surp = $goods['package_surp'] + $add_stock_num; // 剩余库存
            Db::name('ShopGoods')->where($where)->update(['package_stock' => $stock['goods_stock'],'package_surp'=>$package_surp]);
        }
        return ['code' => 1, 'msg' => '同步商品库存成功！'];
    }

}