SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Indexes */

DROP INDEX test_data_main_del_flag ON oa_reimburse;
DROP INDEX test_data_child_del_flag ON oa_reimburse_detail;



/* Drop Tables */

DROP TABLE IF EXISTS oa_reimburse_detail;
DROP TABLE IF EXISTS oa_reimburse;




/* Create Tables */

-- 报销主表
CREATE TABLE oa_reimburse
(
	-- 编号
	id varchar(64) NOT NULL COMMENT '编号',
	-- 出差人
	user_id varchar(64) NOT NULL COMMENT '出差人',
	-- 月份
	month varchar(64) NOT NULL COMMENT '月份',
	-- 报销日期
	reimburse_date varchar(64) NOT NULL COMMENT '报销日期',
	-- 报销类型
	reimburse_type int NOT NULL COMMENT '报销类型',
	-- 出差天数
	business_days int NOT NULL COMMENT '出差天数',
	-- 差补总和
	travel_allowance date NOT NULL COMMENT '差补总和',
	-- 交通费用总和
	jtfyzh double(8,2) DEFAULT 0 COMMENT '交通费用总和',
	-- 餐费总和
	zsfyzh double(8,2) DEFAULT 0 COMMENT '餐费总和',
	-- 餐费总和
	cfzh double(8,2) DEFAULT 0 COMMENT '餐费总和',
	-- 招待费总和
	zdfzh double(8,2) DEFAULT 0 COMMENT '招待费总和',
	-- 租赁费总和
	zlfzh double(8,2) DEFAULT 0 COMMENT '租赁费总和',
	-- 福利费总和
	flfzh double(8,2) COMMENT '福利费总和',
	-- 投标费总和
	tbfzh double(8,2) COMMENT '投标费总和',
	-- 创建者
	create_by varchar(64) NOT NULL COMMENT '创建者',
	-- 创建时间
	create_date datetime NOT NULL COMMENT '创建时间',
	-- 更新者
	update_by varchar(64) NOT NULL COMMENT '更新者',
	-- 更新时间
	update_date datetime NOT NULL COMMENT '更新时间',
	-- 备注信息
	remarks varchar(255) COMMENT '备注信息',
	-- 删除标记（0：正常；1：删除）
	del_flag char(1) DEFAULT '0' NOT NULL COMMENT '删除标记（0：正常；1：删除）',
	-- 办公用品总和
	bgypzh double(8,2) COMMENT '办公用品总和',
	-- 其他总和
	qtzh double(8,2) COMMENT '其他总和',
	-- 报销总和
	bxzh double(8,2) DEFAULT 0 COMMENT '报销总和',
	PRIMARY KEY (id)
) COMMENT = '报销主表';


-- 业务数据子表
CREATE TABLE oa_reimburse_detail
(
	-- 编号
	id varchar(64) NOT NULL COMMENT '编号',
	-- 关联id
	oa_reimburse_id varchar(64) NOT NULL COMMENT '关联id',
	-- 出差项目
	target_project varchar(128) COMMENT '出差项目',
	-- 客户
	custom varchar(128) COMMENT '客户',
	-- 出差地点
	tar_place varchar(32) COMMENT '出差地点',
	-- 项目经理
	project_manager varchar(32) COMMENT '项目经理',
	-- 金额
	amount double(8,2) COMMENT '金额',
	-- 票计
	ticket int COMMENT '票计',
	-- 事由
	cause varchar(1024) COMMENT '事由',
	-- 创建者
	create_by varchar(64) NOT NULL COMMENT '创建者',
	-- 创建时间
	create_date datetime NOT NULL COMMENT '创建时间',
	-- 更新者
	update_by varchar(64) NOT NULL COMMENT '更新者',
	-- 更新时间
	update_date datetime NOT NULL COMMENT '更新时间',
	-- 备注信息
	remarks varchar(255) COMMENT '备注信息',
	-- 删除标记（0：正常；1：删除）
	del_flag char(1) DEFAULT '0' NOT NULL COMMENT '删除标记（0：正常；1：删除）',
	PRIMARY KEY (id)
) COMMENT = '业务数据子表';



/* Create Foreign Keys */

ALTER TABLE oa_reimburse_detail
	ADD FOREIGN KEY (oa_reimburse_id)
	REFERENCES oa_reimburse (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;



/* Create Indexes */

CREATE INDEX test_data_main_del_flag ON oa_reimburse ();
CREATE INDEX test_data_child_del_flag ON oa_reimburse_detail ();



