`timescale 1ns / 1ps

module cpu(
    input sys_clk,
    input sys_rst_n,
    input one_clock_input,
    input clock_mode,
    // input clock_halt_en,
    output wire always_clock,
    output wire cpu_clock,
    output wire cpu_clock_n,

    output wire [2:0] command_counter_encode,
    output wire [5:0] command_counter_decode,

    output  [7:0] cpu_bus,

    output wire [7:0] a_reg_data,
    output a_reg_in_en,
    output a_reg_out_en,

    output wire [7:0] b_reg_data,
    output b_reg_in_en,
    output b_reg_out_en,

    output wire [7:0] alu_data,
    output alu_full,
    output alu_empty,
    output alu_out_en,
    output alu_sub_en,

    output wire [3:0] pc_data,
    output pc_load,
    output pc_en,
    output pc_out_en,

    output wire [7:0] command_reg_data,
    output command_reg_in_en,
    output command_reg_out_en,

    input [3:0] ram_hand_address,
    input [7:0] ram_hand_data,
    output [3:0] ram_address,
    output [7:0] ram_data,
    input ram_mode_select,
    output ram_hand_mode,
    output ram_auto_mode,

    output ram_address_lock_en,
    output ram_data_in_en,
    output ram_data_out_en,
    input ram_hand_write_en,

    output display_smg_in_en,
    output [3:0] seg_sel,
    output [7:0] seg_led
);
wire alu_flag_in_en;
// wire cpu_clock;

clock u_clock(
    .sys_clk    (sys_clk  ),
    .sys_rst_n  (sys_rst_n),
    .one_clock_input (one_clock_input),
    .clock_mode (clock_mode),
    .clock_halt_en (clock_halt_en),
    .always_clock (always_clock ),
    .cpu_clock (cpu_clock),
    .cpu_clock_n (cpu_clock_n)
);

command_counter u_command_counter(
    .cpu_clock_n (cpu_clock_n),
    .sys_rst_n (sys_rst_n),
    .command_counter_encode (command_counter_encode),
    .command_counter_decode (command_counter_decode)
    );

// wire [7:0] cpu_bus;
a_reg u_a_reg(
    .a_reg_bus(cpu_bus),
    .a_reg_data(a_reg_data),
    .a_reg_clk(cpu_clock),
    .a_reg_reset_n(sys_rst_n),
    .a_reg_in_en(a_reg_in_en),
    .a_reg_out_en(a_reg_out_en)
    );
b_reg u_b_reg(
    .b_reg_bus(cpu_bus),
    .b_reg_data(b_reg_data),
    .b_reg_clk(cpu_clock),
    .b_reg_reset_n(sys_rst_n),
    .b_reg_in_en(b_reg_in_en),
    .b_reg_out_en(b_reg_out_en)
    );
alu u_alu(
    .alu_bus(cpu_bus),
    .alu_clock(cpu_clock),
    .alu_reset_n(sys_rst_n),
    .alu_in_a(a_reg_data),
    .alu_in_b(b_reg_data),
    .alu_data(alu_data),
    .alu_full(alu_full),
    .alu_empty(alu_empty),
    .alu_out_en(alu_out_en),
    .alu_sub_en(alu_sub_en),
    .alu_flag_in_en(alu_flag_in_en)
);

program_counter u_program_counter(
    .pc_bus(cpu_bus),
    .pc_data(pc_data),
    .pc_reset_n(sys_rst_n),
    .pc_load(pc_load),
    .pc_en(pc_en),
    .pc_clock(cpu_clock),
    .pc_out_en(pc_out_en)
);

command_reg u_command_reg(
    .command_reg_bus(cpu_bus),
    .command_reg_data(command_reg_data),
    .command_reg_clk(cpu_clock),
    .command_reg_reset_n(sys_rst_n),
    .command_reg_in_en(command_reg_in_en),
    .command_reg_out_en(command_reg_out_en)
);
ram u_ram(
    .ram_clock(cpu_clock),
    .sys_rst_n(sys_rst_n),
    .sys_clk(sys_clk),

    .ram_bus(cpu_bus),//!!!!
    .ram_hand_address(ram_hand_address),
    .ram_hand_data(ram_hand_data),
    .ram_address(ram_address),
    .ram_data(ram_data),

    .ram_mode_select(ram_mode_select),//0->自动 1->手动  
    .ram_hand_mode(ram_hand_mode),
    .ram_auto_mode(ram_auto_mode),

    .ram_address_lock_en(ram_address_lock_en),
    .ram_data_in_en(ram_data_in_en),
    .ram_data_out_en(ram_data_out_en),

    .ram_hand_write_en(ram_hand_write_en)
);

display_smg u_display_smg(
    .display_smg_clock(cpu_clock),
    .display_smg_flash_clock(sys_clk),
    .sys_rst_n(sys_rst_n),
    .display_smg_bus(cpu_bus),
    .display_smg_in_en(display_smg_in_en),
    .seg_sel(seg_sel),
    .seg_led(seg_led)
);
control_unit u_control_unit(
    .sys_rst_n(sys_rst_n),

    .command_counter_encode(command_counter_encode),
    .command_reg_data(command_reg_data),

    .alu_full(alu_full),
    .alu_empty(alu_empty),

    .clock_halt_en(clock_halt_en),//

    .a_reg_in_en(a_reg_in_en),//
    .a_reg_out_en(a_reg_out_en),//
    .b_reg_in_en(b_reg_in_en),//
    .b_reg_out_en(b_reg_out_en),//
    .alu_out_en(alu_out_en),//
    .alu_sub_en(alu_sub_en),//

    .pc_load(pc_load),//
    .pc_en(pc_en),//
    .pc_out_en(pc_out_en),//

    .command_reg_in_en(command_reg_in_en),//
    .command_reg_out_en(command_reg_out_en),//

    .ram_address_lock_en(ram_address_lock_en),//
    .ram_data_in_en(ram_data_in_en),//
    .ram_data_out_en(ram_data_out_en),//

    .display_smg_in_en(display_smg_in_en),//
    .alu_flag_in_en(alu_flag_in_en)
);

reg [7:0] cpu_bus_ila;
reg [7:0] a_reg_data_ila;
reg [7:0] b_reg_data_ila;
reg [7:0] alu_data_ila;
reg [3:0] pc_data_ila;
reg [3:0] ram_address_ila;
reg [7:0] ram_data_ila;
reg [2:0] command_counter_encode_ila;
reg [5:0] command_counter_decode_ila;
reg [7:0] command_reg_data_ila;
reg cpu_clock_ila;
reg cpu_clock_n_ila;
reg a_reg_in_en_ila;
reg a_reg_out_en_ila;
reg b_reg_in_en_ila;
reg b_reg_out_en_ila;
reg alu_full_ila;
reg alu_empty_ila;
reg alu_out_en_ila;
reg alu_sub_en_ila;
reg pc_load_ila;
reg pc_en_ila;
reg pc_out_en_ila;
reg command_reg_in_en_ila;
reg command_reg_out_en_ila;
reg ram_hand_mode_ila;
reg ram_auto_mode_ila;
reg ram_address_lock_en_ila;
reg ram_data_in_en_ila;
reg ram_data_out_en_ila;
reg display_smg_in_en_ila;
reg sys_rst_n_ila;
always @(posedge sys_clk) begin
    cpu_bus_ila<=cpu_bus;
    a_reg_data_ila<=a_reg_data;
    b_reg_data_ila<=b_reg_data;
    alu_data_ila<=alu_data;
    pc_data_ila<=pc_data;
    ram_address_ila<=ram_address;
    ram_data_ila<=ram_data;
    command_counter_encode_ila<=command_counter_encode;
    command_counter_decode_ila<=command_counter_decode;
    command_reg_data_ila<=command_reg_data;
    cpu_clock_ila<=cpu_clock;
    cpu_clock_n_ila<=cpu_clock_n;
    a_reg_in_en_ila<=a_reg_in_en;
    a_reg_out_en_ila<=a_reg_out_en;
    b_reg_in_en_ila<=b_reg_in_en;
    b_reg_out_en_ila<=b_reg_out_en;
    alu_full_ila<=alu_full;
    alu_empty_ila<=alu_empty;
    alu_out_en_ila<=alu_out_en;
    alu_sub_en_ila<=alu_sub_en;
    pc_load_ila<=pc_load;
    pc_en_ila<=pc_en;
    pc_out_en_ila<=pc_out_en;
    command_reg_in_en_ila<=command_reg_in_en;
    command_reg_out_en_ila<=command_reg_out_en;
    ram_hand_mode_ila<=ram_hand_mode;
    ram_auto_mode_ila<=ram_auto_mode;
    ram_address_lock_en_ila<=ram_address_lock_en;
    ram_data_in_en_ila<=ram_data_in_en;
    ram_data_out_en_ila<=ram_data_out_en;
    display_smg_in_en_ila<=display_smg_in_en;
    sys_rst_n_ila<=sys_rst_n;
end


ila_0 your_instance_name (
	.clk(sys_clk), // input wire clk
	.probe0(cpu_bus_ila), // input wire [7:0]  probe0  
	.probe1(a_reg_data_ila), // input wire [7:0]  probe1 
	.probe2(b_reg_data_ila), // input wire [7:0]  probe2 
	.probe3(alu_data_ila), // input wire [7:0]  probe3 
	.probe4(pc_data_ila), // input wire [3:0]  probe4 
	.probe5(ram_address_ila), // input wire [3:0]  probe5 
	.probe6(ram_data_ila), // input wire [7:0]  probe6 
	.probe7(command_counter_encode_ila), // input wire [2:0]  probe7 
	.probe8(command_counter_decode_ila), // input wire [5:0]  probe8 
	.probe9(command_reg_data_ila), // input wire [7:0]  probe9 
	.probe10(cpu_clock_ila), // input wire [0:0]  probe10 
	.probe11(cpu_clock_n_ila), // input wire [0:0]  probe11 
	.probe12(a_reg_in_en_ila), // input wire [0:0]  probe12 
	.probe13(a_reg_out_en_ila), // input wire [0:0]  probe13 
	.probe14(b_reg_in_en_ila), // input wire [0:0]  probe14 
	.probe15(b_reg_out_en_ila), // input wire [0:0]  probe15 
	.probe16(alu_full_ila), // input wire [0:0]  probe16 
	.probe17(alu_empty_ila), // input wire [0:0]  probe17 
	.probe18(alu_out_en_ila), // input wire [0:0]  probe18 
	.probe19(alu_sub_en_ila), // input wire [0:0]  probe19 
	.probe20(pc_load_ila), // input wire [0:0]  probe20 
	.probe21(pc_en_ila), // input wire [0:0]  probe21 
	.probe22(pc_out_en_ila), // input wire [0:0]  probe22 
	.probe23(command_reg_in_en_ila), // input wire [0:0]  probe23 
	.probe24(command_reg_out_en_ila), // input wire [0:0]  probe24 
	.probe25(ram_hand_mode_ila), // input wire [0:0]  probe25 
	.probe26(ram_auto_mode_ila), // input wire [0:0]  probe26 
	.probe27(ram_address_lock_en_ila), // input wire [0:0]  probe27 
	.probe28(ram_data_in_en_ila), // input wire [0:0]  probe28 
	.probe29(ram_data_out_en_ila), // input wire [0:0]  probe29 
	.probe30(display_smg_in_en_ila), // input wire [0:0]  probe30
    .probe31(sys_rst_n_ila) // input wire [0:0]  probe31
);

endmodule
