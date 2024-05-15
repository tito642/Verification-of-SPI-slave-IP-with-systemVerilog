program test_program(input SCLK);

// Instantiate the slave IP class
    SlaveIP slave_inst = new();


// Define variables
integer i, j; // Declare i and j here
bit [7:0] MDS;
bit [7:0] Recieve;
int numITerations = `MAX_ITERATIONS;

task write_task();
    int i;
    spi_intf.MOSI = slave_inst.MDS[7];
    if(!spi_intf.wr_en)
        spi_intf.MOSI = 1'bz;
    #2
    for (i = 6; i >= 0; i = i - 1) begin
        #1;
        spi_intf.MOSI = slave_inst.MDS[i];
        if(!spi_intf.wr_en)
        spi_intf.MOSI = 1'bz;
        #2;
    end
    #1;
endtask

task read_task();
    int i;
    #2
  for (i = 6; i >= 0; i = i - 1) begin
        #1;
        slave_inst.Recieve[i+1] = spi_intf.MISO;
        #2;
    end
    #1;
    slave_inst.Recieve[0] = spi_intf.MISO;
    Recieve =  slave_inst.Recieve;
endtask

// Testbench code
initial begin
    spi_intf.SCLK = 0;
    spi_intf.MOSI = 1'bz;
    spi_intf.reset = 1;
    // Test data initialization
    for (j = 0; j < numITerations; j = j + 1) begin
        slave_inst.MDS = slave_inst.DataSend[j];
        MDS = slave_inst.MDS;
        spi_intf.slaveDataToSend = slave_inst.SDS[j];
        spi_intf.CS = 1;
        #6
        spi_intf.CS = 0;
        
        fork
        write_task();
        read_task();
        join
        disable fork;

          // Assert slaveDataToSend and slaveDataReceived signals
          if(spi_intf.rd_en) begin
        assert (slave_inst.Recieve == spi_intf.slaveDataToSend)
          $display("Master received Data %x from slave successfully",slave_inst.Recieve);
            else $error("slaveDataSent FAILED");
          end

          if(spi_intf.wr_en) begin
        assert (spi_intf.slaveDataReceived == slave_inst.MDS)
          $display("Slave received Data %x from Master successfully",spi_intf.slaveDataReceived );
            else $error("slaveDataReceived FAILED");
          end
    end
    $finish;
end 
endprogram
