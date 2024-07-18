module uart_rx
#(
parameter    uart_bps   'd9600,
parameter    clk_freq   'd50000000

)
(
input wire   system_clk,
input wire   system_rst_n,
input wire   rx,

output reg   [7:0]po_data,
output reg   po_flag
);

parameter    BAUD_CNT_MAX    clk_freq/uart_bps;


reg   ;
reg   rx_reg2;
reg   rx_reg3;
reg   start_flag;
reg   work_en;
reg   [15:0]baud_cnt;
reg   bit_flag;
reg   [3:0]bit_cnt;
reg   [7:0]rx_data;
reg   rx_flag;


always@(posedge system_clk or negedge system_rst_n)
    if (system_rst_n=1'b0)
	    rx_reg1<=1'b1;
    else
	    rx_reg1<=rx;

always@(posedge system_clk or negedge system_rst_n)
    if (system_rst_n=1'b0)
	    rx_reg2<=1'b1;
    else
	    rx_reg2<=rx_reg1;

always@(posedge system_clk or negedge system_rst_n)
    if (system_rst_n=1'b0)
	    rx_reg3<=1'b1;
    else
	    rx_reg3<=rx_reg2;
always@(posedge system_clk or negedge system_rst_n)
    if (system_rst_n=1'b0)
	    start_flag<=1'b0;
	else if((rx_reg3==1'b1)&&(rx_reg2==1'b0)&&(work_en==1'b0))
	    start_flag<=1'b1;
    else
	    start_flag<=1'b0;
		
always@(posedge system_clk or negedge system_rst_n)
    if (system_rst_n=1'b0)
	    work_en<=1'b0;
	else if (start_flag==1'b1)
	    work_en<=1'b1;
	else if ((bit_cnt==4'd8)&&(bit_flag==1'b1))
	    work_en<=1'b0;
	
always@(posedge system_clk or negedge system_rst_n)
    if (system_rst_n=1'b0)
	    baud_cnt<=16'd0;
	else if ((baud_cnt==BAUD_CNT_MAX-1)||(work_en==1'b0))
	    baud_cnt<=16'd0;
	else
	    baud_cnt<=baud_cnt+1'b1;
	
always@(posedge system_clk or negedge system_rst_n)
    if (system_rst_n=1'b0)
	    bit_flag<=1'b0;
    else if (bit_cnt==BAUD_CNT_MAX/2-1)
	    bit_flag<=1'b1;
	else
	    bit_flag<=1'b0;

always@(posedge system_clk or negedge system_rst_n)
    if (system_rst_n=1'b0)
	    bit_cnt<=4'd0;
	else if ((bit_cnt==4'd8)&&(bit_flag==1'b1))
	    bit_cnt<=4'd0;
	else if (bit_flag==1'b1)
	    
always@(posedge system_clk or negedge system_rst_n)
    if (system_rst_n=1'b0)
	    rx_data<=8'd0;
	else if((bit_cnt>=4'd1)&&(bit_cnt<=4'd8)&&(bit_flag==1'b1))
	    rx_data={rx_reg3,rx_data[7:1]};
always@(posedge system_clk or negedge system_rst_n)
    if (system_rst_n=1'b0)
	    rx_flag<=1'b0;
	else if ((bit_cnt==4'd8)&&(bit_flag==1'b1))
	    rx_flag<=1'b1;
    else
	    rx_flag<=1'b0;

always@(posedge system_clk or negedge system_rst_n)
    if (system_rst_n=1'b0)
        po_data<=8'd0;
    else if (rx_flag==1'b1)
        po_data<=rx_data;

always@(posedge system_clk or negedge system_rst_n)
    if (system_rst_n=1'b0)
	    po_flag<=1'b0;
	else
	    po_flag<=rx_flag;

		

endmodule