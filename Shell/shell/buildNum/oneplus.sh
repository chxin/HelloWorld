function getParamAndPlusone()
{
arg1="rockBuildNum"
global=`env`
[[ "$global" =~ "$arg1" ]]
if [ $? -ne 0 ]
then
setParam 100
else
expr ${!arg1} + 1 &>/dev/null
if [ $? -eq 0 ]
then
let $arg1=$[$arg1+1]
else
setParam 100
fi
fi
}

setParam()
{
let $arg1=$1
export $arg1 
}

getParamAndPlusone


