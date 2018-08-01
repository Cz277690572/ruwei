<?php

namespace app\Shop\controller;

use controller\BasicAdmin;
use service\DataService;
use think\Db;
use think\exception\HttpResponseException;

/**
 * 商家门店账号管理
 * Class account
 * @package app\shop\controller
 * @author 伟彬
 * @date 2018/08/01
 */
class Account extends BasicAdmin
{

    /**
     * 定义当前操作表名
     * @var string
     */
    public $table = 'ShopAccount';

    /**
     * 商家门店账号
     * @return array|string
     * @throws \think\Exception
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function index()
    {
        $this->title = '门店账号列表';
        $get = $this->request->get();
        $db = Db::name($this->table)->where(['is_deleted' => '0']);
        if (isset($get['username']) && $get['username'] !== '') {
            $db->whereLike('username', "%{$get['username']}%");
        }
        if (isset($get['phone']) && $get['phone'] !== '') {
            $db->whereLike('phone', "%{$get['phone']}%");
        }
        if (isset($get['last_login_time']) && $get['last_login_time'] !== '') {
            list($start, $end) = explode(' - ', $get['last_login_time']);
            $db->whereBetween('last_login_time', ["{$start} 00:00:00", "{$end} 23:59:59"]);
        }
        return parent::_list($db->order('status desc,sort asc,id desc'));
    }

    /**
     * 编辑门店账号
     * @return array|string
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function edit()
    {
        if ($this->request->isGet()) {
            $account_id = $this->request->get('id');
            $account = Db::name($this->table)->where(['id' => $account_id, 'is_deleted' => '0'])->find();
            empty($account) && $this->error('门店账号已不存在！');
            $this->assign('account', $account);
            return $this->fetch('form', ['vo' => $account, 'title' => '编辑门店账号']);
        }
        $post = $this->request->post();
        if ($post['password'] !== $post['repassword']) {
            $this->error('两次输入的密码不一致！');
        }

        $account_id = $post['id'];
        $data = [
            'password' => md5($post['password']),
            'phone' => $post['phone'],
            'nickname' => $post['nickname'],
            'desc' => $post['desc']
        ];

        $where = ['id' => $account_id, 'is_deleted' => '0'];
        $result =Db::name($this->table)->where($where)->update($data);
        if ($result) {
            $this->success('编辑成功！', '');
        }
        $this->error('编辑失败，请稍候再试！');
    }


    /**
     * 删除门店账号
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     */
    public function del()
    {
        if (DataService::update($this->table)) {
            $this->success("门店账号删除成功！", '');
        }
        $this->error("门店账号删除失败，请稍候再试！");
    }

    /**
     * 门店账号禁用
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     */
    public function forbid()
    {
        if (DataService::update($this->table)) {
            $this->success("门店账号禁用成功！", '');
        }
        $this->error("门店账号禁用失败，请稍候再试！");
    }

    /**
     * 门店账号启用
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     */
    public function resume()
    {
        if (DataService::update($this->table)) {
            $this->success("门店账号启用成功！", '');
        }
        $this->error("门店账号启用失败，请稍候再试！");
    }

}
