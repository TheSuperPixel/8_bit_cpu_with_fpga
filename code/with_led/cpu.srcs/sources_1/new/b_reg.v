`timescale 1ns / 1ps

module b_reg(
    inout tri [7:0] b_reg_bus,
    output reg [7:0] b_reg_data,
    input b_reg_clk,
    input b_reg_reset_n,
    input wire b_reg_in_en,
    input wire b_reg_out_en
    );


assign b_reg_bus= b_reg_out_en? b_reg_data : 8'bz;

always @(posedge b_reg_clk or negedge b_reg_reset_n)begin
    if(b_reg_reset_n==1'b0)
        b_reg_data<=8'd0;
    else begin
        if(b_reg_in_en==1'b1)
            b_reg_data<=b_reg_bus;
    end
end    

endmodule
