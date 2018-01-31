function getParamAndPlusone()
{
	arg1="rockBuildNum"
	ifglobal=0

	if [ ! -f ~/.bash_profile ]
	then
		touch ~/.bash_profile
	fi

	for member in `cat ~/.bash_profile`
	do
	key1=${member%=*}
	value1=${member#*=}
	if [ "$key1" = "$arg1" ]
	then
		ifglobal=1
		expr $value1 + 1&>/dev/null
		if [ $? == 0 ]
		then
			let $arg1=$[$value1+1]
			plusone $value1 ${!arg1} 
		else
			plusone $value1 1
		fi
	fi
	done

	if [ $ifglobal -eq 0 ]
	then
		initParam
		let $arg1=1
	fi

	 echo ${!arg1}
	 source ~/.bash_profile
	 return 0
}


function plusone()
{
	# fPath='~/.bash_profile'
	pattern1="rockBuildNum=$1"
	pattern2="rockBuildNum=$2"
	sed -ig "s/$pattern1/$pattern2/g" ~/.bash_profile
}

initParam()
{
	echo -e "rockBuildNum=1\nexport rockBuildNum">>~/.bash_profile
}

