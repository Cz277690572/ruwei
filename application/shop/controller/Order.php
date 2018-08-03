<?php

namespace app\shop\controller;

use app\shop\service\OrderService;
use controller\BasicAdmin;
use service\DataService;
use think\Db;

/**
 * 门店订单管理
 * Class Order
 * @package app\shop\controller
 * @author 伟彬 <277690572@qq.com>
 * @date 2018/08/03
 */
class Order extends BasicAdmin
{

    /**
     * 定义当前操作表名
     * @var string
     */
    public $table = 'ShopOrder';

    /**
     * 订单列表
     * @return array|string
     * @throws \think\Exception
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function index()
    {
        $this->title = '订单管理';
        $db = Db::name($this->table);
        $get = $this->request->get();
        // 会员信息查询过滤
        $memberWhere = [];
        foreach (['phone', 'nickname'] as $field) {
            if (isset($get[$field]) && $get[$field] !== '') {
                $memberWhere[] = [$field, 'like', "%{$get[$field]}%"];
            }
        }
        if (!empty($memberWhere)) {
            $memberWhere[] = ['status', '=', '1'];
            $sql = Db::name('ShopMember')->field('id')->where($memberWhere)->buildSql(true);
            $db->where("mid in {$sql}");

        }
        // =============== 商品信息查询过滤 ===============
        $goodsWhere = [];
        foreach (['goods_title'] as $field) {
            if (isset($get[$field]) && $get[$field] !== '') {
                $goodsWhere[] = [$field, 'like', "%{$get[$field]}%"];
            }
        }
        if (!empty($goodsWhere)) {
            $sql = Db::name('ShopOrderGoods')->field('order_no')->where($goodsWhere)->buildSql(true);
            $db->where("order_no in {$sql}");
        }
        // =============== 收货地址过滤 ===============
        $expressWhere = [];
        foreach (['express_username', 'express_phone', 'express_province', 'express_city', 'express_area', 'express_address'] as $field) {
            if (isset($get[$field]) && $get[$field] !== '') {
                $expressWhere[] = [$field, 'like', "%{$get[$field]}%"];
            }
        }
        if (!empty($expressWhere)) {
            $sql = Db::name('ShopOrderExpress')->field('order_no')->where($expressWhere)->buildSql(true);
            $db->where("order_no in {$sql}");
        }
        // =============== 主订单过滤 ===============
        foreach (['order_no', 'desc'] as $field) {
            (isset($get[$field]) && $get[$field] !== '') && $db->whereLike($field, "%{$get[$field]}%");
        }
        (isset($get['status']) && $get['status'] !== '') && $db->where('status', $get['status']);
        // 订单时间过滤
        foreach (['create_at', 'pay_at'] as $field) {
            if (isset($get[$field]) && $get[$field] !== '') {
                list($start, $end) = explode(' - ', $get[$field]);
                $db->whereBetween($field, ["{$start} 00:00:00", "{$end} 23:59:59"]);
            }
        }
        // echo json_encode($db->getLastSql());
        return parent::_list($db);
    }

    /**
     * 订单列表数据处理
     * @param array $data
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    protected function _data_filter(&$data)
    {
        OrderService::buildOrderList($data);
    }

    /**
     * 订单地址修改
     * @return string
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     * @throws \think\Exception
     */
    public function address()
    {
        $order_no = $this->request->get('order_no');
        if ($this->request->isGet()) {
            $order = Db::name('ShopOrder')->where(['order_no' => $order_no])->find();
            empty($order) && $this->error('该订单无法进行地址修改，订单数据不存在！');
            $orderExpress = Db::name('ShopOrderExpress')->where(['order_no' => $order_no])->find();
            empty($orderExpress) && $this->error('该订单无法进行地址修改！');
            return $this->fetch('', $orderExpress);
        }
        $data = [
            'order_no' => $order_no,
            'express_username' => $this->request->post('express_username'),
            'express_phone'    => $this->request->post('express_phone'),
            'express_province' => $this->request->post('express_province'),
            'express_city'     => $this->request->post('express_city'),
            'express_area'     => $this->request->post('express_area'),
            'express_address'  => $this->request->post('express_address'),
            'desc'     => $this->request->post('desc'),
        ];
        if (DataService::save('ShopOrderExpress', $data, 'order_no')) {
            $this->success('收货地址修改成功！', '');
        }
        $this->error('收货地址修改失败，请稍候再试！');
    }


}
