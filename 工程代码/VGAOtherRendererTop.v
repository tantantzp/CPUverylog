`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:45:29 12/02/2013 
// Design Name: 
// Module Name:    VGAOtherRendererTop 
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
module VGAOtherRendererTop(
  input [10:0] x, y,
  input [10:0] center_x, center_y,
  input [15:0] pc,
  output wor show
);

parameter deltaY = 60;

VGARegisterRenderer pcRegister (
  x, y,
  center_x, center_y,
  4'ha, pc,
  show
);

// For others "center_y + k * deltaY"

endmodule
