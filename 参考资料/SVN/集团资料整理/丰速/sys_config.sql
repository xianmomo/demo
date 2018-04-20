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
-- 正在导出表  fsitdd.sys_config 的数据：~38 rows (大约)
/*!40000 ALTER TABLE `sys_config` DISABLE KEYS */;
INSERT INTO `sys_config` (`config_id`, `parent_id`, `config_name`, `config_value`, `config_type`, `create_id`, `create_time`, `modify_id`, `modify_time`, `remark`) VALUES
	(5, 999999, 'auth_process', '', '0', '80002325', '2016-10-20 00:00:00', NULL, NULL, '权限处理配置组'),
	(6, 5, '自动授权标志', '0', '1', '80002325', '2017-09-01 15:44:40', NULL, NULL, '0=自动1=半自动2=手动'),
	(7, 999999, 'file_path', '', '0', '80002325', '2016-10-28 14:58:00', NULL, NULL, '文件路径组'),
	(8, 7, 'svn产品库权限配置文件', '/app/SVN/auth/authz.conf', '1', '80002325', '2016-10-28 00:00:00', NULL, NULL, NULL),
	(12, 999999, 'user_auth_num', '', '0', '80002325', '2016-10-28 00:00:00', NULL, NULL, '用户权限天数'),
	(13, 12, '0', '730', '1', '80002325', '2016-10-28 00:00:00', NULL, NULL, '资科用户'),
	(14, 12, '1', '180', '1', '80002325', '2016-10-28 00:00:00', NULL, NULL, '非资科用户'),
	(15, 5, '初始化权限标志', '1', '1', '80002325', '2017-06-29 10:11:51', NULL, NULL, '0=是1=否'),
	(20, 7, '产品库地址', 'http://10.202.34.72:8080/svn/upgrade-new/', '1', '80002325', '2016-10-28 00:00:00', NULL, NULL, NULL),
	(21, 7, 'svn系统库权限配置文件', '/app/SVN/auth/authz.conf', '1', '80002325', '2016-10-28 00:00:00', NULL, NULL, NULL),
	(22, 5, '用户自动创建标志', '0', '1', '00000000', '2017-05-24 09:24:20', NULL, NULL, '丰速系统内部用户0=自动创建1=异常处理'),
	(23, 7, '新增svn用户脚本', '/home/appdeploy/tools/createPwd.sh', '1', '80002325', '2016-10-28 00:00:00', NULL, NULL, NULL),
	(24, 999999, 'sso', '', '0', '80002325', '2016-10-20 16:21:45', NULL, '2016-10-10 12:14:15', ' 单点登录组'),
	(25, 24, '启动单点登录', '0', '1', '00000000', '2017-05-27 15:02:10', NULL, NULL, '0=启动1=不启动'),
	(26, 5, 'SVN用户自动创建标志', '1', '1', '00000000', '2017-05-24 11:44:57', NULL, NULL, 'SVN服务器内部用户0=自动1=半自动2=手动'),
	(28, 7, '产品库接口服务地址', 'http://10.202.34.72:8780/qaps/cxfService/SvnPermissionProcessService?wsdl', '1', '00000000', '2017-05-23 17:47:19', NULL, NULL, NULL),
	(29, 7, '系统库接口服务地址', 'http://10.202.34.72:8680/qaps/cxfService/SvnPermissionProcessService?wsdl', '1', '00000000', '2017-05-23 17:47:19', NULL, NULL, NULL),
	(40, 7, '文档下载目录1', '/nfsc/SVN_FS/data/download_file/', '1', '80002325', '2016-10-28 00:00:00', NULL, NULL, NULL),
	(52, 7, '申请单上传目录1', '/nfsc/SVN_FS/data/upload_file/', '1', '80002325', '2016-10-28 00:00:00', NULL, NULL, NULL),
	(53, 7, '系统库地址', 'http://10.202.34.72:8080/svn/', '1', '80002325', '2016-10-28 00:00:00', NULL, NULL, NULL),
	(54, 999999, 'sys_auth_user', '', '0', '80002325', '2016-10-20 16:21:45', NULL, '2016-10-10 12:14:15', '系统权限用户'),
	(57, 7, '申请模板上传目录1', '/nfsc/SVN_FS/data/modul_upload_file/', '1', '80002325', '2016-10-28 00:00:00', NULL, NULL, NULL),
	(58, 999999, 'ecp', '', '0', '80002325', '2017-03-08 14:11:50', NULL, NULL, 'web服务地址'),
	(59, 58, 'ecp工作流接口服务地址', 'http://10.202.33.158:12131/esb/ws/ecp', '1', '80002325', '2017-03-09 15:38:53', NULL, NULL, NULL),
	(60, 5, '规则自动校验标志', '0', '1', '80002325', '2017-03-09 15:38:53', NULL, NULL, '0=是1=否'),
	(61, 5, '环境标志', '0', '1', '608820', '2017-05-27 15:58:01', NULL, NULL, '0=测试1=准生产2=生产'),
	(62, 999999, 'git', '', '0', '80002325', '2016-10-20 16:21:45', NULL, '2016-10-10 12:14:15', 'git相关配置'),
	(63, 62, 'git应用地址', 'http://10.202.7.147:7990/', '1', '00000000', '2017-05-19 09:18:42', NULL, NULL, 'git应用程序访问地址'),
	(64, 62, 'gitQA负责人', '608820', '1', '00000000', '2017-05-24 16:11:31', NULL, NULL, 'git应用程序访问地址'),
	(66, 62, 'git自动授权', '0', '1', '80002325', '2017-08-31 11:07:34', NULL, NULL, '0=自动1=半自动2=手动'),
	(67, 62, 'git本地库目录', '/home/appdeploy/test_git_repository/', '1', '00000000', '2017-04-21 11:08:46', NULL, NULL, 'git克隆本地库地址'),
	(68, 999999, 'svn', '', '0', '', '2017-04-28 10:36:43', NULL, '2017-04-28 10:36:47', 'svn相关配置'),
	(69, 68, 'svnQA负责人', '608820', '1', '80002325', '2017-07-19 10:12:03', NULL, NULL, ''),
	(70, 68, 'svn配置库创建脚本', '/home/appdeploy/tools/createRespos.sh', '1', '608820', '2017-04-18 17:20:16', NULL, NULL, ''),
	(71, 999999, 'wbsap', '', '0', '80002325', '2016-10-28 14:58:00', NULL, NULL, '外包大文件'),
	(72, 71, '外包bigFile下载目录', '/nfsc/SVN_FS/data/sync_data_qapp', '1', '80002325', '2017-05-04 17:57:53', NULL, NULL, ''),
	(73, 7, 'svn标准目录地址', '/home/appdeploy/SVN_REPOSITORY_DIR', '1', '80002325', '2016-10-28 00:00:00', NULL, NULL, NULL),
	(74, 58, 'ecpIT003工作流地址', 'http://10.202.30.153/ecp/platform/bpm/bpmDefinition/flowImg.ht?actDefId=xtbmjpzkgllctd:3:70000013182480&rand=1495625586872', '1', '608820', '2017-05-27 15:12:31', NULL, NULL, 'ECPIT003流程示意图'),
	(75, 62, 'git规则自动校验标志', '0', '1', '80002325', '2017-05-24 17:06:24', NULL, NULL, '0=是1=否');
/*!40000 ALTER TABLE `sys_config` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
