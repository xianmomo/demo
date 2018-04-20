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
-- 正在导出表  fsitdd.sys_res 的数据：~22 rows (大约)
/*!40000 ALTER TABLE `sys_res` DISABLE KEYS */;
INSERT INTO `sys_res` (`res_id`, `parent_id`, `res_name`, `res_path`, `res_type`, `res_statu`, `level_path`, `create_id`, `create_time`, `modify_id`, `modify_time`, `remark`) VALUES
	('1', '999999', '业务管理', '', '0', '0', '1|', '80002325', '2016-10-18 00:00:00', NULL, NULL, NULL),
	('10', '1', '模板文件', '/main/bus/tbModulFileList', '0', '0', '1|10|', '80002325', '2016-10-18 00:00:00', NULL, NULL, NULL),
	('11', '1', '申请单列表', '/main/bus/tbSvnApplyList', '0', '0', '1|11|', '80002325', '2016-10-18 10:00:00', NULL, NULL, NULL),
	('12', '2', '定时任务列表', '/main/sys/quartzList', '0', '1', '2|12|', '80002325', '2017-06-01 15:41:24', '80002325', '2017-06-02 14:07:39', '定时任务一览'),
	('13', '999999', 'SVN主题', '', '0', '0', '13|', '80002325', '2016-06-01 15:43:01', NULL, NULL, 'SVN业务管理'),
	('14', '13', 'SVN申请单列表', '/main/svn/tbSvnApplyList', '0', '0', '13|14|', '80002325', '2017-06-01 15:44:32', '80002325', '2017-06-01 15:47:03', ''),
	('15', '13', 'SVN库列表', '/main/svn/tbSvnRespList', '0', '1', '13|15|', '80002325', '2017-06-01 15:45:02', '80002325', '2017-06-26 17:04:33', ''),
	('16', '13', 'SVN目录列表', '/main/svn/tbSvnDirList', '0', '1', '13|16|', '80002325', '2017-06-01 15:45:50', '80002325', '2017-06-26 17:04:43', ''),
	('17', '13', 'SVN组列表', '/main/svn/tbSvnGroupList', '0', '2', '13|17|', '80002325', '2017-06-01 15:46:15', '80002325', '2017-06-13 13:25:10', ''),
	('18', '13', 'SVN用户列表', '/main/svn/tbSvnUserList', '0', '2', '13|18|', '80002325', '2017-06-01 15:46:41', '80002325', '2017-06-08 19:33:07', ''),
	('19', '13', 'SVN权限一览管理', '/main/svn/permissionShow', '0', '0', '13|19|', '80002325', '2017-06-13 13:24:46', NULL, NULL, 'SVN权限浏览及管理'),
	('1c2e2359-e8fd-4c79-9c3d-f38ac73dc7a2', '784b4bfd-4d40-42fc-a439-ba57ad2e6910', 'test123', '', '0', '2', '784b4bfd-4d40-42fc-a439-ba57ad2e6910|1c2e2359-e8fd-4c79-9c3d-f38ac73dc7a2|', '80002325', '2017-06-16 11:14:27', NULL, NULL, ''),
	('2', '999999', '系统管理', '', '0', '0', '2|', '80002325', '2016-10-18 00:00:00', NULL, NULL, 'test'),
	('2c1be749-6461-4cbf-9f42-af592544aaf9', 'f9ebe11e-7302-4128-b227-92c82e0ca677', 'GIT申请单列表', '/main/git/tbSvnApplyList', '0', '0', 'f9ebe11e-7302-4128-b227-92c82e0ca677|2c1be749-6461-4cbf-9f42-af592544aaf9|', '608820', '2017-08-30 13:51:00', NULL, NULL, ''),
	('3', '2', '资源管理', '/main/sys/sysResList', '0', '0', '2|3|', '80002325', '2016-10-18 00:00:00', NULL, NULL, NULL),
	('5', '1', 'SVN权限受理', '/main/bus/tbOperaList', '0', '0', '1|5|', '80002325', '2016-10-17 02:00:00', NULL, NULL, NULL),
	('7', '1', '文件上传', '/main/bus/uploadFile', '0', '0', '1|7|', '80002325', '2016-10-17 01:00:00', NULL, NULL, NULL),
	('76a07edf-35c4-4fe1-85e9-dad4ff596571', '999999', '业务管理1', '', '0', '2', '76a07edf-35c4-4fe1-85e9-dad4ff596571|', '608820', '2017-09-05 15:49:28', NULL, NULL, ''),
	('784b4bfd-4d40-42fc-a439-ba57ad2e6910', '999999', 'test12', '', '0', '2', '784b4bfd-4d40-42fc-a439-ba57ad2e6910|', '80002325', '2017-06-16 11:13:46', NULL, NULL, ''),
	('8', '2', '加解密运算', '/main/sys/desEncrypt', '0', '0', '2|8|', '80002325', '2016-10-18 00:00:00', NULL, NULL, NULL),
	('9', '2', '配置信息', '/main/sys/sysConfigList', '0', '0', '2|9|', '80002325', '2016-10-18 00:00:00', NULL, NULL, NULL),
	('f9ebe11e-7302-4128-b227-92c82e0ca677', '999999', 'GIT主题', '', '0', '0', 'f9ebe11e-7302-4128-b227-92c82e0ca677|', '608820', '2016-06-01 15:44:01', NULL, NULL, '');
/*!40000 ALTER TABLE `sys_res` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
