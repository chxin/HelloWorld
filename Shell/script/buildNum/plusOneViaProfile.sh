#!/bin/bash
function getParamAndPlusone()
{
	arg1="rockBuildNum"
	ifExist=0

	if [ ! -f ~/Documents/.profile ]
	then
		touch ~/Documents/.profile
	fi

	for member in `cat ~/Documents/.profile`
	do
	key1=${member%=*}        #key=value结构，%从后删除=*即剩key，#从前删除*=即剩value
	value1=${member#*=}
	if [ "$key1" = "$arg1" ]
	then
		ifExist=1
		expr $value1 + 1&>/dev/null		#判断是否整数（加1后的状态值）
		if [ $? == 0 ]
		then
			let $arg1=$[$value1+1]
			setParam ${!arg1}			#间接引用变量，arg1=>rockBuildNum=>integer
		else
			setParam 1
		fi
	fi
	done

	if [ $ifExist -eq 0 ]
	then
		setParam 1
		let $arg1=1
	fi

	 eval echo \$$arg1				#间接引用变量，eval方法
	 return 0
}

setParam()
{
	echo "$arg1=$1">~/Documents/.profile  #变量存入隐藏文件
}

# initParam()
# {
# 	echo "$arg1=1">~/Documents/.profile
# }

