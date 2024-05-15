// Define interface
interface intf;
    logic reset;
    logic [7:0] slaveDataToSend;
    logic [7:0] slaveDataReceived;
    logic SCLK, CS, MOSI;
    logic wr_en ,rd_en;
    logic MISO;

    clocking spi_clocking @(posedge SCLK);
        input reset;
        output MOSI, CS;
        input MISO;
        input wr_en ,rd_en;
    endclocking
endinterface