-- --------------------------------------------------------
-- 主机:                           10.202.34.84
-- 服务器版本:                        5.6.27-log - MySQL Community Server (GPL)
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  9.1.0.4867
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 导出 fsitdd 的数据库结构
CREATE DATABASE IF NOT EXISTS `fsitdd` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `fsitdd`;


-- 导出  表 fsitdd.hcm_out_emp 结构
CREATE TABLE IF NOT EXISTS `hcm_out_emp` (
  `emp_num` varchar(10) NOT NULL COMMENT '员工工号',
  `last_name` varchar(150) DEFAULT NULL COMMENT '员工姓名',
  `sex` varchar(10) DEFAULT NULL COMMENT '性别',
  `curr_org_id` decimal(10,0) DEFAULT NULL COMMENT '当前组织id',
  `net_code` varchar(150) DEFAULT NULL COMMENT '组织网点代码',
  `curr_org_name` varchar(255) DEFAULT NULL COMMENT '当前组织名称',
  `org_code` varchar(150) DEFAULT NULL COMMENT '组织代码',
  `mail_address` varchar(60) DEFAULT NULL COMMENT '邮箱',
  `mobile_phone` varchar(60) DEFAULT NULL COMMENT '手机号',
  `office_phone` varchar(60) DEFAULT NULL COMMENT '办公电话',
  `cancel_date` date DEFAULT NULL COMMENT '离职状态Y离职',
  `cancel_flag` varchar(10) DEFAULT NULL COMMENT '离职时间',
  `org_ass_date` date DEFAULT NULL COMMENT '调岗日期',
  `last_org_name` varchar(255) DEFAULT NULL COMMENT '上一部门名称',
  `date_of_birth` date DEFAULT NULL COMMENT '生日',
  `bukrs` varchar(150) DEFAULT NULL COMMENT '公司代码',
  `bukrs_txt` varchar(150) DEFAULT NULL COMMENT '公司名称',
  `persg` varchar(2) DEFAULT NULL COMMENT '员工子组',
  `persg_txt` varchar(20) DEFAULT NULL COMMENT '员工子组名称',
  `lastupdate` date DEFAULT NULL COMMENT '最后修改时间',
  `inserttime` date DEFAULT NULL COMMENT '插入时间',
  `sync` varchar(2) DEFAULT 'N' COMMENT '推送标志',
  `sys_process_result` varchar(2048) DEFAULT NULL COMMENT '系统处理结果',
  PRIMARY KEY (`emp_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据导出被取消选择。


-- 导出  表 fsitdd.hcm_out_org 结构
CREATE TABLE IF NOT EXISTS `hcm_out_org` (
  `org_id` decimal(10,0) NOT NULL COMMENT '组织id',
  `org_id_parent` decimal(10,0) DEFAULT NULL COMMENT '父组织id',
  `org_name` varchar(255) DEFAULT NULL COMMENT '组织名称',
  `loc_id` varchar(150) DEFAULT NULL COMMENT '组织地点ID',
  `internal_address` varchar(255) DEFAULT NULL COMMENT '组织地点名称',
  `org_type` varchar(150) DEFAULT NULL COMMENT '部门类型',
  `net_code` varchar(120) DEFAULT NULL COMMENT '网络代码',
  `org_code` varchar(120) DEFAULT NULL COMMENT '组织编码',
  `date_from` date DEFAULT NULL COMMENT '有效起始日期',
  `date_to` date DEFAULT NULL COMMENT '有效结束日期',
  `org_desc` varchar(4000) DEFAULT NULL COMMENT '部门职责说明',
  `manager` varchar(150) DEFAULT NULL COMMENT '组织负责人工号',
  `manager_name` varchar(150) DEFAULT NULL COMMENT '组织负责人姓名',
  `zhrzn` varchar(150) DEFAULT NULL COMMENT '职能',
  `zhrzzcj` varchar(150) DEFAULT NULL COMMENT '组织层级',
  `zhrzzgn` varchar(150) DEFAULT NULL COMMENT '组织功能',
  `kostl` varchar(30) DEFAULT NULL COMMENT '成本中心编码',
  `kostl_txt` varchar(150) DEFAULT NULL COMMENT '成本中心名称',
  `zhrxzzz` varchar(4) DEFAULT NULL COMMENT '小组标志',
  `lastupdate` date DEFAULT NULL COMMENT '最后更新时间',
  `inserttime` date DEFAULT NULL COMMENT '插入时间',
  PRIMARY KEY (`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='组织信息公用接口表';

-- 数据导出被取消选择。


-- 导出  表 fsitdd.qrtz_job_triggers 结构
CREATE TABLE IF NOT EXISTS `qrtz_job_triggers` (
  `sched_name` varchar(128) NOT NULL,
  `context_instance_id` varchar(32) NOT NULL DEFAULT '',
  `trigger_name` varchar(128) DEFAULT NULL,
  `trigger_group` varchar(128) DEFAULT NULL,
  `job_name` varchar(128) DEFAULT NULL,
  `job_group` varchar(128) DEFAULT NULL,
  `start_time` bigint(13) DEFAULT NULL,
  PRIMARY KEY (`sched_name`,`context_instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据导出被取消选择。


-- 导出  表 fsitdd.sys_config 结构
CREATE TABLE IF NOT EXISTS `sys_config` (
  `config_id` int(16) NOT NULL AUTO_INCREMENT,
  `parent_id` int(16) DEFAULT NULL COMMENT '上级id',
  `config_name` varchar(64) CHARACTER SET utf8 NOT NULL COMMENT '配置项',
  `config_value` varchar(512) CHARACTER SET utf8 NOT NULL COMMENT '配置项值',
  `config_type` varchar(2) CHARACTER SET utf8 NOT NULL COMMENT '配置类型0=配置组1=配置项',
  `create_id` varchar(32) CHARACTER SET utf8 NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_id` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '修改人',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  `remark` varchar(1024) CHARACTER SET utf8 DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='配置信息表';

-- 数据导出被取消选择。


-- 导出  表 fsitdd.sys_file 结构
CREATE TABLE IF NOT EXISTS `sys_file` (
  `file_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '文件id',
  `file_name` varchar(128) NOT NULL COMMENT '文件名称',
  `file_upload_name` varchar(128) NOT NULL COMMENT '文件上传名称',
  `file_path` varchar(1024) DEFAULT NULL COMMENT '文件路径',
  `file_statu` varchar(2) DEFAULT NULL COMMENT '文件状态0未处理1已处理2处理失败',
  `create_id` varchar(32) DEFAULT NULL COMMENT '创建人id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_id` varchar(32) DEFAULT NULL COMMENT '修改人Id',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  `apply_id` varchar(32) DEFAULT NULL COMMENT '申请单id',
  PRIMARY KEY (`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据导出被取消选择。


-- 导出  表 fsitdd.sys_res 结构
CREATE TABLE IF NOT EXISTS `sys_res` (
  `res_id` varchar(36) NOT NULL COMMENT 'java  uuid',
  `parent_id` varchar(36) NOT NULL COMMENT '父级id默认999999',
  `res_name` varchar(64) CHARACTER SET utf8 NOT NULL COMMENT '资源名称',
  `res_path` varchar(128) CHARACTER SET utf8 NOT NULL COMMENT '资源路径',
  `res_type` varchar(2) CHARACTER SET utf8 NOT NULL COMMENT '资源类型0=菜单1=按钮',
  `res_statu` varchar(2) CHARACTER SET utf8 NOT NULL COMMENT '资源状态0=正常1=禁用2=删除',
  `level_path` varchar(1024) CHARACTER SET utf8 NOT NULL COMMENT '级数路径',
  `create_id` varchar(32) CHARACTER SET utf8 NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_id` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '修改人',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  `remark` varchar(1024) CHARACTER SET utf8 DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`res_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='系统资源表';

-- 数据导出被取消选择。


-- 导出  表 fsitdd.sys_user 结构
CREATE TABLE IF NOT EXISTS `sys_user` (
  `user_code` varchar(32) CHARACTER SET utf8 NOT NULL COMMENT '用户编码',
  `user_alias` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '用户别名',
  `is_admin` varchar(2) DEFAULT NULL COMMENT '0=是1=否',
  `org_id` varchar(10) DEFAULT NULL COMMENT '机构id',
  `org_name` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '机构名称',
  PRIMARY KEY (`user_code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='系统用户信息表';

-- 数据导出被取消选择。


-- 导出  表 fsitdd.tb_ecp_it003 结构
CREATE TABLE IF NOT EXISTS `tb_ecp_it003` (
  `apply_id` varchar(32) NOT NULL COMMENT 'uuid',
  `apply_user_name` varchar(16) DEFAULT NULL COMMENT '申请人',
  `apply_user_alias` varchar(16) DEFAULT NULL COMMENT '申请人姓名',
  `apply_time` varchar(32) DEFAULT NULL COMMENT '申请时间',
  `receive_time` varchar(32) NOT NULL COMMENT '接收时间',
  `over_time` varchar(32) NOT NULL COMMENT '完成时间',
  `run_id` bigint(20) DEFAULT NULL COMMENT '工作流Id',
  `process_number` varchar(64) DEFAULT NULL COMMENT 'ecp流程编码',
  `apply_statu_name` varchar(32) DEFAULT NULL COMMENT '申请单状态：已保存、转向QA、ECP审批中、ECP归档、处理完成、处理异常',
  `remark` text COMMENT '备注',
  `apply_type_name` varchar(32) NOT NULL COMMENT '申请类型',
  `repository_type_name` varchar(32) DEFAULT NULL COMMENT '配置库类型',
  `apply_user_type` varchar(2) DEFAULT NULL COMMENT '申请人员类型0=顺丰人员1=非顺丰人员',
  `repository_dept` varchar(256) DEFAULT NULL COMMENT '配置库所属部门',
  `repository_user` varchar(256) DEFAULT NULL COMMENT '配置库所属负责人',
  `rule_check_remark` text COMMENT '规则校验异常备注',
  PRIMARY KEY (`apply_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据导出被取消选择。


-- 导出  表 fsitdd.tb_git_group 结构
CREATE TABLE IF NOT EXISTS `tb_git_group` (
  `group_id` int(16) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(64) CHARACTER SET utf8 NOT NULL COMMENT '组名称',
  `group_alias` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '组别名',
  `group_type` varchar(2) CHARACTER SET utf8 DEFAULT NULL COMMENT '组类型0=默认1=自定义',
  `create_id` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `remark` varchar(2048) CHARACTER SET utf8 DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='git组信息表';

-- 数据导出被取消选择。


-- 导出  表 fsitdd.tb_git_project 结构
CREATE TABLE IF NOT EXISTS `tb_git_project` (
  `project_id` int(16) NOT NULL AUTO_INCREMENT,
  `project_name` varchar(64) CHARACTER SET utf8 NOT NULL COMMENT '项目名称',
  `project_key` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '项目key值',
  `create_id` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `remark` varchar(2048) CHARACTER SET utf8 DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='git项目信息表';

-- 数据导出被取消选择。


-- 导出  表 fsitdd.tb_git_resp 结构
CREATE TABLE IF NOT EXISTS `tb_git_resp` (
  `resp_id` int(16) NOT NULL AUTO_INCREMENT,
  `resp_name` varchar(64) CHARACTER SET utf8 NOT NULL COMMENT '库名称',
  `project_id` int(16) DEFAULT NULL COMMENT '项目id',
  `project_name` varchar(64) DEFAULT NULL COMMENT '项目名称',
  `create_id` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `remark` varchar(2048) CHARACTER SET utf8 DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`resp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='git库信息表';

-- 数据导出被取消选择。


-- 导出  表 fsitdd.tb_git_user 结构
CREATE TABLE IF NOT EXISTS `tb_git_user` (
  `user_id` int(16) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(32) CHARACTER SET utf8 NOT NULL COMMENT '用户名称',
  `user_alias` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '用户别名',
  `user_email` varchar(64) CHARACTER SET utf8 DEFAULT NULL COMMENT '用户邮箱',
  `user_type` varchar(2) CHARACTER SET utf8 DEFAULT NULL COMMENT '用户类型',
  `date_num` int(8) DEFAULT NULL COMMENT '权限天数',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  `remark` varchar(2048) CHARACTER SET utf8 DEFAULT NULL COMMENT '备注',
  `org_code` varchar(120) COLLATE latin1_general_ci DEFAULT NULL COMMENT '组织编码',
  `org_name` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '组织名称',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='git人员信息';

-- 数据导出被取消选择。


-- 导出  表 fsitdd.tb_git_user_group 结构
CREATE TABLE IF NOT EXISTS `tb_git_user_group` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(32) COLLATE latin1_general_ci NOT NULL COMMENT '用户名称',
  `group_name` varchar(64) COLLATE latin1_general_ci NOT NULL COMMENT '组名称',
  `valid_begintime` datetime NOT NULL COMMENT '有效期开始时间',
  `valid_endtime` datetime NOT NULL COMMENT '有效期结束时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `statu` varchar(2) COLLATE latin1_general_ci DEFAULT NULL COMMENT '0=正常1=删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='git用户组关系表';

-- 数据导出被取消选择。


-- 导出  表 fsitdd.tb_jira_group 结构
CREATE TABLE IF NOT EXISTS `tb_jira_group` (
  `group_id` varchar(32) NOT NULL,
  `group_name` varchar(64) CHARACTER SET utf8 NOT NULL COMMENT '组名称',
  `create_id` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `remark` varchar(2048) CHARACTER SET utf8 DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='jira组信息表';

-- 数据导出被取消选择。


-- 导出  表 fsitdd.tb_jira_user 结构
CREATE TABLE IF NOT EXISTS `tb_jira_user` (
  `user_id` varchar(32) COLLATE latin1_general_ci NOT NULL,
  `user_name` varchar(32) CHARACTER SET utf8 NOT NULL COMMENT '用户名称',
  `user_alias` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '用户别名',
  `user_email` varchar(64) CHARACTER SET utf8 DEFAULT NULL COMMENT '用户邮箱',
  `user_type` varchar(2) CHARACTER SET utf8 DEFAULT NULL COMMENT '用户类型',
  `date_num` int(8) DEFAULT NULL COMMENT '权限天数',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  `remark` varchar(2048) CHARACTER SET utf8 DEFAULT NULL COMMENT '备注',
  `org_code` varchar(120) COLLATE latin1_general_ci DEFAULT NULL COMMENT '组织编码',
  `org_name` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '组织名称',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='jira人员信息';

-- 数据导出被取消选择。


-- 导出  表 fsitdd.tb_jira_user_group 结构
CREATE TABLE IF NOT EXISTS `tb_jira_user_group` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(32) COLLATE latin1_general_ci NOT NULL COMMENT '用户名称',
  `group_name` varchar(64) COLLATE latin1_general_ci NOT NULL COMMENT '组名称',
  `valid_begintime` datetime NOT NULL COMMENT '有效期开始时间',
  `valid_endtime` datetime NOT NULL COMMENT '有效期结束时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `statu` varchar(2) COLLATE latin1_general_ci DEFAULT NULL COMMENT '0=正常1=删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='jira用户组关系表';

-- 数据导出被取消选择。


-- 导出  表 fsitdd.tb_modul_file 结构
CREATE TABLE IF NOT EXISTS `tb_modul_file` (
  `modul_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '文件id',
  `modul_name` varchar(128) NOT NULL COMMENT '文件名称',
  `modul_upload_name` varchar(128) NOT NULL COMMENT '文件上传名称',
  `modul_path` varchar(1024) DEFAULT NULL COMMENT '文件路径',
  `modul_type` varchar(16) DEFAULT NULL COMMENT '文件类型0=IT003',
  `create_id` varchar(32) DEFAULT NULL COMMENT '创建人id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`modul_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据导出被取消选择。


-- 导出  表 fsitdd.tb_operainfo 结构
CREATE TABLE IF NOT EXISTS `tb_operainfo` (
  `oper_id` int(16) NOT NULL AUTO_INCREMENT,
  `oper_type` varchar(2) CHARACTER SET utf8 NOT NULL COMMENT '记录类型1=svn',
  `oper_title` varchar(1024) CHARACTER SET utf8 NOT NULL COMMENT '操作标题EX:新增组权限',
  `oper_result` varchar(2) CHARACTER SET utf8 NOT NULL COMMENT '操作结果0=成功1=失败',
  `oper_remark` varchar(1024) CHARACTER SET utf8 DEFAULT NULL COMMENT '操作备注',
  `apply_id` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '申请人',
  `apply_time` datetime DEFAULT NULL COMMENT '申请时间',
  `create_id` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`oper_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='操作记录表';

-- 数据导出被取消选择。


-- 导出  表 fsitdd.tb_org 结构
CREATE TABLE IF NOT EXISTS `tb_org` (
  `org_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '组织id',
  `parent_id` int(11) DEFAULT '999999' COMMENT '上级组织id',
  `org_code` varchar(120) DEFAULT NULL COMMENT '组织编码',
  `org_name` varchar(255) DEFAULT NULL COMMENT '组织名称',
  `org_statu` varchar(2) DEFAULT NULL COMMENT '组织状态0正常1禁用',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据导出被取消选择。


-- 导出  表 fsitdd.tb_svn_apply 结构
CREATE TABLE IF NOT EXISTS `tb_svn_apply` (
  `apply_id` varchar(32) NOT NULL,
  `apply_user_name` varchar(32) DEFAULT NULL COMMENT '申请人',
  `apply_user_alias` varchar(32) DEFAULT NULL COMMENT '申请人姓名',
  `apply_time` datetime DEFAULT NULL COMMENT '申请时间',
  `receive_time` varchar(32) DEFAULT NULL COMMENT '接收时间',
  `over_time` varchar(32) DEFAULT NULL COMMENT '完成时间',
  `run_id` bigint(20) DEFAULT NULL COMMENT '工作流Id',
  `process_number` varchar(64) DEFAULT NULL COMMENT 'ecp流程编码',
  `apply_type_name` varchar(32) NOT NULL COMMENT '申请类型',
  `repository_type_name` varchar(32) DEFAULT NULL COMMENT '配置库类型',
  `apply_model_type` varchar(32) DEFAULT NULL COMMENT '申请单模板类型。IT003',
  `apply_user_type` varchar(2) CHARACTER SET utf32 DEFAULT NULL COMMENT '申请人员类型0=顺丰人员1=非顺丰人员',
  `repository_dept` varchar(256) DEFAULT NULL COMMENT '配置库所属部门',
  `repository_user` varchar(256) DEFAULT NULL COMMENT '配置库所属负责人',
  `apply_statu` varchar(2) DEFAULT NULL COMMENT '申请单状态0=申请单已保存1=申请单已提交2=ECP审批中3=ECP审批归档4=丰速处理完成5=丰速处理异常6=申请单转向QA',
  `remark` varchar(2048) DEFAULT NULL COMMENT '备注',
  `rule_check_remark` varchar(2048) DEFAULT NULL COMMENT '规则校验异常备注',
  PRIMARY KEY (`apply_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据导出被取消选择。


-- 导出  表 fsitdd.tb_svn_dir 结构
CREATE TABLE IF NOT EXISTS `tb_svn_dir` (
  `dir_id` varchar(36) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL COMMENT 'java UUID',
  `dir_path` varchar(512) CHARACTER SET utf8 NOT NULL COMMENT '目录地址',
  `resp_id` varchar(36) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL COMMENT '库id',
  `dir_type` varchar(2) CHARACTER SET utf8 DEFAULT NULL COMMENT '目录类型0=标准1=非标准',
  `create_id` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_id` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT ' 修改人',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  `remark` varchar(2048) CHARACTER SET utf8 DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dir_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='svn目录信息表';

-- 数据导出被取消选择。


-- 导出  表 fsitdd.tb_svn_group 结构
CREATE TABLE IF NOT EXISTS `tb_svn_group` (
  `group_id` varchar(36) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL COMMENT 'java UUID',
  `parent_id` varchar(1024) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL COMMENT '上级组id默认999999',
  `group_name` varchar(64) CHARACTER SET utf8 NOT NULL COMMENT '组名称',
  `group_alias` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '组别名',
  `group_type` varchar(2) CHARACTER SET utf8 DEFAULT NULL COMMENT '组类型0=默认1=自定义',
  `resp_type` varchar(2) DEFAULT NULL COMMENT '库类型0=产品库1=系统库',
  `create_id` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_id` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '修改人',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  `remark` varchar(2048) CHARACTER SET utf8 DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='svn组信息表';

-- 数据导出被取消选择。


-- 导出  表 fsitdd.tb_svn_group_dir 结构
CREATE TABLE IF NOT EXISTS `tb_svn_group_dir` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `group_id` varchar(36) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL COMMENT '组id',
  `dir_id` varchar(36) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL COMMENT '目录id',
  `auth` varchar(2) NOT NULL COMMENT '组权限r/rw(读写)',
  `create_id` varchar(32) CHARACTER SET utf8 NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='svn组目录关系表';

-- 数据导出被取消选择。


-- 导出  表 fsitdd.tb_svn_resp 结构
CREATE TABLE IF NOT EXISTS `tb_svn_resp` (
  `resp_id` varchar(36) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL COMMENT 'java UUID',
  `resp_name` varchar(64) CHARACTER SET utf8 NOT NULL COMMENT '库名称',
  `resp_type` varchar(2) CHARACTER SET utf8 DEFAULT NULL COMMENT '库类型0=产品库1=系统库2=管理库',
  `resp_path` varchar(512) CHARACTER SET utf8 DEFAULT NULL COMMENT '库路径',
  `create_id` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_id` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '修改人',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  `remark` varchar(2048) CHARACTER SET utf8 DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`resp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='svn库信息表';

-- 数据导出被取消选择。


-- 导出  表 fsitdd.tb_svn_user 结构
CREATE TABLE IF NOT EXISTS `tb_svn_user` (
  `user_id` varchar(36) COLLATE latin1_general_ci NOT NULL COMMENT 'java UUID',
  `user_name` varchar(32) CHARACTER SET utf8 NOT NULL COMMENT '用户名称',
  `user_alias` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '用户别名',
  `user_email` varchar(64) CHARACTER SET utf8 DEFAULT NULL COMMENT '用户邮箱',
  `user_type` varchar(2) CHARACTER SET utf8 DEFAULT NULL COMMENT '用户类型',
  `date_num` int(8) DEFAULT NULL COMMENT '权限天数',
  `create_id` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_id` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '修改人',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  `cancel_date` date DEFAULT NULL COMMENT '离职日期',
  `remark` varchar(2048) CHARACTER SET utf8 DEFAULT NULL COMMENT '备注',
  `org_code` varchar(120) COLLATE latin1_general_ci DEFAULT NULL COMMENT '组织编码',
  `org_name` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '组织名称',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='人员信息';

-- 数据导出被取消选择。


-- 导出  表 fsitdd.tb_svn_user_dir 结构
CREATE TABLE IF NOT EXISTS `tb_svn_user_dir` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(36) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL COMMENT '用户id',
  `dir_id` varchar(36) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL COMMENT '目录id',
  `valid_begintime` datetime NOT NULL COMMENT '权限开始时间',
  `valid_endtime` datetime NOT NULL COMMENT '权限结束时间',
  `auth` varchar(2) CHARACTER SET utf8 NOT NULL COMMENT '权限r=只读rw=读写',
  `create_id` varchar(32) CHARACTER SET utf8 NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='svn用户目录关系表';

-- 数据导出被取消选择。


-- 导出  表 fsitdd.tb_svn_user_group 结构
CREATE TABLE IF NOT EXISTS `tb_svn_user_group` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(36) COLLATE latin1_general_ci NOT NULL COMMENT '用户id',
  `group_id` varchar(36) COLLATE latin1_general_ci NOT NULL COMMENT '组id',
  `valid_begintime` datetime NOT NULL COMMENT '有效期开始时间',
  `valid_endtime` datetime NOT NULL COMMENT '有效期结束时间',
  `create_id` varchar(32) CHARACTER SET utf8 NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='svn用户组关系表';

-- 数据导出被取消选择。


-- 导出  触发器 fsitdd.hcm_out_org_after_insert 结构
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `hcm_out_org_after_insert` AFTER INSERT ON `hcm_out_org` FOR EACH ROW BEGIN
#判断是否存在组织信息
select count(1) into @orgNum from tb_org t where t.org_id = new.org_id;

#判断组织是否有效
select case count(1) when 0 then '1' when 1 then '0' end into @orgStatu from hcm_out_org t where t.org_id = new.org_id and ((t.date_from<=sysdate() and t.date_to>=sysdate()) or (t.date_from is null and t.date_to is null));

case @orgNum when 0 then 
	insert into tb_org(org_id,parent_id,org_code,org_name,org_statu,create_time) values(new.org_id,new.org_id_parent,new.org_id,new.org_name,@orgStatu,sysdate());
else 
	update tb_org t set t.parent_id=new.org_id_parent,t.org_code=new.org_id,t.org_name=new.org_name,t.org_statu=@orgStatu,t.create_time=sysdate() where t.org_id = new.org_id;
end case; 

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
