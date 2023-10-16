CREATE DATABASE IF NOT EXISTS bigo_diner_backend_user DEFAULT CHARSET utf8mb4;

USE bigo_diner_backend_user;

DROP TABLE IF EXISTS ums_growth_change_history;

DROP TABLE IF EXISTS ums_integration_change_history;

DROP TABLE IF EXISTS ums_member;

DROP TABLE IF EXISTS ums_member_collect_spu;

DROP TABLE IF EXISTS ums_member_collect_subject;

DROP TABLE IF EXISTS ums_member_level;

DROP TABLE IF EXISTS ums_member_login_log;

DROP TABLE IF EXISTS ums_member_receive_address;

DROP TABLE IF EXISTS ums_member_statistics_info;

/*==============================================================*/
/* Table: ums_growth_change_history                             */
/*==============================================================*/
CREATE TABLE ums_growth_change_history (
  id bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  member_id bigint COMMENT 'member_id',
  create_time datetime COMMENT 'create_time',
  change_count int COMMENT '改变的值（正负计数）',
  note varchar(0) COMMENT '备注',
  source_type tinyint COMMENT '积分来源[0-购物，1-管理员修改]',
  PRIMARY KEY (id)
);

ALTER TABLE ums_growth_change_history COMMENT '成长值变化历史记录';

/*==============================================================*/
/* Table: ums_integration_change_history                        */
/*==============================================================*/
CREATE TABLE ums_integration_change_history (
  id bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  member_id bigint COMMENT 'member_id',
  create_time datetime COMMENT 'create_time',
  change_count int COMMENT '变化的值',
  note varchar(255) COMMENT '备注',
  source_tyoe tinyint COMMENT '来源[0->购物；1->管理员修改;2->活动]',
  PRIMARY KEY (id)
);

ALTER TABLE ums_integration_change_history COMMENT '积分变化历史记录';

/*==============================================================*/
/* Table: ums_member                                            */
/*==============================================================*/
CREATE TABLE ums_member (
  id bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  level_id bigint COMMENT '会员等级id',
  username char(64) COMMENT '用户名',
  PASSWORD varchar(64) COMMENT '密码',
  nickname varchar(64) COMMENT '昵称',
  mobile varchar(20) COMMENT '手机号码',
  email varchar(64) COMMENT '邮箱',
  header varchar(500) COMMENT '头像',
  gender tinyint COMMENT '性别',
  birth date COMMENT '生日',
  city varchar(500) COMMENT '所在城市',
  job varchar(255) COMMENT '职业',
  sign varchar(255) COMMENT '个性签名',
  source_type tinyint COMMENT '用户来源',
  integration int COMMENT '积分',
  growth int COMMENT '成长值',
  STATUS tinyint COMMENT '启用状态',
  create_time datetime COMMENT '注册时间',
  PRIMARY KEY (id)
);

ALTER TABLE ums_member COMMENT '会员';

/*==============================================================*/
/* Table: ums_member_collect_spu                                */
/*==============================================================*/
CREATE TABLE ums_member_collect_spu (
  id bigint NOT NULL COMMENT 'id',
  member_id bigint COMMENT '会员id',
  spu_id bigint COMMENT 'spu_id',
  spu_name varchar(500) COMMENT 'spu_name',
  spu_img varchar(500) COMMENT 'spu_img',
  create_time datetime COMMENT 'create_time',
  PRIMARY KEY (id)
);

ALTER TABLE ums_member_collect_spu COMMENT '会员收藏的商品';

/*==============================================================*/
/* Table: ums_member_collect_subject                            */
/*==============================================================*/
CREATE TABLE ums_member_collect_subject (
  id bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  subject_id bigint COMMENT 'subject_id',
  subject_name varchar(255) COMMENT 'subject_name',
  subject_img varchar(500) COMMENT 'subject_img',
  subject_urll varchar(500) COMMENT '活动url',
  PRIMARY KEY (id)
);

ALTER TABLE ums_member_collect_subject COMMENT '会员收藏的专题活动';

/*==============================================================*/
/* Table: ums_member_level                                      */
/*==============================================================*/
CREATE TABLE ums_member_level (
  id bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  name varchar(100) COMMENT '等级名称',
  growth_point int COMMENT '等级需要的成长值',
  default_status tinyint COMMENT '是否为默认等级[0->不是；1->是]',
  free_freight_point decimal(18, 4) COMMENT '免运费标准',
  comment_growth_point int COMMENT '每次评价获取的成长值',
  priviledge_free_freight tinyint COMMENT '是否有免邮特权',
  priviledge_member_price tinyint COMMENT '是否有会员价格特权',
  priviledge_birthday tinyint COMMENT '是否有生日特权',
  note varchar(255) COMMENT '备注',
  PRIMARY KEY (id)
);

ALTER TABLE ums_member_level COMMENT '会员等级';

/*==============================================================*/
/* Table: ums_member_login_log                                  */
/*==============================================================*/
CREATE TABLE ums_member_login_log (
  id bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  member_id bigint COMMENT 'member_id',
  create_time datetime COMMENT '创建时间',
  ip varchar(64) COMMENT 'ip',
  city varchar(64) COMMENT 'city',
  login_type tinyint(1) COMMENT '登录类型[1-web，2-app]',
  PRIMARY KEY (id)
);

ALTER TABLE ums_member_login_log COMMENT '会员登录记录';

/*==============================================================*/
/* Table: ums_member_receive_address                            */
/*==============================================================*/
CREATE TABLE ums_member_receive_address (
  id bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  member_id bigint COMMENT 'member_id',
  name varchar(255) COMMENT '收货人姓名',
  phone varchar(64) COMMENT '电话',
  post_code varchar(64) COMMENT '邮政编码',
  province varchar(100) COMMENT '省份/直辖市',
  city varchar(100) COMMENT '城市',
  region varchar(100) COMMENT '区',
  detail_address varchar(255) COMMENT '详细地址(街道)',
  areacode varchar(15) COMMENT '省市区代码',
  default_status tinyint(1) COMMENT '是否默认',
  PRIMARY KEY (id)
);

ALTER TABLE ums_member_receive_address COMMENT '会员收货地址';

/*==============================================================*/
/* Table: ums_member_statistics_info                            */
/*==============================================================*/
CREATE TABLE ums_member_statistics_info (
  id bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  member_id bigint COMMENT '会员id',
  consume_amount decimal(18, 4) COMMENT '累计消费金额',
  coupon_amount decimal(18, 4) COMMENT '累计优惠金额',
  order_count int COMMENT '订单数量',
  coupon_count int COMMENT '优惠券数量',
  comment_count int COMMENT '评价数',
  return_order_count int COMMENT '退货数量',
  login_count int COMMENT '登录次数',
  attend_count int COMMENT '关注数量',
  fans_count int COMMENT '粉丝数量',
  collect_product_count int COMMENT '收藏的商品数量',
  collect_subject_count int COMMENT '收藏的专题活动数量',
  collect_comment_count int COMMENT '收藏的评论数量',
  invite_friend_count int COMMENT '邀请的朋友数量',
  PRIMARY KEY (id)
);

ALTER TABLE ums_member_statistics_info COMMENT '会员统计信息';
