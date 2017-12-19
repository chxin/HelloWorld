#### 1. Shell错误检测

- set-x，之后的每一条命令以及加载命令行中的任何参数都会显示出来
- echo和print命令，检查值的正确性和逻辑正确性，但是每次修改都要删除这些命令
- 设置调试变量$debug，根据调试层次控制输出test $debug -gt 0 && echo "the answer is $var"
- 函数alert检查$?的值
- 手动单步执行

#### 2. 库文件

- `#!/bin/echo` 该库的脚本不能像常规脚本那样执行，而是以source命令的方式在当前shell中执行
- 调用库：source std_lib 或者 . std_lib