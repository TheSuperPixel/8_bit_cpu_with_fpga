module program_counter (
    inout [7:0] pc_bus,
    output reg [3:0] pc_data,
    input pc_reset_n,
    input pc_load,
    input pc_en,
    input pc_clock,
    input pc_out_en
);

assign pc_bus= pc_out_en? {4'dz,pc_data} : 8'bz;
always @(posedge pc_clock or negedge pc_reset_n) begin
    if (!pc_reset_n) begin
        pc_data<=0;
    end
    else if (pc_load) 
        pc_data<=pc_bus[3:0];
    else if (pc_en)
        pc_data<=pc_data+1;
end
    
endmodule