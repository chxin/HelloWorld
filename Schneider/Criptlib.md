1. Xcode 处理C语言头文件
   1. 在当前工程目录下添加。需要注意，include某个头文件时，必须将引用的头文件放在引用文件目录下
   2. 添加头文件依次找到

   **Header Search Paths**: 添加#include <>的路径 
   **User Header Search Paths**: 添加#include “”路径

   **添加库文件** 
   **Library Search Paths**: 添加库所在目录 
   **Other Linker Flags**: 比如要链接的库是libboost_regex.a,那么此处应该添加-lboost_regex即可。

   相对路径：$(SRCROOT)/当前工程名字/需要包含头文件所在文件夹