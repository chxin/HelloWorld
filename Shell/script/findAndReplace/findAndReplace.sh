#!/bin/bash
function setFileName()
{
	file=(react-native-image-picker react-native-permissions react-native-file-opener react-native-fs react-native-svg react-native-detect-new-photo)
	parentDir=../node_modules
}

#找到文件的绝对路径，并替换
function getFileAndChangeJcenter()
{
	setFileName
	totalDir=`ls -R $parentDir`
	parentDir=$parentDir'/'

	for childDir in $totalDir
	do
		[[ "$childDir" =~ ":" ]]		#形式 pDir：cDir1，cDir……如果有：，则是pDir，否则，则是cDir应该前缀pDir
		if [ $? -eq 0 ]
		then
			parentDir=${childDir/':'/'/'} #把:替换为/
		else
			nowDir="$parentDir""$childDir"
			[ -f $nowDir ]
			if [ $? -eq 0 -a ${nowDir##*/} = "build.gradle" ] #${nowDir##*/}得到文件类型
			then
				for obj in ${file[@]} 		#在所有待查找文件夹名中匹配当前路径
				do
					[[ "$nowDir" =~ "$obj" ]] 	#注意，双中括号	
					if [ $? -eq 0 ]
					then
						changeJcenterContent $nowDir
					fi
				done
			fi
		fi
	done
}

#sed方法使用正则表达式匹配并替换
#sed [-Ealn] command [file ...]
function changeJcenterContent()
{
	fPath=$1
	pattern1='jcenter()'
	pattern2='jcenter{url "http:\/\/jcenter.bintray.com\/"}'  #对特殊字符要转义，尤其是/
	sed -ig "s/$pattern1/$pattern2/g" $fPath 
}

function changeJSCHeader() {
	JscPath=../node_modules/react-native/ReactAndroid/build.gradle
	pattern1='https:\/\/svn.webkit.org'
	pattern2='http:\/\/svn.webkit.org'
	sed -ig "s/$pattern1/$pattern2/g" $JscPath 
}

function changeBuildVersion() {
	verPath=../node_modules/rn-camera-roll/android/build.gradle
	pattern1='23.0.2'
	pattern2='23.0.1'
	sed -ig "s/$pattern1/$pattern2/g" $verPath 
}

