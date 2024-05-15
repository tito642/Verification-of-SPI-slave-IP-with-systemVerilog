`define MAX_ITERATIONS 10



// Define SlaveIP class
class SlaveIP;
    // Define variables
    rand bit [7:0] DataSend[0:`MAX_ITERATIONS - 1];
    rand bit [7:0] SDS[0:`MAX_ITERATIONS - 1];
    bit [7:0] MDS;
    bit [7:0] Recieve;
    virtual intf spi_intf;

    // Constructor to initialize variables
    function new();
        // Randomize DataSend and SDS arrays
        foreach (DataSend[i])
          DataSend[i] = $urandom;
        foreach (SDS[i])
          SDS[i] = $urandom;
    endfunction

   constraint mosi_miso_constraint {
     if(spi_intf.CS == 1)
       spi_intf.MOSI == spi_intf.MISO;
   }
endclass