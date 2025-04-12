module Control#(
    parameter WIDTH = 32
)(
    input clk,
    input reset,
    input [5:0] opcode,
    output logic RegDst,
    output logic ALUSrc,
    output logic MemToReg,
    output logic RegWrite,
    output logic MemRead,
    output logic MemWrite,
    output logic Branch,
    output logic Jump,
    output logic Jal
);

        // R type instructions : (opcode (6) | rs (5) | rt (5) | rd (5) | shamt (5) | funct (6) )
        // Let opcode be 000000 (0); Funct:-
            // ADD : 000000
            // SUB : 000001
            // AND : 000010
            // OR  : 000011
            // SLT : 000100

        // I type instructions : (opcode (6) | rs (5) | rt (5) | immediate (16) )
        // opcodes for lw,sw,beq:
            // LW  : 000100 (4)
            // SW  : 000101 (5)
            // BEQ : 000110 (6)

        // J type instructions : (opcode (6) | jump address (26) )
        // opcode for Jump/Jal:
            // Jump : 000010 (2)
            // JAL  : 000011 (3)


    always @(*) begin
        case(opcode)
        6'b000000 : begin
            RegDst   = 1;     // Destination is rd.
            ALUSrc   = 0;     // Second ALU operand comes from register.
            MemToReg = 0;     // Write ALU result. (Final stage in WB ed of diagram)
            RegWrite = 1;     // Enable register write. 
            MemRead  = 0;     // no use :(
            MemWrite = 0;     // no use :(
            Branch   = 0;     // no use :(
            Jump     = 0;     // no use :(
            Jal      = 0;
        end
        6'b000100 : begin // lw
            RegDst   = 0;     // Destination is rt.
            ALUSrc   = 1;     // Second operand is immediate.
            MemToReg = 1;     // Write data from memory.
            RegWrite = 1;     // Enable register write.
            MemRead  = 1;     // Enable memory read.
            MemWrite = 0;     // no use :(
            Branch   = 0;     // no use :(
            Jump     = 0;     // no use :(
            Jal      = 0;
        end
        6'b000101 : begin // sw
            RegDst   = 0;     // no use :(
            ALUSrc   = 1;     // Use immediate for address.
            MemToReg = 0;     // no use :(
            RegWrite = 0;     // no use :(
            MemRead  = 0;     // no use :(
            MemWrite = 1;     // Enable memory write.
            Branch   = 0;     // no use :(
            Jump     = 0;     // no use :(
            Jal      = 0;
        end
        6'b000110 : begin // beq
            RegDst   = 0;     // no use :(
            ALUSrc   = 0;     // Second ALU operand comes from register. ( rs == rt condition )
            MemToReg = 0;     // no use :(
            RegWrite = 0;     // no use :(
            MemRead  = 0;     // no use :(
            MemWrite = 0;     // no use :(
            Branch   = 1;     // Enable branch.
            Jump     = 0;     // no use :(
            Jal      = 0;
        end
        6'b000010 : begin // jump
        RegDst   = 0;     // no use :(
        ALUSrc   = 0;     // no use :(
        MemToReg = 0;     // no use :(
        RegWrite = 0;     // no use :(
        MemRead  = 0;     // no use :(
        MemWrite = 0;     // no use :(
        Branch   = 0;     // no use :(
        Jump     = 1;     // Enable jump.
        Jal      = 0;
        end
        6'b000011 : begin // jal
        RegDst   = 0;     // no use.
        ALUSrc   = 0;     // no use :(
        MemToReg = 0;     // no use :(
        RegWrite = 1;     // store in last register
        MemRead  = 0;     // no use :(
        MemWrite = 0;     // no use :(
        Branch   = 0;     // no use :(
        Jump     = 1;     // next address to be immediate 26
        Jal      = 1;     // Jump and link.
        end
        default : begin
            RegDst   = 0;
            ALUSrc   = 0;
            MemToReg = 0;
            RegWrite = 0;
            MemRead  = 0;
            MemWrite = 0;
            Branch   = 0;
            Jump     = 0;
            Jal      = 0;
        end

        endcase

    end


endmodule