/** @module : PROJECT_NAME
 *  @author : Adaptive & Secure Computing Systems (ASCS) Laboratory

 *  Copyright (c) 2018 BRISC-V (ASCS/ECE/BU)
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *  The above copyright notice and this permission notice shall be included in
 *  all copies or substantial portions of the Software.

 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 *  THE SOFTWARE.
 *
 */

module PROJECT_NAME #(
  parameter CORE = CORE_VALUE,
  parameter DATA_WIDTH = DATA_WIDTH_VALUE,
  parameter INDEX_BITS = INDEX_BITS_VALUE,
  parameter OFFSET_BITS = OFFSET_BITS_VALUE,
  parameter ADDRESS_BITS = ADDRESS_BITS_VALUE,
  parameter PROGRAM = "PROGRAM_PATH"
) (
  input clock,
  input reset,

  // Control ports to set arbitrary PCs
  input start,
  input [ADDRESS_BITS-1:0] prog_address,

  // For I/O funstions
  input [1:0]    from_peripheral,
  input [31:0]   from_peripheral_data,
  input from_peripheral_valid,

  // In-System Programmer - A port to write instruction memory
  input isp_write,
  input [ADDRESS_BITS-1:0] isp_address,
  input [DATA_WIDTH-1:0] isp_data,

  output [1:0]  to_peripheral,
  output [31:0] to_peripheral_data,
  output to_peripheral_valid,

  // Core debug ports
  input report,
  output [ADDRESS_BITS-1:0] current_PC
);

RISC_V_Core #(
  .CORE(CORE),
  .DATA_WIDTH(DATA_WIDTH),
  .INDEX_BITS(INDEX_BITS),
  .OFFSET_BITS(OFFSET_BITS),
  .ADDRESS_BITS(ADDRESS_BITS),
  .PROGRAM(PROGRAM)
) core0 (
  .clock(clock),
  .reset(reset),
  .start(start),
  .prog_address(prog_address),

  .isp_write(isp_write),
  .isp_address(isp_address),
  .isp_data(isp_data),

  .from_peripheral(from_peripheral),
  .from_peripheral_data(from_peripheral_data),
  .from_peripheral_valid(from_peripheral_valid),
  .to_peripheral(to_peripheral),
  .to_peripheral_data(to_peripheral_data),
  .to_peripheral_valid(to_peripheral_valid),

  .report(report),
  .current_PC(current_PC)
);

endmodule
