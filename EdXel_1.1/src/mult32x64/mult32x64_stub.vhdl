-- Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2014.3.1 (lin64) Build 1056140 Thu Oct 30 16:30:39 MDT 2014
-- Date        : Sun Nov 16 21:40:18 2014
-- Host        : bunker running 64-bit Ubuntu 14.04.1 LTS
-- Command     : write_vhdl -force -mode synth_stub /home/immesys/w/FPGA/edxcel/EdXel_1.1/src/mult32x64/mult32x64_stub.vhdl
-- Design      : mult32x64
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mult32x64 is
  Port ( 
    CLK : in STD_LOGIC;
    A : in STD_LOGIC_VECTOR ( 31 downto 0 );
    B : in STD_LOGIC_VECTOR ( 63 downto 0 );
    P : out STD_LOGIC_VECTOR ( 63 downto 0 )
  );

end mult32x64;

architecture stub of mult32x64 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "CLK,A[31:0],B[63:0],P[63:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "mult_gen_v12_0,Vivado 2014.3.1";
begin
end;
