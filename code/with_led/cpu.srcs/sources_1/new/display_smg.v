module display_smg (
    input display_smg_clock,
    input display_smg_flash_clock,
    input sys_rst_n,
    input [7:0] display_smg_bus,
    input display_smg_in_en,
    output reg [3:0] seg_sel,
    output reg [7:0] seg_led
);
reg [7:0] display_smg_reg;
always @(posedge display_smg_clock or negedge sys_rst_n) begin
    if (!sys_rst_n)
        display_smg_reg<=8'd0;
    else if (display_smg_in_en)
        display_smg_reg<=display_smg_bus;
end


wire [3:0] num1;
wire [3:0] num2;
wire [3:0] num3;
wire [3:0] num4;
reg [2:0] smg_status;
reg [28:0] smg_div_counter;
reg  smg_div_carry;

assign num1=display_smg_reg % 4'd10;
assign num2=display_smg_reg / 4'd10 % 4'd10;
assign num3=display_smg_reg / 7'd100 % 4'd10;
assign num4=display_smg_reg / 10'd1000 % 4'd10;

always @(posedge display_smg_flash_clock or negedge sys_rst_n) begin
    if (!sys_rst_n)begin
        smg_div_counter <= 24'd0;
        smg_div_carry<=1'b0;
    end
    else if (smg_div_counter < 28'd10_0000)begin
        smg_div_counter <= smg_div_counter + 1'b1;
        smg_div_carry<=1'b0;
    end
    else begin
        smg_div_counter <= 24'd0;
        smg_div_carry<=1'b1;
    end
end

//smg_status adder
always @(posedge display_smg_flash_clock or negedge sys_rst_n) begin
    if(!sys_rst_n)
        smg_status<=3'd0;
    else if(smg_div_carry) begin
        if(smg_status<3'd3)
            smg_status<=smg_status+1'b1;
        else
            smg_status<=0;
    end
end

//transfer
always @(posedge display_smg_flash_clock or negedge sys_rst_n) begin
    if(!sys_rst_n)
        seg_led<=1'b0;
    else begin
        if(smg_status==3'd0)begin
            seg_sel<=4'b0111;
            case (num1)
            4'h0 :    seg_led <= 8'b0011_1111;
            4'h1 :    seg_led <= 8'b0000_0110;
            4'h2 :    seg_led <= 8'b0101_1011;
            4'h3 :    seg_led <= 8'b0100_1111;
            4'h4 :    seg_led <= 8'b0110_0110;
            4'h5 :    seg_led <= 8'b0110_1101;
            4'h6 :    seg_led <= 8'b0111_1101;
            4'h7 :    seg_led <= 8'b0000_0111;
            4'h8 :    seg_led <= 8'b0111_1111;
            4'h9 :    seg_led <= 8'b0110_1111;
            4'ha :    seg_led <= 8'b0111_0111;
            4'hb :    seg_led <= 8'b0111_1100;
            4'hc :    seg_led <= 8'b0011_1001;
            4'hd :    seg_led <= 8'b0101_1110;
            4'he :    seg_led <= 8'b0111_1001;
            4'hf :    seg_led <= 8'b0111_0001;
            default : seg_led <= 8'b0011_1111;
        endcase
        end
        else if(smg_status==3'd1)begin
            seg_sel<=4'b1011;
            case (num2)
            4'h0 :    seg_led <= 8'b0011_1111;
            4'h1 :    seg_led <= 8'b0000_0110;
            4'h2 :    seg_led <= 8'b0101_1011;
            4'h3 :    seg_led <= 8'b0100_1111;
            4'h4 :    seg_led <= 8'b0110_0110;
            4'h5 :    seg_led <= 8'b0110_1101;
            4'h6 :    seg_led <= 8'b0111_1101;
            4'h7 :    seg_led <= 8'b0000_0111;
            4'h8 :    seg_led <= 8'b0111_1111;
            4'h9 :    seg_led <= 8'b0110_1111;
            4'ha :    seg_led <= 8'b0111_0111;
            4'hb :    seg_led <= 8'b0111_1100;
            4'hc :    seg_led <= 8'b0011_1001;
            4'hd :    seg_led <= 8'b0101_1110;
            4'he :    seg_led <= 8'b0111_1001;
            4'hf :    seg_led <= 8'b0111_0001;
            default : seg_led <= 8'b0011_1111;
        endcase
        end
        else if(smg_status==3'd2)begin
            seg_sel<=4'b1101;
            case (num3)
            4'h0 :    seg_led <= 8'b0011_1111;
            4'h1 :    seg_led <= 8'b0000_0110;
            4'h2 :    seg_led <= 8'b0101_1011;
            4'h3 :    seg_led <= 8'b0100_1111;
            4'h4 :    seg_led <= 8'b0110_0110;
            4'h5 :    seg_led <= 8'b0110_1101;
            4'h6 :    seg_led <= 8'b0111_1101;
            4'h7 :    seg_led <= 8'b0000_0111;
            4'h8 :    seg_led <= 8'b0111_1111;
            4'h9 :    seg_led <= 8'b0110_1111;
            4'ha :    seg_led <= 8'b0111_0111;
            4'hb :    seg_led <= 8'b0111_1100;
            4'hc :    seg_led <= 8'b0011_1001;
            4'hd :    seg_led <= 8'b0101_1110;
            4'he :    seg_led <= 8'b0111_1001;
            4'hf :    seg_led <= 8'b0111_0001;
            default : seg_led <= 8'b0011_1111;
        endcase
        end
        else if(smg_status==3'd3)begin
            seg_sel<=4'b1110;
            case (num4)
            4'h0 :    seg_led <= 8'b0011_1111;
            4'h1 :    seg_led <= 8'b0000_0110;
            4'h2 :    seg_led <= 8'b0101_1011;
            4'h3 :    seg_led <= 8'b0100_1111;
            4'h4 :    seg_led <= 8'b0110_0110;
            4'h5 :    seg_led <= 8'b0110_1101;
            4'h6 :    seg_led <= 8'b0111_1101;
            4'h7 :    seg_led <= 8'b0000_0111;
            4'h8 :    seg_led <= 8'b0111_1111;
            4'h9 :    seg_led <= 8'b0110_1111;
            4'ha :    seg_led <= 8'b0111_0111;
            4'hb :    seg_led <= 8'b0111_1100;
            4'hc :    seg_led <= 8'b0011_1001;
            4'hd :    seg_led <= 8'b0101_1110;
            4'he :    seg_led <= 8'b0111_1001;
            4'hf :    seg_led <= 8'b0111_0001;
            default : seg_led <= 8'b0011_1111;
        endcase
        end
    end
end

endmodule