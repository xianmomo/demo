Git flow介绍

为什么要用gitflow
git优点
分布式多人协作
快速廉价的分支
灵活的分支管理
导致的问题
未及时合并导致代码冲突
分支数量&分支未及时清理
各部门使用规则混乱

就像代码需要代码规范一样，代码管理同样需要一个清晰的流程和规范

Gitflow分支管理模型适用于大型团队项目中高效快速管理分支（初始化/新建/结束 分支）

如何使用
gitflow分支管理模型图
gitflow文档
http://wiki.juanpi.org/pages/viewpage.action?pageId=15139582

Git管理制度
分组策略
按照各FT进行分组

授权策略
project可见级别 不允许public[风险：不需要登录] 推荐Intenal 个别对保密性要求较高的项目可使用Private
group权限 开发负责人master权限 开发人员developer权限 测试人员及其他 reporter权限
project权限 开发负责人owner权限 开发人员developer权限 测试人员及其他 reporter权限

变更流程
新建项目
填写wiki提出申请-配置管理员新建项目-通知申请人
需提供 Group ProjectName Description ProjectOwner
组权限变更
填写wiki提出申请-配置管理员修改权限-通知申请人
project权限变更
project owner 自行处理




接入Jenkins的基本策略，为下一步规范发布构建创建一些必备的条件
项目源码开发不应在个人仓库


执行计划

仓库列表申报，我们出模板，技术团队填写申报，完成信息收集（截止时间，负责人，文档模板位置等）
输出更完整的各场景下灵活使用gitflow的指导文档（多release共存、回滚、项目取消等场景）
按照申报信息完成权限管理，分组move，创建develop分支，分支保护（提供客户端更改remote repo更改路径文档）（截止时间，负责人）
技术团队按照git flow 方式完成项目开发，support机制，新旧项目过渡方案