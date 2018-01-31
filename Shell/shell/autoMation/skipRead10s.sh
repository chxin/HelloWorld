version=1.0.0
echo "Automatic execute skip read ten seconds after"
echo "Please enter the version?like the 1.0.0"
echo "the old version is $version"

while([[ $versionTemp == '' ]])
do
	stty -icanon min 0 time 50
	read versionTemp
	if [ -z $versionTemp ]
	then
		echo "skip read version"
		break
	fi
	# 做格式匹配
	count=`echo $versionTemp | grep -E "^[0-9]+\.[0-9]+\.[0-9]+$"| wc -l`
	if [ $count = 0 ]
	then
		versionTemp=''
		echo "Error!Please enter the version?like the 1.0.0"
	fi
done

if [ ! -z $versionTemp ]
then
    version=$versionTemp
fi

echo "version : $version"
