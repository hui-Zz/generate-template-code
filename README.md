# 【generate-template-code】模板生成代码（Control/Service/ServiceImpl/Dao）

在日常的开发中，往往写繁琐的业务代码占据着大量时间，很多代码块明明只有命名不同。

也许聪明的人会把类似的代码复制粘贴修改，但容易百密一疏。

为何不把最通用的代码（比如CRUD）做成模板呢？

本人从网络寻得以FreeMarker为模板引擎的代码，稍适修改便实现了简单的模板代码生成。

经过几个项目的实际使用，可以非常快速生成一个模块的Control/Service/ServiceImpl/Dao四层通用代码，大大提高了开发效率和减少了加班时间。

（注：Model层和Mapping映射搭配使用mybatis-generator-core生成效果最佳）

**使用于SSM架构项目(Spring+SpringMVC+Mybatis）**
