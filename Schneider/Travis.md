#### 1. Travis配置

1. 设置为分享

2. 在`git commit`中如果包含`[skip ci]`或`[ci skip]`，该提交就不会触发一次build。

3. 如果多次提交同时push，默认只在最新提交执行一次build

4. ```
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

5. 支持github的同类软件

   https://github.com/marketplace/category/continuous-integration

#### 2. iOS配置

   1. gem install travis

   2. 证书进行加、解密

      1. 利用

      2. ​

         ```
         travis encrypt-file keys/***key --add
         ```

      3. 在before_script里面就需要对证书解密还原(travis命令执行完后，自动在.travis.yml添加相关配置)

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





travis encrypt "keyEncryption=keyEncrypt" --add

```
openssl aes-256-cbc -k "keyEncrypt" -in android/app/hiprock.jks -out android/app/hiprock.jks.enc -a
openssl aes-256-cbc -k "keyEncrypt" -in ios/RockCer/privateKey.p12 -out ios/RockCer/privateKey.p12.enc -a
openssl aes-256-cbc -k "keyEncrypt" -in ios/RockCer/ios_distribution.cer -out ios/RockCer/ios_distribution.cer.enc -a
openssl aes-256-cbc -k "keyEncrypt" -in ios/RockCer/hocHipRock.mobileprovision -out ios/RockCer/hocHipRock.mobileprovision.enc -a
```

```
- openssl aes-256-cbc -k "$keyEncryption" -in android/app/hiprock.jks.enc  -d -a -out android/app/hiprock.jks
- openssl aes-256-cbc -k "$keyEncryption" -in ios/RockCer/privateKey.p12.enc  -d -a -out ios/RockCer/privateKey.p12
- openssl aes-256-cbc -k "$keyEncryption" -in ios/RockCer/ios_distribution.cer.enc  -d -a -out ios/RockCer/ios_distribution.cer
- openssl aes-256-cbc -k "$keyEncryption" -in ios/RockCer/hocHipRock.mobileprovision.enc  -d -a -out ios/RockCer/hocHipRock.mobileprovision
```





### 3. ios操作步骤

   1. 确保打包脚本运行顺利，并将项目设置为分享

   2. 加密

      1. ``` openssl aes-256-cbc -k "keyEncrypt" -in android/app/hiprock.jks -out android/app/hiprock.jks.enc -a

         openssl aes-256-cbc -k "keyEncrypt" -in ios/RockCer/ios_distribution.cer -out ios/RockCer/ios_distribution.cer.enc -a
         openssl aes-256-cbc -k "keyEncrypt" -in ios/RockCer/hocHipRock.mobileprovision -out ios/RockCer/hocHipRock.mobileprovision.enc -a
         ```

         2. 在.gitignore中，设置忽略加密的文件

            ```

            ```

            ​

   3. 配置环境

      1. 在.travis.yml中

   4. 解密和证书

      1. ```

         - openssl aes-256-cbc -k "$keyEncryption" -in ios/RockCer/privateKey.p12.enc  -d -a -out ios/RockCer/privateKey.p12
         - openssl aes-256-cbc -k "$keyEncryption" -in ios/RockCer/ios_distribution.cer.enc  -d -a -out ios/RockCer/ios_distribution.cer
         - openssl aes-256-cbc -k "$keyEncryption" -in ios/RockCer/hocHipRock.mobileprovision.enc  -d -a -out ios/RockCer/hocHipRock.mobileprovision
         ```

      2. source ios/RockCer/add-key.sh

   5. 打包

      1. source ./buildTestIpa.sh



### 4. android操作步骤
   1. 确保打包脚本运行顺利

   2. 加密

         1. ```
            openssl aes-256-cbc -k "keyEncrypt" -in ios/RockCer/privateKey.p12 -out ios/RockCer/privateKey.p12.enc -a
            ```

         2. 在.gitignore中，设置忽略加密的文件

            ```

            ```

            ​

   3. 配置环境

         1. 在.travis.yml中

         2. 配置android ndk

            ```
            - wget http://dl.google.com/android/ndk/android-ndk-r10e-linux-x86_64.bin
            - chmod +x android-ndk-r10e-linux-x86_64.bin
            - "./android-ndk-r10e-linux-x86_64.bin | grep ndk-build.cmd"
            - export ANDROID_NDK=`pwd`/android-ndk-r10e
            ```

   4. 解密

         1. ```
            - openssl aes-256-cbc -k "$keyEncryption" -in android/app/hiprock.jks.enc  -d -a -out android/app/hiprock.jks
            ```

   5. 打包

         1. source ./run.sh