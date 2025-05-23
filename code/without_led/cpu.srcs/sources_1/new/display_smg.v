module display_smg (
    input display_smg_clock,
    input display_smg_rst_n,
    input [7:0] display_smg_bus,
    output reg [7:0] display_smg_data,
    input display_smg_in_en
);

always @(posedge display_smg_clock or negedge display_smg_rst_n)begin
    if (!display_smg_rst_n) begin
        display_smg_data<=0;
    end
    else if (display_smg_in_en) begin
        display_smg_data<=display_smg_bus;
    end
end    



endmodule