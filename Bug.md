#### Bug

1. 删除了node_modules

A problem occurred evaluating project ':app'.

\> Could not read script '/Users/sechina/Documents/reactNative/FunkRock/node_modules/react-native/react.gradle' as it does not exist.

在根目录中，执行npm install。（npm代理和shell代理）

2. jcenter不能访问

FAILURE: Build failed with an exception.

\* What went wrong:

A problem occurred configuring project ':app'.

\> A problem occurred configuring project ':react-native-image-picker'.

   > Could not resolve all dependencies for configuration ':react-native-image-picker:classpath'.

​      > Could not resolve com.android.tools.build:gradle:1.3.1.

​        Required by:

​            Rock:react-native-image-picker:unspecified

​         > Could not resolve com.android.tools.build:gradle:1.3.1.

​            > Could not get resource 'https://jcenter.bintray.com/com/android/tools/build/gradle/1.3.1/gradle-1.3.1.pom'.

​               > Could not HEAD 'https://jcenter.bintray.com/com/android/tools/build/gradle/1.3.1/gradle-1.3.1.pom'.

​                  > peer not authenticated

修改./node_modules/react-native-image-picker/android/build.gradle

buildscript {

​    repositories {

​        jcenter()

​    }

buildscript {

​    repositories {

​        jcenter{

​        	url "http://jcenter.bintray.com/"

​        }

​    }

[react-native-image-picker,react-native-permissions,react-native-file-opener,react-native-fs,react-native-svg,react-native-detect-new-photo,

]

3. 版本错误

A problem occurred configuring project ':app'.

\> A problem occurred configuring project ':rn-camera-roll'.

   > failed to find Build Tools revision 23.0.2

定位文件：./node_modules/rn-camera-roll/android/build.gradle

4. 对于https不能访问，http的502错误

1)Execution failed for task ':ReactAndroid:downloadBoost'.

\> javax.net.ssl.SSLHandshakeException: sun.security.validator.ValidatorException: PKIX path building failed: sun.security.provider.certpath.SunCertPathBuilderException: unable to find valid certification path to requested target

修改文件./node_modules/react_native/reactAndroid/build.gradle

替换http之后

Execution failed for task ':ReactAndroid:downloadBoost'.

\> java.io.IOException: Server returned HTTP response code: 502 for URL: http://mirror.nienbo.com/boost/boost_1_57_0.zip

下载文件到本地 ,把zip文件放置到./node_modules/rn-camera-roll/android/build/downloads

2）Execution failed for task ':ReactAndroid:downloadJSCHeaders'.

\> javax.net.ssl.SSLHandshakeException: sun.security.validator.ValidatorException: PKIX path building failed: sun.security.provider.certpath.SunCertPathBuilderException: unable to find valid certification path to requested target

替换http，文件位置./node_modules/react_native/reactAndroid/build.gradle 寻找ReactAndroid:downloadJSCHeaders

3) 

- 设置gradle代理

在 USER_HOME/.gradle/中新建一个gradle.properties，然后输入以下内容
xx-net

systemProp.http.proxyHost=127.0.0.1
systemProp.http.proxyPort=8087
systemProp.https.proxyHost=127.0.0.1
systemProp.https.proxyPort=8087
ss

systemProp.https.proxyHost=127.0.0.1
systemProp.https.proxyPort=1080
systemProp.http.proxyHost=127.0.0.1
systemProp.http.proxyPort=1080
systemProp.socks.proxyHost=127.0.0.1
systemProp.socks.proxyPort=1080

- 解决https证书错误

设置好代理之后，可能出现htpps代理失败的问题。因为jc库默认是https的，我用的免费代理软件，需要导入自签证书才能使用。然而我安装官方教程使用keytool向java导入了CA证书，还是无法使用。一般会显示如下的错误

"Error:(26, 13) Failed to resolve: com.alibaba:fastjson:1.1.34.android"
"Error:A problem occurred configuring project ':app'.peer not authenticated.
去代理软件后台看到其报错

Aug 10 16:59:59.618 - [INFO] ssl error: [SSL: SSLV3_ALERT_CERTIFICATE_UNKNOWN] sslv3 alert certificate unknown (_ssl.c:590),create full domain cert for host:jcenter.bintray.com
就是因为软件不能信任我们自己的证书，所以导致https通讯失败。而解决办法就是将jcenter仓库地址替换为http。即将build.gradle中的

    repositories {
    jacenter()
    }
全部替换为(应该有两个，一个是app的，一个是module的)


    repositories {
    jcenter 
    { 
        url 'http://jcenter.bintray.com' 
    } 
    }
- init.gradle永久替换jcenter()

按照上述方法，就成功的设置了代理。但是缺点是需要每次新建项目后都修改一下仓库地址，尤其是初学Android时，基本上每个示例都要新建一个项目，难不成每个都改一遍么？当然不可能，自然有替换方法，将下面的内容，保存为init.gradle，和gradle.properties一样，也放到USER_HOME/.gradle/中。

    allprojects{
    repositories {
        def REPOSITORY_URL = 'http://jcenter.bintray.com/'
        all { ArtifactRepository repo ->
            println repo.url.toString()
            if ((repo instanceof MavenArtifactRepository) && repo.url.toString().startsWith("https://jcenter.bintray.com/")) {
                project.logger.lifecycle "Repository ${repo.url} replaced by $REPOSITORY_URL."
                remove repo
            }   
        }
        jcenter { 
            url REPOSITORY_URL
        }
    }
    }
重新打开Android Studio并进行同步gradle，你会发现一切都正常了。

init.gradle是Gradle的初始化脚本(Initialization Scripts)，会再每次gradle运行时执行，即上述代码是在gradle运行时修改jcenter仓库链接而不会去修改build.gradle文件里的内容。

5. `* What went wrong:`

   `Execution failed ``for` `task ``':app:lintVitalRelease'``.`

   `> java.lang.NullPointerException (no error message)`

   `* Try:`

   `Run ``with` `--stack``trace` `option to ``get` `the stack ``trace``. Run ``with` `--info or --debug option to ``get` `more log output.` 

   `BUILD FAILED`

   解决方法：

   ./gradlew app:assembleRelease -x lintVitalRelease 

   或则在 

   android － app － build.gradle 里面添加

   android {

   ...

   lintOptions { checkReleaseBuilds false }

   ...

   }

6. 重复定义了库v7

Unknown source file : UNEXPECTED TOP-LEVEL EXCEPTION:
Unknown source file : com.android.dex.DexException: Multiple dex files define Landroid/support/v7/appcompat/R$anim;
Unknown source file : 	at com.android.dx.merge.DexMerger.readSortableTypes(DexMerger.java:596)
Unknown source file : 	at com.android.dx.merge.DexMerger.getSortedTypes(DexMerger.java:554)
Unknown source file : 	at com.android.dx.merge.DexMerger.mergeClassDefs(DexMerger.java:535)
Unknown source file : 	at com.android.dx.merge.DexMerger.mergeDexes(DexMerger.java:171)
Unknown source file : 	at com.android.dx.merge.DexMerger.merge(DexMerger.java:189)
Unknown source file : 	at com.android.dx.command.dexer.Main.mergeLibraryDexBuffers(Main.java:502)
Unknown source file : 	at com.android.dx.command.dexer.Main.runMonoDex(Main.java:334)
Unknown source file : 	at com.android.dx.command.dexer.Main.run(Main.java:277)
Unknown source file : 	at com.android.dx.command.dexer.Main.main(Main.java:245)
Unknown source file : 	at com.android.dx.command.Main.main(Main.java:106)

:app:dexInternalRelease FAILED
FAILURE: Build failed with an exception.
\* What went wrong:
Execution failed for task ':app:dexInternalRelease'.
\> com.android.ide.common.process.ProcessException: org.gradle.process.internal.ExecException: Process 'command '/Library/Java/JavaVirtualMachines/jdk1.8.0_151.jdk/Contents/Home/bin/java'' finished with non-zero exit value 2

原因：在App/build.gradle中重复定义了库v7

dependencies {

​    compile fileTree(dir: "libs", include: ["*.jar"])

​    compile "com.android.support:appcompat-v7:23.0.1"

​    /*compile "com.alibaba:fastjson:1.2.11"*/

​    /*compile "com.facebook.react:react-native:+"  // From node_modules*/

​    compile project(':ReactAndroid')

​    /*compile "cn.finalteam:galleryfinal:1.4.8.7"*/

​    /*compile "com.aliyun.dpa:oss-android-sdk:2.2.0"*/

​    compile project(':OneSDK')

​    compile (project(':ReactNativeBarcodescanner')){

​      exclude group: 'com.facebook.react', module: 'react-native'

​    }

​    compile (project(':react-native-code-push')){

​      exclude group: 'com.facebook.react', module: 'react-native'

​    }

​    compile (project(':react-native-image-picker')){

​      exclude group: 'com.facebook.react', module: 'react-native'

​    }

​    /*compile project(':react-native-splashscreen')*/

​    /*compile project(':react-native-camera')*/

​    compile (project(':react-native-permissions')){

​      exclude group: 'com.facebook.react', module: 'react-native'

​    }

​    compile (project(':react-native-file-opener')){

​      exclude group: 'com.facebook.react', module: 'react-native'

​    }

​    compile (project(':react-native-fs')){

​      exclude group: 'com.facebook.react', module: 'react-native'

​    }

​    compile (project(':react-native-svg')){

​      exclude group: 'com.facebook.react', module: 'react-native'

​    }

​    compile (project(':react-native-orientation')){

​      exclude group: 'com.facebook.react', module: 'react-native'

​    }

​    compile (project(':react-native-detect-new-photo')){

​      exclude group: 'com.facebook.react', module: 'react-native'

​    }

​    compile (project(':rn-camera-roll')){

​      exclude group: 'com.facebook.react', module: 'react-native'

​    }

​    compile (project(':react-native-device-info')){

​      exclude group: 'com.facebook.react', module: 'react-native'

​    }

}

compile "com.android.support:appcompat-v7:23.0.1”

原因：

1) You have same library or jar file included several places and some of them conflicting with each other.

2) You are about to or already exceeded 65k method limit

处理：

1) cd android// && ./gradlew clean

​	clean的作用是删除build中的文件，即在运行过程中产生的文件

​	实际起作用的是react-native-svg/android/build

Only in ./android/OneSDK/build
Only in ./android/app/build
Only in ./node_modules/react-native/ReactAndroid/build
Only in ./node_modules/react-native-barcodescanner/android/build
Only in ./node_modules/react-native-code-push/android/app/build
Only in ./node_modules/react-native-detect-new-photo/android/build
Only in ./node_modules/react-native-device-info/android/build
Only in ./node_modules/react-native-file-opener/android/build
Only in ./node_modules/react-native-fs/android/build
Only in ./node_modules/react-native-image-picker/android/build
Only in ./node_modules/react-native-orientation/android/build
Only in ./node_modules/react-native-permissions/android/build
*<u>**Only in ./node_modules/react-native-svg/android/build**</u>*
Only in ./node_modules/rn-camera-roll/android/build

2) 或者查找重复包./gradlew -q dependencies yourProjectName_usually_app:dependencies --configuration compile

或者：	./gradlew -q  app:dependencies

​		./gradlew :app:dependencies --configuration compile

项目中引用了重复的jar包，这可能是因为新引入的library module中有和主项目中重复引用的jar包，需要重点检查 Android 兼容包 **support-v4** 和 **support-v7** 包，还有一些常用的开源项目，例如Gson，Nineoldandroids…，这些常用的开源项目有可能在你引用的 library 项目中已经被引用过了。

对于重复依赖项，可以使用force transitive exclude 来移除依赖关系

3) 修改SDK版本
  ```
   android {
       defaultConfig {
           ...
           minSdkVersion 21 
           targetSdkVersion 26
           multiDexEnabled true
       }
       ...
       multiDexEnabled true
   }
   dependencies {
     compile 'com.android.support:multidex:1.0.1'
     ...
   }
  ```

文件位置：./android/app/build.gradle

4) 从多个依赖中移除冲突文件

文件位置：./module/setting.gradle

adroid{

​	packagingOptions {

​	exclude 'LICENSE.txt'

​	}

}

6. SyntaxError /Users/eric/WorkSpace/HipRock/app/components/NetworkDocumentCard.js: false is a reserved word (77:93)

:app:bundleInternalReleaseJsAndAssets FAILED

FAILURE: Build failed with an exception.

* What went wrong:
  Execution failed for task ':app:bundleInternalReleaseJsAndAssets'.
> Process 'command 'node'' finished with non-zero exit value 1
>

​	问题发生在灯塔，将证书导入java后，编译时的问题

```
downloadFile(options: DownloadFileOptions): { jobId: number, promise: Promise<DownloadResult> }

type DownloadFileOptions = {
  fromUrl: string;          // URL to download file from
  toFile: string;           // Local filesystem path to save the file to
  headers?: Headers;        // An object of headers to be passed to the server
  background?: boolean;     // Continue the download in the background after the app terminates (iOS only)
  discretionary?: boolean;  // Allow the OS to control the timing and speed of the download to improve perceived performance  (iOS only)
  progressDivider?: number;
  begin?: (res: DownloadBeginCallbackResult) => void;
  progress?: (res: DownloadProgressCallbackResult) => void;
  connectionTimeout?: number // only supported on Android yet
  readTimeout?: number       // supported on Android and iOS
};
```
`npm start -- --reset-cache`

//git+https://github.com/yamill/react-native-orientation



7. npm node

   错误：$   npm install

   npm WARN react-native-orientation@3.1.0 requires a peer of react-native@>=0.40 but none is installed. You must install peer dependencies yourself.

   npm ERR! code UNABLE_TO_GET_ISSUER_CERT_LOCALLY

   npm ERR! errno UNABLE_TO_GET_ISSUER_CERT_LOCALLY

   npm ERR! request to https://registry.npm.taobao.org/arrify failed, reason: unable to get local issuer certificate

   npm ERR! A complete log of this run can be found in:

   npm ERR!     /Users/sechina/.npm/_logs/2017-12-12T05_04_40_721Z-debug.log

   解决：npm config set strict-ssl false

   ​	或者在主目录下的.npmrc文件中修改[strict-ssl](https://docs.npmjs.com/misc/config#strict-ssl)等于false

8.:app:compileInternalReleaseJavaWithJavac

/Users/sechina/ToDo/FunkRock/android/app/src/main/java/com/energymost/funkRocking/MainApplication.java:13: error: package com.reactnative.ivpusic.imagepicker does not exist

import com.reactnative.ivpusic.imagepicker.PickerPackage;

​                                          ^

/Users/sechina/ToDo/FunkRock/android/app/src/main/java/com/energymost/funkRocking/MainApplication.java:76: error: cannot find symbol

​          new PickerPackage(),

​              ^

  symbol: class PickerPackage

Note: /Users/sechina/ToDo/FunkRock/android/app/src/main/java/com/energymost/funkRocking/MainApplication.java uses or overrides a deprecated API.

Note: Recompile with -Xlint:deprecation for details.

2 errors

:app:compileInternalReleaseJavaWithJavac FAILED