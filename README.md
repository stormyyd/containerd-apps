# Containerd Apps

本仓库用于存放个人使用的一些放在Docker中运行的GUI App（目前是这样）的Dockerfile。

目前存放了以下App的Dockerfile：

- 百度网盘
- 115

## Why?

因为我自己有一台Linux服务器，有时需要在上面执行一些下载任务，主要下载来源为百度网盘和115。该服务器并未安装GUI，我也不想安装GUI，但是百度网盘和115并未提供官方的CLI客户端，仅仅提供了GUI版（先不谈原来压根就没有Linux版这回事），所以之前我的方案是在服务器上跑一个VirtualBox，在虚拟机中安装一个Windows 10，同时在里面安装并运行这些软件的Windows版，通过共享文件夹的方式来将文件下载到服务器上。该方案存在的最大的一个问题就是VirutalBox的IO性能似乎比较差，下载速度不太理想（不排除是因为这俩软件写得太烂的原因，点名批评百度网盘，同样的网络环境和运行环境，115能跑到15MB/s，百度只能跑到3MB/s），并且虚拟机跑起来的时候服务器CPU和内存资源都近乎被占满了，让我感到很不爽。

偶然间看到百度网盘和115都推出了Linux版客户端，那么在本机运行肯定能在很大程度上缓解资源占用和IO性能差的问题，那么现在唯一的问题就是如何在我并不想在服务器上安装GUI的情况下运行这两个GUI程序，同时最好能将这两个App隔离在沙箱中（众所周知，这些软件似乎并不老实，将他们困在chroot jail中是再好不过的事情了）。

搜索一番后发现，有人已经构建了在Docker中运行GUI程序，并且通过VNC协议对外提供访问接口的镜像（[jlesage/docker-baseimage-gui](https://github.com/jlesage/docker-baseimage-gui)），基于此就可以实现我要做的一切了。

## 使用

一些参数的解释：

| 参数名 | 解释 | 示例 |
| ---- | --  | --  | 
| VNC_WEB_INTERFACE_PORT | 通过网页访问GUI服务的端口 | 5800 |
| VNC_PROTOCOL_PORT | VNC协议端口 | 5900 |
| YOURS_USER_ID | 你的UID，可以通过`id -u username`获取，会影响下载的文件的owner | 1000 |
| YOURS_GROUP_ID | 你的GID，可以通过`id -g username`获取，会影响下载的文件的owner | 1000 |
| TIMEZONE | 时区设置 | Asia/Shanghai |
| DOWNLOAD_DIR_HOST | 本机存放下载文件的文件夹 | /mnt/sda114514/Downloads |
| DOWNLOAD_DIR_CONTAINER | 容器中下载文件存放的文件夹，用于与本机文件夹建立映射关系 | /mnt/Downloads |
| CONFIG_DIR | 设置文件在本机的存放的文件夹 | /mnt/sdb1919810/config |
| CONTAINER_NAME | 容器名，方便之后找 | baidunetdisk |

容器跑起来以后，记得进App设置中，把下载路径修改到DOWNLOAD_DIR_CONTAINER，不然文件就会被下到Docker卷中去惹。

### 百度网盘

```shell
docker pull stormyyd/baidunetdisk  # 拉取镜像，当然你也可以自己build
docker run \
  -p {VNC_WEB_INTERFACE_PORT}:5800 \
  -p {VNC_PROTOCOL_PORT}:5900 \
  -e USER_ID={YOURS_USER_ID} \
  -e GROUP_ID={YOURS_GROUP_ID} \
  -e TZ={TIMEZONE} \
  -v {DOWNLOAD_DIR_HOST}:{DOWNLOAD_DIR_CONTAINER} \
  -v {CONFIG_DIR}:/config \
  --name {CONTAINER_NAME} \
  -d stormyyd/baidunetdisk # 运行容器
```

### 115

```shell
docker pull stormyyd/115  # 拉取镜像，当然你也可以自己build
docker run \
  -p {VNC_WEB_INTERFACE_PORT}:5800 \
  -p {VNC_PROTOCOL_PORT}:5900 \
  -e USER_ID={YOURS_USER_ID} \
  -e GROUP_ID={YOURS_GROUP_ID} \
  -e TZ={TIMEZONE} \
  -v {DOWNLOAD_DIR_HOST}:{DOWNLOAD_DIR_CONTAINER} \
  -v {CONFIG_DIR}:/config \
  --name {CONTAINER_NAME} \
  -d stormyyd/115 # 运行容器
```

## 补充说明

### 百度网盘

百度网盘是最费事的，按照deb包中声明的依赖安装完所有依赖后，无法启动，报缺东西，然后只能修改Dockerfile，加上缺失的依赖后重新编译，弄好以后又缺东西，又只能再来一次。就这么反反复复搞了好几次以后，终于把依赖装全了，对比115，什么都不依赖，装好就能用，只能说是令人感叹了。

此外百度网盘在该环境下运行有一个BUG，设置窗口关不掉，不知道在正经安装GUI的环境下是否有这个问题，但是也好说，设置这种东西，反正动一次就好，调好了重开一下容器好了。

### 115

115除了下载速度非常非常慢以外，一切都还不错。看起来单个任务似乎被限到了3MB/s这样的速度，拉满5个任务跑起来速度就还勉强能看，并且下载完成后，还会花很长时间去合并文件区块和校验。总之用115就是别急。
