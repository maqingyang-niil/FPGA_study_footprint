`timescale 1ns/1ns
module tb_rs232_tx();

reg  system_clk  ;
reg  system_rst_n;
reg  [7:0]pi_data;
reg  pi_flag     ;
wire tx          ;

initial
    begin
	    system_clk=1'b1;
		system_rst_n<=1'b0;
		#20
		system_rst_n<=1'b1;
	end

always #10 system_clk=~system_clk;

initial
    begin
	    pi_data<=8'd0;
		pi_flag<=1'b0;
		#200
		//数据0
		pi_data<=8'd0;
		pi_flag<=1'b1;
		#20
		pi_flag<=1'b0;
		#(5208*20*10);
		//数据1
		pi_data<=8'd1;
		pi_flag<=1'b1;
		#20
		pi_flag<=1'b0;
		#(5208*20*10);
		//数据2
		pi_data<=8'd2;
		pi_flag<=1'b1;
		#20
		pi_flag<=1'b0;
		#(5208*20*10);
		//数据3
		pi_data<=8'd3;
		pi_flag<=1'b1;
		#20
		pi_flag<=1'b0;
		#(5208*20*10);
		//数据4
		pi_data<=8'd4;
		pi_flag<=1'b1;
		#20
		pi_flag<=1'b0;
		#(5208*20*10);
		//数据5
		pi_data<=8'd5;
		pi_flag<=1'b1;
		#20
		pi_flag<=1'b0;
		#(5208*20*10);
		//数据6
		pi_data<=8'd6;
		pi_flag<=1'b1;
		#20
		pi_flag<=1'b0;
		#(5208*20*10);
		//数据7
		pi_data<=8'd7;
		pi_flag<=1'b1;
		#20
		pi_flag<=1'b0;
	end

rs232_tx
#(
.uart_bps(9600),
.clk_freq(50000000)
)
r2
(
.system_clk    (system_clk  ),
.system_rst_n  (system_rst_n),
.pi_data       (pi_data     ),
.pi_flag       (pi_flag     ),
.tx            (tx          )
);

endmodule