从 KCU116 移植例子到 Kintex7_ECO_R5
tips: 

1.  一定要注释掉
    set_property BITSTREAM.CONFIG.SPI_32BIT_ADDR YES [current_design]
    否则不正常，只能启动golden镜像。

2.  串口波特率是 9600

3.  原来的拨码开关，现在板子分配到 KEY2 和 KEY5, 复位按钮为 KEY1
