<?php

namespace app\Shop\controller;


use controller\BasicAdmin;
use service\DataService;
use service\ToolsService;
use think\Db;
use think\exception\HttpResponseException;

/**
 * 商家门店管理
 * Class Merchant
 * @package app\shop\controller
 * @author 伟彬
 * @date 2018/07/31
 */
class Merchant extends BasicAdmin
{

    /**
     * 定义当前操作表名
     * @var string
     */
    public $table = 'ShopMerchant';

    /**
     * 商家门店
     * @return array|string
     * @throws \think\Exception
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function index()
    {
        $this->title = '门店管理';
        $get = $this->request->get();
        $db = Db::name($this->table)->where(['is_deleted' => '0']);
        if (isset($get['shop_title']) && $get['shop_title'] !== '') {
            $db->whereLike('shop_title', "%{$get['shop_title']}%");
        }
        if (isset($get['merchant_title']) && $get['merchant_title'] !== '') {
            $db->whereLike('merchant_title', "%{$get['merchant_title']}%");
        }
        if (isset($get['merchant_phone']) && $get['merchant_phone'] !== '') {
            $db->whereLike('merchant_phone', "%{$get['merchant_phone']}%");
        }
        if (isset($get['create_at']) && $get['create_at'] !== '') {
            list($start, $end) = explode(' - ', $get['create_at']);
            $db->whereBetween('create_at', ["{$start} 00:00:00", "{$end} 23:59:59"]);
        }
        return parent::_list($db->order('status desc,sort asc,id desc'));
    }

    /**
     * 商城数据处理
     * @param array $data
     */
//    protected function _data_filter(&$data)
//    {
//        $result = merchantService::buildmerchantList($data);
//        $this->assign([
//            'brands' => $result['brand'],
//            'cates'  => ToolsService::arr2table($result['cate']),
//        ]);
//    }

    /**
     * 添加门店
     * @return array|string
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     * @throws \think\Exception
     */
    public function add()
    {
        if ($this->request->isGet()) {
            $this->title = '添加门店';
            return $this->_form($this->table, 'form');
        }
        try {
//            $data = $this->_form_build_data();
//            Db::transaction(function () use ($data) {
//                $merchantID = Db::name($this->table)->insertGetId($data['main']);
//                foreach ($data['list'] as &$vo) {
//                    $vo['merchant_id'] = $merchantID;
//                }
//                Db::name('ShopmerchantList')->insertAll($data['list']);
//            });
        } catch (HttpResponseException $exception) {
//            return $exception->getResponse();
        } catch (\Exception $e) {
//            $this->error('门店添加失败，请稍候再试！');
        }
//        list($base, $spm, $url) = [url('@admin'), $this->request->get('spm'), url('Shop/merchant/index')];
//        $this->success('添加门店成功！', "{$base}#{$url}?spm={$spm}");
    }

    /**
     * 编辑门店
     * @return array|string
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function edit()
    {
        if (!$this->request->isPost()) {
            $merchant_id = $this->request->get('id');
            $merchant = Db::name($this->table)->where(['id' => $merchant_id, 'is_deleted' => '0'])->find();
            empty($merchant) && $this->error('需要编辑的门店不存在！');
            $merchant['list'] = Db::name('ShopmerchantList')->where(['merchant_id' => $merchant_id, 'is_deleted' => '0'])->select();
            $this->_form_assign();
            return $this->fetch('form', ['vo' => $merchant, 'title' => '编辑门店']);
        }
        try {
            $data = $this->_form_build_data();
            $merchant_id = $this->request->post('id');
            $merchant = Db::name($this->table)->where(['id' => $merchant_id, 'is_deleted' => '0'])->find();
            empty($merchant) && $this->error('门店编辑失败，请稍候再试！');
            foreach ($data['list'] as &$vo) {
                $vo['merchant_id'] = $merchant_id;
            }
            Db::transaction(function () use ($data, $merchant_id, $merchant) {
                // 更新门店主表
                $where = ['id' => $merchant_id, 'is_deleted' => '0'];
                Db::name('Shopmerchant')->where($where)->update(array_merge($merchant, $data['main']));
                // 更新门店详细
                Db::name('ShopmerchantList')->where(['merchant_id' => $merchant_id])->delete();
                Db::name('ShopmerchantList')->insertAll($data['list']);
            });
        } catch (HttpResponseException $exception) {
            return $exception->getResponse();
        } catch (\Exception $e) {
            $this->error('门店编辑失败，请稍候再试！' . $e->getMessage());
        }
        list($base, $spm, $url) = [url('@admin'), $this->request->get('spm'), url('Shop/merchant/index')];
        $this->success('门店编辑成功！', "{$base}#{$url}?spm={$spm}");
    }

    /**
     * 表单数据处理
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
//    protected function _form_assign()
//    {
//        list($where, $order) = [['status' => '1', 'is_deleted' => '0'], 'sort asc,id desc'];
//        $specs = (array)Db::name('ShopmerchantSpec')->where($where)->order($order)->select();
//        $brands = (array)Db::name('ShopmerchantBrand')->where($where)->order($order)->select();
//        $cates = (array)Db::name('ShopmerchantCate')->where($where)->order($order)->select();
//        // 所有的门店信息
//        $where = ['is_deleted' => '0', 'status' => '1'];
//        $merchantListField = 'merchant_id,merchant_spec,merchant_stock,merchant_sale';
//        $merchant = Db::name('Shopmerchant')->field('id,merchant_title')->where($where)->select();
//        $list = Db::name('ShopmerchantList')->field($merchantListField)->where($where)->select();
//        foreach ($merchant as $k => $g) {
//            $merchant[$k]['list'] = [];
//            foreach ($list as $v) {
//                ($g['id'] === $v['merchant_id']) && $merchant[$k]['list'][] = $v;
//            }
//        }
//        array_unshift($specs, ['spec_title' => ' - 不使用规格模板 -', 'spec_param' => '[]', 'id' => '0']);
//        $this->assign([
//            'specs'  => $specs,
//            'cates'  => ToolsService::arr2table($cates),
//            'brands' => $brands,
//            'all'    => $merchant,
//        ]);
//    }

    /**
     * 读取POST表单数据
     * @return array
     */
    protected function _form_build_data()
    {
        list($main, $list, $post, $verify) = [[], [], $this->request->post(), false];
        empty($post['merchant_logo']) && $this->error('门店LOGO不能为空，请上传后再提交数据！');
        // 门店主数据组装
        $main['cate_id'] = $this->request->post('cate_id', '0');
        $main['spec_id'] = $this->request->post('spec_id', '0');
        $main['brand_id'] = $this->request->post('brand_id', '0');
        $main['merchant_logo'] = $this->request->post('merchant_logo', '');
        $main['merchant_title'] = $this->request->post('merchant_title', '');
        $main['merchant_video'] = $this->request->post('merchant_video', '');
        $main['merchant_image'] = $this->request->post('merchant_image', '');
        $main['merchant_desc'] = $this->request->post('merchant_desc', '', null);
        $main['merchant_content'] = $this->request->post('merchant_content', '');
        $main['tags_id'] = ',' . join(',', isset($post['tags_id']) ? $post['tags_id'] : []) . ',';
        // 门店从数据组装
        if (!empty($post['merchant_spec'])) {
            foreach ($post['merchant_spec'] as $key => $value) {
                $merchant = [];
                $merchant['merchant_spec'] = $value;
                $merchant['market_price'] = $post['market_price'][$key];
                $merchant['selling_price'] = $post['selling_price'][$key];
                $merchant['status'] = intval(!empty($post['spec_status'][$key]));
                !empty($merchant['status']) && $verify = true;
                $list[] = $merchant;
            }
        } else {
            $this->error('没有门店规格或套餐信息哦！');
        }
        !$verify && $this->error('没有设置有效的门店规格！');
        return ['main' => $main, 'list' => $list];
    }

    /**
     * 门店库存信息更新
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
            $merchant_id = $this->request->get('id');
            $merchant = Db::name('Shopmerchant')->where(['id' => $merchant_id, 'is_deleted' => '0'])->find();
            empty($merchant) && $this->error('该门店无法操作入库操作！');
            $where = ['merchant_id' => $merchant_id, 'status' => '1', 'is_deleted' => '0'];
            $merchant['list'] = Db::name('ShopmerchantList')->where($where)->select();
            return $this->fetch('', ['vo' => $merchant]);
        }
        // 入库保存
        $merchant_id = $this->request->post('id');
        list($post, $data) = [$this->request->post(), []];
        foreach ($post['spec'] as $key => $spec) {
            if ($post['stock'][$key] > 0) {
                $data[] = [
                    'merchant_stock' => $post['stock'][$key],
                    'stock_desc'  => $this->request->post('desc'),
                    'merchant_spec'  => $spec, 'merchant_id' => $merchant_id,
                ];
            }
        }
        empty($data) && $this->error('无需入库的数据哦！');
        if (Db::name('ShopmerchantStock')->insertAll($data) !== false) {
            merchantService::syncmerchantStock($merchant_id);
            $this->success('门店入库成功！', '');
        }
        $this->error('门店入库失败，请稍候再试！');
    }

    /**
     * 删除门店
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     */
    public function del()
    {
        if (DataService::update($this->table)) {
            $this->success("门店删除成功！", '');
        }
        $this->error("门店删除失败，请稍候再试！");
    }

    /**
     * 门店禁用
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     */
    public function forbid()
    {
        if (DataService::update($this->table)) {
            $this->success("门店下架成功！", '');
        }
        $this->error("门店下架失败，请稍候再试！");
    }

    /**
     * 门店禁用
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     */
    public function resume()
    {
        if (DataService::update($this->table)) {
            $this->success("门店上架成功！", '');
        }
        $this->error("门店上架失败，请稍候再试！");
    }

}
