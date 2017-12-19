1. 使用Android Studio新建一个工程后，默认会生成两个build.gralde文件，一个位于工程根目录(andriod)，一个位于app目录下。

   还有另外一个文件 —settings.gradle

2. Could not get resource 'https://jcenter.bintray.com/com/android/tools/build/gradle/1.3.1/gradle-1.3.1.pom'.

   修改为http地址

   在jcenter的设置文件处，统一修改为http地址：./andriod/build.gradle

   使用本地文件：jcenter{url "$rootDir/../node_modules/react-native/android"

   ​			或者 repositories{flatDir {dir 'lib'}}

3. gradle配置

   ./android/gradle/wrapper/gradle-wrapper.properties  gradle的缓存路径和下载库的地址

4. build.gradle在不同的位置有不同的作用

   在./android目录，是全局的配置

   在module目录下，是当前module的配置，制定编译时的条件、路径和依赖关系。 **从多个依赖中接触冲突文件。packagingoptions{exclude ‘license.txt’}** 

   在./android/app/build.gradle目录下，是所有的依赖包的配置，exclude可以去除依赖

   setting.gradle : 配置project，标明其下有几个module，哪些子项目是这个构建的一部分，它们的逻辑和物理路径是什么，它们的构建脚本是如何命名的

   gradle.properties 代理

   local.properti sdk-dir、ndk-dir路径

   init.gradle

5. 如何定位重复包位置

   命令：./gradlew -q  app:dependencies

   ​	或者./gradlew androidDependencies

   文件位置：

   ./android/app/build.gradle.

   ​	compile "com.android.support:appcompat-v7:23.0.1". 获取最新mirror 版本

   ./node_modules/react_native/reactAndroid/build.gradle

       compile 'com.android.support:recyclerview-v7:23.0.1'  获取最新版本

       compile 'com.android.support:appcompat-v7:23.0.1'  获取最新patch版本

6. npm install

   配置文件：./android/package.json

7. AndroidManifest.xml

8. 编译过程

   1. 目录结构

      ```
      ├── app #Android App目录
      │   ├── app.iml
      │   ├── build #构建输出目录
      │   ├── build.gradle #构建脚本
      │   ├── libs #so相关库
      │   ├── proguard-rules.pro #proguard混淆配置
      │   └── src #源代码，资源等
      ├── build
      │   └── intermediates
      ├── build.gradle #工程构建文件
      ├── gradle
      │   └── wrapper
      ├── gradle.properties #gradle的配置
      ├── gradlew #gradle wrapper linux shell脚本
      ├── gradlew.bat
      ├── LibSqlite.iml
      ├── local.properties #配置Androod SDK位置文件
      └── settings.gradle #工程配置
      ```

   2. Java语言编写的Android应用程序从源码到安装包

   3. 典型Android应用程序模块的构建过程遵循以下一般步骤：

      - 编译器将源代码转换为DEX（Dalvik可执行文件）文件，其中包括在Android设备上运行的字节码，以及其他所有内容到编译资源中。
      - APK Packager将DEX文件和编译资源合并到一个APK中。在您的应用程序可以安装并部署到Android设备上之前，必须先对APK进行签名。
      - APK Packager使用调试或发布密钥库对APK进行签名：
        - 如果您正在构建应用程序的调试版本，即仅用于测试和分析的应用程序，则打包程序会使用调试密钥库对您的应用程序进行签名。Android Studio使用调试密钥库自动配置新项目。
        - 如果您正在构建要从外部发布的应用程序的发行版本，则打包程序会使用发行密钥库为您的应用程序签名。要创建发行版密钥库，请阅读有关[在Android Studio中签署应用程序的信息](https://developer.android.com/studio/publish/app-signing.html#studio)。
      - 在生成最终APK之前，打包程序使用[zipalign](https://developer.android.com/studio/command-line/zipalign.html)工具优化您的应用程序，以便在设备上运行时使用更少的内存。

      在构建过程结束时，您可以使用您的应用程序的调试APK或发布APK，以便将其部署，测试或发布给外部用户。

![javaCompile](/Users/sechina/Downloads/carve/img/compile/javaCompile.png)



9.  Android打包

   签名、渠道打包、名称、打包目录、额外信息（编译次数、编译时间、编译的机器、最新的commit版本）

   全局信息：ext（build.gradle）  gradle.properties    AndroidManifest.xml

   ./gradlew assembleRelease生成的APK文件位于`android/app/build/outputs/apk/app-release.apk`

   (1) app/build.gradle     android{ defaultConfig } 用于配置应用的核心属性，此代码块的属性可以覆盖AndroidManifest.xml文件中对应的条目。*AndroidManifest.xml*的`package`到底有什么用呢

   (2) 签名相关的信息,直接写在gradle不利于安全，我们可以把这些信息写到工程主module根目录下的signing.properties文件，注意这个文件不要添加进版本控制。signing.properties

   ```
   KEYSTORE_FILE=你的keystore文件位置
   KEYSTORE_PASSWORD= 你的keystore文件密码
   KEY_ALIAS= 你的keystore文件用到的别名
   KEY_PASSWORD= 你的keystore文件用到的别名的密码

   ```

   然后在build.gradle中加载这个文件，引用其中的参数就可以了

   ```
   //加载签名配置的文件
   Properties props = new Properties()props.load(new
   FileInputStream(file("signing.properties")))
   android {
     signingConfigs {    
       release{        
           //设置release的签名信息       
           keyAlias props['KEY_ALIAS']        
           keyPassword props['KEY_PASSWORD']        
           storeFile file(props['KEYSTORE_FILE'])        
           storePassword props['KEYSTORE_PASSWORD']    
       }
     }

   ...

     buildTypes {
         debug {
           ...
           signingConfig signingConfigs.release}
         }
         ...    
         release {
           ...
           signingConfig signingConfigs.release}
       }
     }
   }

   ```

   (3)重命名，修改输出属性outputFile

   (4) 多渠道打包，productFlavors{ }` 产品风格配置，ProductFlavor类型

   (5) DEX文件构建属性配置（加快构建速度）  app/build.gradle.       android{  */    dexOptions {        …    } }

   (6) AndroidManifest.xml   组件，权限，以及一些相关信息  http://blog.csdn.net/u012486840/article/details/52468931

   ​	是Android应用的入口文件，它描述了package中暴露的组件（activities, services, 等等），他们各自的实现类，各种能被处理的数据和启动位置。 除了能声明程序中的Activities, ContentProviders, Services, 和Intent Receivers,还能指定permissions和instrumentation（安全控制和测试）。 

   (7) 获取版本号 oldVer=`awk -F= '/ROCK_VERSION/{print $2}' android/gradle.properties |tail -n 1`

   ​	修改为 `awk -F= '/ROCK_VERSION[^CODE]/{print $2}' android/gradle.properties`

   (8) ABI	Proguard 来缩小APK文件的大小，移除依赖库中没有用到的部分 http://reactnative.cn/docs/0.51/signed-apk-android.html#content

10.  ios打包

  xcodebuild  http://www.jianshu.com/p/3f43370437d2

  （1）需要在包含 name.xcodeproj 的目录下执行 `xcodebuild` 命令，且如果该目录下有多个 projects，那么需要使用 `-project` 指定需要 build 的项目。

  （2）当 build workspace 时，需要同时指定 `-workspace` 和 `-scheme` 参数，scheme 参数控制了哪些 targets 会被 build 以及以怎样的方式 build。

  （3）xcodebuild archive 各参数可以通过`xcodebuild -list`获取

  ​			-workspace 项目名称.xcworkspace                        -scheme 项目名称                        -configuration debug 、release                        -archivePath archive包存储路径                        CODE_SIGN_IDENTITY=证书                        PROVISIONING_PROFILE=描述文件UUID  

  （4）xcodebuild -exportArchive -archivePath archive文件的地址.xcarchive                           -exportPath 导出的文件夹地址                           -exportOptionsPlist exprotOptionsPlist.plist                           CODE_SIGN_IDENTITY=证书                           PROVISIONING_PROFILE=描述文件UUID  

  （5） ./ios/FunkRock/Info.plist 存储元信息、属性列表、配置信息

  ​	Core Foundation Keys

  ​          该类的keys的特点是以CF为前缀，用以代表Core Foundation，描述了一些常用的行为项         

  ​	Lanch Services Keys 

  ​            加载服务项，提供了App加载所依赖的配置，描述了app启动的方式选择。          

  ​	Cocoa Keys 

  ​            Cocoa框架或Cocoa Touch框架依赖这些keys来标识更高级别的配置项目，如app的main nib文件，主要类。这些key描述影响着Cocoa和Cocoa Touch框架初始化和运行app的运行方式         

  ​	 UIKit Keys

  ​            描述IOS Apps的行为，每个IOS应用都依赖于Info.plist的keys来与IOS系统通信。Xcode提供了生成的plist文件提供了所有app所需的那些比较重要的keys。 

  ​            但app可能需要扩展默认的plist来描述更多的信息，如定制app启动后的默认旋转方向，标识app是否支持文件共享等等。          

  ​	OS X Keys 

  ​            描述了Mac Apps的行为，本章不描述

  ​	设置版本号version、图标 

  11. ![RN生命周期](http://7xqg0d.com1.z0.glb.clouddn.com/hexoBlog/react-native%E5%A3%B0%E6%98%8E%E5%91%A8%E6%9C%9F.PNG)