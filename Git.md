#### Git

1. 创建git文件夹

   git init


2. 查看状态

   git status

   git diff 

   git log	git reflog 版本

   git branch 分支

   git tag 标签

   git remoter 远程信息

3. 提交

   git add 添加到缓存去

   git commit -m ""  提交修改

4. 版本控制

   git reset --hard HEAD^ 回退到上一版本

   git reset --hard 版本号	回退到特定版本

5. 撤销修改

   git checkout -- file尚未add（即还原工作区修改）

   git reset HEAD file => git checkout -- file已经add（即还原缓存区修改）

   git reset --hard HEAD^已经commit（即版本回退）

6. 分支

   git branch dev	创建

   git checkout dev   切换

   git merge dev	合并

7. 标签

   git tag -a v0.1 -m "version 0.1 released" 3628164 创建标签

8. 远程

   git remote add origin git@github.com:michaelliao/learngit.git

   git push (-u) origin master

   git pull origin master 同步远程到本地

   git pull 当push失败，远程分支比你的本地更新

   git branch --set-upstream branch-name origin/branch-name 本地与远程分支关联

   git clone git@github.com:michaelliao/gitskills.git

   ​