`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:24:44 11/30/2013 
// Design Name: 
// Module Name:    VGAControler 
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
module VGAControler (
  input clk, rst,
  output reg hs, vs,
  output reg[10:0] x, y
);

//640*480<-->800*525
parameter H_RESULOTION = 640,
  H_FRONT_PORCH = 16,
  H_SYNC_PULSE = 96,
  H_BACK_PORCH = 48,
  H_TOTAL = 800;
parameter V_RESULOTION = 480,
  V_FRONT_PORCH = 10,
  V_SYNC_PULSE = 2,
  V_BACK_PORCH = 33,
  V_TOTAL = 525;

always @ (negedge clk, negedge rst) //value of x
begin
  if (!rst)
	 x = 0;
  else
  begin
    if (x == H_TOTAL - 1) x = 0;
	 else x = x + 1;
  end
end

always @ (negedge clk, negedge rst) //value of y
begin
  if (!rst)
    y = 0;
  else
  begin
    if (x == H_TOTAL - 1)
      if (y == V_TOTAL - 1)
			y = 0;
      else
			y = y + 1;
  end
end

always @ (negedge clk, negedge rst) //value of hs
begin
  if (!rst)
    hs = 1;
  else
  begin
    if (x >= H_RESULOTION + H_FRONT_PORCH - 1 && x < H_RESULOTION + H_FRONT_PORCH + H_SYNC_PULSE - 1)
      hs = 0;
    else
      hs = 1;
  end
end

always @ (negedge clk, negedge rst) //value of vs
begin
  if (!rst)
    vs = 1;
  else
  begin
    if (y >= V_RESULOTION + V_FRONT_PORCH - 1 && y < V_RESULOTION + V_FRONT_PORCH + V_SYNC_PULSE - 1)
      vs = 0;
    else
      vs = 1;
  end
end

endmodule
