/*******************************************************************************
*     This file is owned and controlled by Xilinx and must be used solely      *
*     for design, simulation, implementation and creation of design files      *
*     limited to Xilinx devices or technologies. Use with non-Xilinx           *
*     devices or technologies is expressly prohibited and immediately          *
*     terminates your license.                                                 *
*                                                                              *
*     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" SOLELY     *
*     FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR XILINX DEVICES.  BY     *
*     PROVIDING THIS DESIGN, CODE, OR INFORMATION AS ONE POSSIBLE              *
*     IMPLEMENTATION OF THIS FEATURE, APPLICATION OR STANDARD, XILINX IS       *
*     MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION IS FREE FROM ANY       *
*     CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE FOR OBTAINING ANY        *
*     RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY        *
*     DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE    *
*     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR           *
*     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF          *
*     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A    *
*     PARTICULAR PURPOSE.                                                      *
*                                                                              *
*     Xilinx products are not intended for use in life support appliances,     *
*     devices, or systems.  Use in such applications are expressly             *
*     prohibited.                                                              *
*                                                                              *
*     (c) Copyright 1995-2015 Xilinx, Inc.                                     *
*     All rights reserved.                                                     *
*******************************************************************************/

/*******************************************************************************
*     Generated from core with identifier: xilinx.com:ip:dds_compiler:4.0      *
*                                                                              *
*     The Xilinx DDS Compiler LogiCORE provides Direct Digital Synthesizers    *
*     (DDS) and optionally either Phase Generator or Sine/Cosine Lookup        *
*     Table constituent parts as independent cores. The core features sine,    *
*     cosine or quadrature outputs with 3 to 26-bit output sample              *
*     precision. The core supports up to 16 channels by time-sharing the       *
*     sine/cosine table which dramatically reduces the area requirement        *
*     when multiple channels are needed.  Phase Dithering and Taylor Series    *
*     Correction options provide high dynamic range signals using minimal      *
*     FPGA resources. In addition, the core has an optional phase offset       *
*     capability, providing support for multiple synthesizers with             *
*     precisely controlled phase differences.                                  *
*******************************************************************************/

// Interfaces:
//    addr_intf
//    clk_intf
//    sclr_intf
//    ce_intf
//    reg_select_intf
//    we_intf
//    data_intf
//    pinc_in_intf
//    poff_in_intf
//    phase_in_intf
//    rdy_intf
//    rfd_intf
//    channel_intf
//    cosine_intf
//    sine_intf
//    phase_out_intf

// The following must be inserted into your Verilog file for this
// core to be instantiated. Change the instance name and port connections
// (in parentheses) to your own signal names.

//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
sin_cos your_instance_name (
  .clk(clk), // input clk
  .we(we), // input we
  .data(data), // input [28 : 0] data
  .cosine(cosine), // output [7 : 0] cosine
  .sine(sine), // output [7 : 0] sine
  .phase_out(phase_out) // output [28 : 0] phase_out
);
// INST_TAG_END ------ End INSTANTIATION Template ---------

// You must compile the wrapper file sin_cos.v when simulating
// the core, sin_cos. When compiling the wrapper file, be sure to
// reference the XilinxCoreLib Verilog simulation library. For detailed
// instructions, please refer to the "CORE Generator Help".

