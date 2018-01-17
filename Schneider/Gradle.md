1. projects 和 tasks

   - projects 和 tasks是Gradle中最重要的两个概念，任何一个Gradle构建都是由一个或者多个project组成，每个project可以是一个jar包，一个web应用，或者一个android app等，每个project又由多个task构成，一个task其实就是构建过程中一个原子性的操作，比如编译、拷贝等。

   - 一个build.gradle文件是一个构建脚本，当运行gradle命令的时候会从当前目录查找build.gradle文件来执行构建。

     项目：对应于一个build.gradle

     模块：

     任务:一系列的动作对象

     项目实例：

     构建脚本：

     插件：用于扩展gradle构建脚本的能力，每一个安卓项目都应该申请插件: apply plugin:'com.android.application'（应用模块或者依赖模块）

2. 构建生命周期

   1. 初始化：读取环境配置文件init.gradle和gradle.properties，并设置所有在settings.gradle中列出的子项目
   2. 配置: 解析所有构建脚本build.gradle ,并配建模型,包括DAG
   3. 运行: 运行期望的项目
