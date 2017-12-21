### merlin科学上网插件 for AM382 4.1.27内核 非ROG皮肤版本
***
##### 此项目仅用于merlin koolshare ARM架构，AM382代码，内核为4.1.27且为非ROG皮肤的改版固件</b><br/>
- **shadowsocks/ss**：该文件夹用于存放shadowsocks相关脚本和规则文件：
- **shadowsocks/webs**：该文件夹用于存放shadowsocks的网页。
- **shadowsocks/res**：该文件夹用于存放科学上网插件相关的网页元素，如js，css等。
- **shadowsocks/bin**：该文件夹用于存放shadowsocks的二进制文件。
- **shadowsocks/scripts**：该文件夹用于存放web调用的脚本文件。
- **history**：存放插件历史安装包，需要回滚历史版本的，可以下载对应版本，然后手动安装。
- **version**：在线版本号和shadowsocks.tar.gz的md5校验值，用于判断更新。
- **shadowsocks.tar.gz**：shadowsocks文件夹的打包，插件最新版本的包，插件内置的在线更新访问此文件的[链接 ](https://raw.githubusercontent.com/koolshare/koolshare.github.io/master/shadowsocks/shadowsocks.tar.gz) 获取安装包更新。

#### 插件手动更新（最新版）：
```bash
cd /tmp
wget --no-check-certificate https://raw.githubusercontent.com/koolshare/rogsoft/master/shadowsocks/shadowsocks.tar.gz
tar -zxvf /tmp/shadowsocks.tar.gz
sh /tmp/shadowsocks/install.sh
```

#### 插件手动更新（历史版本，1.0.0为例）： 

```bash
cd /tmp
wget --no-check-certificate https://raw.githubusercontent.com/koolshare/rogsoft/master/shadowsocks/history/shadowsocks_1.0.0.tar.gz
tar -zxvf /tmp/shadowsocks.tar.gz
sh /tmp/shadowsocks/install.sh
```

<b>怎样提交修改</b>
###### 需要再次说明的是，ss的在线更新是通过请求shadowsocks.tar.gz文件进行的，如果你有发现bug，并希望提交你的更改，需要做以下几点：<br/>
1. 发现bug，修改需要修改的文件；<br/>
2. 更新shadowsocks/ss/version，更新版本号；<br/>
3. 修改Changelog.txt文件，添加更新日志；<br/>
4. 运行build.sh文件，这样会自动打包shadowsocks文件夹，并且更新version内的版本号和md5值，同时会把就版本丢进history中；<br/>
5. 运行git status，查看被修改的文件，然后添加，评论，提交；<br/>
