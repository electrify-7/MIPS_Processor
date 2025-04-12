module TopModule#(
    parameter WIDTH = 32
)(
    input clk,
    input reset
);

    // start program counter
    logic [4:0] currentAddress, nextAddress; // for instruction memory
    ProgramCounter pc_instance(
        .clk(clk),
        .reset(reset),
        .nextAddress(nextAddress),
        .currentAddress(currentAddress)
    );

    assign nextAddress = Jump ? jump_target : ((Branch && zeroFlag) ? branch_target : (currentAddress + 1));

    // start instruction memory

    logic [WIDTH-1:0] instruction;
    logic readInstruction = 1;
    InstructionMemory mem_instance(
        .currentAddress(currentAddress),
        .readInstruction(readInstruction),
        .instruction(instruction)
    );


    wire [5:0]  opcode;
    wire [4:0]  rs, rt, rd, shamt;
    wire [5:0]  funct;
    wire [15:0] immediate;
    assign opcode    = instruction[31:26];
    assign rs        = instruction[25:21];
    assign rt        = instruction[20:16];
    assign rd        = instruction[15:11];
    assign funct     = instruction[5:0];
    assign shamt     = instruction[10:6];
    assign immediate = instruction[15:0];


    logic RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, Jump,Jal;

    Control control_instance(
        .clk(clk),
        .reset(reset),
        .opcode(opcode),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .MemToReg(MemToReg),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .Jump(Jump),
        .Jal(Jal)
    );

    // use register-file to get idk stuff?
    logic [WIDTH-1:0] readValueFirst, readValueSecond, writeData;
    logic [4:0] readAddressFirst, readAddressSecond, writeRegister;
    logic writeEnable;

    assign writeEnable = RegWrite;
    assign readAddressFirst = rs;
    assign readAddressSecond = rt;
    assign writeRegister = Jal ? 5'b11111 : (RegDst ? rd : rt);
    



    RegisterFile reg_instance(
        .clk(clk),
        .writeEnable(writeEnable),
        .writeValue(writeData),
        .writeAddress(writeRegister),
        .readValueFirst(readValueFirst),
        .readValueSecond(readValueSecond),
        .readAddressFirst(readAddressFirst),
        .readAddressSecond(readAddressSecond)
    );

    // pass off to ALU
    logic [4:0] secondOperand;
    logic [WIDTH-1:0] result;
    logic zeroFlag;
    
    // choosing between immediate and rt for alu:
    assign secondOperand = ALUSrc ? {{16{immediate[15]}}, immediate} : readValueSecond; //   ------------------->> .
                                                                                                                // |
    // R type instructions : (opcode (6) | rs (5) | rt (5) | rd (5) ( destination ) | shamt (5) | funct (6) )   // |
    // I type instructions : (opcode (6) | rs (5) | rt (5) ( destination ) | immediate (16) )                   // |
                                                                                                                // |    
                                                                                                                // | 
    AluControl alu_instance(                                                                                    // |     
        .opcode(opcode),                                                                                        // |
        .firstOperand(readValueFirst),                                                                          // |
        .secondOperand(secondOperand),   // <<<--------------------------------------------------------------------.
        .funct(funct),
        .result(result),
        .zeroFlag(zeroFlag)
    );


    logic [WIDTH-1:0] writeValue, readValue;
    /////////// MEM ERROR FIX DAWG ///////////
    logic [4:0]memoryAddress;
    assign memoryAddress = result[4:0]; 




    // Alu for R type Vs Memory for I type lw (memory to reg file path):
    assign writeData = Jal ? (currentAddress + 1) : ( MemToReg ? readValue : result);

    // Incase SW then value writing would be the data from rt
    assign writeValue = readValueSecond;

    DataMemory dm_instance(
        .clk(clk),
        .read(MemRead),
        .write(MemWrite),
        .memoryAddress(memoryAddress),
        .writeValue(writeValue),
        .readValue(readValue)
    );


    // BEQ variables:
    wire [4:0] signed branch_offset = $signed(immediate[4:0]);
    wire[4:0] branch_target = currentAddress + 1 + branch_offset;

    // Jump variables:
    wire [4:0] jump_target = instruction[4:0];


endmodule