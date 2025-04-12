module RegisterFile#(
    parameter WIDTH = 32,
    parameter REGSIZE = 5
)(
    input clk,
    input writeEnable,
    input [WIDTH-1:0] writeValue,
    input [REGSIZE-1:0] writeAddress,
    input [REGSIZE-1:0] readAddressFirst,
    input [REGSIZE-1:0] readAddressSecond,
    output logic [WIDTH-1:0] readValueFirst,
    output logic [WIDTH-1:0] readValueSecond
);

    reg [WIDTH-1:0] registerFile [0:(1<<REGSIZE)-1];

    // reading asynchronously ?
    always @(*) begin
        readValueFirst = registerFile[readAddressFirst];
        readValueSecond = registerFile[readAddressSecond];
    end

    
    always @(posedge clk) begin
        if (writeEnable) begin
            registerFile[writeAddress] <= writeValue;
          //  $display("Write Value: %d", writeValue);

        end
    end

endmodule