`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:44:31 11/30/2013 
// Design Name: 
// Module Name:    VGARectRenderer 
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
module VGARectRenderer (
  input enable,
  input [10:0] x, y,
  input [10:0] center_x, center_y,
  input [10:0] width, height,
  output reg show
);

/*
            width
------------------------------
|                            |
|    (center_x, center_y)    |   height
|                            |
------------------------------
*/

always @ (*)
  if (!enable)
    show = ((x > center_x - width >> 1) && (x < center_x + width >> 1) && (y > center_y - height >> 1) && (y < center_y + height >> 1));
  else
    show = 0;
endmodule
