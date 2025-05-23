`timescale 1ns/1ns 

module tb_cpu ;
    
parameter T = 2000;
reg sys_clk;
reg sys_rst_n;
wire always_clock;
reg one_clock_input;
reg clock_mode;
// wire clock_halt_en;
wire cpu_clock;
wire cpu_clock_n;

wire [2:0] command_counter_encode;
wire [5:0] command_counter_decode;

wire [7:0] cpu_bus;

wire [7:0] a_reg_data;
wire a_reg_in_en;
wire a_reg_out_en;

wire [7:0] b_reg_data;
wire b_reg_in_en;
wire b_reg_out_en;

wire [7:0] alu_data;
wire alu_full;
wire alu_empty;
wire alu_out_en;
wire alu_sub_en;

wire [3:0] pc_data;
wire pc_load;
wire pc_en;
wire pc_out_en;

wire [7:0] command_reg_data;
wire command_reg_in_en;
wire command_reg_out_en;

reg [3:0] ram_hand_address;
reg [7:0] ram_hand_data;
wire [3:0] ram_address;
wire [7:0] ram_data;
reg ram_mode_select;
wire ram_hand_mode;
wire ram_auto_mode;

wire ram_address_lock_en;
wire ram_data_in_en;
wire ram_data_out_en;
reg ram_hand_write_en;

wire display_smg_in_en;
wire [3:0] seg_sel;
wire [7:0] seg_led;
initial begin
    sys_clk=1'b0;
    sys_rst_n=1'b0;
    one_clock_input<=1'b0;
    clock_mode<=1'b0;
    // clock_halt_en<=1'b1;//禁止时钟

    // a_reg_in_en<=1'b0;
    // a_reg_out_en<=1'b0;
    // b_reg_in_en<=1'b0;
    // b_reg_out_en<=1'b0;
    // alu_out_en<=1'b0;
    // alu_sub_en<=1'b0;

    // pc_load<=1'b0;
    // pc_en<=1'b0;
    // pc_out_en<=1'b0;

    // command_reg_in_en<=1'b0;
    // command_reg_out_en<=1'b0;

    ram_hand_address<=4'd0;
    ram_hand_data<=8'd0;
    ram_mode_select<=1'd0;//0->自动 1->手动  
    // ram_address_lock_en<=1'd0;
    // ram_data_in_en<=1'd0;
    // ram_data_out_en<=1'd0;
    ram_hand_write_en<=1'd0;

    // display_smg_in_en<=1'd0;

    // force cpu_bus=8'dz;
    #(T+1) sys_rst_n=1'b1;

    //测试3：条件跳转指令---------------------------------------------------------------------------------------------------------------------------
    #(1000000) ram_mode_select<=1'b1;//0->自动 1->手动  

    //OUT
    #(1000000) ram_hand_address<=4'b0000;
    #(1000000) ram_hand_data<=8'b1110_0000;
    #(1000000) ram_hand_write_en<=1'b1;
    #(1000000) ram_hand_write_en<=1'b0;

    //ADD
    #(1000000) ram_hand_address<=4'b0001;
    #(1000000) ram_hand_data<=8'b0010_1000;
    #(1000000) ram_hand_write_en<=1'b1;
    #(1000000) ram_hand_write_en<=1'b0;

    //JF
    #(1000000) ram_hand_address<=4'b0010;
    #(1000000) ram_hand_data<=8'b1000_0100;
    #(1000000) ram_hand_write_en<=1'b1;
    #(1000000) ram_hand_write_en<=1'b0;

    //JMP
    #(1000000) ram_hand_address<=4'b0011;
    #(1000000) ram_hand_data<=8'b0110_0000;
    #(1000000) ram_hand_write_en<=1'b1;
    #(1000000) ram_hand_write_en<=1'b0;

    //SUB
    #(1000000) ram_hand_address<=4'b0100;
    #(1000000) ram_hand_data<=8'b0011_1001;
    #(1000000) ram_hand_write_en<=1'b1;
    #(1000000) ram_hand_write_en<=1'b0;

    //OUT
    #(1000000) ram_hand_address<=4'b0101;
    #(1000000) ram_hand_data<=8'b1110_0000;
    #(1000000) ram_hand_write_en<=1'b1;
    #(1000000) ram_hand_write_en<=1'b0;

    //JZ
    #(1000000) ram_hand_address<=4'b0110;
    #(1000000) ram_hand_data<=8'b0111_0000;
    #(1000000) ram_hand_write_en<=1'b1;
    #(1000000) ram_hand_write_en<=1'b0;

    //JMP
    #(1000000) ram_hand_address<=4'b0111;
    #(1000000) ram_hand_data<=8'b0110_0100;
    #(1000000) ram_hand_write_en<=1'b1;
    #(1000000) ram_hand_write_en<=1'b0;

    //data1
    #(1000000) ram_hand_address<=4'b1000;
    #(1000000) ram_hand_data<=8'b0000_0001;
    #(1000000) ram_hand_write_en<=1'b1;
    #(1000000) ram_hand_write_en<=1'b0;
    
    //data2
    #(1000000) ram_hand_address<=4'b1001;
    #(1000000) ram_hand_data<=8'b0000_0001;
    #(1000000) ram_hand_write_en<=1'b1;
    #(1000000) ram_hand_write_en<=1'b0;

    #(1000000) ram_mode_select<=1'b0;//0->自动 1->手动  
    #(1000000) clock_mode<=1'b1;//1->自动 0->手动  
    //测试2：基本指令集-----------------------------------------------------------------------------------------------
    // #(1000000) ram_mode_select<=1'b1;//0->自动 1->手动  

    // //LDA
    // #(1000000) ram_hand_address<=4'b0000;
    // #(1000000) ram_hand_data<=8'b0001_1000;
    // #(1000000) ram_hand_write_en<=1'b1;
    // #(1000000) ram_hand_write_en<=1'b0;

    // //ADD
    // #(1000000) ram_hand_address<=4'b0001;
    // #(1000000) ram_hand_data<=8'b0010_1001;
    // #(1000000) ram_hand_write_en<=1'b1;
    // #(1000000) ram_hand_write_en<=1'b0;

    // //OUT
    // #(1000000) ram_hand_address<=4'b0010;
    // #(1000000) ram_hand_data<=8'b1110_0000;
    // #(1000000) ram_hand_write_en<=1'b1;
    // #(1000000) ram_hand_write_en<=1'b0;

    // //SUB
    // #(1000000) ram_hand_address<=4'b0011;
    // #(1000000) ram_hand_data<=8'b0011_1010;
    // #(1000000) ram_hand_write_en<=1'b1;
    // #(1000000) ram_hand_write_en<=1'b0;

    // //LDI
    // #(1000000) ram_hand_address<=4'b0100;
    // #(1000000) ram_hand_data<=8'b0101_1010;
    // #(1000000) ram_hand_write_en<=1'b1;
    // #(1000000) ram_hand_write_en<=1'b0;

    // //STA
    // #(1000000) ram_hand_address<=4'b0101;
    // #(1000000) ram_hand_data<=8'B0100_1011;
    // #(1000000) ram_hand_write_en<=1'b1;
    // #(1000000) ram_hand_write_en<=1'b0;

    // //HLT
    // #(1000000) ram_hand_address<=4'b0110;
    // #(1000000) ram_hand_data<=8'b1111_0000;
    // #(1000000) ram_hand_write_en<=1'b1;
    // #(1000000) ram_hand_write_en<=1'b0;
    
    // //data1
    // #(1000000) ram_hand_address<=4'b1000;
    // #(1000000) ram_hand_data<=8'b1000_1010;
    // #(1000000) ram_hand_write_en<=1'b1;
    // #(1000000) ram_hand_write_en<=1'b0;
    
    // //data2
    // #(1000000) ram_hand_address<=4'b1001;
    // #(1000000) ram_hand_data<=8'b0010_1110;
    // #(1000000) ram_hand_write_en<=1'b1;
    // #(1000000) ram_hand_write_en<=1'b0;

    // //data3
    // #(1000000) ram_hand_address<=4'b1010;
    // #(1000000) ram_hand_data<=8'b0000_0110;
    // #(1000000) ram_hand_write_en<=1'b1;
    // #(1000000) ram_hand_write_en<=1'b0;

    // #(1000000) ram_mode_select<=1'b0;//0->自动 1->手动  

    // #(1000000) clock_mode<=1'b1;//1->自动 0->手动  


    // clock_halt_en<=1'b0;

    //测试1：基本功能-----------------------------------------------------------------------------------------------
    // //时钟测试
    // #(1000000) one_clock_input<=1'b1;
    // #(1000000) clock_mode<=1'b1;
    // #(1000000) clock_halt_en<=1'b1;
    // #(1000000) clock_halt_en<=1'b0;

    // //寄存器A测试
    // #(1000000) force cpu_bus=8'd55;
    // #(1000000) a_reg_in_en<=1'b1;
    // #(1000000) a_reg_in_en<=1'b0;
    // #(1000000) release cpu_bus;
    // #(1000000) a_reg_out_en<=1'b1;
    // #(1000000) a_reg_out_en<=1'b0;

    // //寄存器B测试
    // #(1000000) force cpu_bus=8'd66;
    // #(1000000) b_reg_in_en<=1'b1;
    // #(1000000) b_reg_in_en<=1'b0;
    // #(1000000) release cpu_bus;
    // #(1000000) b_reg_out_en<=1'b1;
    // #(1000000) b_reg_out_en<=1'b0;

    // //ALU测试
    // #(1000000)alu_sub_en<=1'b1;
    // #(1000000)alu_sub_en<=1'b0;
    // #(1000000) alu_out_en<=1'b1;
    // #(1000000) alu_out_en<=1'b0;

    // //程序计数器测试
    // #(1000000) force cpu_bus=8'd12;
    // #(1000000) pc_load<=1'b1;
    // #(1000000) pc_load<=1'b0;
    // #(1000000) release cpu_bus;
    // #(1000000) pc_en<=1'b1;
    // #(2000000) pc_en<=1'b0;
    // #(1000000) pc_out_en<=1'b1;
    // #(1000000) pc_out_en<=1'b0;

    // //指令寄存器测试
    // #(1000000) force cpu_bus=8'd75;
    // #(1000000) command_reg_in_en<=1'b1;
    // #(1000000) command_reg_in_en<=1'b0;
    // #(1000000) release cpu_bus;
    // #(1000000) command_reg_out_en<=1'b1;
    // #(1000000) command_reg_out_en<=1'b0;

    // //内存测试
    // #(1000000) ram_mode_select<=1'b1;//0->自动 1->手动  
    // #(1000000) ram_hand_address<=4'd2;
    // #(1000000) ram_hand_data<=8'd46;
    // #(1000000) ram_hand_write_en<=1'b1;
    // #(1000000) ram_hand_write_en<=1'b0;

    // #(1000000) ram_hand_address<=4'd3;
    // #(1000000) ram_hand_data<=8'd48;
    // #(1000000) ram_hand_write_en<=1'b1;
    // #(1000000) ram_hand_write_en<=1'b0;

    // #(1000000) ram_mode_select<=1'b0;//0->自动 1->手动 
    // #(1000000) force cpu_bus=8'd03;
    // #(1000000) ram_address_lock_en<=1'b1;
    // #(1000000) ram_address_lock_en<=1'b0;
    // #(1000000) force cpu_bus=8'd43;
    // #(1000000) ram_data_in_en<=1'b1;
    // #(1000000) ram_data_in_en<=1'b0;

    // // #(1000000) force cpu_bus=8'd04;
    // // #(1000000) ram_address_lock_en<=1'b1;
    // // #(1000000) ram_address_lock_en<=1'b0;
    // // #(1000000) force cpu_bus=8'd44;
    // // #(1000000) ram_data_in_en<=1'b1;
    // // #(1000000) ram_data_in_en<=1'b0;

    // #(1000000) release cpu_bus;
    // #(1000000) ram_data_out_en<=1'b1;
    // #(1000000) ram_data_out_en<=1'b0;

    // //显示测试
    // #(1000000) force cpu_bus=8'd46;
    // #(1000000) display_smg_in_en<=1'd1;
    // #(1000000) display_smg_in_en<=1'd0;
    // #(1000000) release cpu_bus;
end

always #(T/2) sys_clk=~sys_clk;

cpu u_cpu(
    .sys_clk    (sys_clk  ),
    .sys_rst_n  (sys_rst_n),
    .one_clock_input (one_clock_input),
    .clock_mode (clock_mode),
    // .clock_halt_en (clock_halt_en),
    .always_clock (always_clock ),
    .cpu_clock (cpu_clock),
    .cpu_clock_n (cpu_clock_n),

    .command_counter_encode (command_counter_encode),
    .command_counter_decode (command_counter_decode),

    .cpu_bus(cpu_bus),

    .a_reg_data(a_reg_data),
    .a_reg_in_en(a_reg_in_en),
    .a_reg_out_en(a_reg_out_en),

    .b_reg_data(b_reg_data),
    .b_reg_in_en(b_reg_in_en),
    .b_reg_out_en(b_reg_out_en),

    .alu_data(alu_data),
    .alu_full(alu_full),
    .alu_empty(alu_empty),
    .alu_out_en(alu_out_en),
    .alu_sub_en(alu_sub_en),

    .pc_data(pc_data),
    .pc_load(pc_load),
    .pc_en(pc_en),
    .pc_out_en(pc_out_en),

    .command_reg_data(command_reg_data),
    .command_reg_in_en(command_reg_in_en),
    .command_reg_out_en(command_reg_out_en),

    .ram_hand_address(ram_hand_address),
    .ram_hand_data(ram_hand_data),
    .ram_address(ram_address),
    .ram_data(ram_data),
    .ram_mode_select(ram_mode_select),
    .ram_hand_mode(ram_hand_mode),
    .ram_auto_mode(ram_auto_mode),

    .ram_address_lock_en(ram_address_lock_en),
    .ram_data_in_en(ram_data_in_en),
    .ram_data_out_en(ram_data_out_en),
    .ram_hand_write_en(ram_hand_write_en),

    .display_smg_in_en(display_smg_in_en),
    .seg_sel(seg_sel),
    .seg_led(seg_led)
);

endmodule