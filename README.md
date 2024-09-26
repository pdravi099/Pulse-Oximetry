# Pulse-Oximetry
Design and Implementation of Analog Frontend of Pulse Oximetry.

The design goal of this project is to implement the digital functions of the pulse oximetry method. This approach is widely used to monitor a person’s oxygen blood saturation. 

The first step is to develop an ideal Verilog-A ADC which reads the output voltage of the analog frontend and converts it to an 8-bit unsigned value. This ADC will run with a sampling frequency of 1 kHz.

After writing the code for the ADC, the main part of this project will be constructing the digital part which includes an FIR filter and the controller. This part has the following inputs: CLK, Find_Setting, rst_n and V_ADC<7:0> and the following outputs DC_Comp<6:0>, LED_Drive<3:0>, LED_IR, LED_RED, Out_IR<19:0>, Out_RED<19:0> and PGA_Gain<3:0> like shown in figure 5. These inputs and outputs are the only allowed, except a second CLK source for the filter if needed. The circuit has to run successfully a simulation without adding or removing any of the inputs or outputs.

After designing a controller, next step is to implement an FIR Filter. The separated output of the ADC needs two identical FIR filters. The coefficients are given. The
filter uses a sampling frequency of 500 Hz and has 22 coefficients. Implement the filter in Verilog and write a suitable testbench for it. To optimize the area consumption of the filter, we can use a faster
clock. Have to make sure that filter has to work with every possible input from 0 to 255.

If the controller and the filter are working properly, combine the three components into one Verilog module. Test the resulting component in Modelsim and Cadence Virtuoso.

Synthesize the design of the top module which includes the controller and the two filters with Synopsis and optimize your design based on the umc65ll process for the area. The most potential for saving area is
probably the FIR filter. Since it operates at a very low frequency, we can optimize the number of multipliers for example.

After being satisfied with the optimization Place & Route the digital Verilog controller together with the two filters with Cadence Innovus. Run Place & Route and Then optimize the floorplan and the utilization of the chip area to reduce the area of your filter.
