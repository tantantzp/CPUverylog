`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:34:10 11/30/2013 
// Design Name: 
// Module Name:    VGARenderer 
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
module VGARenderer (
  input [10:0] x, y,
  input [159:0] registers,
  input [15:0] pc,
  output reg [2:0] r, g, b
);

wor show;

always @ (x, y, show)
begin
  r = 0;
  g = 0;
  b = 0;
  if (x < 640 && y < 480)
  begin
    if (show)
    begin
      r = 7;
      g = 7;
      b = 7;
    end
  end
end

VGARegisterRendererTop registerTop (
  x, y,
  200, 50,
  registers,
  show
);

VGAOtherRendererTop otherTop (
  x, y,
  500, 50,
  pc,
  show
);

endmodule
