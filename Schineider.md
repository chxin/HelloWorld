#### Schneider 

1. Proxy
  10.198.157.119:9400
  101.231.121.17:80

2. 命令行设置代理
  export https_proxy=http://10.198.157.119:9400
  export https_proxy=http://101.231.121.17:80
  删除代理
  export https_proxy=
  echo  $https_proxy

3. Andriod Studio设置代理
  根目录下gradle.properties文件
  配置HTTP代理
  systemProp.http.proxyHost=101.231.121.17
  systemProp.http.proxyPort=80
  systemProp.http.proxyUser=sesa368550
  systemProp.http.proxyPassword=!1234567q
  systemProp.http.nonProxyHosts=*.nonproxyrepos.com|localhost
  配置HTTPS代理
  systemProp.https.proxyHost=101.231.121.17
  systemProp.https.proxyPort=80
  systemProp.https.proxyUser=sesa368550 
  systemProp.https.proxyPassword=!1234567q 
  systemProp.https.nonProxyHosts=*.nonproxyrepos.com|localhost

4.  your credentials may be sent unencrypted

   在系统设置中设置了https代理，没有证书没有加密就发送https，不安全

5. charles代理设置

   主要是解决代理证书的问题

   help—SSL Proxy—install charles root certificate—证书管理always trust

   Proxy—ssl proxying settting—SSL proxying---add——host:* port:443

6. 证书问题

   Firefox导出证书

   Firefox导入证书

   JAVA证书：

   ​		用cd进入到java证书目录   cd $JAVA_HOME/jre/lib/security

   　　　　敲入如下命令回车执行

   　　　　sudo keytool -import -alias cacerts -keystore cacerts -file ~/Documents/***.cer

   ​		如果permission denied，用sudo

   　　　　此时命令行会提示你输入cacerts证书库的密码，

   　　　　敲入changeit，这是java中cacerts证书库的默认密码

   查看证书列表：keytool -list -keystore cacerts | grep cacerts
   删除证书：keytool -delete -alias cacerts -keystore cacerts
   添加证书：sudo keytool -import -alias cacerts -keystore cacerts -file ~/Documents/***.cer

7. web

   https://cms1.hust.edu.cn:9999/system/hustlogin.jsp

   1997010243

   hzkjdx62588328

8. VNC

   ```
   vnc://10.177.201.82
   buildserver
   P@ssw0rd
   ```