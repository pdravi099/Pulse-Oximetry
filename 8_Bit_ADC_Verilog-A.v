`include "disciplines.vams"
`include "constants.vams"

module ideal_adc(in,clk,out);
input in,clk;
output [7:0] out;
voltage in,clk;
voltage [7:0] out;
parameter real fullscale = 1.8;
parameter real delay_ = 0, trise = 5n, tfall = 5n;
parameter real clk_vth = 0.9;
parameter real out_high = 1.8, out_low = 0 from (-inf:out_high);
real sample,thresh;
real result[7:0];
integer i;

analog
begin
@(cross(V(clk)-clk_vth, +1))
begin
sample = V(in);
thresh = fullscale/2;
for(i=7;i>=0;i=i-1)
begin
if (sample > thresh)
begin
result[i] = out_high;
sample = sample - thresh;
end
else result[i] = out_low;
sample = 2*sample;
end
end
V(out[0]) <+ transition(result[0],delay_,trise,tfall);
V(out[1]) <+ transition(result[1],delay_,trise,tfall);
V(out[2]) <+ transition(result[2],delay_,trise,tfall);
V(out[3]) <+ transition(result[3],delay_,trise,tfall);
V(out[4]) <+ transition(result[4],delay_,trise,tfall);
V(out[5]) <+ transition(result[5],delay_,trise,tfall);
V(out[6]) <+ transition(result[6],delay_,trise,tfall);
V(out[7]) <+ transition(result[7],delay_,trise,tfall);
end
endmodule
