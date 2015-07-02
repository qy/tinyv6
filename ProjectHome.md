This project include two parts:
  * TinyV6, An IPv6/6LoWPAN implementation for TinyOS 2.x.
  * CC2530 port for TinyOS 2.x.

has some features that official blip not have:
  * Small footprint: RAM < 8KB.
  * Support IRIS/CC2530, which are not supported by Blip.

This project is organized and maintained by Northwestern Polytechnical University, School of Computer Science.

---


本项目包含以下两个部分：
  * TinyV6: 适用于TinyOS 2.x的IPv6/6LoWPAN实现。
    1. 支持ICMPv6协议，地址自动配置和邻居发现协议
    1. 支持UDP/TCP协议
    1. 提供类似于Socket的编程接口。
  * CC2530的TinyOS移植
    1. 定时器系统的的完整移植
    1. 射频协议栈的完整移植
    1. 串口协议栈的完整移植。
    1. ADC的部分移植

特点：
  * 普通节点的RAM占用小于8K
  * IRIS/CC2530平台已经测试可用，其它平台理论上皆可使用。

本项目由西北工业大学计算机学院发起并维护。