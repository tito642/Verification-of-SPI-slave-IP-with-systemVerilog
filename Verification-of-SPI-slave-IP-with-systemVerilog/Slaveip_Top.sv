module Slave_tb();

// Instantiate the interface
intf spi_intf();

// Instantiate the slave module
Slave M1(spi_intf.reset, spi_intf.slaveDataToSend, spi_intf.slaveDataReceived,
        spi_intf.SCLK, spi_intf.CS, spi_intf.MOSI, spi_intf.wr_en, spi_intf.rd_en, spi_intf.MISO);


  //CLOCK Generation
  always begin
#2
  spi_intf.SCLK = 1;
#1
  spi_intf.SCLK = 0;
end

//MOSI should be hi-z if no slave selection provided
  always @ (posedge spi_intf.CS)
begin
  spi_intf.MOSI = 1'bz;
  spi_intf.rd_en = $urandom_range(1,0);
  spi_intf.wr_en = $urandom_range(1,0);
end

//Generate reset signal
always begin
#1
spi_intf.reset = 0;
if(M1.counter == 4'b1000)
#1
spi_intf.reset = 1;
end

 test_program tb(
   .SCLK(spi_intf.SCLK) // Connect the clock signal
  );

  slaveCoverage sv(spi_intf);

// Dump waveform
initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, Slave_tb);
end
endmodule