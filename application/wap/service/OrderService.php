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
    /**
     * 门店信息
     * @var array
     */
    protected $oShop;
    /**
     * 会员ID
     * @var integer
     */
    protected $mid;


    public function place($mid, $params)
    {
        $this->mid = $mid;
        $this->express['username'] = $params['username'];
        $this->express['phone']    = $params['phone'];
        $this->express['address']  = $params['address'];
        $this->express['desc']     = isset($params['desc']) ? $params['desc'] : '';
        $this->oGoods              = $params['goods'];

        $this->goods = $this->_getGoods($this->oGoods);

        $oStatus     = $this->_getOrderStatus();
        if(!$oStatus['code']) {
            return $oStatus;
        }

        // 生成订单编码
        $order_no      = $this->makeOrderNo();
        // 创建收货地址快照
        $snapExpress   = $this->_snapExpress($this->express, $this->oShop, $this->mid, $order_no);
        // 创建订单商品快照
        $snapGoodsList = $this->_snapGoodsList($oStatus['gStatusArray'], $this->oShop, $this->mid, $order_no);
        // 创建订单快照
        $snapOrder     = $this->_snapOrder($oStatus, $this->oShop, $this->mid, $order_no, $this->express['desc']);
        $order         = $this->createOrder($snapExpress, $snapGoodsList, $snapOrder, $order_no);
        return $order;
    }

    private function createOrder($snapExpress, $snapGoodsList, $snapOrder, $order_no)
    {
        try {
            // 写入订单信息
            Db::transaction(function () use ($snapOrder, $snapGoodsList, $snapExpress) {
                Db::name('ShopOrder')->insert($snapOrder); // 主订单信息
                Db::name('ShopOrderGoods')->insertAll($snapGoodsList); // 订单关联的商品信息
                Db::name('ShopOrderExpress')->insert($snapExpress); // 快递信息
            });

        } catch (\Exception $e) {
            return ['code' => 0, 'msg' => '门店订单创建失败，请稍候再试！' . $e->getLine() . $e->getFile() . $e->getMessage()];
        }
        return ['code' => 1, 'msg' => '门店订单创建成功！', 'data' => ['order_no' => $order_no]];
    }

    // 组合订单数据
    private function _snapOrder($oStatus, $oShop, $mid, $order_no, $desc)
    {
        $snap = [
            'shop_id' => $oShop['id'],
            'mid' => $mid,
            'order_no' => $order_no,
            'order_title' => $oStatus['gStatusArray'][0]['name'],
            'order_logo'  => $oStatus['gStatusArray'][0]['logo'],
            'goods_price' => $oStatus['goodsPrice'],
            'goods_count' => $oStatus['goodsCount'],
            'real_price'  => $oStatus['goodsPrice'],
            'pay_type'    => config('wechat.pay_type'),
            'pay_price'   => $oStatus['goodsPrice'],
            'desc'        => $desc,
        ];

        if(count($oStatus['gStatusArray']) > 1)
        {
            $snap['order_title'] .= '等';
        }
        return $snap;
    }

    // 组合订单商品数据
    private function _snapGoodsList($oGoods, $oShop, $mid, $order_no)
    {
        $snap = [];
        foreach ($oGoods as $key => $val)
        {
            $snap[$key]['shop_id']       = $oShop['id'];
            $snap[$key]['mid']           = $mid;
            $snap[$key]['order_no']      = $order_no;
            $snap[$key]['goods_id']      = $val['id'];
            $snap[$key]['goods_title']   = $val['name'];
            $snap[$key]['goods_logo']    = $val['logo'];
            $snap[$key]['selling_price'] = $val['price'];
            $snap[$key]['number']        = $val['counts'];
        }
        return $snap;
    }

    // 组合订单物流数据
    private function _snapExpress($express, $oShop, $mid, $order_no)
    {
        $snap['shop_id']  = $oShop['id'];
        $snap['mid']      = $mid;
        $snap['order_no'] = $order_no;
        $snap['express_username'] = $express['username'];
        $snap['express_phone']    = $express['phone'];
        $snap['express_province'] = config('shop.express_province');
        $snap['express_city']     = config('shop.express_city');
        $snap['express_area']     = config('shop.express_area');
        $snap['express_address']  = $express['address'];
        $snap['send_username']    = $oShop['contact_name'];
        $snap['send_phone']       = $oShop['contact_phone'];
        $snap['send_province']    = $oShop['province'];
        $snap['send_city']        = $oShop['city'];
        $snap['send_area']        = $oShop['area'];
        $snap['send_address']     = $oShop['address'];
        return $snap;
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

        $gShopIdS = array_column($this->goods,'shop_id');
        $oSId = $gShopIdS[0];
        $gShopStatus = $this->_getShopStatus($oSId, $gShopIdS, $status['goodsPrice']);
        if(!$gShopStatus['code'])
        {
            return $gShopStatus;
        }

        return $status;
    }

    private function _getShopStatus($oSID, $gShopIdS, $goodsPrice)
    {

        foreach ($gShopIdS as $value)
        {
            if($oSID != $value)
            {
                return ['code' => 0, 'msg' => '不能跨店下单,请联系管理员！'];
            }
        }
        $this->oShop = Db::name('ShopLocation')
            ->where(['id' => $oSID, 'is_deleted' => 0])
            ->field('id,contact_name,contact_phone,start_price,province,city,area,address,status')->find();
        if(empty($this->oShop))
        {
            return ['code' => 0, 'msg' => '商品对应的门店信息不存在！'];
        }
        if(!$this->oShop['status'])
        {
            return ['code' => 0, 'msg' => '门店休息中,换一家尝尝吧！'];
        }
        if($this->oShop['start_price'] > $goodsPrice)
        {
            return ['code' => 0, 'msg' => '订单总金额不能低于起送价！'];
        }
        return ['code' => 1, 'msg' => '门店信息校验成功！'];
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
            $temGoods              = $goods[$gIndex];
            $gStatus['id']         = $temGoods['id'];
            $gStatus['shop_id']    = $temGoods['shop_id'];
            $gStatus['status']     = $temGoods['status'];
            $gStatus['price']      = $temGoods['selling_price'];
            $gStatus['name']       = $temGoods['goods_title'];
            $gStatus['logo']       = $temGoods['goods_logo'];
            $gStatus['counts']     = $oCount;
            $gStatus['totalPrice'] = $oCount * $temGoods['selling_price'];
            if($temGoods['package_surp'] > $oCount)
            {
                $gStatus['haveStock'] = true;
            }
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