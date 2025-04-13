module DataMemory#(
    parameter REGSIZE = 32
)(
    input clk,
    input read,
    input write,
    input [4:0] memoryAddress,
    input [REGSIZE-1:0] writeValue,
    output logic [REGSIZE-1:0] readValue
);

    reg [REGSIZE-1:0] memory [0:31];

    // read instantly
    always@(*) begin
        if(read) begin
            readValue = memory[memoryAddress];
        end
        else begin
            readValue = 0;
        end
    end

    // writing the data on positive clock
    always @(posedge clk) begin
        if(write) begin
            memory[memoryAddress] <= writeValue;
        end
    end

endmodule
