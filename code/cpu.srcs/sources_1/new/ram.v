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
assign ram_bus= ram_data_out_en? ram_data : 8'bz;

// assign ram_bus = (ram_data_out_en && !ram_data_in_en) ? ram_data : (ram_data_in_en ? 8'bz : 8'bz);

assign ram_address=(ram_mode_select==1)? ram_hand_address :ram_auto_address;
assign ram_hand_mode=(ram_mode_select==1)? 1:0;
assign ram_auto_mode=(ram_mode_select==0)? 1:0;
always @(posedge ram_clock or negedge sys_rst_n or posedge ram_hand_write_en)begin
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
    else if(ram_clock==1 && ram_mode_select==0)begin//要加上ram_clock==1 防止和内存手动模式冲突
        if(ram_address_lock_en) begin
            ram_auto_address<=ram_bus[3:0];
        end
        // 目前内存写入命令 0100-STA 不可用,还在完善
        // else if(ram_data_in_en==1'b1)begin
        //     ram_all_data[ram_address]<=ram_bus;
        // end
    end
    else if (ram_hand_write_en==1 && ram_mode_select==1)begin//要加上ram_hand_write_en==1 防止和内存自动模式冲突
        ram_all_data[ram_address]<=ram_hand_data;
    end
end

reg [0:7] ram_all_data_ila_0;
reg [0:7] ram_all_data_ila_1;
reg [0:7] ram_all_data_ila_2;
reg [0:7] ram_all_data_ila_3;
reg [0:7] ram_all_data_ila_4;
reg [0:7] ram_all_data_ila_5;
reg [0:7] ram_all_data_ila_6;
reg [0:7] ram_all_data_ila_7;
reg [0:7] ram_all_data_ila_8;
reg [0:7] ram_all_data_ila_9;
reg [0:7] ram_all_data_ila_10;
reg [0:7] ram_all_data_ila_11;
reg [0:7] ram_all_data_ila_12;
reg [0:7] ram_all_data_ila_13;
reg [0:7] ram_all_data_ila_14;
reg [0:7] ram_all_data_ila_15;
reg ram_clock_ila;
reg sys_rst_n_ila;
reg ram_data_in_en_ila;
reg ram_address_lock_en_ila;
always @(posedge sys_clk) begin
    ram_all_data_ila_0<=ram_all_data[0];
    ram_all_data_ila_1<=ram_all_data[1];
    ram_all_data_ila_2<=ram_all_data[2];
    ram_all_data_ila_3<=ram_all_data[3];
    ram_all_data_ila_4<=ram_all_data[4];
    ram_all_data_ila_5<=ram_all_data[5];
    ram_all_data_ila_6<=ram_all_data[6];
    ram_all_data_ila_7<=ram_all_data[7];
    ram_all_data_ila_8<=ram_all_data[8];
    ram_all_data_ila_9<=ram_all_data[9];
    ram_all_data_ila_10<=ram_all_data[10];
    ram_all_data_ila_11<=ram_all_data[11];
    ram_all_data_ila_12<=ram_all_data[12];
    ram_all_data_ila_13<=ram_all_data[13];
    ram_all_data_ila_14<=ram_all_data[14];
    ram_all_data_ila_15<=ram_all_data[15];
    sys_rst_n_ila<=sys_rst_n;
    ram_clock_ila<=ram_clock;
    ram_data_in_en_ila<=ram_data_in_en;
    ram_address_lock_en_ila<=ram_address_lock_en;
end

ila_1 your_instance_name (
	.clk(sys_clk), // input wire clk
	.probe0(ram_all_data_ila_0), // input wire [7:0]  probe0  
	.probe1(ram_all_data_ila_1), // input wire [7:0]  probe1 
	.probe2(ram_all_data_ila_2), // input wire [7:0]  probe2 
	.probe3(ram_all_data_ila_3), // input wire [7:0]  probe3 
	.probe4(ram_all_data_ila_4), // input wire [7:0]  probe4 
	.probe5(ram_all_data_ila_5), // input wire [7:0]  probe5 
	.probe6(ram_all_data_ila_6), // input wire [7:0]  probe6 
	.probe7(ram_all_data_ila_7), // input wire [7:0]  probe7 
	.probe8(ram_all_data_ila_8), // input wire [7:0]  probe8 
	.probe9(ram_all_data_ila_9), // input wire [7:0]  probe9 
	.probe10(ram_all_data_ila_10), // input wire [7:0]  probe10 
	.probe11(ram_all_data_ila_11), // input wire [7:0]  probe11 
	.probe12(ram_all_data_ila_12), // input wire [7:0]  probe12 
	.probe13(ram_all_data_ila_13), // input wire [7:0]  probe13 
	.probe14(ram_all_data_ila_14), // input wire [7:0]  probe14 
	.probe15(ram_all_data_ila_15), // input wire [7:0]  probe15
    .probe16(sys_rst_n_ila), // input wire [0:0]  probe16 
	.probe17(ram_clock_ila), // input wire [0:0]  probe17
    .probe18(ram_data_in_en_ila), // input wire [0:0]  probe18 
	.probe19(ram_address_lock_en_ila) // input wire [0:0]  probe19
);


endmodule