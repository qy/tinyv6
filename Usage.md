# 编译环境配置 #
  * tinyv6的编译环境配置与TinyOS 2.x基本相同，支持linux和windows/Cygwin。
  * 请先按照[官方文档](http://docs.tinyos.net/tinywiki/index.php/Getting_started)安装TinyOS,包括nesc,tinyos-tools以及你所用平台的gcc编译工具链(如avr-gcc,msp430-gcc等)。另外，别忘了Perl和Python是必须装的。
  * 对于cc2530，由于目前尚无支持CC2530的gcc，故不需安装gcc工具链，tinyv6最终只生成一个可用于IAR编译的C文件app-iar.c。

在Downloads中下载tinyv6-allinone-x.x.tar.bz2源码包，用以下命令解压缩：
```
tar xvf tinyv6-allinone-x.x.tar.bz2
```

进入源码包目录：
```
cd tinyv6-allinone-x.x
```

执行脚本自动设置环境变量：
```
source tinyv6.sh
```

## 对于CC2530 ##
设置完环境变量后，可进编译任意TinyOS程序。以Blink为例:
```
cd $TOSROOT/apps/Blink
make cc2530
```

编译成功后在build/cc2530/目录下得到app-iar.c文件，需要使用IAR编译。
在IAR中新建工程，并在工程属性中作如下设置：
  * "General options->device"选为cc2530
  * "General options->Calling convetion"设为"XDATA stack reentrant"
  * "General options->Stack/Heap->XDATA" 设为0x400。
  * "C/C++ compiler->optimizations"中将level设为High

设置完成后，将app-iar.c该文件加入到工程中，并编译烧写。


---


# Tinyv6 configuration #
## 编译tinyv6测试程序UdpEchoServer ##

### 设置路由表及邻居发现代理 ###
创建/etc/ppp/ipv6-up.d/01-tos-ppp-up.sh，内容如下：
```
NODE_ID_RANGE="1 10"
for i in $(seq $NODE_ID_RANGE)
do
	IP6ADDR=2001:250:1004:5020:22:ff:fe00:$(printf "%x" $i)
	ip -6 r a $IP6ADDR via fe80::23 dev ppp0
	ip -6 neigh add proxy $IP6ADDR dev eth0
done
```

创建/etc/ppp/ipv6-down.d/01-tos-ppp-down.sh，内容如下：
```
NODE_ID_RANGE="1 10"
for i in $(seq $NODE_ID_RANGE)
do
	IP6ADDR=2001:250:1004:5020:22:ff:fe00:$(printf "%x" $i)
	ip -6 r d $IP6ADDR via fe80::23 dev ppp0
	ip -6 neigh del proxy $IP6ADDR dev enp1s0
done
```

**NOTE: You should modify 2001:250:1004:5020 to your own <global prefix>**

**NOTE2: Maybe you should modify NODE\_ID\_RANGE**

### 连接方式 ###
```
+---------+
|  Linux  | Linux PC
|   PC    | Connect root mote with $ pppd debug passive noauth nodetach 57600 /dev/ttyUSB1 nocdtrcts lcp-echo-interval 0 noccp noip ipv6 ::23,::24
+---------+ Test connection: $ ping6 2001:250:1004:5020:22:ff:fe00:2
    //      Connect mote2 with netcat6: $ nc6 -u 2001:250:1004:5020:22:ff:fe00:2 6666
 |======|
    |       Serial connection with PPP
+--------+  
| mote 1 |  Root mote.
+--------+  with $ make -f Makefile.root <platform>
    .       IP: 2001:250:1004:5020:22:22:ff:fe00:1
    .
+--------+  
| mote 2 |  Sensor mote.
+--------+  with $ make <platform>
            IP: 2001:250:1004:5020:22:22:ff:fe00:2

NOTE: You should modify 2001:250:1004:5020 to your own <global prefix>
```

### 编译UdpEchoServer普通节点程序 ###

```
cd apps/UdpEchoServer
make cc2530
make cc2530 install <一系列烧写参数>
```

### 编译UdpEchoServer根节点 ###

```
cd apps/UdpEchoServer
make -f Makefile.root cc2530
make cc2530 install <一系列烧写参数>
```



---


# Configuration #
  * tinyv6's compile environment is similar with TinyOS 2.x，support linux, windows/Cygwin。
  * Please refer to [Official Docs](http://docs.tinyos.net/tinywiki/index.php/Getting_started) to install TinyOS,including nesc,tinyos-tools and gcc toolchain for your chip(e.g. avr-gcc,msp430-gcc等)。Oh, don't forget Perl and Python, they are mandatory。
  * For cc2530，as there is no gcc for 8051, so no gcc for CC2530. tinyv6 only generates a IAR compilable C file with the name 'app-iar.c'。

Downloads tinyv6-allinone-x.x.tar.bz2，extracts it with：
```
tar xvf tinyv6-allinone-x.x.tar.bz2
```

then：
```
cd tinyv6-allinone-x.x
```

sets the environment variables：
```
source tinyv6.sh
```

## For CC2530 ##
If evironment variables are set，you can compile most of TinyOS programs。Take Blink for example:
```
cd $TOSROOT/apps/Blink
make cc2530
```

If success, you'll get  app-iar.c under build/cc2530/，this file should compile with IAR
Create a new project in IAR，with the following setting in project properties：
  * "General options->device" select cc2530
  * "General options->Calling convetion" set to "XDATA stack reentrant"
  * "General options->Stack/Heap->XDATA" set to 0x400
  * "C/C++ compiler->optimizations" set level to High

Add app-iar.c to this project then compile.

# tinyv6 test program: UdpEchoServer #
build UdpEchoServer：

```
cd apps/UdpEchoServer
make cc2530
make cc2530 install <burn parameters>
```