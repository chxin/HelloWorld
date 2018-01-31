buildNum=`curl -F "_api_key=be1290e71bb2fab7a9547cda2ee37d7b" -F "appKey=8d52314a63156de90abff8a1413e7b8a" https://www.pgyer.com/apiv2/app/view | tr ',' '\n' | awk -F : '/buildUpdateDescription/{print $2}'| sed 's/"//g' | head -1 | awk -F _ '{print $2}'`
echo $buildNum
