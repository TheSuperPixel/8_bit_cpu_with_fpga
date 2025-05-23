`timescale 1ns / 1ps

module command_counter(
    input cpu_clock_n,
    input sys_rst_n,
    output reg [2:0] command_counter_encode,
    output [5:0] command_counter_decode
    );

reg sys_rst_n_d1;
always @(posedge cpu_clock_n or negedge sys_rst_n) begin
    if (!sys_rst_n)
        sys_rst_n_d1<=1'b0;
    else 
        sys_rst_n_d1<=sys_rst_n;
end


always @(posedge cpu_clock_n or negedge sys_rst_n) begin
    if (!sys_rst_n || !sys_rst_n_d1) begin
    // if (!sys_rst_n) begin
        command_counter_encode<=0;
        // command_counter_decode<=0;
    end
    else if (command_counter_encode<3'd5) begin
        command_counter_encode<=command_counter_encode+1'b1;
    end
    else 
        command_counter_encode<=0;
    // case (command_counter_encode)
    //     3'd0: command_counter_decode<=6'd1;
    //     3'd1: command_counter_decode<=6'd2;
    //     3'd2: command_counter_decode<=6'd4;
    //     3'd3: command_counter_decode<=6'd8;
    //     3'd4: command_counter_decode<=6'd16;
    //     3'd5: command_counter_decode<=6'd32;
    //     default: 
    //         command_counter_decode<=3'd1;
    // endcase
end

assign command_counter_decode[0]= (command_counter_encode==3'd0)?  1 : 0;
assign command_counter_decode[1]= (command_counter_encode==3'd1)?  1 : 0;
assign command_counter_decode[2]= (command_counter_encode==3'd2)?  1 : 0;
assign command_counter_decode[3]= (command_counter_encode==3'd3)?  1 : 0;
assign command_counter_decode[4]= (command_counter_encode==3'd4)?  1 : 0;
assign command_counter_decode[5]= (command_counter_encode==3'd5)?  1 : 0;
endmodule
