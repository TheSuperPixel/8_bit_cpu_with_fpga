module alu (
    inout  [7:0] alu_bus,
    input alu_clock,
    input alu_reset_n,
    input [7:0] alu_in_a,
    input [7:0] alu_in_b,
    output [7:0] alu_data,
    output reg alu_full,
    output reg alu_empty,
    input alu_out_en,
    input alu_sub_en,
    input alu_flag_in_en
);
wire [7:0] alu_add;
wire [7:0] alu_sub;
assign alu_add=alu_in_a+alu_in_b;
assign alu_sub=alu_in_a-alu_in_b;
assign alu_data=(alu_sub_en==1)? alu_sub:alu_add;
assign alu_bus= alu_out_en? alu_data : 8'bz;
always @(posedge alu_clock or negedge alu_reset_n) begin
    if (!alu_reset_n) begin
        alu_full<=1'b0;
        alu_empty<=1'b0;
    end
    else if(alu_flag_in_en)begin
        alu_full<=(alu_data==8'd255)? 1:0;
        alu_empty<=(alu_data==8'd0)? 1:0;
    end
end
// assign alu_full=1'b0;//!!!!
// assign alu_empty=1'b0;//!!!!
endmodule