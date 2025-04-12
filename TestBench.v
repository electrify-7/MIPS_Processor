module TestBench;

logic clk;
logic reset;

TopModule dut(
    .clk(clk),
    .reset(reset)
);

always #5 clk = ~clk;


    initial begin
         clk = 0;
         reset = 1;
         #10 reset = 0;

        // // for addition!
        //  dut.mem_instance.InstructionMemory[0] = 32'b00000000101010010000000000000000;
        //  dut.reg_instance.registerFile[5] = 15;
        //  dut.reg_instance.registerFile[9] = 5;

        // // for consecutive subtraction;
        // dut.mem_instance.InstructionMemory[1] = 32'b00000000101000000000100000000001;

         //$display("Instruction at 0 = %b", dut.mem_instance.InstructionMemory[0]);

        //  #100
        //   $display("CALCULATIONS COMPLETED");
        //   $display("Register 0 = %0d", $signed(dut.reg_instance.registerFile[0]));
        //   $display("Register 5 = %0d", $signed(dut.reg_instance.registerFile[5]));
        //   $display("Register 9 = %0d", $signed(dut.reg_instance.registerFile[9]));

        //   $display("Register 1 = %0d", $signed(dut.reg_instance.registerFile[1]));

        ////////check stuff


        dut.reg_instance.registerFile[1] = 10;     // Used for ADD/SUB
        dut.reg_instance.registerFile[2] = 20;
        dut.reg_instance.registerFile[3] = -5;
        dut.reg_instance.registerFile[4] = -5;     // Same as r3, used for BEQ
        dut.reg_instance.registerFile[10] = 10;   // For memory address


        dut.dm_instance.memory[15] = 123; // For LW check

        dut.mem_instance.InstructionMemory[0] = 32'b000000_00001_00010_00101_00000_000000; // ADD r5, r1, r2
        dut.mem_instance.InstructionMemory[1] = 32'b000000_00010_00001_00110_00000_000001; // SUB r6, r2, r1
        dut.mem_instance.InstructionMemory[2] = 32'b000000_00001_00010_00111_00000_000010; // AND r7, r1, r2
        dut.mem_instance.InstructionMemory[3] = 32'b000000_00001_00010_01000_00000_000011; // OR  r8, r1, r2
        dut.mem_instance.InstructionMemory[4] = 32'b000000_00011_00010_01001_00000_000100; // SLT r9, r3, r2

        // #50
        // $display("Register 5 (ADD result) = %0d", $signed(dut.reg_instance.registerFile[5]));
        // $display("Register 6 (SUB result) = %0d", $signed(dut.reg_instance.registerFile[6]));
        // $display("Register 7 (AND result) = %0d", $signed(dut.reg_instance.registerFile[7]));
        // $display("Register 8 (OR result) = %0d", $signed(dut.reg_instance.registerFile[8]));
        // $display("Register 9 (SLT result) = %0d", $signed(dut.reg_instance.registerFile[9]));

        dut.mem_instance.InstructionMemory[5] = 32'b000110_00011_00100_00000_00000_000010;
        dut.mem_instance.InstructionMemory[6] = 32'b000000_00000_00000_00000_00000_000000;
        dut.mem_instance.InstructionMemory[7] = 32'b000000_00000_00000_00000_00000_000000;

        // LW r11, 5(r10) => r11 = mem[10 + 5] = 123
        dut.mem_instance.InstructionMemory[8] = 32'b000100_01010_01011_00000_00000_000101;

        // SW r5, 6(r10) => mem[10 + 6] = r5 = 30
        dut.mem_instance.InstructionMemory[9] = 32'b000101_01010_00101_00000_00000_000110;

        #100
        $display("Register 11 = %0d", $signed(dut.reg_instance.registerFile[11]));
        $display("mem16th location = %0d", $signed(dut.dm_instance.memory[16]));
        $display("mem15th location = %0d", $signed(dut.dm_instance.memory[15]));



        $finish;
    end


endmodule