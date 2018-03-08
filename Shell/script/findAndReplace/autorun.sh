#!自动配置环境中遇到的BUG，依次用命令行解决
export https_proxy=http://101.231.121.17:80 #代理
npm install
rm ./android/local.properties
source ./findWhat.sh && getFileAndChangeJcenter
#手动修改buildToolVision 
cp ./boost_1_57_0.zip ./node_modules/react-native/ReactAndroid/build/downloads/boost_1_57_0.zip

cd android// && ./gradlew clean 
cd ..

source ./findWhat.sh && changeFileContent

cd android// && ./gradlew clean 
cd ..

cp ./boost_1_57_0.zip ./node_modules/react-native/ReactAndroid/build/downloads/boost_1_57_0.zip

