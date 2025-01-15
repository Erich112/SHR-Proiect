`timescale 1ns / 1ps

module segemnt_display_left(clk_100MHz, switch_in, reset_butt, pl_butt, D0_AN, D0_SEG);
  input clk_100MHz;
  input reset_butt;
  input pl_butt;
  input [7:0] switch_in;
  output reg [3:0]D0_AN;
  output reg [7:0]D0_SEG;

  reg [15:0] cnt;
  reg [3:0] Code;

  reg [19:0] div_cnt = 20'b0;

  reg [1:0] cs = 2'b00;
  reg [1:0] ns;
  wire inc;

  reg [1:0] Cs = 2'b00;
  reg [1:0] Ns;
  wire pl;

  // automat care transforma palierul activ al butonului de parallel load intr-un impuls cu latimea de o perioada de clock

  always @(posedge clk_100MHz)
  if(reset_butt==1'b1)
Cs <= 2'b00;
  else
Cs <= Ns;

  always @(Cs,pl_butt)
casex({Cs,pl_butt})
3'b00_0: Ns = 2'b00;
3'b00_1: Ns = 2'b01;
3'b01_0: Ns = 2'b00;
3'b01_1: Ns = 2'b10;
3'b10_0: Ns = 2'b00;
3'b10_1: Ns = 2'b10;
default: Ns = 2'b00;
endcase

  assign pl = (Cs == 2'b01);

  // automat care transforma palierul activ al butonului de enable count intr-un impuls cu latimea de o perioada de clock

  always @(posedge clk_100MHz)
  if(reset_butt==1'b1)
cs <= 2'b00;
  else
cs <= ns;

  always @(posedge clk_100MHz)
  if(reset_butt)
cnt <= 16'b0;
else
if(pl)
cnt <= switch_in;
   
 always @(posedge clk_100MHz)
if(reset_butt)
div_cnt <= 20'b0;
else
div_cnt <= div_cnt + 1;

 always @(div_cnt[19:18])
case(div_cnt[19:18])
2'b00: D0_AN = 4'b1110;
2'b01: D0_AN = 4'b1101;
2'b10: D0_AN = 4'b1011;
2'b11: D0_AN = 4'b0111;
endcase

 always @(div_cnt[19:18])
case(div_cnt[19:18])
2'b00: Code = cnt[3:0];
2'b01: Code = cnt[7:4];
2'b10: Code = cnt[11:8];
2'b11: Code = cnt[15:12];
endcase

  always @(Code)
case(Code)
4'b0000: D0_SEG = 8'b11000000;
4'b0001: D0_SEG = 8'b11111001;
4'b0010: D0_SEG = 8'b10100100;
4'b0011: D0_SEG = 8'b10110000;
4'b0100: D0_SEG = 8'b10011001;
4'b0101: D0_SEG = 8'b10010010;
4'b0110: D0_SEG = 8'b10000010;
4'b0111: D0_SEG = 8'b11111000;
4'b1000: D0_SEG = 8'b10000000;
4'b1001: D0_SEG = 8'b10010000;
4'b1010: D0_SEG = 8'b10001000;
4'b1011: D0_SEG = 8'b10000011;
4'b1100: D0_SEG = 8'b11000110;
4'b1101: D0_SEG = 8'b10100001;
4'b1110: D0_SEG = 8'b10000110;
4'b1111: D0_SEG = 8'b10001110;
endcase
endmodule

module segemnt_display_right(clk_100MHz, switch_in, reset_butt, pl_butt, D1_AN, D1_SEG);
  input clk_100MHz;
  input reset_butt;
  input pl_butt;
  input [7:0] switch_in;
  //output reg [15:0] led_out;
  output reg [3:0]D1_AN;
  output reg [7:0]D1_SEG;

  reg [15:0] cnt;
  reg [3:0] Code;

  reg [19:0] div_cnt = 20'b0;

  reg [1:0] cs = 2'b00;
  reg [1:0] ns;
  wire inc;

  reg [1:0] Cs = 2'b00;
  reg [1:0] Ns;
  wire pl;
  // automat care transforma palierul activ al butonului de parallel load intr-un impuls cu latimea de o perioada de clock

  always @(posedge clk_100MHz)
  if(reset_butt==1'b1)
Cs <= 2'b00;
  else
Cs <= Ns;

  always @(Cs,pl_butt)
casex({Cs,pl_butt})
3'b00_0: Ns = 2'b00;
3'b00_1: Ns = 2'b01;
3'b01_0: Ns = 2'b00;
3'b01_1: Ns = 2'b10;
3'b10_0: Ns = 2'b00;
3'b10_1: Ns = 2'b10;
default: Ns = 2'b00;
endcase

  assign pl = (Cs == 2'b01);

  // automat care transforma palierul activ al butonului de enable count intr-un impuls cu latimea de o perioada de clock

  always @(posedge clk_100MHz)
  if(reset_butt==1'b1)
cs <= 2'b00;
  else
cs <= ns;

  always @(posedge clk_100MHz)
  if(reset_butt)
cnt <= 16'b0;
else
if(pl)
cnt <= switch_in;
else
if(inc)
cnt <= cnt + 1;
   
 always @(posedge clk_100MHz)
if(reset_butt)
div_cnt <= 20'b0;
else
div_cnt <= div_cnt + 1;

 always @(div_cnt[19:18])
case(div_cnt[19:18])
2'b00: D1_AN = 4'b1110;
2'b01: D1_AN = 4'b1101;
2'b10: D1_AN = 4'b1011;
2'b11: D1_AN = 4'b0111;
endcase

 always @(div_cnt[19:18])
case(div_cnt[19:18])
2'b00: Code = cnt[3:0];
2'b01: Code = cnt[7:4];
2'b10: Code = cnt[11:8];
2'b11: Code = cnt[15:12];
endcase

  always @(Code)
case(Code)
4'b0000: D1_SEG = 8'b11000000;
4'b0001: D1_SEG = 8'b11111001;
4'b0010: D1_SEG = 8'b10100100;
4'b0011: D1_SEG = 8'b10110000;
4'b0100: D1_SEG = 8'b10011001;
4'b0101: D1_SEG = 8'b10010010;
4'b0110: D1_SEG = 8'b10000010;
4'b0111: D1_SEG = 8'b11111000;
4'b1000: D1_SEG = 8'b10000000;
4'b1001: D1_SEG = 8'b10010000;
4'b1010: D1_SEG = 8'b10001000;
4'b1011: D1_SEG = 8'b10000011;
4'b1100: D1_SEG = 8'b11000110;
4'b1101: D1_SEG = 8'b10100001;
4'b1110: D1_SEG = 8'b10000110;
4'b1111: D1_SEG = 8'b10001110;
endcase
endmodule


module sync(clk_100MHz,reset,in,out);
    input clk_100MHz, reset, in;
    output reg out;
    reg c;
   
    always @(posedge clk_100MHz)
        if(reset)
            begin
                c <= 1'b0;
                out <= 1'b0;
            end
        else
            begin
                c <= in;
                out <= c;
            end
endmodule

module one_period(clk_100MHz, reset, in, out);
    input clk_100MHz, reset, in;
    output out;
    reg[1:0] cs, ns;
   
    always @(posedge clk_100MHz)
        if(reset)
            cs <= 2'b0;
        else
            cs <= ns;
     always@ (cs or in)
        begin
        casex({cs,in})
            3'b00_0: ns<=2'b00;
            3'b00_1: ns<=2'b01;
            3'b01_0: ns<=2'b00;
            3'b01_1: ns<=2'b10;
            3'b10_0: ns<=2'b00;
            3'b10_1: ns<=2'b10;
            default: ns<=2'b00;
        endcase
    end
    assign out = (cs == 2'b01);
endmodule


module register(clk_100MHz, reset_butt, switch_in, pl_butt, led_out);
  input clk_100MHz;
  input reset_butt;
  input pl_butt;
  input [15:0] switch_in;
  output reg [15:0] led_out;
  reg [15:0] regdata;
//  always @(posedge clk_100MHz or posedge reset_butt or posedge pl_butt) begin
    always @(posedge clk_100MHz) begin

    if(reset_butt) begin
            led_out <= 16'b0;
            $display("REGISTER REZ RESET");
        end
    if (pl_butt) begin
        led_out <= switch_in;
        $display("REGISTER REZ ARE = %b",led_out);
        end
   end

endmodule

module shift_register_r (clk_100MHz, reset_butt, pl_butt, shr_butt, data_in, led_out);
    input clk_100MHz, reset_butt, pl_butt, shr_butt;              
    input [15:0] data_in;    
    output reg [15:0] led_out;
    reg [7:0] ShiftOut;  
    always @(posedge clk_100MHz) begin
        if (reset_butt) begin
            led_out <= 16'b0;
        end else if (pl_butt) begin   
            led_out <= data_in;
            $display("REGISTER SHR ARE = %b",led_out);
        end else if (shr_butt) begin
            //Shiftare la dreapta
            led_out <= {1'b0, led_out[15:1]};
            $display("REGISTER SHIFT SHR ARE = %b",led_out);
        end
    end
endmodule

module shift_register_l (clk_100MHz, reset_butt, pl_butt, shl_butt, data_in, led_out);
    input clk_100MHz, reset_butt, pl_butt, shl_butt;              
    input [15:0] data_in;    
    output reg [15:0] led_out; 

    always @(posedge clk_100MHz) begin
        if (reset_butt) begin
            led_out <= 16'b0;
        end else if (pl_butt) begin 
            led_out <= data_in;
            $display("REGISTER SHL ARE = %b",led_out);
        end else if (shl_butt) begin
            led_out <= {led_out[14:0], 1'b0};
            $display("REGISTER SHL ARE = %b",led_out);
        end
        
    end
endmodule
module swapper(in_a, in_b, out_a_swap, out_b_swap);
    input[7:0] in_a;
    input[7:0] in_b;
    output reg [15:0] out_a_swap;
    output reg [15:0] out_b_swap;
    
    always@(in_a or in_b) begin
        if(in_a < in_b) begin
            out_a_swap <= {8'b0, in_b};
            out_b_swap <= {8'b0, in_a};
        end
        else begin
            out_a_swap <= {8'b0, in_a};
            out_b_swap <= {8'b0, in_b};
        end
    end
    
endmodule

module adder(datain1, datain2, en, dataout1);
  input [15:0] datain1;
  input [15:0] datain2;
  input en;
  output reg [15:0] dataout1;
  reg [15:0] sum;
    always@(datain1 or datain2) begin
        if (en) begin
        dataout1 <= datain1 + datain2;
        $display("ADDER ARE = %b", dataout1);
        end
        
    end
endmodule

module fsm_moore_func(clk,in,out);
  input clk;
  input [3:0] in;
  // start, a=0, b=0, b[0]
  output reg [4:0] out;
  // reset, setrdyp, pla_b, plrez_sumen, shr_l
  reg [3:0] ns,cs;
  
  parameter s0=4'b0000;
  parameter s1=4'b0001;
  parameter s2=4'b0010;
  parameter s3=4'b0011;
  parameter s4=4'b0100;
  parameter s5=4'b0101;
  parameter s6=4'b0110;
  parameter s7=4'b0111;
  parameter s8=4'b1000;
  parameter s9=4'b1001;

    initial begin
        cs <= s0;
    end
  always @(posedge clk) begin
      cs<=ns;
      $display("CURRENT STARE = %b",cs);
      end
  
  always @(cs or in)
    casex({cs,in})
      8'b0000_0xxx: ns=s0;
      8'b0000_1xxx: ns=s1;
      
      8'b0001_xxxx: ns=s2;
      8'b0010_xxxx: ns=s3;
      8'b0011_x0xx: ns=s5;
      8'b0011_x1xx: ns=s4;
      
      8'b0100_xxxx: ns=s9;
      8'b0101_xx0x: ns=s6;
      8'b0101_xx1x: ns=s4;
      
      8'b0110_xxx0: ns=s8;
      8'b0110_xxx1: ns=s7;
      
      8'b0111_xxxx: ns=s8;
      8'b1000_xxxx: ns=s5;
      
      8'b1001_1xxx: ns=s9;
      8'b1001_0xxx: ns=s0;

      default: ns=s0;
      
    endcase
  
  always @(cs) begin
    case(cs)
      s0: out=5'b00000;
      s1: out=5'b10000;
      s2: out=5'b00100;
      s3: out=5'b00000;
      s4: out=5'b01000;
      s5: out=5'b00000;
      s6: out=5'b00000;
      s7: out=5'b00010;
      s8: out=5'b00001;
      s9: out=5'b00000;
    endcase
    $display("CURRENT OUTPUT STARE = %b",out);
end
endmodule

module print_led(
    in,
    en,
    out
    );
    input en;
    input [15:0] in;
    output reg [15:0] out;
    always@(in) begin
        if(en)
            out <= in;
    end
endmodule

module modulfinal(
    clk_100MHz,
    switch_in,
    start_butt,
    D1_AN,
    D1_SEG,
    D0_AN,
    D0_SEG,
    led_out
    );
   
    input [15:0] switch_in;
    input clk_100MHz;
    input start_butt;

    wire reset_rez;
    wire pla_b;
    wire sumen_plrez;
    wire shr_l;
    
    wire start_sync;
    wire [15:0] out_a;
    wire [15:0] out_b;
    wire [15:0] out_sum;
    wire [15:0] out_rez;
    
    wire clk_out_sync;
    wire clk_out_oneper;
    
    wire [15:0] reg_a_in;
    wire [15:0] reg_b_in;
    
    wire isAzero;
    wire isBzero;
    wire setrdyp;
    
    output [15:0] led_out;
    output [3:0] D1_AN;
    output [7:0] D1_SEG;
    output [3:0] D0_AN;
    output [7:0] D0_SEG;
   
    // sync sync_clk1(clk_100MHz, reset_butt, clk_100MHz, clk_out_sync);
    // one_period slow_clk2(clk_100MHz, reset_butt, clk_out_sync, clk_out_oneper);
    
   // sync sync_start(clk_100MHz, reset_butt, start_butt, start_sync);
       
    
    assign isBzero = (out_b == 8'b0) ? 1'b1 : 1'b0;
    assign isAzero = (out_a == 8'b0) ? 1'b1 : 1'b0;
    
    fsm_moore_func secventiatior(clk_100MHz, {start_butt, isAzero, isBzero, out_b[0]}, {reset_rez, setrdyp, pla_b, sumen_plrez, shr_l});
    
    //EEA
    swapper swap(switch_in[15:8], switch_in[7:0], reg_a_in, reg_b_in);
    
    shift_register_r reg_b(clk_100MHz, reset_rez, pla_b, shr_l, reg_b_in, out_b);
    segemnt_display_right cifra_b(clk_100MHz, switch_in[7:0], reset_rez, pla_b, D1_AN, D1_SEG);
    shift_register_l reg_a(clk_100MHz, reset_rez, pla_b, shr_l, reg_a_in, out_a);
    segemnt_display_left cifra_a(clk_100MHz, switch_in[15:8], reset_rez, pla_b, D0_AN, D0_SEG);
    
    adder sum(out_a, out_rez, sumen_plrez, out_sum);
    register reg_rez(clk_100MHz, reset_rez, out_sum, sumen_plrez, out_rez);
    
    print_led print(out_rez, 1'b1, led_out);
    
endmodule