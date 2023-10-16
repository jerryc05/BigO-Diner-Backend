CREATE DATABASE IF NOT EXISTS bigo_diner_backend_product DEFAULT CHARSET utf8mb4;

USE bigo_diner_backend_product;

DROP TABLE IF EXISTS pms_attr;

DROP TABLE IF EXISTS pms_attr_attrgroup_relation;

DROP TABLE IF EXISTS pms_attr_group;

DROP TABLE IF EXISTS pms_brand;

DROP TABLE IF EXISTS pms_category;

DROP TABLE IF EXISTS pms_category_brand_relation;

DROP TABLE IF EXISTS pms_comment_replay;

DROP TABLE IF EXISTS pms_product_attr_value;

DROP TABLE IF EXISTS pms_sku_images;

DROP TABLE IF EXISTS pms_sku_info;

DROP TABLE IF EXISTS pms_sku_sale_attr_value;

DROP TABLE IF EXISTS pms_spu_comment;

DROP TABLE IF EXISTS pms_spu_images;

DROP TABLE IF EXISTS pms_spu_info;

DROP TABLE IF EXISTS pms_spu_info_desc;

/*==============================================================*/
/* Table: pms_attr                                              */
/*==============================================================*/
CREATE TABLE pms_attr (
  attr_id bigint NOT NULL AUTO_INCREMENT COMMENT '属性id',
  attr_name char(30) COMMENT '属性名',
  search_type tinyint COMMENT '是否需要检索[0-不需要，1-需要]',
  value_type tinyint(4) DEFAULT NULL COMMENT '值类型[0-为单个值，1-可以选择多个值]',
  icon varchar(255) DEFAULT NULL COMMENT '属性图标',
  value_select char(255) DEFAULT NULL COMMENT '可选值列表[用逗号分隔]',
  attr_type tinyint(4) DEFAULT NULL COMMENT '属性类型[0-销售属性，1-基本属性，2-既是销售属性又是基本属性]',
  `enable` bigint COMMENT '启用状态[0 - 禁用，1 - 启用]',
  catelog_id bigint COMMENT '所属分类',
  show_desc tinyint COMMENT '快速展示【是否展示在介绍上；0-否 1-是】，在sku中仍然可以调整',
  PRIMARY KEY (attr_id)
);

ALTER TABLE pms_attr COMMENT '商品属性';

/*==============================================================*/
/* Table: pms_attr_attrgroup_relation                           */
/*==============================================================*/
CREATE TABLE pms_attr_attrgroup_relation (
  id bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  attr_id bigint COMMENT '属性id',
  attr_group_id bigint COMMENT '属性分组id',
  attr_sort int COMMENT '属性组内排序',
  PRIMARY KEY (id)
);

ALTER TABLE pms_attr_attrgroup_relation COMMENT '属性&属性分组关联';

/*==============================================================*/
/* Table: pms_attr_group                                        */
/*==============================================================*/
CREATE TABLE pms_attr_group (
  attr_group_id bigint NOT NULL AUTO_INCREMENT COMMENT '分组id',
  attr_group_name char(20) COMMENT '组名',
  sort int COMMENT '排序',
  descript varchar(255) COMMENT '描述',
  icon varchar(255) COMMENT '组图标',
  catelog_id bigint COMMENT '所属分类id',
  PRIMARY KEY (attr_group_id)
);

ALTER TABLE pms_attr_group COMMENT '属性分组';

/*==============================================================*/
/* Table: pms_brand                                             */
/*==============================================================*/
CREATE TABLE pms_brand (
  brand_id bigint NOT NULL AUTO_INCREMENT COMMENT '品牌id',
  `name` char(50) COMMENT '品牌名',
  logo varchar(2000) COMMENT '品牌logo地址',
  descript longtext COMMENT '介绍',
  show_status tinyint COMMENT '显示状态[0-不显示；1-显示]',
  first_letter char(1) COMMENT '检索首字母',
  sort int COMMENT '排序',
  PRIMARY KEY (brand_id)
);

ALTER TABLE pms_brand COMMENT '品牌';

/*==============================================================*/
/* Table: pms_category                                          */
/*==============================================================*/
CREATE TABLE pms_category (
  cat_id bigint NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `name` char(50) COMMENT '分类名称',
  parent_cid bigint COMMENT '父分类id',
  cat_level int COMMENT '层级',
  show_status tinyint COMMENT '是否显示[0-不显示，1显示]',
  sort int COMMENT '排序',
  icon char(255) COMMENT '图标地址',
  product_unit char(50) COMMENT '计量单位',
  product_count int COMMENT '商品数量',
  PRIMARY KEY (cat_id)
);

ALTER TABLE pms_category COMMENT '商品三级分类';

/*==============================================================*/
/* Table: pms_category_brand_relation                           */
/*==============================================================*/
CREATE TABLE pms_category_brand_relation (
  id bigint NOT NULL AUTO_INCREMENT,
  brand_id bigint COMMENT '品牌id',
  catelog_id bigint COMMENT '分类id',
  brand_name varchar(255),
  catelog_name varchar(255),
  PRIMARY KEY (id)
);

ALTER TABLE pms_category_brand_relation COMMENT '品牌分类关联';

/*==============================================================*/
/* Table: pms_comment_replay                                    */
/*==============================================================*/
CREATE TABLE pms_comment_replay (
  id bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  comment_id bigint COMMENT '评论id',
  reply_id bigint COMMENT '回复id',
  PRIMARY KEY (id)
);

ALTER TABLE pms_comment_replay COMMENT '商品评价回复关系';

/*==============================================================*/
/* Table: pms_product_attr_value                                */
/*==============================================================*/
CREATE TABLE pms_product_attr_value (
  id bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  spu_id bigint COMMENT '商品id',
  attr_id bigint COMMENT '属性id',
  attr_name varchar(200) COMMENT '属性名',
  attr_value varchar(200) COMMENT '属性值',
  attr_sort int COMMENT '顺序',
  quick_show tinyint COMMENT '快速展示【是否展示在介绍上；0-否 1-是】',
  PRIMARY KEY (id)
);

ALTER TABLE pms_product_attr_value COMMENT 'spu属性值';

/*==============================================================*/
/* Table: pms_sku_images                                        */
/*==============================================================*/
CREATE TABLE pms_sku_images (
  id bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  sku_id bigint COMMENT 'sku_id',
  img_url varchar(255) COMMENT '图片地址',
  img_sort int COMMENT '排序',
  default_img int COMMENT '默认图[0 - 不是默认图，1 - 是默认图]',
  PRIMARY KEY (id)
);

ALTER TABLE pms_sku_images COMMENT 'sku图片';

/*==============================================================*/
/* Table: pms_sku_info                                          */
/*==============================================================*/
CREATE TABLE pms_sku_info (
  sku_id bigint NOT NULL AUTO_INCREMENT COMMENT 'skuId',
  spu_id bigint COMMENT 'spuId',
  sku_name varchar(255) COMMENT 'sku名称',
  sku_desc varchar(2000) COMMENT 'sku介绍描述',
  catalog_id bigint COMMENT '所属分类id',
  brand_id bigint COMMENT '品牌id',
  sku_default_img varchar(255) COMMENT '默认图片',
  sku_title varchar(255) COMMENT '标题',
  sku_subtitle varchar(2000) COMMENT '副标题',
  price decimal(18, 4) COMMENT '价格',
  sale_count bigint COMMENT '销量',
  PRIMARY KEY (sku_id)
);

ALTER TABLE pms_sku_info COMMENT 'sku信息';

/*==============================================================*/
/* Table: pms_sku_sale_attr_value                               */
/*==============================================================*/
CREATE TABLE pms_sku_sale_attr_value (
  id bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  sku_id bigint COMMENT 'sku_id',
  attr_id bigint COMMENT 'attr_id',
  attr_name varchar(200) COMMENT '销售属性名',
  attr_value varchar(200) COMMENT '销售属性值',
  attr_sort int COMMENT '顺序',
  PRIMARY KEY (id)
);

ALTER TABLE pms_sku_sale_attr_value COMMENT 'sku销售属性&值';

/*==============================================================*/
/* Table: pms_spu_comment                                       */
/*==============================================================*/
CREATE TABLE pms_spu_comment (
  id bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  sku_id bigint COMMENT 'sku_id',
  spu_id bigint COMMENT 'spu_id',
  spu_name varchar(255) COMMENT '商品名字',
  member_nick_name varchar(255) COMMENT '会员昵称',
  star tinyint(1) COMMENT '星级',
  member_ip varchar(64) COMMENT '会员ip',
  create_time datetime COMMENT '创建时间',
  show_status tinyint(1) COMMENT '显示状态[0-不显示，1-显示]',
  spu_attributes varchar(255) COMMENT '购买时属性组合',
  likes_count int COMMENT '点赞数',
  reply_count int COMMENT '回复数',
  resources varchar(1000) COMMENT '评论图片/视频[json数据；[{type:文件类型,url:资源路径}]]',
  content text COMMENT '内容',
  member_icon varchar(255) COMMENT '用户头像',
  comment_type tinyint COMMENT '评论类型[0 - 对商品的直接评论，1 - 对评论的回复]',
  PRIMARY KEY (id)
);

ALTER TABLE pms_spu_comment COMMENT '商品评价';

/*==============================================================*/
/* Table: pms_spu_images                                        */
/*==============================================================*/
CREATE TABLE pms_spu_images (
  id bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  spu_id bigint COMMENT 'spu_id',
  img_name varchar(200) COMMENT '图片名',
  img_url varchar(255) COMMENT '图片地址',
  img_sort int COMMENT '顺序',
  default_img tinyint COMMENT '是否默认图',
  PRIMARY KEY (id)
);

ALTER TABLE pms_spu_images COMMENT 'spu图片';

/*==============================================================*/
/* Table: pms_spu_info                                          */
/*==============================================================*/
CREATE TABLE pms_spu_info (
  id bigint NOT NULL AUTO_INCREMENT COMMENT '商品id',
  spu_name varchar(200) COMMENT '商品名称',
  spu_description varchar(1000) COMMENT '商品描述',
  catalog_id bigint COMMENT '所属分类id',
  brand_id bigint COMMENT '品牌id',
  `weight` decimal(18, 4),
  publish_status tinyint COMMENT '上架状态[0 - 下架，1 - 上架]',
  create_time datetime,
  update_time datetime,
  PRIMARY KEY (id)
);

ALTER TABLE pms_spu_info COMMENT 'spu信息';

/*==============================================================*/
/* Table: pms_spu_info_desc                                     */
/*==============================================================*/
CREATE TABLE pms_spu_info_desc (
  spu_id bigint NOT NULL COMMENT '商品id',
  decript longtext COMMENT '商品介绍',
  PRIMARY KEY (spu_id)
);

ALTER TABLE pms_spu_info_desc COMMENT 'spu信息介绍';
