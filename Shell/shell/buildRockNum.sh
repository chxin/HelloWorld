function getParamAndPlusone()
{
	arg1="rockBuildNum"
	ifglobal=0

	if [ ! -f ./cache/.profile ]
	then
		touch -f ./cache/.profile
	fi

	for member in `cat ./cache/.profile`
	do
	key1=${member%=*}
	echo $key1
	value1=${member#*=}
	echo $value1
	if [ "$key1" = "$arg1" ]
	then
		ifglobal=1
		expr $value1 + 1&>/dev/null
		if [ $? == 0 ]
		then
			 let rockBuildNum=$[$value1+1]
			setParam $rockBuildNum
		else
			setParam 1
		fi
	fi
	done

	if [ $ifglobal -eq 0 ]
	then
		setParam 1
		rockBuildNum=1
	fi

	echo $rockBuildNum
	return 0
}

setParam()
{
	echo "rockBuildNum=$1">./cache/.profile
	export rockBuildNum=$1
	echo $1
}

# initParam()
# {
# 	echo "rockBuildNum=1">./cache/.profile
# }


 getParamAndPlusone
# Number=$?
# echo $Number

