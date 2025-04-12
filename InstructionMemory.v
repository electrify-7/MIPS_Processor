module InstructionMemory#(
    parameter WIDTH = 32,
    parameter InstructionCount = 32
)(
    input [4:0] currentAddress,
    input readInstruction,
    output reg [WIDTH-1:0] instruction
);


    reg [WIDTH-1:0] InstructionMemory [0:InstructionCount-1];

    always@(*) begin
        if(readInstruction) begin
            instruction <= InstructionMemory[currentAddress];
        end
    end


    initial begin
         // add instructions from somewhere
    end


endmodule