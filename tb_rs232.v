`timescale 1ns/1ns
module tb_rs232();

reg system_clk    ;
reg system_rst_n  ;
reg rx            ;

wire   [7:0]  po_data;
wire          po_flag;

initial
    begin
	    system_clk=1'b1;
		system_rst_n<=1'b0;
		rx<=1'b1;
		#20
		system_rst_n<=1'b1;
	end

always #10 system_clk=~system_clk;

initial
    begin
	    #200
		rx_bit(8'd0);
		rx_bit(8'd1);
		rx_bit(8'd2);
		rx_bit(8'd3);
		rx_bit(8'd4);
		rx_bit(8'd5);
		rx_bit(8'd6);
		rx_bit(8'd7);
    end

task rx_bit
(
input [7:0]  data
);

integer i;
for (i=0;i<10;i=i+1)
begin
    case(i)
	    0:rx<=1'd0;
		1:rx<=data[0];
		2:rx<=data[1];		
		3:rx<=data[2];
        4:rx<=data[3];
        5:rx<=data[4];
		6:rx<=data[5];		
		7:rx<=data[6];
        8:rx<=data[7];
        9:rx<=1'd1;
	endcase
	#(5208*20);
end
endtask


rs232  
#(
.uart_bps(9600),
.clk_freq(50000000)
)
r1
(
.system_clk    (system_clk),
.system_rst_n  (system_rst_n),
.rx            (rx),

.po_data       (po_data),
.po_flag       (po_flag)
);

endmodule