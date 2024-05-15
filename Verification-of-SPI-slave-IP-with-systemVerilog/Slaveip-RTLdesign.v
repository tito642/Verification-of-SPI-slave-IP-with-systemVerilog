module Slave
(
	input reset,
	input [7:0]slaveDataToSend, 
	output [7:0]slaveDataReceived,
	input SCLK, CS, MOSI,
    input wr_en ,rd_en,
	output reg MISO
);
integer counter;
reg [7:0] SDS;
reg [7:0] SDR;

wire [7:0] SDS_next;
wire [7:0] SDR_next;

always @ (negedge CS)
begin
	counter = 0;
	SDS = slaveDataToSend;
end

always @(posedge SCLK , posedge reset)
begin
if(reset==1'b1)
begin
	SDS=slaveDataToSend;
	SDR=0;
	counter = 0;
end
else
begin 
	SDR=SDR_next;
	SDS=SDS_next;
	counter = counter+1;
end

end
  assign SDS_next = (CS==1'b0&&counter<=8 &&counter >0 && rd_en)?{ SDS[6:0],1'b0 }:SDS;
  assign SDR_next = (CS==1'b0&&counter<=8 && wr_en )?{SDR[6:0],MOSI}:SDR;
assign MISO = (CS==1'b0 && rd_en)? SDS[7]:1'bz;
assign slaveDataReceived = SDR;


endmodule