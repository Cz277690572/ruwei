<?php

namespace app\Shop\controller;

use controller\BasicAdmin;
use service\DataService;
use think\Db;
use think\exception\HttpResponseException;

/**
 * 商家门店管理
 * Class Location
 * @package app\shop\controller
 * @author 伟彬 <277690572@qq.com>
 * @date 2018/08/01
 */
class Location extends BasicAdmin
{

    /**
     * 定义当前操作表名
     * @var string
     */
    public $table = 'ShopLocation';

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
        if (isset($get['title']) && $get['title'] !== '') {
            $db->whereLike('title', "%{$get['title']}%");
        }
        if (isset($get['contact_name']) && $get['contact_name'] !== '') {
            $db->whereLike('contact_name', "%{$get['contact_name']}%");
        }
        if (isset($get['contact_phone']) && $get['contact_phone'] !== '') {
            $db->whereLike('contact_phone', "%{$get['contact_phone']}%");
        }
        if (isset($get['create_at']) && $get['create_at'] !== '') {
            list($start, $end) = explode(' - ', $get['create_at']);
            $db->whereBetween('create_at', ["{$start} 00:00:00", "{$end} 23:59:59"]);
        }
        return parent::_list($db->order('status desc,sort asc,id desc'));
    }


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
            $this->_form_assign();
            return $this->_form($this->table, 'form');
        }
        try {
            $data = $this->_form_build_data();
            Db::transaction(function () use ($data) {
                Db::name($this->table)->insertGetId($data['main']);
            });
        } catch (HttpResponseException $exception) {
            return $exception->getResponse();
        } catch (\Exception $e) {
            $this->error('门店添加失败，请稍候再试！');
        }
        list($base, $spm, $url) = [url('@admin'), $this->request->get('spm'), url('Shop/location/index')];
        $this->success('添加门店成功！', "{$base}#{$url}?spm={$spm}");
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
        // 所有商户信息
        $merchants = (array)Db::name('ShopMerchant')->where($where)->order($order)->select();
        $this->assign([
            'merchants'  => $merchants,
        ]);
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
            $location_id = $this->request->get('id');
            $location = Db::name($this->table)->where(['id' => $location_id, 'is_deleted' => '0'])->find();
            empty($location) && $this->error('需要编辑的门店不存在！');
            $this->_form_assign();
            return $this->fetch('form', ['vo' => $location, 'title' => '编辑门店']);
        }
        try {
            $data = $this->_form_build_data();
            $location_id = $this->request->post('id');
            $location = Db::name($this->table)->where(['id' => $location_id, 'is_deleted' => '0'])->find();
            empty($location) && $this->error('门店编辑失败，请稍候再试！');

            Db::transaction(function () use ($data, $location_id, $location) {
                // 更新门店表
                $where = ['id' => $location_id, 'is_deleted' => '0'];
                Db::name($this->table)->where($where)->update(array_merge($location, $data['main']));
            });
        } catch (HttpResponseException $exception) {
            return $exception->getResponse();
        } catch (\Exception $e) {
            $this->error('门店编辑失败，请稍候再试！' . $e->getMessage());
        }
        list($base, $spm, $url) = [url('@admin'), $this->request->get('spm'), url('Shop/location/index')];
        $this->success('门店编辑成功！', "{$base}#{$url}?spm={$spm}");
    }


    /**
     * 读取POST表单数据
     * @return array
     */
    protected function _form_build_data()
    {
        list($main,$post) = [[],$this->request->post()];
        empty($post['logo']) && $this->error('门店LOGO不能为空，请上传后再提交数据！');
        empty($post['scene']) && $this->error('门店实景图不能为空，请上传后再提交数据！');

        // 门店主数据组装
        $main['merchant_id'] = $this->request->post('merchant_id', '');
        $main['title'] = $this->request->post('title', '');
        $main['start_price'] = $this->request->post('start_price', '0.00');
        $main['delivery_time'] = $this->request->post('delivery_time', '10');
        $main['contact_name'] = $this->request->post('contact_name', '0');
        $main['contact_phone'] = $this->request->post('contact_phone', '');
        $main['province'] = $this->request->post('province', '');
        $main['city'] = $this->request->post('city', '');
        $main['area'] = $this->request->post('area', '');
        $main['address'] = $this->request->post('address', '');
        $main['logo'] = $this->request->post('logo', '');
        $main['scene'] = $this->request->post('scene', '');
        $main['desc'] = $this->request->post('desc', '');
        $main['content'] = $this->request->post('content', '',null);

        return ['main' => $main];
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
            $this->success("门店禁用成功！", '');
        }
        $this->error("门店禁用失败，请稍候再试！");
    }

    /**
     * 门店禁用
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     */
    public function resume()
    {
        if (DataService::update($this->table)) {
            $this->success("门店启用成功！", '');
        }
        $this->error("门店启用失败，请稍候再试！");
    }

    /**
     * 添加门店管理员
     */
    public function admin(){
        if ($this->request->isGet()) {
            $location_id = $this->request->get('id');
            $location = Db::name($this->table)->where(['id' => $location_id, 'is_deleted' => '0'])->find();
            empty($location) && $this->error('门店已不存在！');
            $this->assign('location', $location);
            return $this->fetch('admin', ['vo' => $location, 'title' => '添加门店管理员']);
        }
        $post = $this->request->post();
        if ($post['password'] !== $post['repassword']) {
            $this->error('两次输入的密码不一致！');
        }
        $data = [
            'shop_id' => $post['id'],
            'merchant_id' => $post['merchant_id'],
            'username' => $post['username'],
            'password' => md5($post['password']),
            'phone' => $post['phone'],
            'nickname' => $post['nickname'],
            'desc' => $post['desc']
        ];
        $result = Db::name('ShopAccount')->insert($data);
        if ($result) {
            $this->success('添加成功，下次即可使用新账号登录！', '');
        }
        $this->error('添加失败，请稍候再试！');
    }
}
