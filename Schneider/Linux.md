#### Linux

1. expr  let  eval

   expr命令是一个手工命令行计数器，用空格隔开每个项；

2. 间接引用变量

   eval echo \$$varname

   echo ${!varname}

3. 调用脚本的函数

   source ***.sh

   functionName

4. exec单步调试


   exec内建命令并不启动新的shell，而是用被执行的命令替换当前的shell进程，并将老进程的环境清理掉，在exec之后的其他命令也不再执行。

5. case语句

   双引号结束

6. $( ) 与  (反引号)

   $(( )) 的整数运算

7. awk 编程语言

   awk的处理文本和数据的方式是这样的，它逐行扫描文件，从第一行到最后一行，寻找匹配的特定模式的行，并在这些行上进行你想要的操作。如果没有指定处理动作，则把匹配的行显示到标准输出(屏幕)，如果没有指定模式，则所有被操作所指定的行都被处理。

   - awk [options] 'script' var=value file(s)
   - awk [options] -f scriptfile var=value file(s)
     - awk脚本是由模式和操作组成的：pattern {action} 

