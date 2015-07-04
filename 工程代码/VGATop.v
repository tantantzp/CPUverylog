`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:21:47 11/30/2013 
// Design Name: 
// Module Name:    VGATop 
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
module VGATop (
  input clk50M, rst,
  input [159:0] registerVGA,
  input [15:0] pc,
  output vgaHs, vgaVs,
  output [2:0] vgaR, vgaG, vgaB
);

wire [10:0] x, y;
reg clk25M;

//need clk at 25.18MHz or so
always @ (negedge clk50M, negedge rst)
begin
  if (!rst)
    clk25M = 0;
  else
    clk25M = ~ clk25M;
end

VGAControler VGAControlerM (
  clk25M, rst,
  vgaHs, vgaVs,
  x, y
);

VGARenderer VGARendererM (
  x, y,
  registerVGA, pc,
  vgaR, vgaG, vgaB
);

endmodule
