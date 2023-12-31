CREATE DATABASE IF NOT EXISTS bigo_diner_backend_ware DEFAULT CHARSET utf8mb4;

USE bigo_diner_backend_ware;

DROP TABLE IF EXISTS wms_purchase;

DROP TABLE IF EXISTS wms_purchase_detail;

DROP TABLE IF EXISTS wms_ware_info;

DROP TABLE IF EXISTS wms_ware_order_task;

DROP TABLE IF EXISTS wms_ware_order_task_detail;

DROP TABLE IF EXISTS wms_ware_sku;

/*==============================================================*/
/* Table: wms_purchase                                          */
/*==============================================================*/
CREATE TABLE wms_purchase (
  id bigint NOT NULL AUTO_INCREMENT COMMENT '采购单id',
  assignee_id bigint COMMENT '采购人id',
  assignee_name varchar(255) COMMENT '采购人名',
  phone char(13) COMMENT '联系方式',
  `priority` int(4) COMMENT '优先级',
  `status` int(4) COMMENT '状态',
  ware_id bigint COMMENT '仓库id',
  amount decimal(18, 4) COMMENT '总金额',
  create_time datetime COMMENT '创建日期',
  update_time datetime COMMENT '更新日期',
  PRIMARY KEY (id)
);

ALTER TABLE wms_purchase COMMENT '采购信息';

/*==============================================================*/
/* Table: wms_purchase_detail                                   */
/*==============================================================*/
CREATE TABLE wms_purchase_detail (
  id bigint NOT NULL AUTO_INCREMENT,
  purchase_id bigint COMMENT '采购单id',
  sku_id bigint COMMENT '采购商品id',
  sku_num int COMMENT '采购数量',
  sku_price decimal(18, 4) COMMENT '采购金额',
  ware_id bigint COMMENT '仓库id',
  `status` int COMMENT '状态[0新建，1已分配，2正在采购，3已完成，4采购失败]',
  PRIMARY KEY (id)
);

/*==============================================================*/
/* Table: wms_ware_info                                         */
/*==============================================================*/
CREATE TABLE wms_ware_info (
  id bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) COMMENT '仓库名',
  `address` varchar(255) COMMENT '仓库地址',
  areacode varchar(20) COMMENT '区域编码',
  PRIMARY KEY (id)
);

ALTER TABLE wms_ware_info COMMENT '仓库信息';

/*==============================================================*/
/* Table: wms_ware_order_task                                   */
/*==============================================================*/
CREATE TABLE wms_ware_order_task (
  id bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  order_id bigint COMMENT 'order_id',
  order_sn varchar(255) COMMENT 'order_sn',
  consignee varchar(100) COMMENT '收货人',
  consignee_tel char(15) COMMENT '收货人电话',
  delivery_address varchar(500) COMMENT '配送地址',
  order_comment varchar(200) COMMENT '订单备注',
  payment_way tinyint(1) COMMENT '付款方式【 1:在线付款 2:货到付款】',
  task_status tinyint(2) COMMENT '任务状态',
  order_body varchar(255) COMMENT '订单描述',
  tracking_no char(30) COMMENT '物流单号',
  create_time datetime COMMENT 'create_time',
  ware_id bigint COMMENT '仓库id',
  task_comment varchar(500) COMMENT '工作单备注',
  PRIMARY KEY (id)
);

ALTER TABLE wms_ware_order_task COMMENT '库存工作单';

/*==============================================================*/
/* Table: wms_ware_order_task_detail                            */
/*==============================================================*/
CREATE TABLE wms_ware_order_task_detail (
  id bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  sku_id bigint COMMENT 'sku_id',
  sku_name varchar(255) COMMENT 'sku_name',
  sku_num int COMMENT '购买个数',
  task_id bigint COMMENT '工作单id',
  PRIMARY KEY (id)
);

ALTER TABLE wms_ware_order_task_detail COMMENT '库存工作单';

/*==============================================================*/
/* Table: wms_ware_sku                                          */
/*==============================================================*/
CREATE TABLE wms_ware_sku (
  id bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  sku_id bigint COMMENT 'sku_id',
  ware_id bigint COMMENT '仓库id',
  stock int COMMENT '库存数',
  sku_name varchar(200) COMMENT 'sku_name',
  stock_locked int COMMENT '锁定库存',
  PRIMARY KEY (id)
);

ALTER TABLE wms_ware_sku COMMENT '商品库存';
