#!/bin/bash
function getParamAndPlusone()
{
arg1="rockBuildNum"
global=`env`

[[ "$global" =~ "$arg1" ]]	#匹配，判断rockBuildNum是否在env中
if [ $? -ne 0 ]
then
	setParam 1
else
	expr ${!arg1} + 1 &>/dev/null
	if [ $? -eq 0 ]
	then
		let $arg1=$[$arg1+1]
		else
			setParam 1
	fi
fi
echo ${!arg1}
}

setParam()
{
	let $arg1=$1
	export $arg1 
}

getParamAndPlusone
