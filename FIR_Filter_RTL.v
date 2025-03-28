module FIR_FILTER2 (clk, rst_n,IR_ADC_Value, Out_IR_Filtered);
//parameter N = 8, 8 bit;
input clk, rst_n;
input [7:0] IR_ADC_Value;
output reg [19:0] Out_IR_Filtered;
//Controller dut(.clk(clk),.rst_n(rst_n),.Out_IR(IR_ADC_Value));
// coefficients defination
// Moving Average Filter, 3rd order
// four coefficients; 1/(order+1) = 1/4 = 0.25
// 0.25 x 128(scaling factor) = 32 = 6'b100000
wire [7:0] b0 = 8'b00000010;
wire [7:0] b1 = 8'b00001010;
wire [7:0] b2 = 8'b00010000;
wire [7:0] b3 = 8'b00011100;
wire [7:0] b4 = 8'b00101011;
wire [7:0] b5 = 8'b00111100;
wire [7:0] b6 = 8'b01001110;
wire [7:0] b7 = 8'b01011111;
wire [7:0] b8 = 8'b01101111;
wire [7:0] b9 = 8'b01110111;
wire [7:0] b10 = 8'b10000000;
wire [7:0] b11 = 8'b10000000;
wire [7:0] b12 = 8'b01110111;
wire [7:0] b13 = 8'b01101111;
wire [7:0] b14 = 8'b01011111;
wire [7:0] b15 = 8'b01001110;
wire [7:0] b16 = 8'b00111100;
wire [7:0] b17 = 8'b00101011;
wire [7:0] b18 = 8'b00011100;
wire [7:0] b19 = 8'b00010000;
wire [7:0] b20 = 8'b00001010;
wire [7:0] b21 = 8'b00000010;
reg [7:0] x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21;
always@(posedge clk)
begin
if (!rst_n) begin
x2 <= 0;
x3 <= 0;
x4 <= 0;
x5 <= 0;
x6 <= 0;
x7 <= 0;
x8 <= 0;
x9 <= 0;
x10 <= 0;
x11 <= 0;
x12 <= 0;
x13 <= 0;
x14 <= 0;
x15 <= 0;
x16 <= 0;
x17 <= 0;
x18 <= 0;
x19 <= 0;
x20 <= 0;
x21 <= 0;
end
else begin
x1 <= IR_ADC_Value;
x2 <= x1;
x3 <= x2;
x4 <= x3;
x5 <= x4;
x6 <= x5;
x7 <= x6;
x8 <= x7;
x9 <= x8;
x10 <= x9;
x11 <= x10;
x12 <= x11;
x13 <= x12;
x14 <= x13;
x15 <= x14;
x16 <= x15;
x17 <= x16;
x18 <= x17;
x19 <= x18;
x20 <= x19;
x21 <= x20;
end
end
// Multiplication
wire [19:0] Mul0, Mul1, Mul2, Mul3,Mul4, Mul5, Mul6, Mul7,Mul8, Mul9, Mul10, Mul11,Mul12,
Mul13, Mul14, Mul15,Mul16, Mul17, Mul18, Mul19,Mul20, Mul21;
assign Mul0 = IR_ADC_Value * b0;
assign Mul1 = x1 * b1;
assign Mul2 = x2 * b2;
assign Mul3 = x3 * b3;
assign Mul4 = x4 * b4;
assign Mul5 = x5 * b5;
assign Mul6 = x6 * b6;
assign Mul7 = x7 * b7;
assign Mul8 = x8 * b8;
assign Mul9 = x9 * b9;
assign Mul10 = x10 * b10;
assign Mul11 = x11 * b11;
assign Mul12 = x12 * b12;
assign Mul13 = x13 * b13;
assign Mul14 = x14 * b14;
assign Mul15 = x15 * b15;
assign Mul16 = x16 * b16;
assign Mul17 = x17 * b17;
assign Mul18 = x18 * b18;
assign Mul19 = x19 * b19;
assign Mul20 = x20 * b20;
assign Mul21 = x21 * b21;
// Addition operation
wire [19:0] Add_final;
assign Add_final = Mul0 + Mul1 + Mul2 + Mul3 + Mul4 + Mul5 + Mul6 + Mul7 + Mul8 + Mul9 +
Mul10 + Mul11 + Mul12 + Mul13 + Mul14 + Mul15+ Mul16 + Mul17 + Mul18 + Mul19 + Mul20
+ Mul21;
// Final calculation to output
always@(posedge clk)
Out_IR_Filtered <= Add_final;
endmodule
