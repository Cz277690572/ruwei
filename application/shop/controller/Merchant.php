<?php

namespace app\Shop\controller;

use controller\BasicAdmin;
use service\DataService;
use think\Db;
use think\exception\HttpResponseException;

/**
 * 商家商户管理
 * Class Merchant
 * @package app\shop\controller
 * @author 伟彬 <277690572@qq.com>
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
     * 商家商户
     * @return array|string
     * @throws \think\Exception
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function index()
    {
        $this->title = '商户管理';
        $get = $this->request->get();
        $db = Db::name($this->table)->where(['is_deleted' => '0']);
        if (isset($get['merchant_title']) && $get['merchant_title'] !== '') {
            $db->whereLike('merchant_title', "%{$get['merchant_title']}%");
        }
        if (isset($get['merchant_email']) && $get['merchant_email'] !== '') {
            $db->whereLike('merchant_email', "%{$get['merchant_email']}%");
        }
        if (isset($get['bank_account']) && $get['bank_account'] !== '') {
            $db->whereLike('bank_account', "%{$get['bank_account']}%");
        }
        if (isset($get['bank_username']) && $get['bank_username'] !== '') {
            $db->whereLike('bank_username', "%{$get['bank_username']}%");
        }
        if (isset($get['legal_name']) && $get['legal_name'] !== '') {
            $db->whereLike('legal_name', "%{$get['legal_name']}%");
        }
        if (isset($get['legal_phone']) && $get['legal_phone'] !== '') {
            $db->whereLike('legal_phone', "%{$get['legal_phone']}%");
        }
        if (isset($get['create_at']) && $get['create_at'] !== '') {
            list($start, $end) = explode(' - ', $get['create_at']);
            $db->whereBetween('create_at', ["{$start} 00:00:00", "{$end} 23:59:59"]);
        }
        return parent::_list($db->order('status desc,sort asc,id desc'));
    }


    /**
     * 添加商户
     * @return array|string
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     * @throws \think\Exception
     */
    public function add()
    {

        if ($this->request->isGet()) {
            $this->title = '添加商户';
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
            $this->error('商户添加失败，请稍候再试！');
        }
        list($base, $spm, $url) = [url('@admin'), $this->request->get('spm'), url('Shop/merchant/index')];
        $this->success('添加商户成功！', "{$base}#{$url}?spm={$spm}");
    }

    /**
     * 编辑商户
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
            empty($merchant) && $this->error('需要编辑的商户不存在！');
            return $this->fetch('form', ['vo' => $merchant, 'title' => '编辑商户']);
        }
        try {
            $data = $this->_form_build_data();
            $merchant_id = $this->request->post('id');
            $merchant = Db::name($this->table)->where(['id' => $merchant_id, 'is_deleted' => '0'])->find();
            empty($merchant) && $this->error('商户编辑失败，请稍候再试！');

            Db::transaction(function () use ($data, $merchant_id, $merchant) {
                // 更新商户表
                $where = ['id' => $merchant_id, 'is_deleted' => '0'];
                Db::name($this->table)->where($where)->update(array_merge($merchant, $data['main']));
            });
        } catch (HttpResponseException $exception) {
            return $exception->getResponse();
        } catch (\Exception $e) {
            $this->error('商户编辑失败，请稍候再试！' . $e->getMessage());
        }
        list($base, $spm, $url) = [url('@admin'), $this->request->get('spm'), url('Shop/merchant/index')];
        $this->success('商户编辑成功！', "{$base}#{$url}?spm={$spm}");
    }


    /**
     * 读取POST表单数据
     * @return array
     */
    protected function _form_build_data()
    {
        list($main) = [[]];
//        empty($post['merchant_logo']) && $this->error('商户LOGO不能为空，请上传后再提交数据！');
//        empty($post['merchant_license']) && $this->error('商户营业执照不能为空，请上传后再提交数据！');
//        empty($post['legal_posit_card']) && $this->error('法人身份证正面图片不能为空，请上传后再提交数据！');
//        empty($post['legal_back_card']) && $this->error('法人身份证背面图片不能为空，请上传后再提交数据！');
        // 商户主数据组装
        $main['merchant_title'] = $this->request->post('merchant_title', '');
        $main['merchant_email'] = $this->request->post('merchant_email', '');
        $main['merchant_province'] = $this->request->post('merchant_province', '0');
        $main['merchant_city'] = $this->request->post('merchant_city', '');
        $main['merchant_area'] = $this->request->post('merchant_area', '');
        $main['merchant_address'] = $this->request->post('merchant_address', '');
        $main['merchant_logo'] = $this->request->post('merchant_logo', '');
        $main['merchant_license'] = $this->request->post('merchant_license', '');
        $main['merchant_desc'] = $this->request->post('merchant_desc', '',null);

        $main['bank_account'] = $this->request->post('bank_account', '');
        $main['bank_title'] = $this->request->post('bank_title', '');
        $main['bank_username'] = $this->request->post('bank_username', '');
        $main['bank_money'] = $this->request->post('bank_money', '');

        $main['legal_name'] = $this->request->post('legal_name', '');
        $main['legal_phone'] = $this->request->post('legal_phone', '');
        $main['legal_posit_card'] = $this->request->post('legal_posit_card', '');
        $main['legal_back_card'] = $this->request->post('legal_back_card', '');

        return ['main' => $main];
    }

    /**
     * 删除商户
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     */
    public function del()
    {
        if (DataService::update($this->table)) {
            $this->success("商户删除成功！", '');
        }
        $this->error("商户删除失败，请稍候再试！");
    }

    /**
     * 商户禁用
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     */
    public function forbid()
    {
        if (DataService::update($this->table)) {
            $this->success("商户禁用成功！", '');
        }
        $this->error("商户禁用失败，请稍候再试！");
    }

    /**
     * 商户禁用
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     */
    public function resume()
    {
        if (DataService::update($this->table)) {
            $this->success("商户启用成功！", '');
        }
        $this->error("商户启用失败，请稍候再试！");
    }

}
