`timescale 1ns / 1ps

module a_reg(
    inout tri [7:0] a_reg_bus,
    output reg [7:0] a_reg_data,
    input a_reg_clk,
    input a_reg_reset_n,
    input wire a_reg_in_en,
    input wire a_reg_out_en
    );


assign a_reg_bus= a_reg_out_en? a_reg_data : 8'bz;

always @(posedge a_reg_clk or negedge a_reg_reset_n)begin
    if(a_reg_reset_n==1'b0)
        a_reg_data<=8'd0;
    else begin
        if(a_reg_in_en==1'b1)
            a_reg_data<=a_reg_bus;
    end
end    

endmodule
