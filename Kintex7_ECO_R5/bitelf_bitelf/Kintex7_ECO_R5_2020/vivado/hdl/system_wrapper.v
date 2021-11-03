//Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2017.1 (lin64) Build 1846317 Fri Apr 14 18:54:47 MDT 2017
//Date        : Tue Apr 18 23:06:58 2017
//Host        : xcoapps55 running 64-bit Red Hat Enterprise Linux Workstation release 6.5 (Santiago)
//Command     : generate_target multiboot_USp_wrapper.bd
//Design      : multiboot_USp_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module system_wrapper
   (sys_clk,
    GPIO_DIPSW0,
    GPIO_DIPSW1,
    GPIO_DIPSW2,
    GPIO_DIPSW3,
//    gpio_rtl_0_tri_o,
//    gpio_rtl_tri_i,
    GPIO_LED0,
    GPIO_LED1,
    GPIO_LED2,
    GPIO_LED3,
    GPIO_LED4,
    GPIO_LED5,
    GPIO_LED6,
    GPIO_LED7 , 
    reset_n,
    RX,
    TX);
  input sys_clk;
  //output [7:0]dip_switches_4bits_0_tri_o;
 // input [3:0]dip_switches_4bits_tri_i;
  input reset_n;
  input RX;
  output TX;

  wire default_sysclk1_300_clk_n;
  wire default_sysclk1_300_clk_p;
  //wire [7:0]dip_switches_4bits_0_tri_o;
  output GPIO_LED0;
  output GPIO_LED1;
  output GPIO_LED2;
  output GPIO_LED3;
  output GPIO_LED4;
  output GPIO_LED5;
  output GPIO_LED6;
  output GPIO_LED7;

  //wire [3:0]dip_switches_4bits_tri_i;
  input GPIO_DIPSW0;
  input GPIO_DIPSW1;
  input GPIO_DIPSW2;
  input GPIO_DIPSW3;
  
  wire [7:0]gpio_rtl_0_tri_o;
  wire [3:0]gpio_rtl_tri_i;
  wire RX;
  wire TX;
  
  assign gpio_rtl_tri_i[0] = GPIO_DIPSW0;
  assign gpio_rtl_tri_i[1] = GPIO_DIPSW1;
  assign gpio_rtl_tri_i[2] = GPIO_DIPSW2;
  assign gpio_rtl_tri_i[3] = GPIO_DIPSW3;
  
  assign GPIO_LED0 = gpio_rtl_0_tri_o[0];
  assign GPIO_LED1 = gpio_rtl_0_tri_o[1];
  assign GPIO_LED2 = gpio_rtl_0_tri_o[2];
  assign GPIO_LED3 = gpio_rtl_0_tri_o[3];
  assign GPIO_LED4 = gpio_rtl_0_tri_o[4];
  assign GPIO_LED5 = gpio_rtl_0_tri_o[5];
  assign GPIO_LED6 = gpio_rtl_0_tri_o[6];
  assign GPIO_LED7 = gpio_rtl_0_tri_o[7];

  system system_i
       (.sys_clk(sys_clk),
        .dip_switches_4bits_0_tri_o(gpio_rtl_0_tri_o),
        .dip_switches_4bits_tri_i(gpio_rtl_tri_i),
        .reset_n(reset_n),
        .sin(RX),
        .sout(TX));
endmodule
