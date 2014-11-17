// Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2014.3.1 (lin64) Build 1056140 Thu Oct 30 16:30:39 MDT 2014
// Date        : Sun Nov 16 13:59:40 2014
// Host        : bunker running 64-bit Ubuntu 14.04.1 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/immesys/w/FPGA/edxcel/partproject/partproject.srcs/sources_1/ip/mult19/mult19_stub.v
// Design      : mult19
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "mult_gen_v12_0,Vivado 2014.3.1" *)
module mult19(CLK, A, P)
/* synthesis syn_black_box black_box_pad_pin="CLK,A[31:0],P[31:0]" */;
  input CLK;
  input [31:0]A;
  output [31:0]P;
endmodule
