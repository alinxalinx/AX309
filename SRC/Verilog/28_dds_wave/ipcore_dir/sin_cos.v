////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.20131013
//  \   \         Application: netgen
//  /   /         Filename: sin_cos.v
// /___/   /\     Timestamp: Fri Jul 31 14:13:25 2015
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -w -sim -ofmt verilog E:/Project/AX545/verilog/dds_wave/ipcore_dir/tmp/_cg/sin_cos.ngc E:/Project/AX545/verilog/dds_wave/ipcore_dir/tmp/_cg/sin_cos.v 
// Device	: 6slx45csg324-3
// Input file	: E:/Project/AX545/verilog/dds_wave/ipcore_dir/tmp/_cg/sin_cos.ngc
// Output file	: E:/Project/AX545/verilog/dds_wave/ipcore_dir/tmp/_cg/sin_cos.v
// # of Modules	: 1
// Design Name	: sin_cos
// Xilinx        : C:\Xilinx\14.7\ISE_DS\ISE\
//             
// Purpose:    
//     This verilog netlist is a verification model and uses simulation 
//     primitives which may not represent the true implementation of the 
//     device, however the netlist is functionally correct and should not 
//     be modified. This file cannot be synthesized and should only be used 
//     with supported simulation tools.
//             
// Reference:  
//     Command Line Tools User Guide, Chapter 23 and Synthesis and Simulation Design Guide, Chapter 6
//             
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ps

module sin_cos (
  clk, we, data, cosine, sine, phase_out
)/* synthesis syn_black_box syn_noprune=1 */;
  input clk;
  input we;
  input [28 : 0] data;
  output [7 : 0] cosine;
  output [7 : 0] sine;
  output [28 : 0] phase_out;
  
  // synthesis translate_off
  
  wire sig00000001;
  wire sig00000002;
  wire sig00000003;
  wire sig00000004;
  wire sig00000005;
  wire sig00000006;
  wire sig00000007;
  wire sig00000008;
  wire sig00000009;
  wire sig0000000a;
  wire sig0000000b;
  wire sig0000000c;
  wire sig0000000d;
  wire sig0000000e;
  wire sig0000000f;
  wire sig00000010;
  wire sig00000011;
  wire sig00000012;
  wire sig00000013;
  wire sig00000014;
  wire sig00000015;
  wire sig00000016;
  wire sig00000017;
  wire sig00000018;
  wire sig00000019;
  wire sig0000001a;
  wire sig0000001b;
  wire sig0000001c;
  wire sig0000001d;
  wire sig0000001e;
  wire sig0000001f;
  wire sig00000020;
  wire sig00000021;
  wire sig00000022;
  wire sig00000023;
  wire sig00000024;
  wire sig00000025;
  wire sig00000026;
  wire sig00000027;
  wire sig00000028;
  wire sig00000029;
  wire sig0000002a;
  wire sig0000002b;
  wire sig0000002c;
  wire sig0000002d;
  wire sig0000002e;
  wire sig0000002f;
  wire sig00000030;
  wire sig00000031;
  wire sig00000032;
  wire sig00000033;
  wire sig00000034;
  wire sig00000035;
  wire sig00000036;
  wire sig00000037;
  wire sig00000038;
  wire sig00000039;
  wire sig0000003a;
  wire sig0000003b;
  wire sig0000003c;
  wire sig0000003d;
  wire sig0000003e;
  wire sig0000003f;
  wire sig00000040;
  wire sig00000041;
  wire sig00000042;
  wire sig00000043;
  wire sig00000044;
  wire sig00000045;
  wire sig00000046;
  wire sig00000047;
  wire sig00000048;
  wire sig00000049;
  wire sig0000004a;
  wire sig0000004b;
  wire sig0000004c;
  wire sig0000004d;
  wire sig0000004e;
  wire sig0000004f;
  wire sig00000050;
  wire sig00000051;
  wire sig00000052;
  wire sig00000053;
  wire sig00000054;
  wire sig00000055;
  wire sig00000056;
  wire sig00000057;
  wire sig00000058;
  wire sig00000059;
  wire sig0000005a;
  wire sig0000005b;
  wire sig0000005c;
  wire sig0000005d;
  wire sig0000005e;
  wire sig0000005f;
  wire sig00000060;
  wire sig00000061;
  wire sig00000062;
  wire sig00000063;
  wire sig00000064;
  wire sig00000065;
  wire sig00000066;
  wire sig00000067;
  wire sig00000068;
  wire sig00000069;
  wire sig0000006a;
  wire sig0000006b;
  wire sig0000006c;
  wire sig0000006d;
  wire sig0000006e;
  wire sig0000006f;
  wire sig00000070;
  wire sig00000071;
  wire sig00000072;
  wire sig00000073;
  wire sig00000074;
  wire sig00000075;
  wire sig00000076;
  wire sig00000077;
  wire sig00000078;
  wire \blk0000003e/sig00000109 ;
  wire \blk0000003e/sig00000108 ;
  wire \blk0000003e/sig00000107 ;
  wire \blk0000003e/sig00000106 ;
  wire \blk0000003e/sig00000105 ;
  wire \blk0000003e/sig00000104 ;
  wire \blk0000003e/sig00000103 ;
  wire \blk0000003e/sig00000102 ;
  wire \blk0000003e/sig00000101 ;
  wire \blk0000003e/sig00000100 ;
  wire \blk0000003e/sig000000ff ;
  wire \blk0000003e/sig000000fe ;
  wire \blk0000003e/sig000000fd ;
  wire \blk0000003e/sig000000fc ;
  wire \blk0000003e/sig000000fb ;
  wire \blk0000003e/sig000000fa ;
  wire \blk0000003e/sig000000f9 ;
  wire \blk0000003e/sig000000f8 ;
  wire \blk0000003e/sig000000f7 ;
  wire \blk0000003e/sig000000f6 ;
  wire \blk0000003e/sig000000f5 ;
  wire \blk0000003e/sig000000f4 ;
  wire \blk0000003e/sig000000f3 ;
  wire \blk0000003e/sig000000f2 ;
  wire \blk0000003e/sig000000f1 ;
  wire \blk0000003e/sig000000f0 ;
  wire \blk0000003e/sig000000ef ;
  wire \blk0000003e/sig000000ee ;
  wire \blk0000003e/sig000000ed ;
  wire \blk0000003e/sig000000ec ;
  wire \blk0000003e/sig000000eb ;
  wire \blk0000003e/sig000000ea ;
  wire \blk0000003e/sig000000e9 ;
  wire \blk0000003e/sig000000e8 ;
  wire \blk0000003e/sig000000e7 ;
  wire \blk0000003e/sig000000e6 ;
  wire \blk0000003e/sig000000e5 ;
  wire \blk0000003e/sig000000e4 ;
  wire \blk0000003e/sig000000e3 ;
  wire \blk0000003e/sig000000e2 ;
  wire \blk0000003e/sig000000e1 ;
  wire \blk0000003e/sig000000e0 ;
  wire \blk0000003e/sig000000df ;
  wire \blk0000003e/sig000000de ;
  wire \blk0000003e/sig000000dd ;
  wire \blk0000003e/sig000000dc ;
  wire \blk0000003e/sig000000db ;
  wire \blk0000003e/sig000000da ;
  wire \blk0000003e/sig000000d9 ;
  wire \blk0000003e/sig000000d8 ;
  wire \blk0000003e/sig000000d7 ;
  wire \blk0000003e/sig000000d6 ;
  wire \blk0000003e/sig000000d5 ;
  wire \blk0000003e/sig000000d4 ;
  wire \blk0000003e/sig000000d3 ;
  wire \blk0000003e/sig000000d2 ;
  wire \blk0000003e/sig000000d1 ;
  wire \blk0000003e/sig000000d0 ;
  wire \NLW_blk000000d1_DOADO<15>_UNCONNECTED ;
  wire \NLW_blk000000d1_DOADO<14>_UNCONNECTED ;
  wire \NLW_blk000000d1_DOADO<13>_UNCONNECTED ;
  wire \NLW_blk000000d1_DOADO<12>_UNCONNECTED ;
  wire \NLW_blk000000d1_DOADO<11>_UNCONNECTED ;
  wire \NLW_blk000000d1_DOADO<10>_UNCONNECTED ;
  wire \NLW_blk000000d1_DOADO<9>_UNCONNECTED ;
  wire \NLW_blk000000d1_DOADO<8>_UNCONNECTED ;
  wire \NLW_blk000000d1_DOPADOP<1>_UNCONNECTED ;
  wire \NLW_blk000000d1_DOPADOP<0>_UNCONNECTED ;
  wire \NLW_blk000000d1_DOPBDOP<1>_UNCONNECTED ;
  wire \NLW_blk000000d1_DOPBDOP<0>_UNCONNECTED ;
  wire \NLW_blk000000d1_ADDRAWRADDR<2>_UNCONNECTED ;
  wire \NLW_blk000000d1_ADDRAWRADDR<1>_UNCONNECTED ;
  wire \NLW_blk000000d1_ADDRAWRADDR<0>_UNCONNECTED ;
  wire \NLW_blk000000d1_DIPBDIP<1>_UNCONNECTED ;
  wire \NLW_blk000000d1_DIPBDIP<0>_UNCONNECTED ;
  wire \NLW_blk000000d1_DIBDI<15>_UNCONNECTED ;
  wire \NLW_blk000000d1_DIBDI<14>_UNCONNECTED ;
  wire \NLW_blk000000d1_DIBDI<13>_UNCONNECTED ;
  wire \NLW_blk000000d1_DIBDI<12>_UNCONNECTED ;
  wire \NLW_blk000000d1_DIBDI<11>_UNCONNECTED ;
  wire \NLW_blk000000d1_DIBDI<10>_UNCONNECTED ;
  wire \NLW_blk000000d1_DIBDI<9>_UNCONNECTED ;
  wire \NLW_blk000000d1_DIBDI<8>_UNCONNECTED ;
  wire \NLW_blk000000d1_DIBDI<7>_UNCONNECTED ;
  wire \NLW_blk000000d1_DIBDI<6>_UNCONNECTED ;
  wire \NLW_blk000000d1_DIBDI<5>_UNCONNECTED ;
  wire \NLW_blk000000d1_DIBDI<4>_UNCONNECTED ;
  wire \NLW_blk000000d1_DIBDI<3>_UNCONNECTED ;
  wire \NLW_blk000000d1_DIBDI<2>_UNCONNECTED ;
  wire \NLW_blk000000d1_DIBDI<1>_UNCONNECTED ;
  wire \NLW_blk000000d1_DIBDI<0>_UNCONNECTED ;
  wire \NLW_blk000000d1_DIADI<15>_UNCONNECTED ;
  wire \NLW_blk000000d1_DIADI<14>_UNCONNECTED ;
  wire \NLW_blk000000d1_DIADI<13>_UNCONNECTED ;
  wire \NLW_blk000000d1_DIADI<12>_UNCONNECTED ;
  wire \NLW_blk000000d1_DIADI<11>_UNCONNECTED ;
  wire \NLW_blk000000d1_DIADI<10>_UNCONNECTED ;
  wire \NLW_blk000000d1_DIADI<9>_UNCONNECTED ;
  wire \NLW_blk000000d1_DIADI<8>_UNCONNECTED ;
  wire \NLW_blk000000d1_ADDRBRDADDR<2>_UNCONNECTED ;
  wire \NLW_blk000000d1_ADDRBRDADDR<1>_UNCONNECTED ;
  wire \NLW_blk000000d1_ADDRBRDADDR<0>_UNCONNECTED ;
  wire \NLW_blk000000d1_DOBDO<15>_UNCONNECTED ;
  wire \NLW_blk000000d1_DOBDO<14>_UNCONNECTED ;
  wire \NLW_blk000000d1_DOBDO<13>_UNCONNECTED ;
  wire \NLW_blk000000d1_DOBDO<12>_UNCONNECTED ;
  wire \NLW_blk000000d1_DOBDO<11>_UNCONNECTED ;
  wire \NLW_blk000000d1_DOBDO<10>_UNCONNECTED ;
  wire \NLW_blk000000d1_DOBDO<9>_UNCONNECTED ;
  wire \NLW_blk000000d1_DOBDO<8>_UNCONNECTED ;
  wire \NLW_blk000000d1_DIPADIP<1>_UNCONNECTED ;
  wire [28 : 0] \U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 ;
  assign
    phase_out[28] = \U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [28],
    phase_out[27] = \U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [27],
    phase_out[26] = \U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [26],
    phase_out[25] = \U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [25],
    phase_out[24] = \U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [24],
    phase_out[23] = \U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [23],
    phase_out[22] = \U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [22],
    phase_out[21] = \U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [21],
    phase_out[20] = \U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [20],
    phase_out[19] = \U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [19],
    phase_out[18] = \U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [18],
    phase_out[17] = \U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [17],
    phase_out[16] = \U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [16],
    phase_out[15] = \U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [15],
    phase_out[14] = \U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [14],
    phase_out[13] = \U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [13],
    phase_out[12] = \U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [12],
    phase_out[11] = \U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [11],
    phase_out[10] = \U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [10],
    phase_out[9] = \U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [9],
    phase_out[8] = \U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [8],
    phase_out[7] = \U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [7],
    phase_out[6] = \U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [6],
    phase_out[5] = \U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [5],
    phase_out[4] = \U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [4],
    phase_out[3] = \U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [3],
    phase_out[2] = \U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [2],
    phase_out[1] = \U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [1],
    phase_out[0] = \U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [0];
  VCC   blk00000001 (
    .P(sig00000001)
  );
  GND   blk00000002 (
    .G(sig00000002)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000003 (
    .C(clk),
    .CE(we),
    .D(data[28]),
    .Q(sig0000000b)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000004 (
    .C(clk),
    .CE(we),
    .D(data[27]),
    .Q(sig0000000c)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000005 (
    .C(clk),
    .CE(we),
    .D(data[26]),
    .Q(sig0000000d)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000006 (
    .C(clk),
    .CE(we),
    .D(data[25]),
    .Q(sig0000000e)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000007 (
    .C(clk),
    .CE(we),
    .D(data[24]),
    .Q(sig0000000f)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000008 (
    .C(clk),
    .CE(we),
    .D(data[23]),
    .Q(sig00000010)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000009 (
    .C(clk),
    .CE(we),
    .D(data[22]),
    .Q(sig00000011)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000000a (
    .C(clk),
    .CE(we),
    .D(data[21]),
    .Q(sig00000012)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000000b (
    .C(clk),
    .CE(we),
    .D(data[20]),
    .Q(sig00000013)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000000c (
    .C(clk),
    .CE(we),
    .D(data[19]),
    .Q(sig00000014)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000000d (
    .C(clk),
    .CE(we),
    .D(data[18]),
    .Q(sig00000015)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000000e (
    .C(clk),
    .CE(we),
    .D(data[17]),
    .Q(sig00000016)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000000f (
    .C(clk),
    .CE(we),
    .D(data[16]),
    .Q(sig00000017)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000010 (
    .C(clk),
    .CE(we),
    .D(data[15]),
    .Q(sig00000018)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000011 (
    .C(clk),
    .CE(we),
    .D(data[14]),
    .Q(sig00000019)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000012 (
    .C(clk),
    .CE(we),
    .D(data[13]),
    .Q(sig0000001a)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000013 (
    .C(clk),
    .CE(we),
    .D(data[12]),
    .Q(sig0000001b)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000014 (
    .C(clk),
    .CE(we),
    .D(data[11]),
    .Q(sig0000001c)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000015 (
    .C(clk),
    .CE(we),
    .D(data[10]),
    .Q(sig0000001d)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000016 (
    .C(clk),
    .CE(we),
    .D(data[9]),
    .Q(sig0000001e)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000017 (
    .C(clk),
    .CE(we),
    .D(data[8]),
    .Q(sig0000001f)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000018 (
    .C(clk),
    .CE(we),
    .D(data[7]),
    .Q(sig00000020)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000019 (
    .C(clk),
    .CE(we),
    .D(data[6]),
    .Q(sig00000021)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000001a (
    .C(clk),
    .CE(we),
    .D(data[5]),
    .Q(sig00000022)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000001b (
    .C(clk),
    .CE(we),
    .D(data[4]),
    .Q(sig00000023)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000001c (
    .C(clk),
    .CE(we),
    .D(data[3]),
    .Q(sig00000024)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000001d (
    .C(clk),
    .CE(we),
    .D(data[2]),
    .Q(sig00000025)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000001e (
    .C(clk),
    .CE(we),
    .D(data[1]),
    .Q(sig00000026)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000001f (
    .C(clk),
    .CE(we),
    .D(data[0]),
    .Q(sig00000027)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000020 (
    .C(clk),
    .D(sig00000028),
    .Q(sig0000005b)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000021 (
    .C(clk),
    .D(sig00000029),
    .Q(sig00000003)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000022 (
    .C(clk),
    .D(sig0000002a),
    .Q(sig00000004)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000023 (
    .C(clk),
    .D(sig0000002b),
    .Q(sig00000005)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000024 (
    .C(clk),
    .D(sig0000002c),
    .Q(sig00000006)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000025 (
    .C(clk),
    .D(sig0000002d),
    .Q(sig00000007)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000026 (
    .C(clk),
    .D(sig0000002e),
    .Q(sig00000008)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000027 (
    .C(clk),
    .D(sig0000002f),
    .Q(sig00000009)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000028 (
    .C(clk),
    .D(sig00000030),
    .Q(sig0000000a)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000029 (
    .C(clk),
    .D(sig00000031),
    .Q(sig0000005a)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000002a (
    .C(clk),
    .D(sig00000032),
    .Q(sig00000059)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000002b (
    .C(clk),
    .D(sig00000033),
    .Q(sig00000058)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000002c (
    .C(clk),
    .D(sig00000034),
    .Q(sig00000057)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000002d (
    .C(clk),
    .D(sig00000035),
    .Q(sig00000056)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000002e (
    .C(clk),
    .D(sig00000036),
    .Q(sig00000055)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000002f (
    .C(clk),
    .D(sig00000037),
    .Q(sig00000054)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000030 (
    .C(clk),
    .D(sig00000038),
    .Q(sig00000053)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000031 (
    .C(clk),
    .D(sig00000039),
    .Q(sig00000052)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000032 (
    .C(clk),
    .D(sig0000003a),
    .Q(sig00000051)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000033 (
    .C(clk),
    .D(sig0000003b),
    .Q(sig00000050)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000034 (
    .C(clk),
    .D(sig0000003c),
    .Q(sig0000004f)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000035 (
    .C(clk),
    .D(sig0000003d),
    .Q(sig0000004e)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000036 (
    .C(clk),
    .D(sig0000003e),
    .Q(sig0000004d)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000037 (
    .C(clk),
    .D(sig0000003f),
    .Q(sig0000004c)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000038 (
    .C(clk),
    .D(sig00000040),
    .Q(sig0000004b)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000039 (
    .C(clk),
    .D(sig00000041),
    .Q(sig0000004a)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000003a (
    .C(clk),
    .D(sig00000042),
    .Q(sig00000049)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000003b (
    .C(clk),
    .D(sig00000043),
    .Q(sig00000048)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000003c (
    .C(clk),
    .D(sig00000044),
    .Q(sig00000047)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000003d (
    .C(clk),
    .D(sig00000045),
    .Q(sig00000046)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000097 (
    .C(clk),
    .D(sig00000078),
    .Q(\U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [28])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000098 (
    .C(clk),
    .D(sig00000077),
    .Q(\U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [27])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000099 (
    .C(clk),
    .D(sig00000076),
    .Q(\U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [26])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000009a (
    .C(clk),
    .D(sig00000075),
    .Q(\U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [25])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000009b (
    .C(clk),
    .D(sig00000074),
    .Q(\U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [24])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000009c (
    .C(clk),
    .D(sig00000073),
    .Q(\U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [23])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000009d (
    .C(clk),
    .D(sig00000072),
    .Q(\U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [22])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000009e (
    .C(clk),
    .D(sig00000071),
    .Q(\U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [21])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000009f (
    .C(clk),
    .D(sig00000070),
    .Q(\U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [20])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000a0 (
    .C(clk),
    .D(sig0000006f),
    .Q(\U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [19])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000a1 (
    .C(clk),
    .D(sig0000006e),
    .Q(\U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [18])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000a2 (
    .C(clk),
    .D(sig0000006d),
    .Q(\U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [17])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000a3 (
    .C(clk),
    .D(sig0000006c),
    .Q(\U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [16])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000a4 (
    .C(clk),
    .D(sig0000006b),
    .Q(\U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [15])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000a5 (
    .C(clk),
    .D(sig0000006a),
    .Q(\U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [14])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000a6 (
    .C(clk),
    .D(sig00000069),
    .Q(\U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [13])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000a7 (
    .C(clk),
    .D(sig00000068),
    .Q(\U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [12])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000a8 (
    .C(clk),
    .D(sig00000067),
    .Q(\U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [11])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000a9 (
    .C(clk),
    .D(sig00000066),
    .Q(\U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [10])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000aa (
    .C(clk),
    .D(sig00000065),
    .Q(\U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [9])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000ab (
    .C(clk),
    .D(sig00000064),
    .Q(\U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [8])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000ac (
    .C(clk),
    .D(sig00000063),
    .Q(\U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [7])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000ad (
    .C(clk),
    .D(sig00000062),
    .Q(\U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [6])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000ae (
    .C(clk),
    .D(sig00000061),
    .Q(\U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [5])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000af (
    .C(clk),
    .D(sig00000060),
    .Q(\U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [4])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000b0 (
    .C(clk),
    .D(sig0000005f),
    .Q(\U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [3])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000b1 (
    .C(clk),
    .D(sig0000005e),
    .Q(\U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [2])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000b2 (
    .C(clk),
    .D(sig0000005d),
    .Q(\U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [1])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000b3 (
    .C(clk),
    .D(sig0000005c),
    .Q(\U0/i_synth/i_phase_out.del/opt_has_pipe.pipe_2 [0])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000b4 (
    .C(clk),
    .D(sig00000003),
    .Q(sig00000078)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000b5 (
    .C(clk),
    .D(sig00000004),
    .Q(sig00000077)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000b6 (
    .C(clk),
    .D(sig00000005),
    .Q(sig00000076)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000b7 (
    .C(clk),
    .D(sig00000006),
    .Q(sig00000075)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000b8 (
    .C(clk),
    .D(sig00000007),
    .Q(sig00000074)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000b9 (
    .C(clk),
    .D(sig00000008),
    .Q(sig00000073)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000ba (
    .C(clk),
    .D(sig00000009),
    .Q(sig00000072)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000bb (
    .C(clk),
    .D(sig0000000a),
    .Q(sig00000071)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000bc (
    .C(clk),
    .D(sig0000005a),
    .Q(sig00000070)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000bd (
    .C(clk),
    .D(sig00000059),
    .Q(sig0000006f)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000be (
    .C(clk),
    .D(sig00000058),
    .Q(sig0000006e)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000bf (
    .C(clk),
    .D(sig00000057),
    .Q(sig0000006d)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000c0 (
    .C(clk),
    .D(sig00000056),
    .Q(sig0000006c)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000c1 (
    .C(clk),
    .D(sig00000055),
    .Q(sig0000006b)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000c2 (
    .C(clk),
    .D(sig00000054),
    .Q(sig0000006a)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000c3 (
    .C(clk),
    .D(sig00000053),
    .Q(sig00000069)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000c4 (
    .C(clk),
    .D(sig00000052),
    .Q(sig00000068)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000c5 (
    .C(clk),
    .D(sig00000051),
    .Q(sig00000067)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000c6 (
    .C(clk),
    .D(sig00000050),
    .Q(sig00000066)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000c7 (
    .C(clk),
    .D(sig0000004f),
    .Q(sig00000065)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000c8 (
    .C(clk),
    .D(sig0000004e),
    .Q(sig00000064)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000c9 (
    .C(clk),
    .D(sig0000004d),
    .Q(sig00000063)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000ca (
    .C(clk),
    .D(sig0000004c),
    .Q(sig00000062)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000cb (
    .C(clk),
    .D(sig0000004b),
    .Q(sig00000061)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000cc (
    .C(clk),
    .D(sig0000004a),
    .Q(sig00000060)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000cd (
    .C(clk),
    .D(sig00000049),
    .Q(sig0000005f)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000ce (
    .C(clk),
    .D(sig00000048),
    .Q(sig0000005e)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000cf (
    .C(clk),
    .D(sig00000047),
    .Q(sig0000005d)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000d0 (
    .C(clk),
    .D(sig00000046),
    .Q(sig0000005c)
  );
  RAMB8BWER #(
    .INIT_00 ( 256'h585653514F4C4A4745423F3D3A3734322F2C292623201D1A1714110E0B080502 ),
    .INIT_01 ( 256'h7E7E7E7E7D7D7C7C7B7B7A7978777675747371706E6D6B6A68666462605E5C5A ),
    .INIT_02 ( 256'h5A5C5E60626466686A6B6D6E7071737475767778797A7B7B7C7C7D7D7E7E7E7E ),
    .INIT_03 ( 256'h0205080B0E1114171A1D202326292C2F3234373A3D3F4245474A4C4F51535658 ),
    .INIT_04 ( 256'hA8AAADAFB1B4B6B9BBBEC1C3C6C9CCCED1D4D7DADDE0E3E6E9ECEFF2F5F8FBFE ),
    .INIT_05 ( 256'h82828282838384848585868788898A8B8C8D8F9092939596989A9C9EA0A2A4A6 ),
    .INIT_06 ( 256'hA6A4A2A09E9C9A9896959392908F8D8C8B8A8988878685858484838382828282 ),
    .INIT_07 ( 256'hFEFBF8F5F2EFECE9E6E3E0DDDAD7D4D1CECCC9C6C3C1BEBBB9B6B4B1AFADAAA8 ),
    .INIT_08 ( 256'h5A5C5E60626466686A6B6D6E7071737475767778797A7B7B7C7C7D7D7E7E7E7E ),
    .INIT_09 ( 256'h0205080B0E1114171A1D202326292C2F3234373A3D3F4245474A4C4F51535658 ),
    .INIT_0A ( 256'hA8AAADAFB1B4B6B9BBBEC1C3C6C9CCCED1D4D7DADDE0E3E6E9ECEFF2F5F8FBFE ),
    .INIT_0B ( 256'h82828282838384848585868788898A8B8C8D8F9092939596989A9C9EA0A2A4A6 ),
    .INIT_0C ( 256'hA6A4A2A09E9C9A9896959392908F8D8C8B8A8988878685858484838382828282 ),
    .INIT_0D ( 256'hFEFBF8F5F2EFECE9E6E3E0DDDAD7D4D1CECCC9C6C3C1BEBBB9B6B4B1AFADAAA8 ),
    .INIT_0E ( 256'h585653514F4C4A4745423F3D3A3734322F2C292623201D1A1714110E0B080502 ),
    .INIT_0F ( 256'h7E7E7E7E7D7D7C7C7B7B7A7978777675747371706E6D6B6A68666462605E5C5A ),
    .INIT_A ( 18'h00000 ),
    .INIT_B ( 18'h00000 ),
    .WRITE_MODE_A ( "WRITE_FIRST" ),
    .WRITE_MODE_B ( "WRITE_FIRST" ),
    .DATA_WIDTH_A ( 9 ),
    .DATA_WIDTH_B ( 9 ),
    .DOA_REG ( 1 ),
    .DOB_REG ( 1 ),
    .EN_RSTRAM_A ( "TRUE" ),
    .EN_RSTRAM_B ( "TRUE" ),
    .INITP_00 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_01 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_02 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_03 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_10 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_11 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_12 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_13 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_14 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_15 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_16 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_17 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_18 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_19 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_1A ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_1B ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_1C ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_1D ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_1E ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_1F ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .RAM_MODE ( "TDP" ),
    .RST_PRIORITY_A ( "CE" ),
    .RST_PRIORITY_B ( "CE" ),
    .RSTTYPE ( "SYNC" ),
    .SRVAL_A ( 18'h00000 ),
    .SRVAL_B ( 18'h00000 ),
    .INIT_FILE ( "NONE" ),
    .SIM_COLLISION_CHECK ( "ALL" ))
  blk000000d1 (
    .RSTBRST(sig00000002),
    .ENBRDEN(sig00000001),
    .REGCEA(sig00000001),
    .ENAWREN(sig00000001),
    .CLKAWRCLK(clk),
    .CLKBRDCLK(clk),
    .REGCEBREGCE(sig00000001),
    .RSTA(sig00000002),
    .WEAWEL({sig00000002, sig00000002}),
    .DOADO({\NLW_blk000000d1_DOADO<15>_UNCONNECTED , \NLW_blk000000d1_DOADO<14>_UNCONNECTED , \NLW_blk000000d1_DOADO<13>_UNCONNECTED , 
\NLW_blk000000d1_DOADO<12>_UNCONNECTED , \NLW_blk000000d1_DOADO<11>_UNCONNECTED , \NLW_blk000000d1_DOADO<10>_UNCONNECTED , 
\NLW_blk000000d1_DOADO<9>_UNCONNECTED , \NLW_blk000000d1_DOADO<8>_UNCONNECTED , sine[7], sine[6], sine[5], sine[4], sine[3], sine[2], sine[1], sine[0]
}),
    .DOPADOP({\NLW_blk000000d1_DOPADOP<1>_UNCONNECTED , \NLW_blk000000d1_DOPADOP<0>_UNCONNECTED }),
    .DOPBDOP({\NLW_blk000000d1_DOPBDOP<1>_UNCONNECTED , \NLW_blk000000d1_DOPBDOP<0>_UNCONNECTED }),
    .WEBWEU({sig00000002, sig00000002}),
    .ADDRAWRADDR({sig00000002, sig00000002, sig00000003, sig00000004, sig00000005, sig00000006, sig00000007, sig00000008, sig00000009, sig0000000a, 
\NLW_blk000000d1_ADDRAWRADDR<2>_UNCONNECTED , \NLW_blk000000d1_ADDRAWRADDR<1>_UNCONNECTED , \NLW_blk000000d1_ADDRAWRADDR<0>_UNCONNECTED }),
    .DIPBDIP({\NLW_blk000000d1_DIPBDIP<1>_UNCONNECTED , \NLW_blk000000d1_DIPBDIP<0>_UNCONNECTED }),
    .DIBDI({\NLW_blk000000d1_DIBDI<15>_UNCONNECTED , \NLW_blk000000d1_DIBDI<14>_UNCONNECTED , \NLW_blk000000d1_DIBDI<13>_UNCONNECTED , 
\NLW_blk000000d1_DIBDI<12>_UNCONNECTED , \NLW_blk000000d1_DIBDI<11>_UNCONNECTED , \NLW_blk000000d1_DIBDI<10>_UNCONNECTED , 
\NLW_blk000000d1_DIBDI<9>_UNCONNECTED , \NLW_blk000000d1_DIBDI<8>_UNCONNECTED , \NLW_blk000000d1_DIBDI<7>_UNCONNECTED , 
\NLW_blk000000d1_DIBDI<6>_UNCONNECTED , \NLW_blk000000d1_DIBDI<5>_UNCONNECTED , \NLW_blk000000d1_DIBDI<4>_UNCONNECTED , 
\NLW_blk000000d1_DIBDI<3>_UNCONNECTED , \NLW_blk000000d1_DIBDI<2>_UNCONNECTED , \NLW_blk000000d1_DIBDI<1>_UNCONNECTED , 
\NLW_blk000000d1_DIBDI<0>_UNCONNECTED }),
    .DIADI({\NLW_blk000000d1_DIADI<15>_UNCONNECTED , \NLW_blk000000d1_DIADI<14>_UNCONNECTED , \NLW_blk000000d1_DIADI<13>_UNCONNECTED , 
\NLW_blk000000d1_DIADI<12>_UNCONNECTED , \NLW_blk000000d1_DIADI<11>_UNCONNECTED , \NLW_blk000000d1_DIADI<10>_UNCONNECTED , 
\NLW_blk000000d1_DIADI<9>_UNCONNECTED , \NLW_blk000000d1_DIADI<8>_UNCONNECTED , sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, 
sig00000002, sig00000002, sig00000002}),
    .ADDRBRDADDR({sig00000002, sig00000001, sig00000003, sig00000004, sig00000005, sig00000006, sig00000007, sig00000008, sig00000009, sig0000000a, 
\NLW_blk000000d1_ADDRBRDADDR<2>_UNCONNECTED , \NLW_blk000000d1_ADDRBRDADDR<1>_UNCONNECTED , \NLW_blk000000d1_ADDRBRDADDR<0>_UNCONNECTED }),
    .DOBDO({\NLW_blk000000d1_DOBDO<15>_UNCONNECTED , \NLW_blk000000d1_DOBDO<14>_UNCONNECTED , \NLW_blk000000d1_DOBDO<13>_UNCONNECTED , 
\NLW_blk000000d1_DOBDO<12>_UNCONNECTED , \NLW_blk000000d1_DOBDO<11>_UNCONNECTED , \NLW_blk000000d1_DOBDO<10>_UNCONNECTED , 
\NLW_blk000000d1_DOBDO<9>_UNCONNECTED , \NLW_blk000000d1_DOBDO<8>_UNCONNECTED , cosine[7], cosine[6], cosine[5], cosine[4], cosine[3], cosine[2], 
cosine[1], cosine[0]}),
    .DIPADIP({\NLW_blk000000d1_DIPADIP<1>_UNCONNECTED , sig00000002})
  );
  XORCY   \blk0000003e/blk00000096  (
    .CI(\blk0000003e/sig00000108 ),
    .LI(\blk0000003e/sig00000109 ),
    .O(sig00000029)
  );
  MUXCY   \blk0000003e/blk00000095  (
    .CI(\blk0000003e/sig00000108 ),
    .DI(sig00000003),
    .S(\blk0000003e/sig00000109 ),
    .O(sig00000028)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000003e/blk00000094  (
    .I0(sig0000000b),
    .I1(sig00000003),
    .O(\blk0000003e/sig00000109 )
  );
  XORCY   \blk0000003e/blk00000093  (
    .CI(\blk0000003e/sig00000106 ),
    .LI(\blk0000003e/sig00000107 ),
    .O(sig0000002a)
  );
  MUXCY   \blk0000003e/blk00000092  (
    .CI(\blk0000003e/sig00000106 ),
    .DI(sig00000004),
    .S(\blk0000003e/sig00000107 ),
    .O(\blk0000003e/sig00000108 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000003e/blk00000091  (
    .I0(sig0000000c),
    .I1(sig00000004),
    .O(\blk0000003e/sig00000107 )
  );
  XORCY   \blk0000003e/blk00000090  (
    .CI(\blk0000003e/sig00000104 ),
    .LI(\blk0000003e/sig00000105 ),
    .O(sig0000002b)
  );
  MUXCY   \blk0000003e/blk0000008f  (
    .CI(\blk0000003e/sig00000104 ),
    .DI(sig00000005),
    .S(\blk0000003e/sig00000105 ),
    .O(\blk0000003e/sig00000106 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000003e/blk0000008e  (
    .I0(sig0000000d),
    .I1(sig00000005),
    .O(\blk0000003e/sig00000105 )
  );
  XORCY   \blk0000003e/blk0000008d  (
    .CI(\blk0000003e/sig00000102 ),
    .LI(\blk0000003e/sig00000103 ),
    .O(sig0000002c)
  );
  MUXCY   \blk0000003e/blk0000008c  (
    .CI(\blk0000003e/sig00000102 ),
    .DI(sig00000006),
    .S(\blk0000003e/sig00000103 ),
    .O(\blk0000003e/sig00000104 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000003e/blk0000008b  (
    .I0(sig0000000e),
    .I1(sig00000006),
    .O(\blk0000003e/sig00000103 )
  );
  XORCY   \blk0000003e/blk0000008a  (
    .CI(\blk0000003e/sig00000100 ),
    .LI(\blk0000003e/sig00000101 ),
    .O(sig0000002d)
  );
  MUXCY   \blk0000003e/blk00000089  (
    .CI(\blk0000003e/sig00000100 ),
    .DI(sig00000007),
    .S(\blk0000003e/sig00000101 ),
    .O(\blk0000003e/sig00000102 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000003e/blk00000088  (
    .I0(sig0000000f),
    .I1(sig00000007),
    .O(\blk0000003e/sig00000101 )
  );
  XORCY   \blk0000003e/blk00000087  (
    .CI(\blk0000003e/sig000000fe ),
    .LI(\blk0000003e/sig000000ff ),
    .O(sig0000002e)
  );
  MUXCY   \blk0000003e/blk00000086  (
    .CI(\blk0000003e/sig000000fe ),
    .DI(sig00000008),
    .S(\blk0000003e/sig000000ff ),
    .O(\blk0000003e/sig00000100 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000003e/blk00000085  (
    .I0(sig00000010),
    .I1(sig00000008),
    .O(\blk0000003e/sig000000ff )
  );
  XORCY   \blk0000003e/blk00000084  (
    .CI(\blk0000003e/sig000000fc ),
    .LI(\blk0000003e/sig000000fd ),
    .O(sig0000002f)
  );
  MUXCY   \blk0000003e/blk00000083  (
    .CI(\blk0000003e/sig000000fc ),
    .DI(sig00000009),
    .S(\blk0000003e/sig000000fd ),
    .O(\blk0000003e/sig000000fe )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000003e/blk00000082  (
    .I0(sig00000011),
    .I1(sig00000009),
    .O(\blk0000003e/sig000000fd )
  );
  XORCY   \blk0000003e/blk00000081  (
    .CI(\blk0000003e/sig000000fa ),
    .LI(\blk0000003e/sig000000fb ),
    .O(sig00000030)
  );
  MUXCY   \blk0000003e/blk00000080  (
    .CI(\blk0000003e/sig000000fa ),
    .DI(sig0000000a),
    .S(\blk0000003e/sig000000fb ),
    .O(\blk0000003e/sig000000fc )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000003e/blk0000007f  (
    .I0(sig00000012),
    .I1(sig0000000a),
    .O(\blk0000003e/sig000000fb )
  );
  XORCY   \blk0000003e/blk0000007e  (
    .CI(\blk0000003e/sig000000f8 ),
    .LI(\blk0000003e/sig000000f9 ),
    .O(sig00000031)
  );
  MUXCY   \blk0000003e/blk0000007d  (
    .CI(\blk0000003e/sig000000f8 ),
    .DI(sig0000005a),
    .S(\blk0000003e/sig000000f9 ),
    .O(\blk0000003e/sig000000fa )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000003e/blk0000007c  (
    .I0(sig00000013),
    .I1(sig0000005a),
    .O(\blk0000003e/sig000000f9 )
  );
  XORCY   \blk0000003e/blk0000007b  (
    .CI(\blk0000003e/sig000000f6 ),
    .LI(\blk0000003e/sig000000f7 ),
    .O(sig00000032)
  );
  MUXCY   \blk0000003e/blk0000007a  (
    .CI(\blk0000003e/sig000000f6 ),
    .DI(sig00000059),
    .S(\blk0000003e/sig000000f7 ),
    .O(\blk0000003e/sig000000f8 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000003e/blk00000079  (
    .I0(sig00000014),
    .I1(sig00000059),
    .O(\blk0000003e/sig000000f7 )
  );
  XORCY   \blk0000003e/blk00000078  (
    .CI(\blk0000003e/sig000000f4 ),
    .LI(\blk0000003e/sig000000f5 ),
    .O(sig00000033)
  );
  MUXCY   \blk0000003e/blk00000077  (
    .CI(\blk0000003e/sig000000f4 ),
    .DI(sig00000058),
    .S(\blk0000003e/sig000000f5 ),
    .O(\blk0000003e/sig000000f6 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000003e/blk00000076  (
    .I0(sig00000015),
    .I1(sig00000058),
    .O(\blk0000003e/sig000000f5 )
  );
  XORCY   \blk0000003e/blk00000075  (
    .CI(\blk0000003e/sig000000f2 ),
    .LI(\blk0000003e/sig000000f3 ),
    .O(sig00000034)
  );
  MUXCY   \blk0000003e/blk00000074  (
    .CI(\blk0000003e/sig000000f2 ),
    .DI(sig00000057),
    .S(\blk0000003e/sig000000f3 ),
    .O(\blk0000003e/sig000000f4 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000003e/blk00000073  (
    .I0(sig00000016),
    .I1(sig00000057),
    .O(\blk0000003e/sig000000f3 )
  );
  XORCY   \blk0000003e/blk00000072  (
    .CI(\blk0000003e/sig000000f0 ),
    .LI(\blk0000003e/sig000000f1 ),
    .O(sig00000035)
  );
  MUXCY   \blk0000003e/blk00000071  (
    .CI(\blk0000003e/sig000000f0 ),
    .DI(sig00000056),
    .S(\blk0000003e/sig000000f1 ),
    .O(\blk0000003e/sig000000f2 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000003e/blk00000070  (
    .I0(sig00000017),
    .I1(sig00000056),
    .O(\blk0000003e/sig000000f1 )
  );
  XORCY   \blk0000003e/blk0000006f  (
    .CI(\blk0000003e/sig000000ee ),
    .LI(\blk0000003e/sig000000ef ),
    .O(sig00000036)
  );
  MUXCY   \blk0000003e/blk0000006e  (
    .CI(\blk0000003e/sig000000ee ),
    .DI(sig00000055),
    .S(\blk0000003e/sig000000ef ),
    .O(\blk0000003e/sig000000f0 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000003e/blk0000006d  (
    .I0(sig00000018),
    .I1(sig00000055),
    .O(\blk0000003e/sig000000ef )
  );
  XORCY   \blk0000003e/blk0000006c  (
    .CI(\blk0000003e/sig000000ec ),
    .LI(\blk0000003e/sig000000ed ),
    .O(sig00000037)
  );
  MUXCY   \blk0000003e/blk0000006b  (
    .CI(\blk0000003e/sig000000ec ),
    .DI(sig00000054),
    .S(\blk0000003e/sig000000ed ),
    .O(\blk0000003e/sig000000ee )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000003e/blk0000006a  (
    .I0(sig00000019),
    .I1(sig00000054),
    .O(\blk0000003e/sig000000ed )
  );
  XORCY   \blk0000003e/blk00000069  (
    .CI(\blk0000003e/sig000000ea ),
    .LI(\blk0000003e/sig000000eb ),
    .O(sig00000038)
  );
  MUXCY   \blk0000003e/blk00000068  (
    .CI(\blk0000003e/sig000000ea ),
    .DI(sig00000053),
    .S(\blk0000003e/sig000000eb ),
    .O(\blk0000003e/sig000000ec )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000003e/blk00000067  (
    .I0(sig0000001a),
    .I1(sig00000053),
    .O(\blk0000003e/sig000000eb )
  );
  XORCY   \blk0000003e/blk00000066  (
    .CI(\blk0000003e/sig000000e8 ),
    .LI(\blk0000003e/sig000000e9 ),
    .O(sig00000039)
  );
  MUXCY   \blk0000003e/blk00000065  (
    .CI(\blk0000003e/sig000000e8 ),
    .DI(sig00000052),
    .S(\blk0000003e/sig000000e9 ),
    .O(\blk0000003e/sig000000ea )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000003e/blk00000064  (
    .I0(sig0000001b),
    .I1(sig00000052),
    .O(\blk0000003e/sig000000e9 )
  );
  XORCY   \blk0000003e/blk00000063  (
    .CI(\blk0000003e/sig000000e6 ),
    .LI(\blk0000003e/sig000000e7 ),
    .O(sig0000003a)
  );
  MUXCY   \blk0000003e/blk00000062  (
    .CI(\blk0000003e/sig000000e6 ),
    .DI(sig00000051),
    .S(\blk0000003e/sig000000e7 ),
    .O(\blk0000003e/sig000000e8 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000003e/blk00000061  (
    .I0(sig0000001c),
    .I1(sig00000051),
    .O(\blk0000003e/sig000000e7 )
  );
  XORCY   \blk0000003e/blk00000060  (
    .CI(\blk0000003e/sig000000e4 ),
    .LI(\blk0000003e/sig000000e5 ),
    .O(sig0000003b)
  );
  MUXCY   \blk0000003e/blk0000005f  (
    .CI(\blk0000003e/sig000000e4 ),
    .DI(sig00000050),
    .S(\blk0000003e/sig000000e5 ),
    .O(\blk0000003e/sig000000e6 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000003e/blk0000005e  (
    .I0(sig0000001d),
    .I1(sig00000050),
    .O(\blk0000003e/sig000000e5 )
  );
  XORCY   \blk0000003e/blk0000005d  (
    .CI(\blk0000003e/sig000000e2 ),
    .LI(\blk0000003e/sig000000e3 ),
    .O(sig0000003c)
  );
  MUXCY   \blk0000003e/blk0000005c  (
    .CI(\blk0000003e/sig000000e2 ),
    .DI(sig0000004f),
    .S(\blk0000003e/sig000000e3 ),
    .O(\blk0000003e/sig000000e4 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000003e/blk0000005b  (
    .I0(sig0000001e),
    .I1(sig0000004f),
    .O(\blk0000003e/sig000000e3 )
  );
  XORCY   \blk0000003e/blk0000005a  (
    .CI(\blk0000003e/sig000000e0 ),
    .LI(\blk0000003e/sig000000e1 ),
    .O(sig0000003d)
  );
  MUXCY   \blk0000003e/blk00000059  (
    .CI(\blk0000003e/sig000000e0 ),
    .DI(sig0000004e),
    .S(\blk0000003e/sig000000e1 ),
    .O(\blk0000003e/sig000000e2 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000003e/blk00000058  (
    .I0(sig0000001f),
    .I1(sig0000004e),
    .O(\blk0000003e/sig000000e1 )
  );
  XORCY   \blk0000003e/blk00000057  (
    .CI(\blk0000003e/sig000000de ),
    .LI(\blk0000003e/sig000000df ),
    .O(sig0000003e)
  );
  MUXCY   \blk0000003e/blk00000056  (
    .CI(\blk0000003e/sig000000de ),
    .DI(sig0000004d),
    .S(\blk0000003e/sig000000df ),
    .O(\blk0000003e/sig000000e0 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000003e/blk00000055  (
    .I0(sig00000020),
    .I1(sig0000004d),
    .O(\blk0000003e/sig000000df )
  );
  XORCY   \blk0000003e/blk00000054  (
    .CI(\blk0000003e/sig000000dc ),
    .LI(\blk0000003e/sig000000dd ),
    .O(sig0000003f)
  );
  MUXCY   \blk0000003e/blk00000053  (
    .CI(\blk0000003e/sig000000dc ),
    .DI(sig0000004c),
    .S(\blk0000003e/sig000000dd ),
    .O(\blk0000003e/sig000000de )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000003e/blk00000052  (
    .I0(sig00000021),
    .I1(sig0000004c),
    .O(\blk0000003e/sig000000dd )
  );
  XORCY   \blk0000003e/blk00000051  (
    .CI(\blk0000003e/sig000000da ),
    .LI(\blk0000003e/sig000000db ),
    .O(sig00000040)
  );
  MUXCY   \blk0000003e/blk00000050  (
    .CI(\blk0000003e/sig000000da ),
    .DI(sig0000004b),
    .S(\blk0000003e/sig000000db ),
    .O(\blk0000003e/sig000000dc )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000003e/blk0000004f  (
    .I0(sig00000022),
    .I1(sig0000004b),
    .O(\blk0000003e/sig000000db )
  );
  XORCY   \blk0000003e/blk0000004e  (
    .CI(\blk0000003e/sig000000d8 ),
    .LI(\blk0000003e/sig000000d9 ),
    .O(sig00000041)
  );
  MUXCY   \blk0000003e/blk0000004d  (
    .CI(\blk0000003e/sig000000d8 ),
    .DI(sig0000004a),
    .S(\blk0000003e/sig000000d9 ),
    .O(\blk0000003e/sig000000da )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000003e/blk0000004c  (
    .I0(sig00000023),
    .I1(sig0000004a),
    .O(\blk0000003e/sig000000d9 )
  );
  XORCY   \blk0000003e/blk0000004b  (
    .CI(\blk0000003e/sig000000d6 ),
    .LI(\blk0000003e/sig000000d7 ),
    .O(sig00000042)
  );
  MUXCY   \blk0000003e/blk0000004a  (
    .CI(\blk0000003e/sig000000d6 ),
    .DI(sig00000049),
    .S(\blk0000003e/sig000000d7 ),
    .O(\blk0000003e/sig000000d8 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000003e/blk00000049  (
    .I0(sig00000024),
    .I1(sig00000049),
    .O(\blk0000003e/sig000000d7 )
  );
  XORCY   \blk0000003e/blk00000048  (
    .CI(\blk0000003e/sig000000d4 ),
    .LI(\blk0000003e/sig000000d5 ),
    .O(sig00000043)
  );
  MUXCY   \blk0000003e/blk00000047  (
    .CI(\blk0000003e/sig000000d4 ),
    .DI(sig00000048),
    .S(\blk0000003e/sig000000d5 ),
    .O(\blk0000003e/sig000000d6 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000003e/blk00000046  (
    .I0(sig00000025),
    .I1(sig00000048),
    .O(\blk0000003e/sig000000d5 )
  );
  XORCY   \blk0000003e/blk00000045  (
    .CI(\blk0000003e/sig000000d2 ),
    .LI(\blk0000003e/sig000000d3 ),
    .O(sig00000044)
  );
  MUXCY   \blk0000003e/blk00000044  (
    .CI(\blk0000003e/sig000000d2 ),
    .DI(sig00000047),
    .S(\blk0000003e/sig000000d3 ),
    .O(\blk0000003e/sig000000d4 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000003e/blk00000043  (
    .I0(sig00000026),
    .I1(sig00000047),
    .O(\blk0000003e/sig000000d3 )
  );
  XORCY   \blk0000003e/blk00000042  (
    .CI(\blk0000003e/sig000000d0 ),
    .LI(\blk0000003e/sig000000d1 ),
    .O(sig00000045)
  );
  MUXCY   \blk0000003e/blk00000041  (
    .CI(\blk0000003e/sig000000d0 ),
    .DI(sig00000046),
    .S(\blk0000003e/sig000000d1 ),
    .O(\blk0000003e/sig000000d2 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000003e/blk00000040  (
    .I0(sig00000027),
    .I1(sig00000046),
    .O(\blk0000003e/sig000000d1 )
  );
  GND   \blk0000003e/blk0000003f  (
    .G(\blk0000003e/sig000000d0 )
  );

// synthesis translate_on

endmodule

// synthesis translate_off

`ifndef GLBL
`define GLBL

`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;

    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule

`endif

// synthesis translate_on
