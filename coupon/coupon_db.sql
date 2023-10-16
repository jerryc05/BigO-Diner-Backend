CREATE DATABASE IF NOT EXISTS bigo_diner_backend_coupon DEFAULT CHARSET utf8mb4;

USE bigo_diner_backend_coupon;

DROP TABLE IF EXISTS cms_coupon;

DROP TABLE IF EXISTS cms_coupon_history;

DROP TABLE IF EXISTS cms_coupon_spu_category_relation;

DROP TABLE IF EXISTS cms_coupon_spu_relation;

DROP TABLE IF EXISTS cms_home_adv;

DROP TABLE IF EXISTS cms_home_subject;

DROP TABLE IF EXISTS cms_home_subject_spu;

DROP TABLE IF EXISTS cms_member_price;

DROP TABLE IF EXISTS cms_seckill_promotion;

DROP TABLE IF EXISTS cms_seckill_session;

DROP TABLE IF EXISTS cms_seckill_sku_notice;

DROP TABLE IF EXISTS cms_seckill_sku_relation;

DROP TABLE IF EXISTS cms_sku_full_reduction;

DROP TABLE IF EXISTS cms_sku_ladder;

DROP TABLE IF EXISTS cms_spu_bounds;

/*==============================================================*/
/* Table: cms_coupon                                            */
/*==============================================================*/
CREATE TABLE cms_coupon (
  id bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  coupon_type tinyint(1) COMMENT '优惠卷类型[0->全场赠券；1->会员赠券；2->购物赠券；3->注册赠券]',
  coupon_img varchar(2000) COMMENT '优惠券图片',
  coupon_name varchar(100) COMMENT '优惠卷名字',
  num int COMMENT '数量',
  amount decimal(18, 4) COMMENT '金额',
  per_limit int COMMENT '每人限领张数',
  min_point decimal(18, 4) COMMENT '使用门槛',
  start_time datetime COMMENT '开始时间',
  end_time datetime COMMENT '结束时间',
  use_type tinyint(1) COMMENT '使用类型[0->全场通用；1->指定分类；2->指定商品]',
  note varchar(200) COMMENT '备注',
  publish_count int(11) COMMENT '发行数量',
  use_count int(11) COMMENT '已使用数量',
  receive_count int(11) COMMENT '领取数量',
  enable_start_time datetime COMMENT '可以领取的开始日期',
  enable_end_time datetime COMMENT '可以领取的结束日期',
  code varchar(64) COMMENT '优惠码',
  member_level tinyint(1) COMMENT '可以领取的会员等级[0->不限等级，其他-对应等级]',
  publish tinyint(1) COMMENT '发布状态[0-未发布，1-已发布]',
  PRIMARY KEY (id)
);

ALTER TABLE cms_coupon COMMENT '优惠券信息';

/*==============================================================*/
/* Table: cms_coupon_history                                    */
/*==============================================================*/
CREATE TABLE cms_coupon_history (
  id bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  coupon_id bigint COMMENT '优惠券id',
  member_id bigint COMMENT '会员id',
  member_nick_name varchar(64) COMMENT '会员名字',
  get_type tinyint(1) COMMENT '获取方式[0->后台赠送；1->主动领取]',
  create_time datetime COMMENT '创建时间',
  use_type tinyint(1) COMMENT '使用状态[0->未使用；1->已使用；2->已过期]',
  use_time datetime COMMENT '使用时间',
  order_id bigint COMMENT '订单id',
  order_sn bigint COMMENT '订单号',
  PRIMARY KEY (id)
);

ALTER TABLE cms_coupon_history COMMENT '优惠券领取历史记录';

/*==============================================================*/
/* Table: cms_coupon_spu_category_relation                      */
/*==============================================================*/
CREATE TABLE cms_coupon_spu_category_relation (
  id bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  coupon_id bigint COMMENT '优惠券id',
  category_id bigint COMMENT '产品分类id',
  category_name varchar(64) COMMENT '产品分类名称',
  PRIMARY KEY (id)
);

ALTER TABLE cms_coupon_spu_category_relation COMMENT '优惠券分类关联';

/*==============================================================*/
/* Table: cms_coupon_spu_relation                               */
/*==============================================================*/
CREATE TABLE cms_coupon_spu_relation (
  id bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  coupon_id bigint COMMENT '优惠券id',
  spu_id bigint COMMENT 'spu_id',
  spu_name varchar(255) COMMENT 'spu_name',
  PRIMARY KEY (id)
);

ALTER TABLE cms_coupon_spu_relation COMMENT '优惠券与产品关联';

/*==============================================================*/
/* Table: cms_home_adv                                          */
/*==============================================================*/
CREATE TABLE cms_home_adv (
  id bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(100) COMMENT '名字',
  pic varchar(500) COMMENT '图片地址',
  start_time datetime COMMENT '开始时间',
  end_time datetime COMMENT '结束时间',
  `status` tinyint(1) COMMENT '状态',
  click_count int COMMENT '点击数',
  `url` varchar(500) COMMENT '广告详情连接地址',
  note varchar(500) COMMENT '备注',
  sort int COMMENT '排序',
  publisher_id bigint COMMENT '发布者',
  auth_id bigint COMMENT '审核者',
  PRIMARY KEY (id)
);

ALTER TABLE cms_home_adv COMMENT '首页轮播广告';

/*==============================================================*/
/* Table: cms_home_subject                                      */
/*==============================================================*/
CREATE TABLE cms_home_subject (
  id bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(200) COMMENT '专题名字',
  title varchar(255) COMMENT '专题标题',
  sub_title varchar(255) COMMENT '专题副标题',
  `status` tinyint(1) COMMENT '显示状态',
  `url` varchar(500) COMMENT '详情连接',
  sort int COMMENT '排序',
  img varchar(500) COMMENT '专题图片地址',
  PRIMARY KEY (id)
);

ALTER TABLE cms_home_subject COMMENT '首页专题表【jd首页下面很多专题，每个专题链接新的页面，展示专题商品信息】';

/*==============================================================*/
/* Table: cms_home_subject_spu                                  */
/*==============================================================*/
CREATE TABLE cms_home_subject_spu (
  id bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(200) COMMENT '专题名字',
  subject_id bigint COMMENT '专题id',
  spu_id bigint COMMENT 'spu_id',
  sort int COMMENT '排序',
  PRIMARY KEY (id)
);

ALTER TABLE cms_home_subject_spu COMMENT '专题商品';

/*==============================================================*/
/* Table: cms_member_price                                      */
/*==============================================================*/
CREATE TABLE cms_member_price (
  id bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  sku_id bigint COMMENT 'sku_id',
  member_level_id bigint COMMENT '会员等级id',
  member_level_name varchar(100) COMMENT '会员等级名',
  member_price decimal(18, 4) COMMENT '会员对应价格',
  add_other tinyint(1) COMMENT '可否叠加其他优惠[0-不可叠加优惠，1-可叠加]',
  PRIMARY KEY (id)
);

ALTER TABLE cms_member_price COMMENT '商品会员价格';

/*==============================================================*/
/* Table: cms_seckill_promotion                                 */
/*==============================================================*/
CREATE TABLE cms_seckill_promotion (
  id bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  title varchar(255) COMMENT '活动标题',
  start_time datetime COMMENT '开始日期',
  end_time datetime COMMENT '结束日期',
  `status` tinyint COMMENT '上下线状态',
  create_time datetime COMMENT '创建时间',
  user_id bigint COMMENT '创建人',
  PRIMARY KEY (id)
);

ALTER TABLE cms_seckill_promotion COMMENT '秒杀活动';

/*==============================================================*/
/* Table: cms_seckill_session                                   */
/*==============================================================*/
CREATE TABLE cms_seckill_session (
  id bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(200) COMMENT '场次名称',
  start_time datetime COMMENT '每日开始时间',
  end_time datetime COMMENT '每日结束时间',
  `status` tinyint(1) COMMENT '启用状态',
  create_time datetime COMMENT '创建时间',
  PRIMARY KEY (id)
);

ALTER TABLE cms_seckill_session COMMENT '秒杀活动场次';

/*==============================================================*/
/* Table: cms_seckill_sku_notice                                */
/*==============================================================*/
CREATE TABLE cms_seckill_sku_notice (
  id bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  member_id bigint COMMENT 'member_id',
  sku_id bigint COMMENT 'sku_id',
  `session_id` bigint COMMENT '活动场次id',
  subcribe_time datetime COMMENT '订阅时间',
  send_time datetime COMMENT '发送时间',
  notice_type tinyint(1) COMMENT '通知方式[0-短信，1-邮件]',
  PRIMARY KEY (id)
);

ALTER TABLE cms_seckill_sku_notice COMMENT '秒杀商品通知订阅';

/*==============================================================*/
/* Table: cms_seckill_sku_relation                              */
/*==============================================================*/
CREATE TABLE cms_seckill_sku_relation (
  id bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  promotion_id bigint COMMENT '活动id',
  promotion_session_id bigint COMMENT '活动场次id',
  sku_id bigint COMMENT '商品id',
  seckill_price decimal COMMENT '秒杀价格',
  seckill_count decimal COMMENT '秒杀总量',
  seckill_limit decimal COMMENT '每人限购数量',
  seckill_sort int COMMENT '排序',
  PRIMARY KEY (id)
);

ALTER TABLE cms_seckill_sku_relation COMMENT '秒杀活动商品关联';

/*==============================================================*/
/* Table: cms_sku_full_reduction                                */
/*==============================================================*/
CREATE TABLE cms_sku_full_reduction (
  id bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  sku_id bigint COMMENT 'spu_id',
  full_price decimal(18, 4) COMMENT '满多少',
  reduce_price decimal(18, 4) COMMENT '减多少',
  add_other tinyint(1) COMMENT '是否参与其他优惠',
  PRIMARY KEY (id)
);

ALTER TABLE cms_sku_full_reduction COMMENT '商品满减信息';

/*==============================================================*/
/* Table: cms_sku_ladder                                        */
/*==============================================================*/
CREATE TABLE cms_sku_ladder (
  id bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  sku_id bigint COMMENT 'spu_id',
  full_count int COMMENT '满几件',
  discount decimal(4, 2) COMMENT '打几折',
  price decimal(18, 4) COMMENT '折后价',
  add_other tinyint(1) COMMENT '是否叠加其他优惠[0-不可叠加，1-可叠加]',
  PRIMARY KEY (id)
);

ALTER TABLE cms_sku_ladder COMMENT '商品阶梯价格';

/*==============================================================*/
/* Table: cms_spu_bounds                                        */
/*==============================================================*/
CREATE TABLE cms_spu_bounds (
  id bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  spu_id bigint,
  grow_bounds decimal(18, 4) COMMENT '成长积分',
  buy_bounds decimal(18, 4) COMMENT '购物积分',
  WORK tinyint(1) COMMENT '优惠生效情况[1111（四个状态位，从右到左）;0 - 无优惠，成长积分是否赠送;1 - 无优惠，购物积分是否赠送;2 - 有优惠，成长积分是否赠送;3 - 有优惠，购物积分是否赠送【状态位0：不赠送，1：赠送】]',
  PRIMARY KEY (id)
);

ALTER TABLE cms_spu_bounds COMMENT '商品spu积分设置';
