`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:42:25 11/30/2013 
// Design Name: 
// Module Name:    VGANumberRenderer 
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
module VGANumberRenderer (
  input [10:0] x, y,
  input [10:0] center_x, center_y,
  input [15:0] number,
  output wor show
);

/*
  Number = 16'h[D3][D2][D1][D0]
*/

VGADigitRenderer D3 (
  x, y,
  center_x - 60, center_y,
  number[15:12],
  show
);

VGADigitRenderer D2 (
  x, y,
  center_x - 20, center_y,
  number[11:8],
  show
);

VGADigitRenderer D1 (
  x, y,
  center_x + 20, center_y,
  number[7:4],
  show
);

VGADigitRenderer D0 (
  x, y,
  center_x + 60, center_y,
  number[3:0],
  show
);

endmodule
