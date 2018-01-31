oldVer=`awk -F= '/ROCK_VERSION/{print $2}' android/gradle.properties |tail -n 1`

version=$(curl -d "_api_key=be1290e71bb2fab7a9547cda2ee37d7b" -d "appKey=b31ce581c0d4b898270189b5962c44fd" https://www.pgyer.com/apiv2/app/view | tr ',' '\n' | awk -F : '/buildVersion/{print $2}' | head -1 | sed 's/"//g')
echo $oldVer
echo $version
if [ $version == $oldVer ]
then 
	version=${version%.*}.$((${version##*.}+1))
else 
	version=$oldVer
fi
echo $oldVer
echo $version


oldVer=`/usr/libexec/PlistBuddy -c "Print :CFBundleShortVersionString" ./ios/HipRock/Info.plist`
version=$(curl -d "_api_key=be1290e71bb2fab7a9547cda2ee37d7b" -d "appKey=8d52314a63156de90abff8a1413e7b8a" https://www.pgyer.com/apiv2/app/view | tr ',' '\n' | awk -F : '/buildVersion/{print $2}' | head -1 | sed 's/"//g')
echo $oldVer
echo $version
if [ $version == $oldVer ]
then 
	version=${version%.*}.$((${version##*.}+1))
else 
	version=$oldVer
fi
echo $oldVer
echo $version