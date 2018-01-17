#### 1. Shell错误检测

- set-x，之后的每一条命令以及加载命令行中的任何参数都会显示出来
- echo和print命令，检查值的正确性和逻辑正确性，但是每次修改都要删除这些命令
- 设置调试变量$debug，根据调试层次控制输出test $debug -gt 0 && echo "the answer is $var"
- 函数alert检查$?的值
- 手动单步执行

#### 2. 库文件

- `#!/bin/echo` 该库的脚本不能像常规脚本那样执行，而是以source命令的方式在当前shell中执行
- 调用库：source std_lib 或者 . std_lib

#### 3. 忽略文件中的空行和注释行

- sed -e "s/#.*//g" app.js | awk '{if(length != 0) print $0}'

#### 4. 特殊匹配行

- 模式之后的行：cat markdown.js | awk -F= ' $1 ~ /textarea/ { getline;print $2}'
- 模式之前的行：
- 处理XML文件：awk '$1 ~ /CFBundleShortVersionString/ { getline;print $1}' info | grep -o -E [0-9.]+


![shell解析过程](http://images.cnblogs.com/cnblogs_com/chengmo/WindowsLiveWriter/LinuxShell_142B8/1_2.png)

##### 5. grep的上下行

ls -R | grep ipa -A 4 所得行之前的4行

ls -R | grep ipa -B 4 所得行之后的4行