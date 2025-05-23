module command_reg (
    inout tri [7:0] command_reg_bus,
    output reg [7:0] command_reg_data,
    input command_reg_clk,
    input command_reg_reset_n,
    input wire command_reg_in_en,
    input wire command_reg_out_en
);

assign command_reg_bus= command_reg_out_en? {4'dz,command_reg_data[3:0]} : 8'bz;

always @(posedge command_reg_clk or negedge command_reg_reset_n)begin
    if(command_reg_reset_n==1'b0)
        command_reg_data<=8'd0;
    else begin
        if(command_reg_in_en==1'b1)
            command_reg_data<=command_reg_bus;
    end
end 
endmodule