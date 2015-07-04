`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:40:45 11/30/2013 
// Design Name: 
// Module Name:    VGARegisterRenderer 
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
module VGARegisterRenderer (
  input [10:0] x, y,
  input [10:0] center_x, center_y,
  input [3:0] registerIndex,
  input [15:0] registerValue,
  output wor show
);

VGADigitRenderer registerindex (
  x, y,
  center_x - 100, center_y,
  registerIndex,
  show
);

VGANumberRenderer registervalue (
  x, y,
  center_x + 40, center_y,
  registerValue,
  show
);

endmodule
