module DataMemory#(
    parameter REGSIZE = 32
)(
    input clk,
   // input read_or_write
    input read,
    input write,
    input [4:0] memoryAddress,
    input [REGSIZE-1:0] writeValue,
    output reg [REGSIZE-1:0] readValue
);

    reg [REGSIZE-1:0] memory [0:31];
    reg hasValue[0:31];

    // read instantly
        always@(*) begin
            if(read) begin
                readValue = hasValue[memoryAddress] ? memory[memoryAddress] : {REGSIZE{1'bx}};
            end
            else begin
                readValue = 0;
            end
        end


    // writing the data on positive clock UwU
    always @(posedge clk) begin
            if(write) begin
                memory[memoryAddress] <= writeValue;
                hasValue[memoryAddress] <= 1'b1;
            end
    end


endmodule