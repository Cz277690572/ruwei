/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 100119
 Source Host           : localhost:3306
 Source Schema         : admin_v3

 Target Server Type    : MySQL
 Target Server Version : 100119
 File Encoding         : 65001

 Date: 31/08/2018 21:02:05
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for shop_account
-- ----------------------------
DROP TABLE IF EXISTS `shop_account`;
CREATE TABLE `shop_account`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `merchant_id` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '商户ID',
  `shop_id` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '门店ID',
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '登录账号',
  `password` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '登录密码',
  `phone` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '账号联系人手机号',
  `nickname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '昵称',
  `desc` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '描述',
  `last_login_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `last_login_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后登录时间',
  `sort` bigint(11) UNSIGNED NULL DEFAULT 0 COMMENT '排序',
  `status` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '账号状态(1有效,0无效)',
  `is_deleted` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(1删除,0未删除)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '门店账号表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of shop_account
-- ----------------------------
INSERT INTO `shop_account` VALUES (1, 2, 1, '111', '698d51a19d8a121ce581499d7b701668', '18476420222', '22222+1', '33333+133333+133333+133333+133333+133333+133333+133333+133333+133333+133333+133333+133333+1', '', '2018-08-01 20:03:47', 0, 1, 0, '2018-08-01 20:03:47');

-- ----------------------------
-- Table structure for shop_cart
-- ----------------------------
DROP TABLE IF EXISTS `shop_cart`;
CREATE TABLE `shop_cart`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `shop_id` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '门店ID',
  `mid` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '会员ID',
  `goods_id` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '商品ID',
  `number` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '商品数量',
  `status` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '商品状态(1有效,0无效)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '门店会员购物车' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for shop_goods
-- ----------------------------
DROP TABLE IF EXISTS `shop_goods`;
CREATE TABLE `shop_goods`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `shop_id` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '门店ID',
  `cate_id` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '商品分类id',
  `goods_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '商品标签',
  `goods_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '商品内容',
  `goods_logo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '商品LOGO',
  `goods_image` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '商品图片地址',
  `goods_desc` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '商品描述',
  `selling_price` decimal(20, 2) UNSIGNED NULL DEFAULT 0.00 COMMENT '商品销售价格',
  `package_stock` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '总库存数量',
  `package_surp` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '剩余库存数量',
  `package_sale` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '已销售数量',
  `sort` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '数据排序',
  `status` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '商品状态(1有效,0无效)',
  `is_deleted` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(1删除,0未删除)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '门店商品表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of shop_goods
-- ----------------------------
INSERT INTO `shop_goods` VALUES (1, 2, 1, '猪扒饭', '<p>内容</p>\r\n', 'http://ruwei.com/static/upload/cb3f32cb706c0325/c1c1afa9b2c5e9a3.jpg', 'http://ruwei.com/static/upload/e844d00fd27f83c9/4e697265a63b9971.jpg', '描述', 12.50, 11, 11, 0, 0, 1, 0, '2018-08-02 16:20:08');
INSERT INTO `shop_goods` VALUES (2, 2, 3, '龟苓膏（芦苇）', '<p>内容</p>\r\n', 'http://ruwei.com/static/upload/3837304710d6af3d/9704596f307eb1e7.jpg', 'http://ruwei.com/static/upload/1d5e9a1f4a375937/c28e7c2167c32812.jpg|http://ruwei.com/static/upload/130dae9e132c4275/cec56df6b54e134b.jpg', '展示', 10.00, 100, 100, 0, 0, 1, 0, '2018-08-06 10:16:33');
INSERT INTO `shop_goods` VALUES (3, 1, 1, '小葱拌豆腐', '<p>内容</p>\r\n', 'http://ruwei.com/static/upload/401979857c0fe815/bca134c7e01cfc48.jpg', '', '描述', 9.90, 10, 10, 0, 0, 1, 0, '2018-08-06 10:17:51');
INSERT INTO `shop_goods` VALUES (4, 2, 1, '石锅牛肉饭', '', 'http://ruwei.com/static/upload/9b87fb7a0d54ce0b/eaeb7c8d79e9d94b.jpg', '', '手快有，手慢无', 19.00, 110, 110, 0, 0, 1, 0, '2018-08-30 11:47:39');
INSERT INTO `shop_goods` VALUES (5, 2, 4, '美国西冷扒', '', 'http://ruwei.com/static/upload/401979857c0fe815/bca134c7e01cfc48.jpg', '', '手快有，手慢无', 79.00, 100, 100, 0, 0, 1, 0, '2018-08-30 11:52:34');

-- ----------------------------
-- Table structure for shop_goods_cate
-- ----------------------------
DROP TABLE IF EXISTS `shop_goods_cate`;
CREATE TABLE `shop_goods_cate`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '上级分类编号',
  `shop_id` bigint(20) NULL DEFAULT 0 COMMENT '门店ID',
  `cate_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '商品分类名称',
  `cate_desc` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '商品分类描述',
  `sort` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '商品分类排序',
  `status` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '商品分类状态(1有效,0无效)',
  `is_deleted` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(1删除,0未删除)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '门店商品分类表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of shop_goods_cate
-- ----------------------------
INSERT INTO `shop_goods_cate` VALUES (1, 0, 0, '热销', '热销描述', 0, 1, 0, '2018-08-02 09:49:20');
INSERT INTO `shop_goods_cate` VALUES (2, 0, 0, '饮料', '饮料描述', 0, 1, 0, '2018-08-02 10:21:50');
INSERT INTO `shop_goods_cate` VALUES (3, 0, 0, '糖水', '糖水描述', 0, 1, 0, '2018-08-02 10:22:14');
INSERT INTO `shop_goods_cate` VALUES (4, 0, 0, 'F4专属快餐', '', 0, 1, 0, '2018-08-30 11:48:46');
INSERT INTO `shop_goods_cate` VALUES (5, 0, 0, '网红美女套餐', '', 0, 1, 0, '2018-08-30 11:51:25');

-- ----------------------------
-- Table structure for shop_goods_stock
-- ----------------------------
DROP TABLE IF EXISTS `shop_goods_stock`;
CREATE TABLE `shop_goods_stock`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `goods_id` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '商品ID',
  `goods_stock` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '商品库存',
  `stock_desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '商品库存描述',
  `sort` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '数据排序',
  `status` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '商品状态(1有效,0无效)',
  `is_deleted` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(1删除,0未删除)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '门店商品库存' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of shop_goods_stock
-- ----------------------------
INSERT INTO `shop_goods_stock` VALUES (39, 1, 10, '描述', 0, 1, 0, '2018-08-02 16:24:09');
INSERT INTO `shop_goods_stock` VALUES (40, 1, 1, '', 0, 1, 0, '2018-08-03 09:19:17');
INSERT INTO `shop_goods_stock` VALUES (41, 3, 10, '', 0, 1, 0, '2018-08-08 17:54:05');
INSERT INTO `shop_goods_stock` VALUES (42, 5, 100, '', 0, 1, 0, '2018-08-30 12:00:43');
INSERT INTO `shop_goods_stock` VALUES (43, 4, 100, '', 0, 1, 0, '2018-08-30 12:01:01');
INSERT INTO `shop_goods_stock` VALUES (44, 4, 10, '', 0, 1, 0, '2018-08-30 12:01:11');
INSERT INTO `shop_goods_stock` VALUES (45, 2, 100, '', 0, 1, 0, '2018-08-30 12:01:26');

-- ----------------------------
-- Table structure for shop_location
-- ----------------------------
DROP TABLE IF EXISTS `shop_location`;
CREATE TABLE `shop_location`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `merchant_id` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '商户ID',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '门店名称',
  `contact_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '门店联系人名称',
  `contact_phone` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '门店联系人手机号',
  `start_price` decimal(20, 2) UNSIGNED NULL DEFAULT 0.00 COMMENT '起送价',
  `delivery_time` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '平均配送时间',
  `opening_at` datetime(0) NULL DEFAULT NULL COMMENT '开放时间',
  `closing_at` datetime(0) NULL DEFAULT NULL COMMENT '关闭时间',
  `province` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '门店地址省份',
  `city` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '门店地址城市',
  `area` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '门店地址区域',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '门店详细地址',
  `logo` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '门店logo',
  `scene` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '门店实景图',
  `desc` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '门店描述',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '门店图文信息',
  `sort` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '门店排序',
  `status` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '门店状态(1有效,0无效)',
  `is_deleted` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(1删除,0未删除)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '门店表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of shop_location
-- ----------------------------
INSERT INTO `shop_location` VALUES (1, 2, '门店2', '门店2联系人', '18476420222', 1.00, 0, NULL, NULL, '广东省', '深圳市', '南山区', '新安技术学校', 'http://ruwei.com/static/upload/aaa5b9b9f37a50d0/217789d24f1dfe23.jpg', 'http://ruwei.com/static/upload/cb3f32cb706c0325/c1c1afa9b2c5e9a3.jpg|http://ruwei.com/static/upload/45cf3bf593cee293/ad8683260472eb5e.jpg', '营业时间10:30-13:30 | 16:30-18:30', '', 0, 1, 0, '2018-08-01 17:55:04');
INSERT INTO `shop_location` VALUES (2, 3, '门店3', '门店3联系人', '18476420333', 1.00, 0, NULL, NULL, '广东省', '珠海市', '金湾区', '珠海市城市职业技术学校', 'http://ruwei.com/static/upload/ff7035667a648714/3d49273f3013587d.jpg', 'http://ruwei.com/static/upload/f0df1cee65b466d6/daf6165e0e127697.jpg|http://ruwei.com/static/upload/236eb146d6cef559/3f75ad166fdb6890.jpg', '营业时间10:30-13:30 | 16:30-18:30', '', 0, 1, 0, '2018-08-01 17:58:26');
INSERT INTO `shop_location` VALUES (4, 4, '门店4', '门店4联系人', '18476420444', 10.00, 0, NULL, NULL, '广东省', '深圳市', '南山区', '欧洲城东', 'http://ruwei.com/static/upload/236eb146d6cef559/3f75ad166fdb6890.jpg', 'http://ruwei.com/static/upload/ee762d7ffdb92ffa/83d7578aafa23a1c.jpg|http://ruwei.com/static/upload/1d5e9a1f4a375937/c28e7c2167c32812.jpg|http://ruwei.com/static/upload/130dae9e132c4275/cec56df6b54e134b.jpg|http://ruwei.com/static/upload/6915fa913bb95279/80d6d1e14074778d.jpg|http://ruwei.com/static/upload/f0df1cee65b466d6/daf6165e0e127697.jpg', '营业时间11:00-13:30', '', 0, 1, 0, '2018-08-30 11:30:07');

-- ----------------------------
-- Table structure for shop_member
-- ----------------------------
DROP TABLE IF EXISTS `shop_member`;
CREATE TABLE `shop_member`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `openid` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '会员微信OPENID',
  `unionid` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '会员微信UnionID',
  `phone` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '会员手机号',
  `password` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '登录密码',
  `nickname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '会员昵称',
  `headimg` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '会员头像',
  `sex` char(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '性别',
  `level` tinyint(2) UNSIGNED NULL DEFAULT 1 COMMENT '会员级别',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '会员个性签名',
  `status` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '会员状态(1有效,0无效)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `index_shop_member_openid`(`openid`) USING BTREE,
  UNIQUE INDEX `index_shop_member_unionid`(`unionid`) USING BTREE,
  INDEX `index_shop_member_phone`(`phone`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '门店会员信息' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of shop_member
-- ----------------------------
INSERT INTO `shop_member` VALUES (1, 'oh-1x53M44u2IBwy0POJ9Fck-Rpc', '', '15220501265', '', '', '', '', 1, '', 1, '2018-08-13 19:26:55');

-- ----------------------------
-- Table structure for shop_member_address
-- ----------------------------
DROP TABLE IF EXISTS `shop_member_address`;
CREATE TABLE `shop_member_address`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `mid` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '会员ID',
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '收货人姓名',
  `phone` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '收货手机号',
  `province` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '收货地址省份',
  `city` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '收货地址城市',
  `area` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '收货地址区域',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '收货详细地址',
  `desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注',
  `status` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '状态(0无效, 1新快递)',
  `is_default` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '默认收货地址',
  `is_deleted` bigint(1) UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(1删除,0未删除)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '门店会员收货地址' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of shop_member_address
-- ----------------------------
INSERT INTO `shop_member_address` VALUES (1, 1, '阿猫', '15220501265', '广东省', '深圳市', '南山区', '新安', '不要加辣', 1, 1, 0, '2018-08-31 16:05:50');

-- ----------------------------
-- Table structure for shop_merchant
-- ----------------------------
DROP TABLE IF EXISTS `shop_merchant`;
CREATE TABLE `shop_merchant`  (
  `id` bigint(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `merchant_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '商户名称',
  `merchant_email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '商户邮箱',
  `merchant_province` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '商户地址省份',
  `merchant_city` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '商户地址城市',
  `merchant_area` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '商户地址区域',
  `merchant_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '商户详细地址',
  `merchant_logo` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '商户LOGO',
  `merchant_license` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '商户营业执照',
  `merchant_desc` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '商户描述',
  `bank_account` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '开户行银行账号',
  `bank_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '开户行名称',
  `bank_username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '开户行用户',
  `bank_money` decimal(20, 2) NOT NULL DEFAULT 0.00 COMMENT '开户行金额',
  `legal_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '法人名称',
  `legal_phone` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '法人联系电话',
  `legal_posit_card` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '法人身份证正面图片',
  `legal_back_card` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '法人身份证背面图片',
  `sort` bigint(11) UNSIGNED NULL DEFAULT 0 COMMENT '商户排序',
  `status` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '商户状态(1有效,0无效)',
  `is_deleted` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(1删除,0未删除)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '门店商户表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of shop_merchant
-- ----------------------------
INSERT INTO `shop_merchant` VALUES (1, '商户1', '', '0', '', '商户1', '', '', '', '', '', '', '', 0.00, '', '', '', '', 0, 1, 1, '2018-08-01 11:23:04');
INSERT INTO `shop_merchant` VALUES (2, '商户2', '', '北京市', '市辖区', '东城区', '', '', '', '', '', '', '', 0.00, '', '', '', '', 5, 1, 0, '2018-08-01 11:25:02');
INSERT INTO `shop_merchant` VALUES (3, '商户3', '', '北京市', '市辖区', '东城区', '', '', '', '', '', '', '', 0.00, '', '', '', '', 7, 1, 0, '2018-08-01 11:28:42');
INSERT INTO `shop_merchant` VALUES (4, '商户4', '277@qq.com', '广东省', '广州市', '荔湾区', '23232323', 'http://ruwei.com/static/upload/64842c39139900d6/1df0c1a19757f531.jpg', 'http://ruwei.com/static/upload/9b87fb7a0d54ce0b/eaeb7c8d79e9d94b.jpg', '', '', '', '', 0.00, '', '', 'http://ruwei.com/static/upload/401979857c0fe815/bca134c7e01cfc48.jpg', 'http://ruwei.com/static/upload/130dae9e132c4275/cec56df6b54e134b.jpg', 8, 1, 0, '2018-08-01 11:29:12');

-- ----------------------------
-- Table structure for shop_order
-- ----------------------------
DROP TABLE IF EXISTS `shop_order`;
CREATE TABLE `shop_order`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `shop_id` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '门店ID',
  `mid` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '会员ID',
  `order_no` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '订单号',
  `order_title` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '订单名称',
  `order_logo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '订单LOGO',
  `freight_price` decimal(20, 2) UNSIGNED NULL DEFAULT 0.00 COMMENT '快递费',
  `goods_price` decimal(20, 2) UNSIGNED NULL DEFAULT 0.00 COMMENT '订单商品总金额(不含快递费)',
  `goods_count` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '订单商品总件数',
  `real_price` decimal(20, 2) UNSIGNED NULL DEFAULT 0.00 COMMENT '订单真实支付金额(商品金额+快递金额)',
  `is_pay` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '订单支付状态(0.未支付,1.已支付)',
  `pay_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '支付方式 (wechat微信支付, alipay支付宝支付)',
  `pay_no` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '商户交易号',
  `pay_price` decimal(20, 2) UNSIGNED NULL DEFAULT 0.00 COMMENT '实际支付金额',
  `pay_at` datetime(0) NULL DEFAULT NULL COMMENT '支付时间',
  `desc` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '订单描述',
  `status` bigint(1) UNSIGNED NULL DEFAULT 1 COMMENT '订单状态(0.无效,1.新订单,2.待发货,3.已发货,4.已收货,5.已完成,6.已退货及退款)',
  `is_deleted` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(1删除,0未删除)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_shop_order_order_no`(`order_no`) USING BTREE,
  INDEX `index_shop_order_status`(`status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '门店订单主表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of shop_order
-- ----------------------------
INSERT INTO `shop_order` VALUES (3, 2, 1, 'A8318672502600682', '猪扒饭等', 'http://ruwei.com/static/upload/cb3f32cb706c0325/c1c1afa9b2c5e9a3.jpg', 0.00, 32.50, 3, 32.50, 0, 'wechat微信支付', '', 32.50, NULL, '不要加辣', 4, 0, '2018-08-31 11:38:45');
INSERT INTO `shop_order` VALUES (4, 2, 1, 'A8318685467700443', '猪扒饭等', 'http://ruwei.com/static/upload/cb3f32cb706c0325/c1c1afa9b2c5e9a3.jpg', 0.00, 12500020.00, 1000002, 12500020.00, 0, 'wechat微信支付', '', 12500020.00, NULL, '不要加辣', 4, 0, '2018-08-31 11:40:54');
INSERT INTO `shop_order` VALUES (5, 2, 1, 'A8318733897800731', '猪扒饭等', 'http://ruwei.com/static/upload/cb3f32cb706c0325/c1c1afa9b2c5e9a3.jpg', 0.00, 32.50, 3, 32.50, 0, 'wechat微信支付', '', 32.50, NULL, '不要加辣', 4, 0, '2018-08-31 11:48:58');
INSERT INTO `shop_order` VALUES (6, 2, 1, 'A8318767205500096', '猪扒饭等', 'http://ruwei.com/static/upload/cb3f32cb706c0325/c1c1afa9b2c5e9a3.jpg', 0.00, 32.50, 3, 32.50, 0, 'wechat微信支付', '', 32.50, NULL, '不要加辣', 5, 0, '2018-08-31 11:54:32');
INSERT INTO `shop_order` VALUES (7, 2, 1, 'A8318769256200125', '猪扒饭等', 'http://ruwei.com/static/upload/cb3f32cb706c0325/c1c1afa9b2c5e9a3.jpg', 0.00, 32.50, 3, 32.50, 0, 'wechat微信支付', '', 32.50, NULL, '不要加辣', 6, 0, '2018-08-31 11:54:52');
INSERT INTO `shop_order` VALUES (8, 2, 1, 'A8318775966800382', '龟苓膏（芦苇）等', 'http://ruwei.com/static/upload/3837304710d6af3d/9704596f307eb1e7.jpg', 0.00, 32.50, 3, 32.50, 0, 'wechat微信支付', '', 32.50, NULL, '不要加辣', 1, 0, '2018-08-31 11:55:59');
INSERT INTO `shop_order` VALUES (9, 2, 1, 'A8319583615500157', '龟苓膏（芦苇）等', 'http://ruwei.com/static/upload/3837304710d6af3d/9704596f307eb1e7.jpg', 0.00, 32.50, 3, 32.50, 0, 'wechat微信支付', '', 32.50, NULL, '不要加辣', 1, 0, '2018-08-31 14:10:36');
INSERT INTO `shop_order` VALUES (10, 2, 1, 'A8319593436800430', '龟苓膏（芦苇）等', 'http://ruwei.com/static/upload/3837304710d6af3d/9704596f307eb1e7.jpg', 0.00, 32.50, 3, 32.50, 0, 'wechat微信支付', '', 32.50, NULL, '不要加辣', 1, 0, '2018-08-31 14:12:14');
INSERT INTO `shop_order` VALUES (11, 2, 1, 'A8319593532500692', '龟苓膏（芦苇）等', 'http://ruwei.com/static/upload/3837304710d6af3d/9704596f307eb1e7.jpg', 0.00, 32.50, 3, 32.50, 0, 'wechat微信支付', '', 32.50, NULL, '不要加辣', 1, 0, '2018-08-31 14:12:15');
INSERT INTO `shop_order` VALUES (12, 2, 1, 'A8319593609700832', '龟苓膏（芦苇）等', 'http://ruwei.com/static/upload/3837304710d6af3d/9704596f307eb1e7.jpg', 0.00, 32.50, 3, 32.50, 0, 'wechat微信支付', '', 32.50, NULL, '不要加辣', 1, 0, '2018-08-31 14:12:16');
INSERT INTO `shop_order` VALUES (13, 2, 1, 'A8319593699700518', '龟苓膏（芦苇）等', 'http://ruwei.com/static/upload/3837304710d6af3d/9704596f307eb1e7.jpg', 0.00, 32.50, 3, 32.50, 0, 'wechat微信支付', '', 32.50, NULL, '不要加辣', 1, 0, '2018-08-31 14:12:17');
INSERT INTO `shop_order` VALUES (14, 2, 1, 'A8319598061300364', '龟苓膏（芦苇）等', 'http://ruwei.com/static/upload/3837304710d6af3d/9704596f307eb1e7.jpg', 0.00, 32.50, 3, 32.50, 0, 'wechat微信支付', '', 32.50, NULL, '不要加辣', 1, 0, '2018-08-31 14:13:00');
INSERT INTO `shop_order` VALUES (15, 2, 1, 'A8311913972000961', '龟苓膏（芦苇）等', 'http://ruwei.com/static/upload/3837304710d6af3d/9704596f307eb1e7.jpg', 0.00, 32.50, 3, 32.50, 0, 'wechat微信支付', '', 32.50, NULL, '不要加辣', 1, 0, '2018-08-31 20:38:59');
INSERT INTO `shop_order` VALUES (16, 2, 1, 'A8311929154600760', '龟苓膏（芦苇）等', 'http://ruwei.com/static/upload/3837304710d6af3d/9704596f307eb1e7.jpg', 0.00, 32.50, 3, 32.50, 0, 'wechat微信支付', '', 32.50, NULL, '不要加辣', 1, 0, '2018-08-31 20:41:31');
INSERT INTO `shop_order` VALUES (17, 2, 1, 'A8311929564400994', '龟苓膏（芦苇）等', 'http://ruwei.com/static/upload/3837304710d6af3d/9704596f307eb1e7.jpg', 0.00, 32.50, 3, 32.50, 0, 'wechat微信支付', '', 32.50, NULL, '不要加辣', 1, 0, '2018-08-31 20:41:35');

-- ----------------------------
-- Table structure for shop_order_express
-- ----------------------------
DROP TABLE IF EXISTS `shop_order_express`;
CREATE TABLE `shop_order_express`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `shop_id` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '门店ID',
  `mid` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '会员ID',
  `type` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '快递类型(0.订单快递,1.退货快递)',
  `order_no` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '订单编号',
  `express_username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '收货人姓名',
  `express_phone` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '收货手机号',
  `express_province` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收货地址省份',
  `express_city` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '收货地址城市',
  `express_area` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '收货地址区域',
  `express_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '收货详细地址',
  `send_username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '寄件人名称',
  `send_phone` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '寄件人手机号',
  `send_province` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '寄件人地址省份',
  `send_city` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '寄件人地址城市',
  `send_area` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '寄件人地址区域',
  `send_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '寄件人详细地址',
  `send_at` datetime(0) NULL DEFAULT NULL COMMENT '快递发货时间',
  `desc` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '发货描述',
  `status` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '状态(0.无效,1.新快递,2.已签收,3.签收失败)',
  `is_deleted` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(1删除,0未删除)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '门店订单配送信息' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of shop_order_express
-- ----------------------------
INSERT INTO `shop_order_express` VALUES (3, 2, 1, 0, 'A8318672502600682', '阿猫', '15220501265', '广东省', '深圳市', '南山区', '1栋111', '门店3联系人', '18476420333', '广东省', '珠海市', '金湾区', '珠海市城市职业技术学校', NULL, '补单', 1, 0, '2018-08-31 11:38:45');
INSERT INTO `shop_order_express` VALUES (4, 2, 1, 0, 'A8318685467700443', '阿猫', '15220501265', '广东省', '深圳市', '宝安区', '2栋622', '门店3联系人', '18476420333', '广东省', '珠海市', '金湾区', '珠海市城市职业技术学校', NULL, 'desc', 1, 0, '2018-08-31 11:40:54');
INSERT INTO `shop_order_express` VALUES (5, 2, 1, 0, 'A8318733897800731', '阿猫', '15220501265', '广东省', '深圳市', '南山区', '2栋622', '门店3联系人', '18476420333', '广东省', '珠海市', '金湾区', '珠海市城市职业技术学校', NULL, NULL, 1, 0, '2018-08-31 11:48:59');
INSERT INTO `shop_order_express` VALUES (6, 2, 1, 0, 'A8318767205500096', '阿猫', '15220501265', '广东省', '深圳市', '南山区', '2栋622', '门店3联系人', '18476420333', '广东省', '珠海市', '金湾区', '珠海市城市职业技术学校', NULL, NULL, 1, 0, '2018-08-31 11:54:32');
INSERT INTO `shop_order_express` VALUES (7, 2, 1, 0, 'A8318769256200125', '阿猫', '15220501265', '广东省', '深圳市', '南山区', '2栋622', '门店3联系人', '18476420333', '广东省', '珠海市', '金湾区', '珠海市城市职业技术学校', NULL, NULL, 1, 0, '2018-08-31 11:54:52');
INSERT INTO `shop_order_express` VALUES (8, 2, 1, 0, 'A8318775966800382', '阿猫', '15220501265', '广东省', '深圳市', '南山区', '新安2栋365', '门店3联系人', '18476420333', '广东省', '珠海市', '金湾区', '珠海市城市职业技术学校', NULL, '补单', 1, 0, '2018-08-31 11:55:59');
INSERT INTO `shop_order_express` VALUES (9, 2, 1, 0, 'A8319583615500157', '阿猫', '15220501265', '广东省', '深圳市', '南山区', '2栋622', '门店3联系人', '18476420333', '广东省', '珠海市', '金湾区', '珠海市城市职业技术学校', NULL, NULL, 1, 0, '2018-08-31 14:10:36');
INSERT INTO `shop_order_express` VALUES (10, 2, 1, 0, 'A8319593436800430', '阿猫', '15220501265', '广东省', '深圳市', '南山区', '2栋622', '门店3联系人', '18476420333', '广东省', '珠海市', '金湾区', '珠海市城市职业技术学校', NULL, NULL, 1, 0, '2018-08-31 14:12:14');
INSERT INTO `shop_order_express` VALUES (11, 2, 1, 0, 'A8319593532500692', '阿猫', '15220501265', '广东省', '深圳市', '南山区', '2栋622', '门店3联系人', '18476420333', '广东省', '珠海市', '金湾区', '珠海市城市职业技术学校', NULL, NULL, 1, 0, '2018-08-31 14:12:15');
INSERT INTO `shop_order_express` VALUES (12, 2, 1, 0, 'A8319593609700832', '阿猫', '15220501265', '广东省', '深圳市', '南山区', '2栋622', '门店3联系人', '18476420333', '广东省', '珠海市', '金湾区', '珠海市城市职业技术学校', NULL, NULL, 1, 0, '2018-08-31 14:12:16');
INSERT INTO `shop_order_express` VALUES (13, 2, 1, 0, 'A8319593699700518', '阿猫', '15220501265', '广东省', '深圳市', '南山区', '2栋622', '门店3联系人', '18476420333', '广东省', '珠海市', '金湾区', '珠海市城市职业技术学校', NULL, NULL, 1, 0, '2018-08-31 14:12:17');
INSERT INTO `shop_order_express` VALUES (14, 2, 1, 0, 'A8319598061300364', '阿猫', '15220501265', '广东省', '深圳市', '南山区', '2栋622', '门店3联系人', '18476420333', '广东省', '珠海市', '金湾区', '珠海市城市职业技术学校', NULL, NULL, 1, 0, '2018-08-31 14:13:00');
INSERT INTO `shop_order_express` VALUES (15, 2, 1, 0, 'A8311913972000961', '阿猫', '15220501265', '广东省', '深圳市', '南山区', '2栋622', '门店3联系人', '18476420333', '广东省', '珠海市', '金湾区', '珠海市城市职业技术学校', NULL, NULL, 1, 0, '2018-08-31 20:38:59');
INSERT INTO `shop_order_express` VALUES (16, 2, 1, 0, 'A8311929154600760', '阿猫', '15220501265', '广东省', '深圳市', '南山区', '2栋622', '门店3联系人', '18476420333', '广东省', '珠海市', '金湾区', '珠海市城市职业技术学校', NULL, NULL, 1, 0, '2018-08-31 20:41:31');
INSERT INTO `shop_order_express` VALUES (17, 2, 1, 0, 'A8311929564400994', '阿猫', '15220501265', '广东省', '深圳市', '南山区', '2栋622', '门店3联系人', '18476420333', '广东省', '珠海市', '金湾区', '珠海市城市职业技术学校', NULL, NULL, 1, 0, '2018-08-31 20:41:35');

-- ----------------------------
-- Table structure for shop_order_goods
-- ----------------------------
DROP TABLE IF EXISTS `shop_order_goods`;
CREATE TABLE `shop_order_goods`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `shop_id` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '门店ID',
  `mid` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '会员ID',
  `order_no` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '订单编号',
  `goods_id` bigint(20) NULL DEFAULT 0 COMMENT '商品ID',
  `goods_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '商品标签',
  `goods_logo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '商品LOGO',
  `goods_image` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '商品图片地址',
  `selling_price` decimal(20, 2) UNSIGNED NULL DEFAULT 0.00 COMMENT '商品销售价格',
  `price_field` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'selling_price' COMMENT '计价字段',
  `number` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '订单商品数量',
  `status` bigint(1) UNSIGNED NULL DEFAULT 1 COMMENT '商品状态(1有效,0无效)',
  `is_deleted` bigint(1) UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(1删除,0未删除)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_shop_order_list_order_no`(`order_no`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '门店订单关联商品' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of shop_order_goods
-- ----------------------------
INSERT INTO `shop_order_goods` VALUES (5, 2, 1, 'A8318672502600682', 1, '猪扒饭', 'http://ruwei.com/static/upload/cb3f32cb706c0325/c1c1afa9b2c5e9a3.jpg', NULL, 12.50, 'selling_price', 1, 1, 0, '2018-08-31 11:38:45');
INSERT INTO `shop_order_goods` VALUES (6, 2, 1, 'A8318672502600682', 2, '龟苓膏（芦苇）', 'http://ruwei.com/static/upload/3837304710d6af3d/9704596f307eb1e7.jpg', NULL, 10.00, 'selling_price', 2, 1, 0, '2018-08-31 11:38:45');
INSERT INTO `shop_order_goods` VALUES (7, 2, 1, 'A8318685467700443', 1, '猪扒饭', 'http://ruwei.com/static/upload/cb3f32cb706c0325/c1c1afa9b2c5e9a3.jpg', NULL, 12.50, 'selling_price', 1000000, 1, 0, '2018-08-31 11:40:54');
INSERT INTO `shop_order_goods` VALUES (8, 2, 1, 'A8318685467700443', 2, '龟苓膏（芦苇）', 'http://ruwei.com/static/upload/3837304710d6af3d/9704596f307eb1e7.jpg', NULL, 10.00, 'selling_price', 2, 1, 0, '2018-08-31 11:40:54');
INSERT INTO `shop_order_goods` VALUES (9, 2, 1, 'A8318733897800731', 1, '猪扒饭', 'http://ruwei.com/static/upload/cb3f32cb706c0325/c1c1afa9b2c5e9a3.jpg', NULL, 12.50, 'selling_price', 1, 1, 0, '2018-08-31 11:48:59');
INSERT INTO `shop_order_goods` VALUES (10, 2, 1, 'A8318733897800731', 2, '龟苓膏（芦苇）', 'http://ruwei.com/static/upload/3837304710d6af3d/9704596f307eb1e7.jpg', NULL, 10.00, 'selling_price', 2, 1, 0, '2018-08-31 11:48:59');
INSERT INTO `shop_order_goods` VALUES (11, 2, 1, 'A8318767205500096', 1, '猪扒饭', 'http://ruwei.com/static/upload/cb3f32cb706c0325/c1c1afa9b2c5e9a3.jpg', NULL, 12.50, 'selling_price', 1, 1, 0, '2018-08-31 11:54:32');
INSERT INTO `shop_order_goods` VALUES (12, 2, 1, 'A8318767205500096', 2, '龟苓膏（芦苇）', 'http://ruwei.com/static/upload/3837304710d6af3d/9704596f307eb1e7.jpg', NULL, 10.00, 'selling_price', 2, 1, 0, '2018-08-31 11:54:32');
INSERT INTO `shop_order_goods` VALUES (13, 2, 1, 'A8318769256200125', 1, '猪扒饭', 'http://ruwei.com/static/upload/cb3f32cb706c0325/c1c1afa9b2c5e9a3.jpg', NULL, 12.50, 'selling_price', 1, 1, 0, '2018-08-31 11:54:52');
INSERT INTO `shop_order_goods` VALUES (14, 2, 1, 'A8318769256200125', 2, '龟苓膏（芦苇）', 'http://ruwei.com/static/upload/3837304710d6af3d/9704596f307eb1e7.jpg', NULL, 10.00, 'selling_price', 2, 1, 0, '2018-08-31 11:54:52');
INSERT INTO `shop_order_goods` VALUES (15, 2, 1, 'A8318775966800382', 2, '龟苓膏（芦苇）', 'http://ruwei.com/static/upload/3837304710d6af3d/9704596f307eb1e7.jpg', NULL, 10.00, 'selling_price', 2, 1, 0, '2018-08-31 11:55:59');
INSERT INTO `shop_order_goods` VALUES (16, 2, 1, 'A8318775966800382', 1, '猪扒饭', 'http://ruwei.com/static/upload/cb3f32cb706c0325/c1c1afa9b2c5e9a3.jpg', NULL, 12.50, 'selling_price', 1, 1, 0, '2018-08-31 11:55:59');
INSERT INTO `shop_order_goods` VALUES (17, 2, 1, 'A8319583615500157', 2, '龟苓膏（芦苇）', 'http://ruwei.com/static/upload/3837304710d6af3d/9704596f307eb1e7.jpg', NULL, 10.00, 'selling_price', 2, 1, 0, '2018-08-31 14:10:36');
INSERT INTO `shop_order_goods` VALUES (18, 2, 1, 'A8319583615500157', 1, '猪扒饭', 'http://ruwei.com/static/upload/cb3f32cb706c0325/c1c1afa9b2c5e9a3.jpg', NULL, 12.50, 'selling_price', 1, 1, 0, '2018-08-31 14:10:36');
INSERT INTO `shop_order_goods` VALUES (19, 2, 1, 'A8319593436800430', 2, '龟苓膏（芦苇）', 'http://ruwei.com/static/upload/3837304710d6af3d/9704596f307eb1e7.jpg', NULL, 10.00, 'selling_price', 2, 1, 0, '2018-08-31 14:12:14');
INSERT INTO `shop_order_goods` VALUES (20, 2, 1, 'A8319593436800430', 1, '猪扒饭', 'http://ruwei.com/static/upload/cb3f32cb706c0325/c1c1afa9b2c5e9a3.jpg', NULL, 12.50, 'selling_price', 1, 1, 0, '2018-08-31 14:12:14');
INSERT INTO `shop_order_goods` VALUES (21, 2, 1, 'A8319593532500692', 2, '龟苓膏（芦苇）', 'http://ruwei.com/static/upload/3837304710d6af3d/9704596f307eb1e7.jpg', NULL, 10.00, 'selling_price', 2, 1, 0, '2018-08-31 14:12:15');
INSERT INTO `shop_order_goods` VALUES (22, 2, 1, 'A8319593532500692', 1, '猪扒饭', 'http://ruwei.com/static/upload/cb3f32cb706c0325/c1c1afa9b2c5e9a3.jpg', NULL, 12.50, 'selling_price', 1, 1, 0, '2018-08-31 14:12:15');
INSERT INTO `shop_order_goods` VALUES (23, 2, 1, 'A8319593609700832', 2, '龟苓膏（芦苇）', 'http://ruwei.com/static/upload/3837304710d6af3d/9704596f307eb1e7.jpg', NULL, 10.00, 'selling_price', 2, 1, 0, '2018-08-31 14:12:16');
INSERT INTO `shop_order_goods` VALUES (24, 2, 1, 'A8319593609700832', 1, '猪扒饭', 'http://ruwei.com/static/upload/cb3f32cb706c0325/c1c1afa9b2c5e9a3.jpg', NULL, 12.50, 'selling_price', 1, 1, 0, '2018-08-31 14:12:16');
INSERT INTO `shop_order_goods` VALUES (25, 2, 1, 'A8319593699700518', 2, '龟苓膏（芦苇）', 'http://ruwei.com/static/upload/3837304710d6af3d/9704596f307eb1e7.jpg', NULL, 10.00, 'selling_price', 2, 1, 0, '2018-08-31 14:12:17');
INSERT INTO `shop_order_goods` VALUES (26, 2, 1, 'A8319593699700518', 1, '猪扒饭', 'http://ruwei.com/static/upload/cb3f32cb706c0325/c1c1afa9b2c5e9a3.jpg', NULL, 12.50, 'selling_price', 1, 1, 0, '2018-08-31 14:12:17');
INSERT INTO `shop_order_goods` VALUES (27, 2, 1, 'A8319598061300364', 2, '龟苓膏（芦苇）', 'http://ruwei.com/static/upload/3837304710d6af3d/9704596f307eb1e7.jpg', NULL, 10.00, 'selling_price', 2, 1, 0, '2018-08-31 14:13:00');
INSERT INTO `shop_order_goods` VALUES (28, 2, 1, 'A8319598061300364', 1, '猪扒饭', 'http://ruwei.com/static/upload/cb3f32cb706c0325/c1c1afa9b2c5e9a3.jpg', NULL, 12.50, 'selling_price', 1, 1, 0, '2018-08-31 14:13:00');
INSERT INTO `shop_order_goods` VALUES (29, 2, 1, 'A8311913972000961', 2, '龟苓膏（芦苇）', 'http://ruwei.com/static/upload/3837304710d6af3d/9704596f307eb1e7.jpg', NULL, 10.00, 'selling_price', 2, 1, 0, '2018-08-31 20:38:59');
INSERT INTO `shop_order_goods` VALUES (30, 2, 1, 'A8311913972000961', 1, '猪扒饭', 'http://ruwei.com/static/upload/cb3f32cb706c0325/c1c1afa9b2c5e9a3.jpg', NULL, 12.50, 'selling_price', 1, 1, 0, '2018-08-31 20:38:59');
INSERT INTO `shop_order_goods` VALUES (31, 2, 1, 'A8311929154600760', 2, '龟苓膏（芦苇）', 'http://ruwei.com/static/upload/3837304710d6af3d/9704596f307eb1e7.jpg', NULL, 10.00, 'selling_price', 2, 1, 0, '2018-08-31 20:41:31');
INSERT INTO `shop_order_goods` VALUES (32, 2, 1, 'A8311929154600760', 1, '猪扒饭', 'http://ruwei.com/static/upload/cb3f32cb706c0325/c1c1afa9b2c5e9a3.jpg', NULL, 12.50, 'selling_price', 1, 1, 0, '2018-08-31 20:41:31');
INSERT INTO `shop_order_goods` VALUES (33, 2, 1, 'A8311929564400994', 2, '龟苓膏（芦苇）', 'http://ruwei.com/static/upload/3837304710d6af3d/9704596f307eb1e7.jpg', NULL, 10.00, 'selling_price', 2, 1, 0, '2018-08-31 20:41:35');
INSERT INTO `shop_order_goods` VALUES (34, 2, 1, 'A8311929564400994', 1, '猪扒饭', 'http://ruwei.com/static/upload/cb3f32cb706c0325/c1c1afa9b2c5e9a3.jpg', NULL, 12.50, 'selling_price', 1, 1, 0, '2018-08-31 20:41:35');

-- ----------------------------
-- Table structure for store_express
-- ----------------------------
DROP TABLE IF EXISTS `store_express`;
CREATE TABLE `store_express`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `express_title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '快递公司名称',
  `express_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '快递公司代码',
  `express_desc` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '快递公司描述',
  `status` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '状态(0.无效,1.有效)',
  `sort` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '排序',
  `is_deleted` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(1删除,0未删除)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 95 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商城快递配置' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of store_express
-- ----------------------------
INSERT INTO `store_express` VALUES (5, 'AAE全球专递', 'aae', '顺丰快递公司', 0, 0, 0, '2017-09-12 11:53:40');
INSERT INTO `store_express` VALUES (6, '安捷快递', 'anjie', '', 0, 0, 0, '2017-09-13 15:27:26');
INSERT INTO `store_express` VALUES (7, '安信达快递', 'anxindakuaixi', NULL, 0, 0, 0, '2017-09-13 16:05:19');
INSERT INTO `store_express` VALUES (8, '彪记快递', 'biaojikuaidi', NULL, 0, 0, 0, '2017-09-13 16:05:26');
INSERT INTO `store_express` VALUES (9, 'BHT', 'bht', '', 0, 0, 0, '2017-09-13 16:05:37');
INSERT INTO `store_express` VALUES (10, '百福东方国际物流', 'baifudongfang', NULL, 0, 0, 0, '2017-09-13 16:05:41');
INSERT INTO `store_express` VALUES (11, '中国东方（COE）', 'coe', NULL, 0, 0, 0, '2017-09-13 16:05:48');
INSERT INTO `store_express` VALUES (12, '长宇物流', 'changyuwuliu', NULL, 0, 0, 0, '2017-09-13 16:05:58');
INSERT INTO `store_express` VALUES (13, '大田物流', 'datianwuliu', NULL, 0, 0, 0, '2017-09-13 16:06:06');
INSERT INTO `store_express` VALUES (14, '德邦物流', 'debangwuliu', NULL, 1, 1, 0, '2017-09-13 16:06:14');
INSERT INTO `store_express` VALUES (15, 'DHL', 'dhl', NULL, 0, 0, 0, '2017-09-13 16:06:24');
INSERT INTO `store_express` VALUES (16, 'DPEX', 'dpex', NULL, 0, 0, 0, '2017-09-13 16:06:29');
INSERT INTO `store_express` VALUES (17, 'd速快递', 'dsukuaidi', NULL, 0, 0, 0, '2017-09-13 16:06:34');
INSERT INTO `store_express` VALUES (18, '递四方', 'disifang', NULL, 0, 0, 0, '2017-09-13 16:06:40');
INSERT INTO `store_express` VALUES (19, 'EMS快递', 'ems', '', 1, 0, 0, '2017-09-13 16:06:47');
INSERT INTO `store_express` VALUES (20, 'FEDEX（国外）', 'fedex', NULL, 0, 0, 0, '2017-09-13 16:06:56');
INSERT INTO `store_express` VALUES (21, '飞康达物流', 'feikangda', NULL, 0, 0, 0, '2017-09-13 16:07:03');
INSERT INTO `store_express` VALUES (22, '凤凰快递', 'fenghuangkuaidi', NULL, 0, 0, 0, '2017-09-13 16:07:10');
INSERT INTO `store_express` VALUES (23, '飞快达', 'feikuaida', NULL, 0, 0, 0, '2017-09-13 16:07:16');
INSERT INTO `store_express` VALUES (24, '国通快递', 'guotongkuaidi', NULL, 0, 0, 0, '2017-09-13 16:07:27');
INSERT INTO `store_express` VALUES (25, '港中能达物流', 'ganzhongnengda', NULL, 0, 0, 0, '2017-09-13 16:07:33');
INSERT INTO `store_express` VALUES (26, '广东邮政物流', 'guangdongyouzhengwuliu', NULL, 0, 0, 0, '2017-09-13 16:08:22');
INSERT INTO `store_express` VALUES (27, '共速达', 'gongsuda', NULL, 0, 0, 0, '2017-09-13 16:08:48');
INSERT INTO `store_express` VALUES (28, '汇通快运', 'huitongkuaidi', NULL, 0, 0, 0, '2017-09-13 16:08:56');
INSERT INTO `store_express` VALUES (29, '恒路物流', 'hengluwuliu', NULL, 0, 0, 0, '2017-09-13 16:09:02');
INSERT INTO `store_express` VALUES (30, '华夏龙物流', 'huaxialongwuliu', NULL, 0, 0, 0, '2017-09-13 16:09:12');
INSERT INTO `store_express` VALUES (31, '海红', 'haihongwangsong', NULL, 0, 0, 0, '2017-09-13 16:09:20');
INSERT INTO `store_express` VALUES (32, '海外环球', 'haiwaihuanqiu', NULL, 0, 0, 0, '2017-09-13 16:09:27');
INSERT INTO `store_express` VALUES (33, '佳怡物流', 'jiayiwuliu', NULL, 0, 0, 0, '2017-09-13 16:09:35');
INSERT INTO `store_express` VALUES (34, '京广速递', 'jinguangsudikuaijian', NULL, 0, 0, 0, '2017-09-13 16:09:42');
INSERT INTO `store_express` VALUES (35, '急先达', 'jixianda', NULL, 0, 0, 0, '2017-09-13 16:09:49');
INSERT INTO `store_express` VALUES (36, '佳吉物流', 'jjwl', NULL, 0, 0, 0, '2017-09-13 16:10:01');
INSERT INTO `store_express` VALUES (37, '加运美物流', 'jymwl', NULL, 0, 0, 0, '2017-09-13 16:10:13');
INSERT INTO `store_express` VALUES (38, '金大物流', 'jindawuliu', NULL, 0, 0, 0, '2017-09-13 16:10:22');
INSERT INTO `store_express` VALUES (39, '嘉里大通', 'jialidatong', NULL, 0, 0, 0, '2017-09-13 16:10:33');
INSERT INTO `store_express` VALUES (40, '晋越快递', 'jykd', NULL, 0, 0, 0, '2017-09-13 16:10:40');
INSERT INTO `store_express` VALUES (41, '快捷速递', 'kuaijiesudi', NULL, 0, 0, 0, '2017-09-13 16:10:49');
INSERT INTO `store_express` VALUES (42, '联邦快递（国内）', 'lianb', NULL, 0, 0, 0, '2017-09-13 16:10:58');
INSERT INTO `store_express` VALUES (43, '联昊通物流', 'lianhaowuliu', NULL, 0, 0, 0, '2017-09-13 16:11:07');
INSERT INTO `store_express` VALUES (44, '龙邦物流', 'longbanwuliu', NULL, 0, 0, 0, '2017-09-13 16:11:15');
INSERT INTO `store_express` VALUES (45, '立即送', 'lijisong', NULL, 0, 0, 0, '2017-09-13 16:11:25');
INSERT INTO `store_express` VALUES (46, '乐捷递', 'lejiedi', NULL, 0, 0, 0, '2017-09-13 16:11:36');
INSERT INTO `store_express` VALUES (47, '民航快递', 'minghangkuaidi', NULL, 0, 0, 0, '2017-09-13 16:11:45');
INSERT INTO `store_express` VALUES (48, '美国快递', 'meiguokuaidi', NULL, 0, 0, 0, '2017-09-13 16:11:53');
INSERT INTO `store_express` VALUES (49, '门对门', 'menduimen', NULL, 0, 0, 0, '2017-09-13 16:12:01');
INSERT INTO `store_express` VALUES (50, 'OCS', 'ocs', NULL, 0, 0, 0, '2017-09-13 16:12:10');
INSERT INTO `store_express` VALUES (51, '配思货运', 'peisihuoyunkuaidi', NULL, 0, 0, 0, '2017-09-13 16:12:18');
INSERT INTO `store_express` VALUES (52, '全晨快递', 'quanchenkuaidi', NULL, 0, 0, 0, '2017-09-13 16:12:26');
INSERT INTO `store_express` VALUES (53, '全峰快递', 'quanfengkuaidi', NULL, 0, 0, 0, '2017-09-13 16:12:34');
INSERT INTO `store_express` VALUES (54, '全际通物流', 'quanjitong', NULL, 0, 0, 0, '2017-09-13 16:12:41');
INSERT INTO `store_express` VALUES (55, '全日通快递', 'quanritongkuaidi', NULL, 0, 0, 0, '2017-09-13 16:12:49');
INSERT INTO `store_express` VALUES (56, '全一快递', 'quanyikuaidi', NULL, 0, 0, 0, '2017-09-13 16:12:56');
INSERT INTO `store_express` VALUES (57, '如风达', 'rufengda', NULL, 0, 0, 0, '2017-09-13 16:13:03');
INSERT INTO `store_express` VALUES (58, '三态速递', 'santaisudi', NULL, 0, 0, 0, '2017-09-13 16:13:15');
INSERT INTO `store_express` VALUES (59, '盛辉物流', 'shenghuiwuliu', NULL, 0, 0, 0, '2017-09-13 16:13:22');
INSERT INTO `store_express` VALUES (60, '申通', 'shentong', NULL, 0, 0, 0, '2017-09-13 16:13:34');
INSERT INTO `store_express` VALUES (61, '顺丰', 'shunfeng', '', 1, 0, 0, '2017-09-13 16:13:41');
INSERT INTO `store_express` VALUES (62, '速尔物流', 'sue', NULL, 0, 0, 0, '2017-09-13 16:13:48');
INSERT INTO `store_express` VALUES (63, '盛丰物流', 'shengfeng', NULL, 0, 0, 0, '2017-09-13 16:13:55');
INSERT INTO `store_express` VALUES (64, '赛澳递', 'saiaodi', NULL, 0, 0, 0, '2017-09-13 16:14:02');
INSERT INTO `store_express` VALUES (65, '天地华宇', 'tiandihuayu', NULL, 0, 0, 0, '2017-09-13 16:14:11');
INSERT INTO `store_express` VALUES (66, '天天快递', 'tiantian', NULL, 0, 0, 0, '2017-09-13 16:14:19');
INSERT INTO `store_express` VALUES (67, 'TNT', 'tnt', NULL, 0, 0, 0, '2017-09-13 16:14:26');
INSERT INTO `store_express` VALUES (68, 'UPS', 'ups', NULL, 0, 0, 0, '2017-09-13 16:14:29');
INSERT INTO `store_express` VALUES (69, '万家物流', 'wanjiawuliu', NULL, 0, 0, 0, '2017-09-13 16:14:37');
INSERT INTO `store_express` VALUES (70, '文捷航空速递', 'wenjiesudi', NULL, 0, 0, 0, '2017-09-13 16:14:46');
INSERT INTO `store_express` VALUES (71, '伍圆', 'wuyuan', NULL, 0, 0, 0, '2017-09-13 16:14:52');
INSERT INTO `store_express` VALUES (72, '万象物流', 'wxwl', NULL, 0, 0, 0, '2017-09-13 16:15:00');
INSERT INTO `store_express` VALUES (73, '新邦物流', 'xinbangwuliu', NULL, 0, 0, 0, '2017-09-13 16:15:06');
INSERT INTO `store_express` VALUES (74, '信丰物流', 'xinfengwuliu', NULL, 0, 0, 0, '2017-09-13 16:15:15');
INSERT INTO `store_express` VALUES (75, '亚风速递', 'yafengsudi', NULL, 0, 0, 0, '2017-09-13 16:15:23');
INSERT INTO `store_express` VALUES (76, '一邦速递', 'yibangwuliu', NULL, 0, 0, 0, '2017-09-13 16:15:30');
INSERT INTO `store_express` VALUES (77, '优速物流', 'youshuwuliu', NULL, 0, 0, 0, '2017-09-13 16:15:36');
INSERT INTO `store_express` VALUES (78, '邮政包裹挂号信', 'youzhengguonei', NULL, 0, 3, 0, '2017-09-13 16:15:44');
INSERT INTO `store_express` VALUES (79, '邮政国际包裹挂号信', 'youzhengguoji', NULL, 0, 2, 0, '2017-09-13 16:15:51');
INSERT INTO `store_express` VALUES (80, '远成物流', 'yuanchengwuliu', NULL, 0, 0, 0, '2017-09-13 16:15:57');
INSERT INTO `store_express` VALUES (81, '圆通速递', 'yuantong', NULL, 1, 1, 0, '2017-09-13 16:16:03');
INSERT INTO `store_express` VALUES (82, '源伟丰快递', 'yuanweifeng', NULL, 0, 0, 0, '2017-09-13 16:16:10');
INSERT INTO `store_express` VALUES (83, '元智捷诚快递', 'yuanzhijiecheng', NULL, 0, 0, 0, '2017-09-13 16:16:17');
INSERT INTO `store_express` VALUES (84, '韵达快运', 'yunda', NULL, 0, 0, 0, '2017-09-13 16:16:24');
INSERT INTO `store_express` VALUES (85, '运通快递', 'yuntongkuaidi', NULL, 0, 0, 0, '2017-09-13 16:16:33');
INSERT INTO `store_express` VALUES (86, '越丰物流', 'yuefengwuliu', NULL, 0, 0, 0, '2017-09-13 16:16:40');
INSERT INTO `store_express` VALUES (87, '源安达', 'yad', NULL, 0, 0, 0, '2017-09-13 16:16:47');
INSERT INTO `store_express` VALUES (88, '银捷速递', 'yinjiesudi', NULL, 0, 0, 0, '2017-09-13 16:16:56');
INSERT INTO `store_express` VALUES (89, '宅急送', 'zhaijisong', NULL, 0, 0, 0, '2017-09-13 16:17:03');
INSERT INTO `store_express` VALUES (90, '中铁快运', 'zhongtiekuaiyun', NULL, 0, 0, 0, '2017-09-13 16:17:10');
INSERT INTO `store_express` VALUES (91, '中通速递', 'zhongtong', '', 0, 0, 0, '2017-09-13 16:17:16');
INSERT INTO `store_express` VALUES (92, '中邮物流', 'zhongyouwuliu', NULL, 0, 0, 0, '2017-09-13 16:17:27');
INSERT INTO `store_express` VALUES (93, '忠信达', 'zhongxinda', NULL, 0, 0, 0, '2017-09-13 16:17:34');
INSERT INTO `store_express` VALUES (94, '芝麻开门', 'zhimakaimen', NULL, 0, 0, 0, '2017-09-13 16:17:41');

-- ----------------------------
-- Table structure for store_goods
-- ----------------------------
DROP TABLE IF EXISTS `store_goods`;
CREATE TABLE `store_goods`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `brand_id` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '品牌ID',
  `cate_id` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '商品分类id',
  `unit_id` bigint(20) NULL DEFAULT NULL COMMENT '商品单位ID',
  `spec_id` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '规格ID',
  `tags_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '商品标签ID',
  `is_code` bigint(1) NULL DEFAULT 1 COMMENT '是否有码商品',
  `goods_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '商品标签',
  `goods_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '商品内容',
  `goods_logo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '商品LOGO',
  `goods_image` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '商品图片地址',
  `goods_video` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '商品视频URL',
  `goods_desc` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '商品描述',
  `package_stock` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '总库存数量',
  `package_sale` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '已销售数量',
  `favorite_num` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '收藏次数',
  `sort` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '数据排序',
  `status` bigint(1) UNSIGNED NULL DEFAULT 1 COMMENT '商品状态(1有效,0无效)',
  `is_deleted` bigint(1) UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(1删除,0未删除)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商城商品主表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of store_goods
-- ----------------------------
INSERT INTO `store_goods` VALUES (1, 1, 1, NULL, 2, ',,', 1, '商品1', '<p>内容</p>\r\n', 'http://ruwei.com/static/upload/81812111a9b6d6c1/900e87fd85a126e1.jpg', 'http://ruwei.com/static/upload/401979857c0fe815/bca134c7e01cfc48.jpg', '', '描述', 0, 0, 0, 0, 1, 0, '2018-07-31 12:07:59');

-- ----------------------------
-- Table structure for store_goods_brand
-- ----------------------------
DROP TABLE IF EXISTS `store_goods_brand`;
CREATE TABLE `store_goods_brand`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `brand_logo` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '品牌logo',
  `brand_cover` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '品牌封面',
  `brand_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '商品品牌名称',
  `brand_desc` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '商品品牌描述',
  `brand_detail` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '品牌图文信息',
  `sort` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '商品分类排序',
  `status` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '商品状态(1有效,0无效)',
  `is_deleted` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(1删除,0未删除)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产品品牌' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of store_goods_brand
-- ----------------------------
INSERT INTO `store_goods_brand` VALUES (1, 'http://thinkadmin.com/static/upload/cb3f32cb706c0325/c1c1afa9b2c5e9a3.jpg', 'http://thinkadmin.com/static/upload/81812111a9b6d6c1/900e87fd85a126e1.jpg', '品牌1', '品牌描述', '', 0, 1, 0, '2018-07-30 19:07:25');

-- ----------------------------
-- Table structure for store_goods_cate
-- ----------------------------
DROP TABLE IF EXISTS `store_goods_cate`;
CREATE TABLE `store_goods_cate`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '上级分类编号',
  `brand_id` bigint(20) NULL DEFAULT 0 COMMENT '品牌ID',
  `cate_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '商品分类名称',
  `cate_desc` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '商品分类',
  `sort` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '商品分类排序',
  `status` bigint(1) UNSIGNED NULL DEFAULT 1 COMMENT '商品状态(1有效,0无效)',
  `is_deleted` bigint(1) UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(1删除,0未删除)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商城商品分类' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of store_goods_cate
-- ----------------------------
INSERT INTO `store_goods_cate` VALUES (1, 0, 0, '饮料', '描述', 0, 1, 0, '2018-07-31 12:20:17');
INSERT INTO `store_goods_cate` VALUES (2, 1, 0, '红酒', 'wine', 0, 1, 0, '2018-08-02 10:57:20');

-- ----------------------------
-- Table structure for store_goods_list
-- ----------------------------
DROP TABLE IF EXISTS `store_goods_list`;
CREATE TABLE `store_goods_list`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `goods_id` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '商品ID',
  `goods_spec` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '商品规格名称',
  `goods_number` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '商品礼品-商品数量',
  `market_price` decimal(20, 2) UNSIGNED NULL DEFAULT 0.00 COMMENT '销售价格',
  `selling_price` decimal(20, 2) UNSIGNED NULL DEFAULT 0.00 COMMENT '商品价格',
  `goods_stock` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '商品库存统计',
  `goods_sale` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '已销售数量',
  `status` bigint(1) UNSIGNED NULL DEFAULT 1 COMMENT '商品状态(1有效,0无效)',
  `is_deleted` bigint(1) UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(1删除,0未删除)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商城商品列表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of store_goods_list
-- ----------------------------
INSERT INTO `store_goods_list` VALUES (6, 1, '规格分组1:规格名称1,规格分组2:规格名称2,规格分组3:规格名称3', 0, 1.00, 1.00, 1, 0, 1, 0, '2018-08-03 09:16:01');

-- ----------------------------
-- Table structure for store_goods_spec
-- ----------------------------
DROP TABLE IF EXISTS `store_goods_spec`;
CREATE TABLE `store_goods_spec`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `mch_id` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '商户ID',
  `spec_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '商品规格名称',
  `spec_param` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '商品规格参数',
  `spec_desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '商品规格描述',
  `sort` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '商品规格排序',
  `status` bigint(1) UNSIGNED NULL DEFAULT 1 COMMENT '商品状态(1有效,0无效)',
  `is_deleted` bigint(1) UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(1删除,0未删除)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_store_goods_spec_mch_id`(`mch_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商城商品规格' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of store_goods_spec
-- ----------------------------
INSERT INTO `store_goods_spec` VALUES (1, 0, '11111', '[{\"name\":\"2222\",\"value\":\"3333\"},{\"name\":\"4444\",\"value\":\"5555\"}]', '描述', 0, 1, 0, '2018-07-31 12:06:11');
INSERT INTO `store_goods_spec` VALUES (2, 0, '规格名称', '[{\"name\":\"规格分组1\",\"value\":\"规格名称1\"},{\"name\":\"规格分组2\",\"value\":\"规格名称2\"},{\"name\":\"规格分组3\",\"value\":\"规格名称3\"}]', '规格描述', 0, 1, 0, '2018-08-03 09:02:56');

-- ----------------------------
-- Table structure for store_goods_stock
-- ----------------------------
DROP TABLE IF EXISTS `store_goods_stock`;
CREATE TABLE `store_goods_stock`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `goods_id` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '商品ID',
  `goods_spec` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '商品属性',
  `goods_stock` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '商品库存',
  `stock_desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '商品库存描述',
  `sort` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '数据排序',
  `status` bigint(1) UNSIGNED NULL DEFAULT 1 COMMENT '商品状态(1有效,0无效)',
  `is_deleted` bigint(1) UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(1删除,0未删除)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商城商品库存' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of store_goods_stock
-- ----------------------------
INSERT INTO `store_goods_stock` VALUES (1, 1, '2222:3333,4444:5555', 1110, '', 0, 1, 0, '2018-07-31 12:08:21');
INSERT INTO `store_goods_stock` VALUES (2, 1, '2222:3333,4444:5555', 10, '', 0, 1, 0, '2018-08-02 11:44:45');
INSERT INTO `store_goods_stock` VALUES (3, 1, '2222:3333,4444:5555', 1, '', 0, 1, 0, '2018-08-02 11:45:32');
INSERT INTO `store_goods_stock` VALUES (4, 1, '2222:3333,4444:5555', 10, '', 0, 1, 0, '2018-08-03 08:59:03');
INSERT INTO `store_goods_stock` VALUES (5, 1, '2222:3333,4444:5555', 1, '', 0, 1, 0, '2018-08-03 09:01:10');
INSERT INTO `store_goods_stock` VALUES (6, 1, '规格分组1:规格名称1,规格分组2:规格名称2,规格分组3:规格名称3', 1, '', 0, 1, 0, '2018-08-03 09:16:11');

-- ----------------------------
-- Table structure for store_member
-- ----------------------------
DROP TABLE IF EXISTS `store_member`;
CREATE TABLE `store_member`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `openid` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '会员微信OPENID',
  `phone` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '会员手机号',
  `password` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '登录密码',
  `nickname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '会员昵称',
  `headimg` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '会员头像',
  `sex` char(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '性别',
  `level` tinyint(2) UNSIGNED NULL DEFAULT 1 COMMENT '会员级别',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '会员个性签名',
  `status` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '会员状态(1有效,0无效)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `index_store_member_openid`(`openid`) USING BTREE,
  INDEX `index_store_member_phone`(`phone`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商城会员信息' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for store_member_address
-- ----------------------------
DROP TABLE IF EXISTS `store_member_address`;
CREATE TABLE `store_member_address`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `mid` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '会员ID',
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '收货人姓名',
  `phone` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '收货手机号',
  `province` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '收货地址省份',
  `city` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '收货地址城市',
  `area` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '收货地址区域',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '收货详细地址',
  `status` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '状态(0无效, 1新快递)',
  `is_default` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '默认收货地址',
  `is_deleted` bigint(1) UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(1删除,0未删除)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商城会员收货地址' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for store_order
-- ----------------------------
DROP TABLE IF EXISTS `store_order`;
CREATE TABLE `store_order`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '订单类型(1普通订单,2积分订单)',
  `mid` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '会员ID',
  `order_no` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '订单号',
  `freight_price` decimal(20, 2) UNSIGNED NULL DEFAULT 0.00 COMMENT '快递费',
  `goods_price` decimal(20, 2) UNSIGNED NULL DEFAULT 0.00 COMMENT '商品总金额(不含快递费)',
  `real_price` decimal(20, 2) UNSIGNED NULL DEFAULT 0.00 COMMENT '真实支付金额(商品金额+快递金额)',
  `is_pay` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '订单支付状态(0.未支付,1.已支付)',
  `pay_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '支付方式 (wechat微信支付, alipay支付宝支付)',
  `pay_no` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '商户交易号',
  `pay_price` decimal(20, 2) UNSIGNED NULL DEFAULT 0.00 COMMENT '实际支付金额',
  `pay_at` datetime(0) NULL DEFAULT NULL COMMENT '支付时间',
  `desc` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '订单描述',
  `status` bigint(1) UNSIGNED NULL DEFAULT 1 COMMENT '订单状态(0.无效,1.新订单,2.待发货,3.已发货,4.已收货,5.已完成,6.已退货及退款)',
  `is_deleted` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(1删除,0未删除)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_store_order_order_no`(`order_no`) USING BTREE,
  INDEX `index_store_order_status`(`status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商城订单主表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for store_order_express
-- ----------------------------
DROP TABLE IF EXISTS `store_order_express`;
CREATE TABLE `store_order_express`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `mid` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '会员ID',
  `type` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '快递类型(0.订单快递,1.退货快递)',
  `order_no` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '订单编号',
  `company_title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '物流公司名称',
  `company_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '物流公司编码',
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '收货人姓名',
  `phone` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '收货手机号',
  `province` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收货地址省份',
  `city` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '收货地址城市',
  `area` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '收货地址区域',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '收货详细地址',
  `send_no` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '实际物流公司单号',
  `send_company_title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '实际发货快递公司',
  `send_company_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '实际发货快递代码',
  `send_username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '寄件人名称',
  `send_phone` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '寄件人手机号',
  `send_province` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '寄件人地址省份',
  `send_city` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '寄件人地址城市',
  `send_area` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '寄件人地址区域',
  `send_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '寄件人详细地址',
  `send_at` datetime(0) NULL DEFAULT NULL COMMENT '快递发货时间',
  `desc` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '发货描述',
  `status` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '状态(0.无效,1.新快递,2.已签收,3.签收失败)',
  `is_deleted` bigint(1) UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(1删除,0未删除)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商城订单快递' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for store_order_goods
-- ----------------------------
DROP TABLE IF EXISTS `store_order_goods`;
CREATE TABLE `store_order_goods`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `mid` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '会员ID',
  `order_no` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '订单编号',
  `goods_id` bigint(20) NULL DEFAULT 0 COMMENT '商品ID',
  `goods_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '商品标签',
  `goods_spec` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '商品规格',
  `goods_logo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '商品LOGO',
  `goods_image` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '商品图片地址',
  `market_price` decimal(20, 2) UNSIGNED NULL DEFAULT 0.00 COMMENT '市场价格',
  `selling_price` decimal(20, 2) UNSIGNED NULL DEFAULT 0.00 COMMENT '商品销售价格',
  `price_field` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'selling_price' COMMENT '计价字段',
  `number` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '订单商品数量',
  `status` bigint(1) UNSIGNED NULL DEFAULT 1 COMMENT '商品状态(1有效,0无效)',
  `is_deleted` bigint(1) UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(1删除,0未删除)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_store_order_list_order_no`(`order_no`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商城订单关联商品' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for system_auth
-- ----------------------------
DROP TABLE IF EXISTS `system_auth`;
CREATE TABLE `system_auth`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '权限名称',
  `status` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '状态(1:禁用,2:启用)',
  `sort` smallint(6) UNSIGNED NULL DEFAULT 0 COMMENT '排序权重',
  `desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注说明',
  `create_by` bigint(11) UNSIGNED NULL DEFAULT 0 COMMENT '创建人',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `index_system_auth_title`(`title`) USING BTREE,
  INDEX `index_system_auth_status`(`status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统权限表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for system_auth_node
-- ----------------------------
DROP TABLE IF EXISTS `system_auth_node`;
CREATE TABLE `system_auth_node`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `auth` bigint(20) UNSIGNED NULL DEFAULT NULL COMMENT '角色ID',
  `node` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '节点路径',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_system_auth_auth`(`auth`) USING BTREE,
  INDEX `index_system_auth_node`(`node`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统角色与节点绑定' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for system_config
-- ----------------------------
DROP TABLE IF EXISTS `system_config`;
CREATE TABLE `system_config`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '配置编码',
  `value` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '配置值',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_system_config_name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统参数配置' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of system_config
-- ----------------------------
INSERT INTO `system_config` VALUES (1, 'app_name', 'ThinkAdmin');
INSERT INTO `system_config` VALUES (2, 'site_name', 'ThinkAdmin');
INSERT INTO `system_config` VALUES (3, 'app_version', '3.0 dev');
INSERT INTO `system_config` VALUES (4, 'site_copy', '©版权所有 2018 夏浪科技');
INSERT INTO `system_config` VALUES (5, 'browser_icon', 'http://localhost/ThinkAdmin/static/upload/f47b8fe06e38ae99/08e8398da45583b9.png');
INSERT INTO `system_config` VALUES (6, 'tongji_baidu_key', '');
INSERT INTO `system_config` VALUES (7, 'miitbeian', '粤ICP备16006642号-2');
INSERT INTO `system_config` VALUES (8, 'storage_type', 'local');
INSERT INTO `system_config` VALUES (9, 'storage_local_exts', 'png,jpg,rar,doc,icon,mp4');
INSERT INTO `system_config` VALUES (10, 'storage_qiniu_bucket', '');
INSERT INTO `system_config` VALUES (11, 'storage_qiniu_domain', '');
INSERT INTO `system_config` VALUES (12, 'storage_qiniu_access_key', '');
INSERT INTO `system_config` VALUES (13, 'storage_qiniu_secret_key', '');
INSERT INTO `system_config` VALUES (14, 'storage_oss_bucket', 'cuci');
INSERT INTO `system_config` VALUES (15, 'storage_oss_endpoint', 'oss-cn-beijing.aliyuncs.com');
INSERT INTO `system_config` VALUES (16, 'storage_oss_domain', 'cuci.oss-cn-beijing.aliyuncs.com');
INSERT INTO `system_config` VALUES (17, 'storage_oss_keyid', '用你自己的吧');
INSERT INTO `system_config` VALUES (18, 'storage_oss_secret', '用你自己的吧');
INSERT INTO `system_config` VALUES (34, 'wechat_appid', 'wx27426b7ce34961cf');
INSERT INTO `system_config` VALUES (35, 'wechat_appkey', '9890a0d7c91801a609d151099e95b61a');
INSERT INTO `system_config` VALUES (36, 'storage_oss_is_https', 'http');
INSERT INTO `system_config` VALUES (37, 'wechat_type', 'api');
INSERT INTO `system_config` VALUES (38, 'wechat_token', 'cwb');
INSERT INTO `system_config` VALUES (39, 'wechat_appsecret', 'cffe34cc018ee932222a87a15ebf4cba');
INSERT INTO `system_config` VALUES (40, 'wechat_encodingaeskey', 'NxRgL4xQepz9IbGd8cXGlkfsExMDutvOLUDVlBrD5HZ');
INSERT INTO `system_config` VALUES (41, 'wechat_thr_appid', 'wx60a43dd8161666d4');
INSERT INTO `system_config` VALUES (42, 'wechat_thr_appkey', '05db2aa335382c66ab56d69b1a9ad0ee');

-- ----------------------------
-- Table structure for system_log
-- ----------------------------
DROP TABLE IF EXISTS `system_log`;
CREATE TABLE `system_log`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ip` char(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '操作者IP地址',
  `node` char(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '当前操作节点',
  `username` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '操作人用户名',
  `action` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '操作行为',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作内容描述',
  `create_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 38 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统操作日志表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of system_log
-- ----------------------------
INSERT INTO `system_log` VALUES (1, '127.0.0.1', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-07-30 17:29:31');
INSERT INTO `system_log` VALUES (2, '127.0.0.1', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-07-31 09:31:58');
INSERT INTO `system_log` VALUES (3, '127.0.0.1', 'wechat/config/index', 'admin', '微信管理', '修改微信接口参数成功', '2018-07-31 09:34:43');
INSERT INTO `system_log` VALUES (4, '127.0.0.1', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-07-31 18:27:40');
INSERT INTO `system_log` VALUES (5, '127.0.0.1', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-08-01 09:03:35');
INSERT INTO `system_log` VALUES (6, '127.0.0.1', 'admin/login/out', 'admin', '系统管理', '用户退出系统成功', '2018-08-01 13:13:35');
INSERT INTO `system_log` VALUES (7, '127.0.0.1', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-08-01 13:13:40');
INSERT INTO `system_log` VALUES (8, '127.0.0.1', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-08-01 13:19:13');
INSERT INTO `system_log` VALUES (9, '127.0.0.1', 'admin/login/out', 'admin', '系统管理', '用户退出系统成功', '2018-08-01 13:19:40');
INSERT INTO `system_log` VALUES (10, '127.0.0.1', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-08-01 13:19:45');
INSERT INTO `system_log` VALUES (11, '127.0.0.1', 'admin/login/out', 'admin', '系统管理', '用户退出系统成功', '2018-08-01 18:24:12');
INSERT INTO `system_log` VALUES (12, '127.0.0.1', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-08-01 18:24:57');
INSERT INTO `system_log` VALUES (13, '127.0.0.1', 'admin/login/out', 'admin', '系统管理', '用户退出系统成功', '2018-08-01 19:46:11');
INSERT INTO `system_log` VALUES (14, '127.0.0.1', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-08-01 19:46:16');
INSERT INTO `system_log` VALUES (15, '127.0.0.1', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-08-02 09:11:14');
INSERT INTO `system_log` VALUES (16, '127.0.0.1', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-08-03 08:58:43');
INSERT INTO `system_log` VALUES (17, '127.0.0.1', 'admin/login/out', 'admin', '系统管理', '用户退出系统成功', '2018-08-03 15:14:31');
INSERT INTO `system_log` VALUES (18, '127.0.0.1', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-08-03 15:14:40');
INSERT INTO `system_log` VALUES (19, '127.0.0.1', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-08-06 10:13:17');
INSERT INTO `system_log` VALUES (20, '127.0.0.1', 'wechat/config/index', 'admin', '微信管理', '修改微信接口参数成功', '2018-08-06 11:49:31');
INSERT INTO `system_log` VALUES (21, '127.0.0.1', 'wechat/config/index', 'admin', '微信管理', '修改微信接口参数成功', '2018-08-06 11:49:40');
INSERT INTO `system_log` VALUES (22, '127.0.0.1', 'wechat/config/index', 'admin', '微信管理', '修改微信接口参数成功', '2018-08-06 11:49:46');
INSERT INTO `system_log` VALUES (23, '127.0.0.1', 'admin/login/out', 'admin', '系统管理', '用户退出系统成功', '2018-08-06 17:10:52');
INSERT INTO `system_log` VALUES (24, '127.0.0.1', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-08-06 17:47:53');
INSERT INTO `system_log` VALUES (25, '127.0.0.1', 'admin/login/out', 'admin', '系统管理', '用户退出系统成功', '2018-08-06 17:48:06');
INSERT INTO `system_log` VALUES (26, '127.0.0.1', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-08-06 18:30:59');
INSERT INTO `system_log` VALUES (27, '127.0.0.1', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-08-07 08:56:38');
INSERT INTO `system_log` VALUES (28, '127.0.0.1', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-08-08 17:53:31');
INSERT INTO `system_log` VALUES (29, '127.0.0.1', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-08-14 12:02:49');
INSERT INTO `system_log` VALUES (30, '127.0.0.1', 'admin/login/out', 'admin', '系统管理', '用户退出系统成功', '2018-08-14 12:20:46');
INSERT INTO `system_log` VALUES (31, '127.0.0.1', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-08-14 12:20:59');
INSERT INTO `system_log` VALUES (32, '127.0.0.1', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-08-28 09:11:14');
INSERT INTO `system_log` VALUES (33, '127.0.0.1', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-08-30 09:55:32');
INSERT INTO `system_log` VALUES (34, '127.0.0.1', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-08-30 10:37:05');
INSERT INTO `system_log` VALUES (35, '127.0.0.1', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-08-31 09:15:19');
INSERT INTO `system_log` VALUES (36, '127.0.0.1', 'admin/login/out', 'admin', '系统管理', '用户退出系统成功', '2018-08-31 15:21:39');
INSERT INTO `system_log` VALUES (37, '127.0.0.1', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-08-31 15:21:44');

-- ----------------------------
-- Table structure for system_menu
-- ----------------------------
DROP TABLE IF EXISTS `system_menu`;
CREATE TABLE `system_menu`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT '父id',
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '名称',
  `node` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '节点代码',
  `icon` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '菜单图标',
  `url` varchar(400) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '链接',
  `params` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '链接参数',
  `target` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '_self' COMMENT '链接打开方式',
  `sort` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '菜单排序',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态(0:禁用,1:启用)',
  `create_by` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建人',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_system_menu_node`(`node`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 53 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统菜单表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of system_menu
-- ----------------------------
INSERT INTO `system_menu` VALUES (1, 0, '系统设置', '', '', '#', '', '_self', 9000, 1, 10000, '2018-01-19 15:27:00');
INSERT INTO `system_menu` VALUES (2, 10, '后台菜单', '', 'fa fa-leaf', 'admin/menu/index', '', '_self', 10, 1, 10000, '2018-01-19 15:27:17');
INSERT INTO `system_menu` VALUES (3, 10, '系统参数', '', 'fa fa-modx', 'admin/config/index', '', '_self', 20, 1, 10000, '2018-01-19 15:27:57');
INSERT INTO `system_menu` VALUES (4, 11, '访问授权', '', 'fa fa-group', 'admin/auth/index', '', '_self', 20, 1, 10000, '2018-01-22 11:13:02');
INSERT INTO `system_menu` VALUES (5, 11, '用户管理', '', 'fa fa-user', 'admin/user/index', '', '_self', 10, 1, 0, '2018-01-23 12:15:12');
INSERT INTO `system_menu` VALUES (6, 11, '访问节点', '', 'fa fa-fort-awesome', 'admin/node/index', '', '_self', 30, 1, 0, '2018-01-23 12:36:54');
INSERT INTO `system_menu` VALUES (7, 0, '后台首页', '', '', 'admin/index/main', '', '_self', 1000, 1, 0, '2018-01-23 13:42:30');
INSERT INTO `system_menu` VALUES (8, 16, '系统日志', '', 'fa fa-code', 'admin/log/index', '', '_self', 10, 1, 0, '2018-01-24 13:52:58');
INSERT INTO `system_menu` VALUES (9, 10, '文件存储', '', 'fa fa-stop-circle', 'admin/config/file', '', '_self', 30, 1, 0, '2018-01-25 10:54:28');
INSERT INTO `system_menu` VALUES (10, 1, '系统管理', '', '', '#', '', '_self', 200, 1, 0, '2018-01-25 18:14:28');
INSERT INTO `system_menu` VALUES (11, 1, '访问权限', '', '', '#', '', '_self', 300, 1, 0, '2018-01-25 18:15:08');
INSERT INTO `system_menu` VALUES (16, 1, '日志管理', '', '', '#', '', '_self', 400, 1, 0, '2018-02-10 16:31:15');
INSERT INTO `system_menu` VALUES (17, 0, '微信管理', '', '', '#', '', '_self', 8000, 1, 0, '2018-03-06 14:42:49');
INSERT INTO `system_menu` VALUES (18, 17, '公众号配置', '', '', '#', '', '_self', 0, 1, 0, '2018-03-06 14:43:05');
INSERT INTO `system_menu` VALUES (19, 18, '微信授权绑定', '', 'fa fa-cog', 'wechat/config/index', '', '_self', 0, 1, 0, '2018-03-06 14:43:26');
INSERT INTO `system_menu` VALUES (20, 18, '关注默认回复', '', 'fa fa-comment-o', 'wechat/keys/subscribe', '', '_self', 0, 1, 0, '2018-03-06 14:44:45');
INSERT INTO `system_menu` VALUES (21, 18, '无反馈默认回复', '', 'fa fa-commenting', 'wechat/keys/defaults', '', '_self', 0, 1, 0, '2018-03-06 14:45:55');
INSERT INTO `system_menu` VALUES (22, 18, '微信关键字管理', '', 'fa fa-hashtag', 'wechat/keys/index', '', '_self', 0, 1, 0, '2018-03-06 14:46:23');
INSERT INTO `system_menu` VALUES (23, 17, '微信服务定制', '', '', '#', '', '_self', 0, 1, 0, '2018-03-06 14:47:11');
INSERT INTO `system_menu` VALUES (24, 23, '微信菜单管理', '', 'fa fa-gg-circle', 'wechat/menu/index', '', '_self', 0, 1, 0, '2018-03-06 14:47:39');
INSERT INTO `system_menu` VALUES (25, 23, '微信图文管理', '', 'fa fa-map-o', 'wechat/news/index', '', '_self', 0, 1, 0, '2018-03-06 14:48:14');
INSERT INTO `system_menu` VALUES (26, 17, '微信粉丝管理', '', 'fa fa-user', '#', '', '_self', 0, 1, 0, '2018-03-06 14:48:33');
INSERT INTO `system_menu` VALUES (27, 26, '微信粉丝列表', '', 'fa fa-users', 'wechat/fans/index', '', '_self', 20, 1, 0, '2018-03-06 14:49:04');
INSERT INTO `system_menu` VALUES (28, 26, '微信黑名单管理', '', 'fa fa-user-times', 'wechat/fans_block/index', '', '_self', 30, 1, 0, '2018-03-06 14:49:22');
INSERT INTO `system_menu` VALUES (29, 26, '微信标签管理', '', 'fa fa-tags', 'wechat/tags/index', '', '_self', 10, 1, 0, '2018-03-06 14:49:39');
INSERT INTO `system_menu` VALUES (32, 0, '商城管理', '', '', '#', '', '_self', 2000, 1, 0, '2018-03-20 16:46:07');
INSERT INTO `system_menu` VALUES (33, 32, '商品管理', '', '', '#', '', '_self', 0, 1, 0, '2018-03-20 16:46:21');
INSERT INTO `system_menu` VALUES (34, 33, '产品管理', '', 'fa fa-modx', 'store/goods/index', '', '_self', 0, 1, 0, '2018-03-20 16:46:45');
INSERT INTO `system_menu` VALUES (35, 33, '规格管理', '', 'fa fa-hashtag', 'store/goods_spec/index', '', '_self', 0, 1, 0, '2018-03-20 16:47:08');
INSERT INTO `system_menu` VALUES (36, 33, '分类管理', '', 'fa fa-product-hunt', 'store/goods_cate/index', '', '_self', 0, 1, 0, '2018-03-20 16:47:50');
INSERT INTO `system_menu` VALUES (37, 33, '品牌管理', '', 'fa fa-scribd', 'store/goods_brand/index', '', '_self', 0, 1, 0, '2018-03-20 16:48:05');
INSERT INTO `system_menu` VALUES (38, 32, '订单管理', '', '', '#', '', '_self', 0, 1, 0, '2018-04-21 15:07:36');
INSERT INTO `system_menu` VALUES (39, 38, '订单列表', '', 'fa fa-adjust', 'store/order/index', '', '_self', 0, 1, 0, '2018-04-21 15:07:54');
INSERT INTO `system_menu` VALUES (40, 32, '商城配置', '', '', '#', '', '_self', 0, 1, 0, '2018-04-21 15:08:17');
INSERT INTO `system_menu` VALUES (41, 40, '参数管理', '', '', '#', '', '_self', 0, 0, 0, '2018-04-21 15:08:25');
INSERT INTO `system_menu` VALUES (42, 40, '快递公司', '', 'fa fa-mixcloud', 'store/express/index', '', '_self', 0, 1, 0, '2018-04-21 15:08:50');
INSERT INTO `system_menu` VALUES (43, 0, '外卖管理', '', '', '#', '', '_self', 1100, 1, 0, '2018-07-31 11:22:41');
INSERT INTO `system_menu` VALUES (44, 43, '商家管理', '', '', '#', '', '_self', 0, 1, 0, '2018-07-31 11:24:22');
INSERT INTO `system_menu` VALUES (45, 44, '商户管理', '', 'fa fa-scribd', '/shop/merchant/index', '', '_self', 0, 1, 0, '2018-07-31 11:35:25');
INSERT INTO `system_menu` VALUES (46, 43, '商品管理', '', '', '#', '', '_self', 0, 1, 0, '2018-07-31 11:37:31');
INSERT INTO `system_menu` VALUES (47, 46, '产品管理', '', 'fa fa-modx', '/shop/goods/index', '', '_self', 0, 1, 0, '2018-07-31 11:39:37');
INSERT INTO `system_menu` VALUES (48, 46, '分类管理', '', 'fa fa-product-hunt', '/shop/goods_cate/index', '', '_self', 0, 1, 0, '2018-07-31 11:44:11');
INSERT INTO `system_menu` VALUES (49, 43, '订单管理', '', '', '#', '', '_self', 0, 1, 0, '2018-07-31 11:45:17');
INSERT INTO `system_menu` VALUES (50, 49, '订单列表', '', 'fa fa-adjust', '/shop/order/index', '', '_self', 0, 1, 0, '2018-07-31 11:48:34');
INSERT INTO `system_menu` VALUES (51, 44, '门店管理', '', 'fa fa-cutlery', '/shop/location/index', '', '_self', 0, 1, 0, '2018-08-01 12:11:12');
INSERT INTO `system_menu` VALUES (52, 44, '门店账号', '', 'fa fa-user', '/shop/account/index', '', '_self', 0, 1, 0, '2018-08-01 19:26:24');

-- ----------------------------
-- Table structure for system_node
-- ----------------------------
DROP TABLE IF EXISTS `system_node`;
CREATE TABLE `system_node`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `node` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '节点代码',
  `title` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '节点标题',
  `is_menu` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '是否可设置为菜单',
  `is_auth` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '是否启动RBAC权限控制',
  `is_login` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '是否启动登录控制',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_system_node_node`(`node`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 147 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统节点表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of system_node
-- ----------------------------
INSERT INTO `system_node` VALUES (13, 'admin', '系统设置', 0, 1, 1, '2018-05-04 11:02:34');
INSERT INTO `system_node` VALUES (14, 'admin/auth', '权限管理', 0, 1, 1, '2018-05-04 11:06:55');
INSERT INTO `system_node` VALUES (15, 'admin/auth/index', '权限列表', 1, 1, 1, '2018-05-04 11:06:56');
INSERT INTO `system_node` VALUES (16, 'admin/auth/apply', '权限配置', 0, 1, 1, '2018-05-04 11:06:56');
INSERT INTO `system_node` VALUES (17, 'admin/auth/add', '添加权限', 0, 1, 1, '2018-05-04 11:06:56');
INSERT INTO `system_node` VALUES (18, 'admin/auth/edit', '编辑权限', 0, 1, 1, '2018-05-04 11:06:56');
INSERT INTO `system_node` VALUES (19, 'admin/auth/forbid', '禁用权限', 0, 1, 1, '2018-05-04 11:06:56');
INSERT INTO `system_node` VALUES (20, 'admin/auth/resume', '启用权限', 0, 1, 1, '2018-05-04 11:06:56');
INSERT INTO `system_node` VALUES (21, 'admin/auth/del', '删除权限', 0, 1, 1, '2018-05-04 11:06:56');
INSERT INTO `system_node` VALUES (22, 'admin/config', '系统配置', 0, 1, 1, '2018-05-04 11:08:18');
INSERT INTO `system_node` VALUES (23, 'admin/config/index', '系统参数', 1, 1, 1, '2018-05-04 11:08:25');
INSERT INTO `system_node` VALUES (24, 'admin/config/file', '文件存储', 1, 1, 1, '2018-05-04 11:08:27');
INSERT INTO `system_node` VALUES (25, 'admin/log', '日志管理', 0, 1, 1, '2018-05-04 11:08:43');
INSERT INTO `system_node` VALUES (26, 'admin/log/index', '日志管理', 1, 1, 1, '2018-05-04 11:08:43');
INSERT INTO `system_node` VALUES (28, 'admin/log/del', '日志删除', 0, 1, 1, '2018-05-04 11:08:43');
INSERT INTO `system_node` VALUES (29, 'admin/menu', '系统菜单', 0, 1, 1, '2018-05-04 11:09:54');
INSERT INTO `system_node` VALUES (30, 'admin/menu/index', '菜单列表', 1, 1, 1, '2018-05-04 11:09:54');
INSERT INTO `system_node` VALUES (31, 'admin/menu/add', '添加菜单', 0, 1, 1, '2018-05-04 11:09:55');
INSERT INTO `system_node` VALUES (32, 'admin/menu/edit', '编辑菜单', 0, 1, 1, '2018-05-04 11:09:55');
INSERT INTO `system_node` VALUES (33, 'admin/menu/del', '删除菜单', 0, 1, 1, '2018-05-04 11:09:55');
INSERT INTO `system_node` VALUES (34, 'admin/menu/forbid', '禁用菜单', 0, 1, 1, '2018-05-04 11:09:55');
INSERT INTO `system_node` VALUES (35, 'admin/menu/resume', '启用菜单', 0, 1, 1, '2018-05-04 11:09:55');
INSERT INTO `system_node` VALUES (36, 'admin/node', '节点管理', 0, 1, 1, '2018-05-04 11:10:20');
INSERT INTO `system_node` VALUES (37, 'admin/node/index', '节点列表', 1, 1, 1, '2018-05-04 11:10:20');
INSERT INTO `system_node` VALUES (38, 'admin/node/clear', '清理节点', 0, 1, 1, '2018-05-04 11:10:21');
INSERT INTO `system_node` VALUES (39, 'admin/node/save', '更新节点', 0, 1, 1, '2018-05-04 11:10:21');
INSERT INTO `system_node` VALUES (40, 'admin/user', '系统用户', 0, 1, 1, '2018-05-04 11:10:43');
INSERT INTO `system_node` VALUES (41, 'admin/user/index', '用户列表', 1, 1, 1, '2018-05-04 11:10:43');
INSERT INTO `system_node` VALUES (42, 'admin/user/auth', '用户授权', 0, 1, 1, '2018-05-04 11:10:43');
INSERT INTO `system_node` VALUES (43, 'admin/user/add', '添加用户', 0, 1, 1, '2018-05-04 11:10:43');
INSERT INTO `system_node` VALUES (44, 'admin/user/edit', '编辑用户', 0, 1, 1, '2018-05-04 11:10:43');
INSERT INTO `system_node` VALUES (45, 'admin/user/pass', '修改密码', 0, 1, 1, '2018-05-04 11:10:43');
INSERT INTO `system_node` VALUES (46, 'admin/user/del', '删除用户', 0, 1, 1, '2018-05-04 11:10:43');
INSERT INTO `system_node` VALUES (47, 'admin/user/forbid', '禁用启用', 0, 1, 1, '2018-05-04 11:10:43');
INSERT INTO `system_node` VALUES (48, 'admin/user/resume', '启用用户', 0, 1, 1, '2018-05-04 11:10:44');
INSERT INTO `system_node` VALUES (49, 'store', '商城管理', 0, 1, 1, '2018-05-04 11:11:28');
INSERT INTO `system_node` VALUES (50, 'store/express', '快递公司管理', 0, 1, 1, '2018-05-04 11:11:39');
INSERT INTO `system_node` VALUES (51, 'store/express/index', '快递公司列表', 1, 1, 1, '2018-05-04 11:11:39');
INSERT INTO `system_node` VALUES (52, 'store/express/add', '添加快递公司', 0, 1, 1, '2018-05-04 11:11:39');
INSERT INTO `system_node` VALUES (53, 'store/express/edit', '编辑快递公司', 0, 1, 1, '2018-05-04 11:11:39');
INSERT INTO `system_node` VALUES (54, 'store/express/del', '删除快递公司', 0, 1, 1, '2018-05-04 11:11:39');
INSERT INTO `system_node` VALUES (55, 'store/express/forbid', '禁用快递公司', 0, 1, 1, '2018-05-04 11:11:39');
INSERT INTO `system_node` VALUES (56, 'store/express/resume', '启用快递公司', 0, 1, 1, '2018-05-04 11:11:40');
INSERT INTO `system_node` VALUES (57, 'store/order', '订单管理', 0, 1, 1, '2018-05-04 11:12:14');
INSERT INTO `system_node` VALUES (58, 'store/order/index', '订单列表', 1, 1, 1, '2018-05-04 11:12:17');
INSERT INTO `system_node` VALUES (59, 'store/order/address', '修改地址', 0, 1, 1, '2018-05-04 11:12:19');
INSERT INTO `system_node` VALUES (76, 'wechat', '微信管理', 0, 1, 1, '2018-05-04 11:14:59');
INSERT INTO `system_node` VALUES (78, 'wechat/config', '微信对接管理', 0, 1, 1, '2018-05-04 11:16:20');
INSERT INTO `system_node` VALUES (79, 'wechat/config/index', '微信对接配置', 1, 1, 1, '2018-05-04 11:16:23');
INSERT INTO `system_node` VALUES (80, 'wechat/fans', '微信粉丝管理', 0, 1, 1, '2018-05-04 11:16:31');
INSERT INTO `system_node` VALUES (81, 'wechat/fans/index', '微信粉丝列表', 1, 1, 1, '2018-05-04 11:16:32');
INSERT INTO `system_node` VALUES (82, 'wechat/fans/backadd', '微信粉丝拉黑', 0, 1, 1, '2018-05-04 11:16:32');
INSERT INTO `system_node` VALUES (83, 'wechat/fans/tagset', '设置粉丝标签', 0, 1, 1, '2018-05-04 11:16:32');
INSERT INTO `system_node` VALUES (84, 'wechat/fans/tagadd', '添加粉丝标签', 0, 1, 1, '2018-05-04 11:16:32');
INSERT INTO `system_node` VALUES (85, 'wechat/fans/tagdel', '删除粉丝标签', 0, 1, 1, '2018-05-04 11:16:32');
INSERT INTO `system_node` VALUES (86, 'wechat/fans/sync', '同步粉丝列表', 0, 1, 1, '2018-05-04 11:16:32');
INSERT INTO `system_node` VALUES (87, 'wechat/fans_block', '粉丝黑名单管理', 0, 1, 1, '2018-05-04 11:17:25');
INSERT INTO `system_node` VALUES (88, 'wechat/fans_block/index', '粉丝黑名单列表', 1, 1, 1, '2018-05-04 11:17:50');
INSERT INTO `system_node` VALUES (89, 'wechat/fans_block/backdel', '移除粉丝黑名单', 0, 1, 1, '2018-05-04 11:17:51');
INSERT INTO `system_node` VALUES (90, 'wechat/keys', '微信关键字', 0, 1, 1, '2018-05-04 11:18:09');
INSERT INTO `system_node` VALUES (91, 'wechat/keys/index', '关键字列表', 1, 1, 1, '2018-05-04 11:18:09');
INSERT INTO `system_node` VALUES (92, 'wechat/keys/add', '添加关键字', 0, 1, 1, '2018-05-04 11:18:09');
INSERT INTO `system_node` VALUES (93, 'wechat/keys/edit', '编辑关键字', 0, 1, 1, '2018-05-04 11:18:09');
INSERT INTO `system_node` VALUES (94, 'wechat/keys/del', '删除关键字', 0, 1, 1, '2018-05-04 11:18:09');
INSERT INTO `system_node` VALUES (95, 'wechat/keys/forbid', '禁用关键字', 0, 1, 1, '2018-05-04 11:18:09');
INSERT INTO `system_node` VALUES (96, 'wechat/keys/resume', '启用关键字', 0, 1, 1, '2018-05-04 11:18:09');
INSERT INTO `system_node` VALUES (97, 'wechat/keys/subscribe', '关注回复', 1, 1, 1, '2018-05-04 11:18:09');
INSERT INTO `system_node` VALUES (98, 'wechat/keys/defaults', '默认回复', 1, 1, 1, '2018-05-04 11:18:09');
INSERT INTO `system_node` VALUES (99, 'wechat/menu', '微信菜单管理', 0, 1, 1, '2018-05-04 11:18:57');
INSERT INTO `system_node` VALUES (100, 'wechat/menu/index', '微信菜单展示', 1, 1, 1, '2018-05-04 11:19:10');
INSERT INTO `system_node` VALUES (101, 'wechat/menu/edit', '编辑微信菜单', 0, 1, 1, '2018-05-04 11:19:22');
INSERT INTO `system_node` VALUES (102, 'wechat/menu/cancel', '取消微信菜单', 0, 1, 1, '2018-05-04 11:19:26');
INSERT INTO `system_node` VALUES (103, 'wechat/news/index', '微信图文列表', 1, 1, 1, '2018-05-04 11:19:28');
INSERT INTO `system_node` VALUES (104, 'wechat/news/select', '微信图文选择', 0, 1, 1, '2018-05-04 11:19:28');
INSERT INTO `system_node` VALUES (105, 'wechat/news/image', '微信图片选择', 0, 1, 1, '2018-05-04 11:19:28');
INSERT INTO `system_node` VALUES (106, 'wechat/news/add', '添加微信图文', 0, 1, 1, '2018-05-04 11:19:28');
INSERT INTO `system_node` VALUES (107, 'wechat/news/edit', '编辑微信图文', 0, 1, 1, '2018-05-04 11:19:28');
INSERT INTO `system_node` VALUES (108, 'wechat/news/del', '删除微信图文', 0, 1, 1, '2018-05-04 11:19:28');
INSERT INTO `system_node` VALUES (109, 'wechat/news/push', '推送微信图文', 0, 1, 1, '2018-05-04 11:19:28');
INSERT INTO `system_node` VALUES (110, 'wechat/news', '微信图文管理', 0, 1, 1, '2018-05-04 11:19:35');
INSERT INTO `system_node` VALUES (111, 'wechat/tags', '微信粉丝标签管理', 0, 1, 1, '2018-05-04 11:20:28');
INSERT INTO `system_node` VALUES (112, 'wechat/tags/index', '粉丝标签列表', 1, 1, 1, '2018-05-04 11:20:28');
INSERT INTO `system_node` VALUES (113, 'wechat/tags/add', '添加粉丝标签', 0, 1, 1, '2018-05-04 11:20:28');
INSERT INTO `system_node` VALUES (114, 'wechat/tags/edit', '编辑粉丝标签', 0, 1, 1, '2018-05-04 11:20:29');
INSERT INTO `system_node` VALUES (115, 'wechat/tags/del', '删除粉丝标签', 0, 1, 1, '2018-05-04 11:20:29');
INSERT INTO `system_node` VALUES (116, 'wechat/tags/sync', '同步粉丝标签', 0, 1, 1, '2018-05-04 11:20:29');
INSERT INTO `system_node` VALUES (117, 'store/goods', '商品管理', 0, 1, 1, '2018-05-04 11:29:55');
INSERT INTO `system_node` VALUES (118, 'store/goods/index', '商品列表', 1, 1, 1, '2018-05-04 11:29:56');
INSERT INTO `system_node` VALUES (119, 'store/goods/add', '添加商品', 0, 1, 1, '2018-05-04 11:29:56');
INSERT INTO `system_node` VALUES (120, 'store/goods/edit', '编辑商品', 0, 1, 1, '2018-05-04 11:29:56');
INSERT INTO `system_node` VALUES (121, 'store/goods/del', '删除商品', 0, 1, 1, '2018-05-04 11:29:56');
INSERT INTO `system_node` VALUES (122, 'store/goods/forbid', '下架商品', 0, 1, 1, '2018-05-04 11:29:56');
INSERT INTO `system_node` VALUES (123, 'store/goods/resume', '上架商品', 0, 1, 1, '2018-05-04 11:29:57');
INSERT INTO `system_node` VALUES (124, 'store/goods_brand', '商品品牌管理', 0, 1, 1, '2018-05-04 11:30:44');
INSERT INTO `system_node` VALUES (125, 'store/goods_brand/index', '商品品牌列表', 1, 1, 1, '2018-05-04 11:30:52');
INSERT INTO `system_node` VALUES (126, 'store/goods_brand/add', '添加商品品牌', 0, 1, 1, '2018-05-04 11:30:55');
INSERT INTO `system_node` VALUES (127, 'store/goods_brand/edit', '编辑商品品牌', 0, 1, 1, '2018-05-04 11:30:56');
INSERT INTO `system_node` VALUES (128, 'store/goods_brand/del', '删除商品品牌', 0, 1, 1, '2018-05-04 11:30:56');
INSERT INTO `system_node` VALUES (129, 'store/goods_brand/forbid', '禁用商品品牌', 0, 1, 1, '2018-05-04 11:30:56');
INSERT INTO `system_node` VALUES (130, 'store/goods_brand/resume', '启用商品品牌', 0, 1, 1, '2018-05-04 11:30:56');
INSERT INTO `system_node` VALUES (131, 'store/goods_cate', '商品分类管理', 0, 1, 1, '2018-05-04 11:31:19');
INSERT INTO `system_node` VALUES (132, 'store/goods_cate/index', '商品分类列表', 1, 1, 1, '2018-05-04 11:31:23');
INSERT INTO `system_node` VALUES (133, 'store/goods_cate/add', '添加商品分类', 0, 1, 1, '2018-05-04 11:31:23');
INSERT INTO `system_node` VALUES (134, 'store/goods_cate/edit', '编辑商品分类', 0, 1, 1, '2018-05-04 11:31:23');
INSERT INTO `system_node` VALUES (135, 'store/goods_cate/del', '删除商品分类', 0, 1, 1, '2018-05-04 11:31:24');
INSERT INTO `system_node` VALUES (136, 'store/goods_cate/forbid', '禁用商品分类', 0, 1, 1, '2018-05-04 11:31:24');
INSERT INTO `system_node` VALUES (137, 'store/goods_cate/resume', '启用商品分类', 0, 1, 1, '2018-05-04 11:31:24');
INSERT INTO `system_node` VALUES (138, 'store/goods_spec', '商品规格管理', 0, 1, 1, '2018-05-04 11:31:47');
INSERT INTO `system_node` VALUES (139, 'store/goods_spec/index', '商品规格列表', 1, 1, 1, '2018-05-04 11:31:47');
INSERT INTO `system_node` VALUES (140, 'store/goods_spec/add', '添加商品规格', 0, 1, 1, '2018-05-04 11:31:47');
INSERT INTO `system_node` VALUES (141, 'store/goods_spec/edit', '编辑商品规格', 0, 1, 1, '2018-05-04 11:31:48');
INSERT INTO `system_node` VALUES (142, 'store/goods_spec/del', '删除商品规格', 0, 1, 1, '2018-05-04 11:31:48');
INSERT INTO `system_node` VALUES (143, 'store/goods_spec/forbid', '禁用商品规格', 0, 1, 1, '2018-05-04 11:31:48');
INSERT INTO `system_node` VALUES (144, 'store/goods_spec/resume', '启用商品规格', 0, 1, 1, '2018-05-04 11:31:48');
INSERT INTO `system_node` VALUES (145, 'shop', '外卖管理', 0, 1, 1, '2018-08-01 18:27:03');
INSERT INTO `system_node` VALUES (146, 'shop/location', '', 0, 1, 1, '2018-08-01 18:27:24');

-- ----------------------------
-- Table structure for system_sequence
-- ----------------------------
DROP TABLE IF EXISTS `system_sequence`;
CREATE TABLE `system_sequence`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '序号类型',
  `sequence` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '序号值',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `index_system_sequence_unique`(`type`, `sequence`) USING BTREE,
  INDEX `index_system_sequence_type`(`type`) USING BTREE,
  INDEX `index_system_sequence_number`(`sequence`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统序号表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for system_user
-- ----------------------------
DROP TABLE IF EXISTS `system_user`;
CREATE TABLE `system_user`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户登录名',
  `password` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户登录密码',
  `qq` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系QQ',
  `mail` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系邮箱',
  `phone` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系手机号',
  `desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注说明',
  `login_num` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '登录次数',
  `login_at` datetime(0) NULL DEFAULT NULL,
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态(0:禁用,1:启用)',
  `authorize` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(1:删除,0:未删)',
  `create_by` bigint(20) UNSIGNED NULL DEFAULT NULL COMMENT '创建人',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `index_system_user_username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10004 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统用户表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of system_user
-- ----------------------------
INSERT INTO `system_user` VALUES (10000, 'admin', '21232f297a57a5a743894a0e4a801fc3', '22222222', '', '', '', 22997, '2018-08-31 15:21:44', 1, '2,4', 0, NULL, '2015-11-13 15:14:22');
INSERT INTO `system_user` VALUES (10001, 'ruwei', 'e10adc3949ba59abbe56e057f20f883e', NULL, '277690572@qq.com', '15220501265', '管理员', 0, NULL, 1, '', 1, NULL, '2018-07-31 09:40:04');
INSERT INTO `system_user` VALUES (10002, 'test', '', NULL, '', '', '', 0, NULL, 1, '', 0, NULL, '2018-07-31 09:44:37');
INSERT INTO `system_user` VALUES (10003, 'ruwei1', 'b59c67bf196a4758191e42f76670ceba', NULL, '', '', '', 0, NULL, 1, '', 0, NULL, '2018-08-01 18:24:04');

-- ----------------------------
-- Table structure for wechat_fans
-- ----------------------------
DROP TABLE IF EXISTS `wechat_fans`;
CREATE TABLE `wechat_fans`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `appid` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '公众号Appid',
  `unionid` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'unionid',
  `openid` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '用户的标识,对当前公众号唯一',
  `spread_openid` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '推荐人OPENID',
  `spread_at` datetime(0) NULL DEFAULT NULL COMMENT '推荐时间',
  `tagid_list` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '标签id',
  `is_black` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '是否为黑名单用户',
  `subscribe` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '用户是否关注该公众号(0:未关注, 1:已关注)',
  `nickname` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '用户的昵称',
  `sex` tinyint(1) UNSIGNED NULL DEFAULT NULL COMMENT '用户的性别,值为1时是男性,值为2时是女性,值为0时是未知',
  `country` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '用户所在国家',
  `province` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '用户所在省份',
  `city` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '用户所在城市',
  `language` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '用户的语言,简体中文为zh_CN',
  `headimgurl` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '用户头像',
  `subscribe_time` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '用户关注时间',
  `subscribe_at` datetime(0) NULL DEFAULT NULL COMMENT '关注时间',
  `remark` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注',
  `expires_in` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '有效时间',
  `refresh_token` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '刷新token',
  `access_token` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '访问token',
  `subscribe_scene` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '扫码关注场景',
  `qr_scene` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '二维码场景值',
  `qr_scene_str` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '二维码场景内容',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_wechat_fans_spread_openid`(`spread_openid`) USING BTREE,
  INDEX `index_wechat_fans_openid`(`openid`) USING BTREE,
  INDEX `index_wechat_fans_unionid`(`unionid`) USING BTREE,
  INDEX `index_wechat_fans_is_back`(`is_black`) USING BTREE,
  INDEX `index_wechat_fans_subscribe`(`subscribe`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '微信粉丝' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wechat_fans_tags
-- ----------------------------
DROP TABLE IF EXISTS `wechat_fans_tags`;
CREATE TABLE `wechat_fans_tags`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '标签ID',
  `appid` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公众号APPID',
  `name` varchar(35) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标签名称',
  `count` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '总数',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  INDEX `index_wechat_fans_tags_id`(`id`) USING BTREE,
  INDEX `index_wechat_fans_tags_appid`(`appid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '微信会员标签' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wechat_keys
-- ----------------------------
DROP TABLE IF EXISTS `wechat_keys`;
CREATE TABLE `wechat_keys`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appid` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '公众号APPID',
  `type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '类型，text 文件消息，image 图片消息，news 图文消息',
  `keys` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关键字',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '文本内容',
  `image_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '图片链接',
  `voice_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '语音链接',
  `music_title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '音乐标题',
  `music_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '音乐链接',
  `music_image` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '音乐缩略图链接',
  `music_desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '音乐描述',
  `video_title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '视频标题',
  `video_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '视频URL',
  `video_desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '视频描述',
  `news_id` bigint(20) UNSIGNED NULL DEFAULT NULL COMMENT '图文ID',
  `sort` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '排序字段',
  `status` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '0 禁用，1 启用',
  `create_by` bigint(20) UNSIGNED NULL DEFAULT NULL COMMENT '创建人',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_wechat_keys_appid`(`appid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '微信关键字' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wechat_menu
-- ----------------------------
DROP TABLE IF EXISTS `wechat_menu`;
CREATE TABLE `wechat_menu`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `index` bigint(20) NULL DEFAULT NULL,
  `pindex` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT '父id',
  `type` varchar(24) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '菜单类型 null主菜单 link链接 keys关键字',
  `name` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '菜单名称',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文字内容',
  `sort` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '排序',
  `status` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '状态(0禁用1启用)',
  `create_by` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建人',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_wechat_menu_pindex`(`pindex`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '微信菜单配置' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wechat_news
-- ----------------------------
DROP TABLE IF EXISTS `wechat_news`;
CREATE TABLE `wechat_news`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `media_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '永久素材MediaID',
  `local_url` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '永久素材显示URL',
  `article_id` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '关联图文ID，用，号做分割',
  `is_deleted` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '是否删除',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_wechat_news_artcle_id`(`article_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '微信图文表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wechat_news_article
-- ----------------------------
DROP TABLE IF EXISTS `wechat_news_article`;
CREATE TABLE `wechat_news_article`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '素材标题',
  `local_url` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '永久素材显示URL',
  `show_cover_pic` tinyint(4) UNSIGNED NULL DEFAULT 0 COMMENT '是否显示封面 0不显示，1 显示',
  `author` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '作者',
  `digest` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '摘要内容',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '图文内容',
  `content_source_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '图文消息原文地址',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '微信素材表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wechat_news_image
-- ----------------------------
DROP TABLE IF EXISTS `wechat_news_image`;
CREATE TABLE `wechat_news_image`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '文件md5',
  `local_url` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '本地文件链接',
  `media_url` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '远程图片链接',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_wechat_news_image_md5`(`md5`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '微信服务器图片' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wechat_news_media
-- ----------------------------
DROP TABLE IF EXISTS `wechat_news_media`;
CREATE TABLE `wechat_news_media`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `appid` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '公众号ID',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '文件md5',
  `type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '媒体类型',
  `media_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '永久素材MediaID',
  `local_url` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '本地文件链接',
  `media_url` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '远程图片链接',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '微信素材表' ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;
