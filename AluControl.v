module AluControl#(
    parameter WIDTH = 32,
    parameter REGSIZE = 32
)(
    input [5:0] opcode,
    input signed [REGSIZE-1:0] firstOperand,
    input signed [REGSIZE-1:0] secondOperand,
    input [5:0] funct,
    output reg signed [REGSIZE-1:0] result,
    output wire zeroFlag
);

        // R type instructions : (opcode (6) | rs (5) | rt (5) | rd (5) | shamt (5) | funct (6) )
        // Let opcode be 000000 (0); Funct:-
        //     ADD : 000000
        //     SUB : 000001
        //     AND : 000010
        //     OR  : 000011
        //     SLT : 000100

        // I type instructions : (opcode (6) | rs (5) | rt (5) | immediate (16) )
        // opcodes for lw,sw,beq:
        //     LW  : 000100 (4)
        //     SW  : 000101 (5)
        //     BEQ : 000110 (6)

        // J type instructions : (opcode (6) | jump address (26) )
        // opcode for Jump/Jal:
        //     Jump : 000010 (2)
        //     JAL  : 000011 (3)


    always@(*) begin
        case(opcode)
            6'b000000 : begin
                case(funct)
                    6'b000000: begin // ADD
                        result = firstOperand + secondOperand;
                    end
                    6'b000001: begin // SUB
                        result = firstOperand - secondOperand;
                    end
                    6'b000010: begin // AND
                        result = firstOperand & secondOperand;
                    end
                    6'b000011: begin // OR
                        result = firstOperand | secondOperand;
                    end
                    6'b000100: begin // SLT
                        result = (firstOperand < secondOperand) ? 32'b1 : 32'b0;
                    end
                    default : begin
                        result = 32'b0;
                    end
                endcase
            end
            6'b000100 : begin // lw
                result = firstOperand + secondOperand;
            end
            6'b000101 : begin // sw
                result = firstOperand + secondOperand;
            end
            6'b000110 : begin // Beq
                result = firstOperand - secondOperand;
            end
            default : begin
                result = 32'b0;
            end

        endcase

    end

    assign zeroFlag = (result == 0);
    

endmodule