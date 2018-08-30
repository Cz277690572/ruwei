<?php

namespace app\wap\service;
use think\Db;

/**
 * 门店订单服务
 * Class OrderService
 * @package app\wap\service
 * @author 伟彬 <277690572@qq.com>
 * @date: 2018/8/30 14:23
 */
class OrderService
{
    /**
     * 订单商品数据
     * @var array
     */
    protected $oGoods;
    /**
     * 真实商品数据
     * @var array
     */
    protected $goods;
    /**
     * 收货信息
     * @var array
     */
    protected $express;
    protected $shopId;
    protected $mid;


    public function place($mid, $params)
    {
        $this->mid = $mid;
        $this->express['username'] = $params['username'];
        $this->express['phone']    = $params['phone'];
        $this->express['address']  = $params['address'];
        $this->oGoods              = $params['goods'];


        $this->goods = $this->_getGoods($this->oGoods);

        $oStatus     = $this->_getOrderStatus();
        if(!$oStatus['code']) {
            return $oStatus;
        }

        // 生成订单编码
        $order_no  = $this->makeOrderNo();
        // 创建收货地址快照
        $express   = $this->_snapExpress($this->express, $this->shop_id, $this->mid, $order_no);
        // 创建订单商品快照
        $goodsList = $this->_snapGoodsList($oStatus['gStatusArray'], $this->shop_id, $this->mid, $order_no);
        // 创建订单快照
        $order     = $this->_snapOrder($oStatus,$order_no);

        return $oStatus;
    }

    private function createOrder()
    {
    }

    private function _snapExpress($express, $shop_id, $mid, $order_no)
    {
        $snap['shop_id']  = $shop_id;
        $snap['mid']      = $mid;
        $snap['order_no'] = $order_no;
        $snap['express_username'] = $express['username'];
        $snap['express_phone']    = $express['express_phone'];
        $snap['express_province'] = $express['express_province'];
        $snap['express_city']     = $express['express_city'];
        $snap['express_area']     = $express['express_area'];
        $snap['express_address']  = $express['express_address'];



    }

    private function _snapOrder()
    {
        $snap = [

        ];
    }

    private function _getOrderStatus()
    {
        $status = [
            'code' => 1,
            'goodsPrice' => 0,
            'goodsCount' => 0,
            'gStatusArray' => []
        ];

        foreach ($this->oGoods as $goods) {
            $gStatus = $this->_getGoodsStatus(
                $goods['goods_id'],$goods['count'],$this->goods
            );
            if(!$gStatus['code'])
            {
                return ['code' => 0, 'msg' => 'id为'.$gStatus['id'].'的商品不存在!'];
            }
            if(!$gStatus['status'])
            {
                return ['code' => 0, 'msg' => '商品:'.$gStatus['name'].'已下架!'];
            }
            if(!$gStatus['haveStock'])
            {
                return ['code' => 0, 'msg' => '商品:'.$gStatus['name'].'库存不足!'];
            }
            $status['goodsPrice'] += $gStatus['totalPrice'];
            $status['goodsCount'] += $gStatus['counts'];
            array_push($status['gStatusArray'], $gStatus);
        }
        $shopIds = array_column($this->goods,'shop_id');
        $this->shopId = $shopIds[0];
        foreach ($shopIds as $value)
        {
            if($this->shopId != $value)
            {
                return ['code' => 0, 'msg' => '不能跨店下单,请联系管理员！'];
            }
        }
        return $status;
    }

    // 制作订单编号
    public static function makeOrderNo()
    {
        $yCode = array('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','U','V');
        $OrderSn =
            $yCode[intval(date('Y')) - 2018]. strtoupper(dechex(date('m'))) . date('d') .
            substr(time(), -5) . substr(microtime(), 2, 5) . sprintf('%03d', rand(0, 999));
        return $OrderSn;
    }

    private function _getGoodsStatus($oGID, $oCount, $goods)
    {
        $gIndex = -1;
        $gStatus = [
            'code' => 1,
            'id' => null,
            'shop_id' => null,
            'haveStock' => false,
            'status' => false,
            'price' => 0,
            'name' => '',
            'logo' => null,
            'counts' => 0,
            'totalPrice' => 0
        ];

        for ($i = 0; $i < count($goods); $i++)
        {
            if($oGID == $goods[$i]['id'])
            {
                $gIndex = $i;
            }
        }

        if($gIndex == -1)
        {
            $gStatus['code'] = 0;
            $gStatus['id'] = $oGID;
            return $gStatus;
        }
        else{
            $temGoods = $goods[$gIndex];
            $gStatus['id'] = $temGoods['id'];
            $gStatus['shop_id'] = $temGoods['shop_id'];
            $gStatus['haveStock'] = $temGoods['package_surp'];
            $gStatus['status'] = $temGoods['status'];
            $gStatus['price'] = $temGoods['selling_price'];
            $gStatus['name']  = $temGoods['goods_title'];
            $gStatus['logo']  = $temGoods['goods_logo'];
            $gStatus['counts'] = $oCount;
            $gStatus['totalPrice'] = $oCount * $temGoods['selling_price'];
        }

        return $gStatus;
    }

    private function _getGoods($oGoods)
    {
        $oGids = array_column($oGoods,'goods_id');
        $goods = Db::name('ShopGoods')
            ->field('id,shop_id,goods_title,goods_logo,selling_price,package_surp,status')
            ->where('id','in',$oGids)->select();
        return $goods;
    }
}