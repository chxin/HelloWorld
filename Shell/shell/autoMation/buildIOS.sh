function runIOSBuild()
{
	OUTPUTDIR="./buildTemp"
	APPNAME=$(date +'FunkRock'%Y-%m-%d-%H-%M-%S)
	SCHEMETEST="FunkRock_Test"
	SCHEMEPROD="FunkRock_Prod"
	APP_PROJECTPATH="./ios/FunkRock.xcodeproj"
	PLIST_PATH='./ios/FunkRock/Info.plist'
	################## version control  ################
	oldVer=`/usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' ./ios/FunkRock/info.plist`
	inputVersion "IOS"
	git checkout ${PLIST_PATH}
	. ./mergeTest.sh
	/usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString ${version}" ${PLIST_PATH}
	################## build number  ##############
	buildNumPlusOne
	################# build process  #######################
	rm "$OUTPUTDIR/$APPNAME/$SCHEMETEST.ipa"
	cp -rf ../downloadResources/* ./node_modules/react-native/ReactAndroid/
	rm -rf ./node_modules/react-native-svg/android/build

	xcodebuild -project "$APP_PROJECTPATH" -scheme "$SCHEMETEST" archive -archivePath "$OUTPUTDIR/$APPNAME.xcarchive" -quiet
	xcodebuild -exportArchive -archivePath "$OUTPUTDIR/$APPNAME.xcarchive" -exportPath "$OUTPUTDIR/$APPNAME" -exportOptionsPlist "exportTestOptions.plist" -quiet
	################  upload xcarchive ##################
	echo commit_buildnum:$description-----version:$version
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
	echo -e "$1: Please input the new version?like the 1.0.0. \nThe old version is:$oldVer"
	read version
	count=`echo $version | grep -E "^[0-9]+\.[0-9]+\.[0-9]+$"| wc -l`
	while(($count==0))
	do
		echo -e "$1: Error! Please input the new version?like the 1.0.0. \nThe old version is:$oldVer"
		read version
		count=`echo $version | grep -E "^[0-9]+\.[0-9]+\.[0-9]+$"| wc -l`
	done
}

runIOSBuild
