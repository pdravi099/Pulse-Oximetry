module Controller (Vppg, Find_Setting, clk, rst_n, DC_Comp, PGA_Gain, LED_IR, LED_RED,
IR_ADC_Value, RED_ADC_Value, clk_filter);
input [7:0] Vppg;
input Find_Setting;
input clk;
output reg clk_filter;
input rst_n;
output reg [6:0] DC_Comp;
output reg [3:0] PGA_Gain;
output reg LED_RED, LED_IR;
output reg [7:0] IR_ADC_Value, RED_ADC_Value;
integer o;
reg [3:0] Red_Gain, IR_Gain;
reg [6:0] Red_DC, IR_DC;

always @(posedge clk) begin
if(!rst_n) begin
clk_filter <= 0;
end
else
begin
clk_filter <= !clk_filter;
end
end
reg [3:0] State;
localparam S1 = 4'b0000;
localparam S2 = 4'b0100;
localparam S3 = 4'b1100;
localparam S4 = 4'b1000;
localparam S5 = 4'b1010;
localparam S6 = 4'b1110;
localparam S7 = 4'b0110;
localparam S8 = 4'b0010;
localparam S9 = 4'b0001;
localparam S10 = 4'b0101;
localparam S11 = 4'b1011;
integer i, j, k, l, m, n, z;
always @(posedge clk) begin

if(!rst_n) begin
State <= S1;
LED_RED <= 0;
LED_IR <= 0;
l <= 0;
m <= 0;
n <= 0;
DC_Comp <= 7'b0000000;
IR_ADC_Value <= 0;
RED_ADC_Value <= 0;
end
else if(rst_n) begin

if (Find_Setting) begin
l <= 1;
end

if (l == 1) begin
case(State)
S1: begin //State1: Initializing LEDs and introducing delay for start
PGA_Gain <= 4'b0000;
LED_RED <= 1;
LED_IR <= 0;
if (m == 2)begin
State <= S9;

end
else begin
m <= m + 1;
end

end
S9: begin //State9: Increasing DC_COMP until Vppg is 0.9V.

DC_Comp <= DC_Comp + 1;
if (Vppg < 150) begin
State <= S2;
end
end
S2: begin //State2: Increasing PGA_GAIN.
PGA_Gain <= PGA_Gain + 1;
i <= 0;
State <= S3;
end
S3: begin //State3: Detecting clipping and storing the valid settings to the registers.

if (Vppg < 4 | Vppg > 250) begin
State <= S4;
Red_DC <= DC_Comp;
Red_Gain <= PGA_Gain;
end
else
begin
if (i == 475) State <= S2;
else begin
i <= i + 1;
end
//else State <= S3;
end
end
S4: begin //State4: Initializing LEDs for finding IR_LED settings.

LED_RED <= 0;
LED_IR <= 1;
DC_Comp <= 7'b0000000;
State <= S5;
end
S5: begin //State5: Introducing delay to wait for settling Vppg signal.

PGA_Gain <= 4'b0000;
if (n == 2) begin
State <= S11;
end
else begin
n <= n + 1;
end
end
S11:begin

DC_Comp <= DC_Comp + 1;
if (Vppg < 150) begin
State <= S6;
end
end
S6: begin

PGA_Gain <= PGA_Gain + 1;
j <= 0;
k <= 0;
State <= S7;
end
S7: begin

if (Vppg < 21 | Vppg > 250) begin
LED_IR <= 0;
LED_RED <= 1;
IR_DC <= DC_Comp;
IR_Gain <= PGA_Gain;
PGA_Gain <= Red_Gain;
DC_Comp <= Red_DC;
RED_ADC_Value <= Vppg;
State <= S8;
end
else
begin
if (j == 475) State <= S6;
else begin
j <= j + 1;
end
//else State <= S3;
end
end
S8: begin //State8 and State10: Running both the LEDs at 1000Hz with respective
settings.
if (k == 4) begin
LED_RED <= !LED_RED;
LED_IR <= !LED_IR;
PGA_Gain <= IR_Gain;
DC_Comp <= IR_DC;

z <= 0;
IR_ADC_Value <= Vppg;
State <= S10;
end
else k <= k + 1;
end
S10:begin
k <= 0;
if (z == 4) begin
LED_RED <= !LED_RED;
LED_IR <= !LED_IR;
PGA_Gain <= Red_Gain;
DC_Comp <= Red_DC;
RED_ADC_Value <= Vppg;
State <= S8;
end
else z <= z + 1;
end
endcase
end
end
end
endmodule
