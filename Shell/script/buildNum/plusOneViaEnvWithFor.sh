#!/bin/bash
#把变量存入环境变量，每执行一次，变量值加一；
#如果不是整数或变量不存在，就新建
function getParamAndPlusone()
{
	arg1="rockBuildNum"
	ifglobal=0

	for member in `env`
	do
	key1=${member%=*}
	value1=${member#*=}
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

	 return $rockBuildNum
}

setParam()
{
	export rockBuildNum=$1		#写入环境变量
}

getParamAndPlusone
Number=$?
echo $Number

