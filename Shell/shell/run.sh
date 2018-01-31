function runAndroidBuild()
{

	##################  version control  #####################
	oldVer=`awk -F= '/ROCK_VERSION[^CODE]/{print $2}' android/gradle.properties`
	inputVersion "Android"
	sed -ig "s/$oldVer/$version/g" ./android/gradle.properties
	###################  build number  ##########################
	buildNumPlusOne
	##################  build process  ##########################
	date +'android start build time:'%Y-%m-%d-%H-%M-%S
	rm -rf node_modules
	npm install
	rm ../build_file/*.apk
	cp ./android/customModules/ShareModule.java ./node_modules/react-native/ReactAndroid/src/main/java/com/facebook/react/modules/share/ShareModule.java

	cp -rf ../downloadResources/* ./node_modules/react-native/ReactAndroid/
	rm -rf ./node_modules/react-native-svg/android/build

	cd android && ./gradlew assembleRelease 
	if [ $? -eq 0 ]; then say "hi,build success"; else say "hi,build failed"; fi
	cd ..

	cp ./android/app/build/outputs/apk/*.apk ../build_file
	rm ../build_file/*unaligned.apk

	date +'android end build time:'%Y-%m-%d-%H-%M-%S
	##################  uploda apk  #############################
	echo commit and buildnum:$description,$version
	# filePath="./android/app/build/outputs/apk/app-internal-release-$version.apk"

	# curl -F "file=@$filePath" -F "uKey= 24af41e3b5e5117e773a733378aefa29" -F "_api_key= 0691c7489e57a5158796f6e1e7e988bd" -F "installType=2" -F "password=123456" -F "updateDescription=$currCommit" http://qiniu-storage.pgyer.com/apiv1/app/upload
}

function runIOSBuild()
{
	OUTPUTDIR="./buildTemp"
	APPNAME=$(date +'FunkRock'%Y-%m-%d-%H-%M-%S)
	SCHEMETEST="FunkRock_Test"
	SCHEMEPROD="FunkRock_Prod"
	APP_PROJECTPATH="./ios/FunkRock.xcodeproj"
	PLIST_PATH='./ios/FunkRock/Info.plist'
	################## build number  ##############
	buildNumPlusOne
	################## version control  ################
	oldVer=`/usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' ./ios/FunkRock/info.plist`
	inputVersion "IOS"
	git checkout ${PLIST_PATH}
	. ./mergeTest.sh
	/usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString ${version}" ${PLIST_PATH}
	
	################# build process  #######################
	rm "$OUTPUTDIR/$APPNAME/$SCHEMETEST.ipa"
	xcodebuild -project "$APP_PROJECTPATH" -scheme "$SCHEMETEST" archive -archivePath "$OUTPUTDIR/$APPNAME.xcarchive" -quiet
	xcodebuild -exportArchive -archivePath "$OUTPUTDIR/$APPNAME.xcarchive" -exportPath "$OUTPUTDIR/$APPNAME" -exportOptionsPlist "exportTestOptions.plist" -quiet

	################  upload xcarchive ##################
	echo commit and buildnum:$description,$version
	# curl -F "file=@$OUTPUTDIR/$APPNAME/$SCHEMETEST.ipa" -F "uKey= 24af41e3b5e5117e773a733378aefa29" -F "_api_key= 0691c7489e57a5158796f6e1e7e988bd" -F "installType=2" -F "password=123456" -F "updateDescription=$description" http://qiniu-storage.pgyer.com/apiv1/app/upload
}
function buildNumPlusOne()
{
	source ./buildNumber.sh
	currCommit=$(git rev-parse --short HEAD)
	buildNumber=`getParamAndPlusone`

	description="$currCommit"_"$buildNumber"
}
function inputVersion()  
{
	echo "$1: Please input the new version?like the 1.0.0. \nThe old version is:$oldVer"
	read version
	count=`echo $version | grep -E "^[0-9]+.[0-9]+.[0-9]+$"| wc -l`
	while(($count==0))
	do
		echo "$1: Error! Please input the new version?like the 1.0.0. \nThe old version is:$oldVer"
		read version
		count=`echo $version | grep -E "^[0-9]+.[0-9]+.[0-9]+$"| wc -l`
	done
}

if [[ $1 == "ios" ]]
then
	runIOSBuild
else
	runAndroidBuild
fi