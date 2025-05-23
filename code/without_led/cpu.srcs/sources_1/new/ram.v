module ram (
    input ram_clock,
    input sys_clk,
    input sys_rst_n,

    inout tri [7:0] ram_bus,
    input [3:0] ram_hand_address,
    input [7:0] ram_hand_data,
    output [3:0] ram_address,
    output [7:0] ram_data,

    input ram_mode_select,//0->自动 1->手动  
    output ram_hand_mode,
    output ram_auto_mode,

    input ram_address_lock_en,
    input ram_data_in_en,
    input ram_data_out_en,

    input ram_hand_write_en
);
reg [0:7] ram_all_data [15:0];
reg [0:3] ram_auto_address;

assign ram_data= ram_all_data[ram_address];
// assign ram_bus= ram_data_out_en? ram_data : 8'bz;

// assign ram_bus = (ram_data_out_en && !ram_data_in_en) ? ram_data : (ram_data_in_en ? 8'bz : 8'bz);

assign ram_address=(ram_mode_select==1)? ram_hand_address :ram_auto_address;
assign ram_hand_mode=(ram_mode_select==1)? 1:0;
assign ram_auto_mode=(ram_mode_select==0)? 1:0;
always @(posedge ram_clock or negedge sys_rst_n)begin
    if (!sys_rst_n)begin
        ram_all_data[0]<=8'b0001_1000;//!!!
        ram_all_data[1]<=8'b0010_1001;
        ram_all_data[2]<=8'b1110_0000;
        ram_all_data[3]<=8'b0110_0001;
        ram_all_data[4]<=8'b0;
        ram_all_data[5]<=8'b0;
        ram_all_data[6]<=8'b0;
        ram_all_data[7]<=8'b0;
        ram_all_data[8]<=8'b0000_0001;
        ram_all_data[9]<=8'b0000_0001;
        ram_all_data[10]<=8'b0;
        ram_all_data[11]<=8'b0;
        ram_all_data[12]<=8'b0;
        ram_all_data[13]<=8'b0;
        ram_all_data[14]<=8'b0;
        ram_all_data[15]<=8'b0;

        // ram_all_data[0]<=8'b0;//!!!
        // ram_all_data[1]<=8'b0;
        // ram_all_data[2]<=8'b0;
        // ram_all_data[3]<=8'b0;
        // ram_all_data[4]<=8'b0;
        // ram_all_data[5]<=8'b0;
        // ram_all_data[6]<=8'b0;
        // ram_all_data[7]<=8'b0;
        // ram_all_data[8]<=8'b0;
        // ram_all_data[9]<=8'b0;
        // ram_all_data[10]<=8'b0;
        // ram_all_data[11]<=8'b0;
        // ram_all_data[12]<=8'b0;
        // ram_all_data[13]<=8'b0;
        // ram_all_data[14]<=8'b0;
        // ram_all_data[15]<=8'b0;
    end
    else if(ram_mode_select==0)begin//要加上ram_clock==1 防止和内存手动模式冲突
        if(ram_address_lock_en) begin
            ram_auto_address<=ram_bus[3:0];
        end
        // 目前内存写入命令 0100-STA 不可用,还在完善
        else if(ram_data_in_en==1'b1)begin
            ram_all_data[ram_address]<=ram_bus;
        end
    end
    else if (ram_hand_write_en==1 && ram_mode_select==1)begin//要加上ram_hand_write_en==1 防止和内存自动模式冲突
        ram_all_data[ram_address]<=ram_hand_data;
    end
end


endmodule