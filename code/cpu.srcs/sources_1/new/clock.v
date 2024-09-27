`timescale 1ns / 1ps
module clock(
    input sys_clk,
    input sys_rst_n,
    input one_clock_input,
    input clock_mode,
    input clock_halt_en,
    output reg always_clock,
    output wire cpu_clock,
    output wire cpu_clock_n
);

//时钟选择
wire cpu_clock_unhalt;
assign cpu_clock_unhalt=(clock_mode==1'b1)? always_clock:one_clock;
assign cpu_clock=(clock_halt_en==1'b1)? 1'b0:cpu_clock_unhalt;
assign cpu_clock_n=~cpu_clock;


//单次时钟
reg one_clock_d0;
reg one_clock_d1;
wire one_clock;
assign one_clock=(~one_clock_d1&one_clock_d0);
always @(posedge always_clock or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
        one_clock_d0<=0;
        one_clock_d1<=0;
    end
    else begin
        one_clock_d0<=one_clock_input;
        one_clock_d1<=one_clock_d0;
    end
end

//计数器
reg [28:0] cnt;
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
        cnt<=0;
    end
    // else if (cnt<24'd4) begin//ila
    // else if (cnt<24'd100) begin//仿真
    else if (cnt<28'd1000_0000) begin//实际
        cnt<=cnt+1'b1;
    end
    else 
        cnt<=0;
end

always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        always_clock<=0;
    // else if(cnt<24'd2)//ila
    // else if(cnt<24'd50)//仿真
    else if(cnt<28'd500_0000)//实际
       always_clock<=1'b1;
    else
       always_clock<=1'b0;
end


endmodule
