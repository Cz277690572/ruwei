<?php

namespace app\shop\controller;

use app\shop\service\GoodsService;
use controller\BasicAdmin;
use service\DataService;
use service\ToolsService;
use think\Db;
use think\exception\HttpResponseException;

/**
 * 门店商品管理
 * Class Goods
 * @package app\shop\controller
 * @author 伟彬 <277690572@qq.com>
 * @date 2018/08/02
 */
class Goods extends BasicAdmin
{

    /**
     * 定义当前操作表名
     * @var string
     */
    public $table = 'ShopGoods';

    /**
     * 普通商品
     * @return array|string
     * @throws \think\Exception
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function index()
    {
        $this->title = '商品管理';
        $get = $this->request->get();
        $db = Db::name($this->table)->where(['is_deleted' => '0']);

        if (isset($get['goods_title']) && $get['goods_title'] !== '') {
            $db->whereLike('goods_title', "%{$get['goods_title']}%");
        }
        foreach (['cate_id', 'shop_id'] as $field) {
            (isset($get[$field]) && $get[$field] !== '') && $db->where($field, $get[$field]);
        }
        if (isset($get['create_at']) && $get['create_at'] !== '') {
            list($start, $end) = explode(' - ', $get['create_at']);
            $db->whereBetween('create_at', ["{$start} 00:00:00", "{$end} 23:59:59"]);
        }
        return parent::_list($db->order('status desc,sort asc,id desc'));
    }

    /**
     * 门店分类数据处理
     * @param array $data
     */
    protected function _data_filter(&$data)
    {
        $result = GoodsService::buildGoodsList($data);
        $this->assign([
            'shops' => $result['shop'],
            'cates'  => ToolsService::arr2table($result['cate']),
        ]);
    }

    /**
     * 添加商品
     * @return array|string
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     * @throws \think\Exception
     */
    public function add()
    {
        if ($this->request->isGet()) {
            $this->title = '添加商品';
            $this->_form_assign();
            return $this->_form($this->table, 'form');
        }
        try {
            $data = $this->_form_build_data();
            Db::name($this->table)->insert($data['main']);
        } catch (HttpResponseException $exception) {
            return $exception->getResponse();
        } catch (\Exception $e) {
            $this->error('商品添加失败，请稍候再试！');
        }
        list($base, $spm, $url) = [url('@admin'), $this->request->get('spm'), url('shop/goods/index')];
        $this->success('添加商品成功！', "{$base}#{$url}?spm={$spm}");
    }

    /**
     * 编辑商品
     * @return array|string
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function edit()
    {
        if (!$this->request->isPost()) {
            $goods_id = $this->request->get('id');
            $goods = Db::name($this->table)->where(['id' => $goods_id, 'is_deleted' => '0'])->find();
            empty($goods) && $this->error('需要编辑的商品不存在！');
            $this->_form_assign();
            return $this->fetch('form', ['vo' => $goods, 'title' => '编辑商品']);
        }
        try {
            $data = $this->_form_build_data();
            $goods_id = $this->request->post('id');
            $goods = Db::name($this->table)->where(['id' => $goods_id, 'is_deleted' => '0'])->find();
            empty($goods) && $this->error('商品编辑失败，请稍候再试！');
            $where = ['id' => $goods_id, 'is_deleted' => '0'];
            Db::name('ShopGoods')->where($where)->update(array_merge($goods, $data['main']));
        } catch (HttpResponseException $exception) {
            return $exception->getResponse();
        } catch (\Exception $e) {
            $this->error('商品编辑失败，请稍候再试！' . $e->getMessage());
        }
        list($base, $spm, $url) = [url('@admin'), $this->request->get('spm'), url('shop/goods/index')];
        $this->success('商品编辑成功！', "{$base}#{$url}?spm={$spm}");
    }

    /**
     * 表单数据处理
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    protected function _form_assign()
    {
        list($where, $order) = [['status' => '1', 'is_deleted' => '0'], 'sort asc,id desc'];
        $shops = (array)Db::name('ShopLocation')->where($where)->order($order)->select();
        $cates = (array)Db::name('ShopGoodsCate')->where($where)->order($order)->select();
        $this->assign([
            'cates'  => ToolsService::arr2table($cates),
            'shops' => $shops,
            'status' => [0=>'下架',1=>'上架'],
        ]);
    }

    /**
     * 读取POST表单数据
     * @return array
     */
    protected function _form_build_data()
    {
        list($main, $post) = [[], $this->request->post()];
        empty($post['goods_logo']) && $this->error('商品LOGO不能为空，请上传后再提交数据！');
        // 商品主数据组装
        $main['shop_id'] = $this->request->post('shop_id', '0');
        $main['cate_id'] = $this->request->post('cate_id', '0');
        $main['goods_title'] = $this->request->post('goods_title', '');
        $main['goods_content'] = $this->request->post('goods_content', '',null);
        $main['goods_logo'] = $this->request->post('goods_logo', '');
        $main['goods_image'] = $this->request->post('goods_image', '');
        $main['goods_desc'] = $this->request->post('goods_desc', '');
        $main['selling_price'] = $this->request->post('selling_price', '0.00');
        $main['status'] = $this->request->post('status', '1');
        return ['main' => $main];
    }

    /**
     * 商品库存信息更新
     * @return string
     * @throws \think\Exception
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     * @throws \think\exception\PDOException
     */
    public function stock()
    {
        if (!$this->request->post()) {
            $goods_id = $this->request->get('id');
            $goods = Db::name('ShopGoods')->where(['id' => $goods_id, 'is_deleted' => '0'])->find();
            empty($goods) && $this->error('该商品无法操作入库操作！');
            return $this->fetch('', ['vo' => $goods]);
        }
        // 入库保存
        $goods_id = $this->request->post('id');
        list($post, $data) = [$this->request->post(), []];
        if($post['stock'] > 0){
            $data['goods_stock'] = $post['stock'];
            $data['stock_desc']  = $this->request->post('desc', '');
            $data['goods_id'] = $goods_id;
        }
        empty($data) && $this->error('无需入库的数据哦！');
        if (Db::name('ShopGoodsStock')->insert($data) !== false) {
            GoodsService::syncGoodsStock($goods_id,$post['stock']);
            $this->success('商品入库成功！', '');
        }
        $this->error('商品入库失败，请稍候再试！');
    }

    /**
     * 删除商品
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     */
    public function del()
    {
        if (DataService::update($this->table)) {
            $this->success("商品删除成功！", '');
        }
        $this->error("商品删除失败，请稍候再试！");
    }

    /**
     * 商品禁用
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     */
    public function forbid()
    {
        if (DataService::update($this->table)) {
            $this->success("商品下架成功！", '');
        }
        $this->error("商品下架失败，请稍候再试！");
    }

    /**
     * 商品禁用
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     */
    public function resume()
    {
        if (DataService::update($this->table)) {
            $this->success("商品上架成功！", '');
        }
        $this->error("商品上架失败，请稍候再试！");
    }

}
