module slaveCoverage(intf spi_intf);
 // Coverage group definition
    covergroup spi_coverage;
    option.per_instance = 1; // Allows per-instance coverage

    // Coverage points for Full and Empty flags
      coverpoint(spi_intf.MOSI) {
        bins MOSI_is_true = {1'b1}; // Bin for full being true
        bins MOSI_is_false = {1'b0}; // Bin for full being false
    }

      coverpoint(spi_intf.MISO) {
        bins MISO_is_true = {1'b1}; // Bin for empty being true
        bins MISO_is_false = {1'b0}; // Bin for empty being false
    }

      coverpoint(spi_intf.wr_en) {
        bins wr_is_true = {1'b1}; // Bin for empty being true
        bins wr_is_false = {1'b0}; // Bin for empty being false
    }

      coverpoint(spi_intf.rd_en) {
        bins rd_is_true = {1'b1}; // Bin for empty being true
        bins rd_is_false = {1'b0}; // Bin for empty being false
    }
    endgroup

     spi_coverage fc = new;
endmodule
