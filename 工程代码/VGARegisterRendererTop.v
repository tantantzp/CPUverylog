`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:39:32 11/30/2013 
// Design Name: 
// Module Name:    VGARegisterRendererTop 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module VGARegisterRendererTop (
  input [10:0] x, y,
  input [10:0] center_x, center_y,
  input [159:0] registers,
  output wor show
);

parameter deltaY = 60;

VGARegisterRenderer register0 (
  x, y,
  center_x, center_y,
  0, registers[15:0],
  show
);

VGARegisterRenderer register1 (
  x, y,
  center_x, center_y + deltaY,
  1, registers[31:16],
  show
);

VGARegisterRenderer register2 (
  x, y,
  center_x, center_y + 2 * deltaY,
  2, registers[47:32],
  show
);

VGARegisterRenderer register3 (
  x, y,
  center_x, center_y + 3 * deltaY,
  3, registers[63:48],
  show
);

VGARegisterRenderer register4 (
  x, y,
  center_x, center_y + 4 * deltaY,
  4, registers[79:64],
  show
);

VGARegisterRenderer register5 (
  x, y,
  center_x, center_y + 5 * deltaY,
  5, registers[95:80],
  show
);

VGARegisterRenderer register6 (
  x, y,
  center_x, center_y + 6 * deltaY,
  6, registers[111:96],
  show
);

VGARegisterRenderer register7 (
  x, y,
  center_x, center_y + 7 * deltaY,
  7, registers[127:112],
  show
);

//registers[159:128] is available

endmodule
