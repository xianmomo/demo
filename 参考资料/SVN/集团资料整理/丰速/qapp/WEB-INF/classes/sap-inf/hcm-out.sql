#推送用户信息
CREATE TABLE IF NOT EXISTS `HCM_OUT_EMP` (
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
  `cancel_flag` varchar(10) DEFAULT NULL COMMENT '离职状态Y离职',
  `cancel_date` date DEFAULT NULL COMMENT '离职时间',
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
#由于第一次推送数据太多。添加触发器导致推送很慢。所以暂不添加触发器
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `hcm_out_emp_after_insert` AFTER UPDATE ON `HCM_OUT_EMP` FOR EACH ROW BEGIN
case new.persg_txt when '业务外包' then
	set @userType='1';
	set @dateNum=180;
else
	set @userType='0';
	set @dateNum=730;
end case;

select count(1) into @userCount from tb_svn_user t where t.user_name = new.emp_num;

case @userCount when 0 then 
	set @tempData = 1;
else
	update tb_svn_user t set t.user_alias=new.last_name,t.user_email=new.mail_address,t.user_type=@userType,t.date_num=@dateNum,t.create_time=sysdate(),t.cancel_date=new.cancel_date,t.org_code=new.curr_org_id,t.org_name=new.curr_org_name where t.user_name = new.emp_num;
end case;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `hcm_out_emp_after_insert` AFTER INSERT ON `HCM_OUT_EMP` FOR EACH ROW BEGIN
case new.persg_txt when '业务外包' then
	set @userType='1';
	set @dateNum=180;
else
	set @userType='0';
	set @dateNum=730;
end case;

select count(1) into @userCount from tb_svn_user t where t.user_name = new.emp_num;

case @userCount when 0 then 
	set @tempData = 1;
else
	update tb_svn_user t set t.user_alias=new.last_name,t.user_email=new.mail_address,t.user_type=@userType,t.date_num=@dateNum,t.create_time=sysdate(),t.cancel_date=new.cancel_date,t.org_code=new.curr_org_id,t.org_name=new.curr_org_name where t.user_name = new.emp_num;
end case;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

#推送组织数据
CREATE TABLE IF NOT EXISTS `HCM_OUT_ORG` (
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

#组织触发器
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `hcm_out_org_after_insert` AFTER INSERT ON `HCM_OUT_ORG` FOR EACH ROW BEGIN
#判断是否存在组织信息
select count(1) into @orgNum from tb_org t where t.org_id = new.org_id;

#判断组织是否有效
select case count(1) when 0 then '1' when 1 then '0' end into @orgStatu from HCM_OUT_ORG t where t.org_id = new.org_id and ((t.date_from<=sysdate() and t.date_to>=sysdate()) or (t.date_from is null and t.date_to is null));

case @orgNum when 0 then 
	insert into tb_org(org_id,parent_id,org_code,org_name,org_statu,create_time) values(new.org_id,new.org_id_parent,new.org_id,new.org_name,@orgStatu,sysdate());
else 
	update tb_org t set t.parent_id=new.org_id_parent,t.org_code=new.org_id,t.org_name=new.org_name,t.org_statu=@orgStatu,t.create_time=sysdate() where t.org_id = new.org_id;
end case; 

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;