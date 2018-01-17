#### 1. Travis配置

1. 在`git commit`中如果包含`[skip ci]`或`[ci skip]`，该提交就不会触发一次build。

2. 如果多次提交同时push，默认只在最新提交执行一次build

3. ```
   # 运行流程
   Install apt addons
   before_install
   install
   before_script
   script # 打包代码
   after_success or after_failure
   OPTIONAL before_deploy
   OPTIONAL deploy
   OPTIONAL after_deploy
   after_script
   ```

4. 支持github的同类软件

   https://github.com/marketplace/category/continuous-integration

#### 2. iOS配置

   1. gem install travis

   2. 证书进行加、解密

      1. 利用Travis的命令行工具在根目录执行下面的命令加密：

         ```
         travis encrypt-file keys/***key --add
         ```

      2. 在before_script里面就需要对证书解密还原(travis命令执行完后，自动在.travis.yml添加相关配置)

   3. 导入私钥、证书

   4. xcodebuild

      ```
      xcodebuild -project "$APP_PROJECTPATH" -scheme "$SCHEMETEST" archive -archivePath "$OUTPUTDIR/$APPNAME.xcarchive" -quiet
      	xcodebuild -exportArchive -archivePath "$OUTPUTDIR/$APPNAME.xcarchive" -exportPath "$OUTPUTDIR/$APPNAME" -exportOptionsPlist "exportTestOptions.plist" -quiet
      ```

      ​

   5. 上传

      ```
      	curl -F "file=@$OUTPUTDIR/$APPNAME/$SCHEMETEST.ipa" -F "uKey= 24af41e3b5e5117e773a733378aefa29" -F "_api_key= 0691c7489e57a5158796f6e1e7e988bd" -F "installType=2" -F "password=123456" -F "updateDescription=$description" http://qiniu-storage.pgyer.com/apiv1/app/upload
      ```

      ​

#### 3. Android配置

1. gem install travis

   ```
   language: android

   sudo: false

   android:
     components:
     - build-tools-23.0.1
     - android-23
     - extra-android-m2repository
     - extra-android-support

   script:
     - "./gradlew assembleRelease"
   ```

   `sudo: false`，是为了[开启基于容器的Travis CI任务](https://docs.travis-ci.com/user/migrating-from-legacy/)，让编译效率更高。

2. 密码和证书加密

   1. 密码放在环境变量中

      ```
       releaseConfig {
                  storeFile file("../keys/evandroid.jks")
                  storePassword project.hasProperty("KEYSTORE_PASS") ? KEYSTORE_PASS : System.getenv("KEYSTORE_PASS")
                  keyAlias project.hasProperty("ALIAS_NAME") ? ALIAS_NAME : System.getenv("ALIAS_NAME")
                  keyPassword project.hasProperty("ALIAS_PASS") ? ALIAS_PASS : System.getenv("ALIAS_PASS")
              }
      ```

   2. 证书加密

      1. travis encrypt-file keys/evandroid.jks --add
      2. 会自动生成加密配置

   3. 打包，相关配置放在 script:中 ./gradlew assembleRelease

   4. 发布