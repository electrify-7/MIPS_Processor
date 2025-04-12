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
         #20 reset = 0;

        // for addition!
         dut.mem_instance.InstructionMemory[0] = 32'b00000000101010010000000000000000;
         dut.reg_instance.registerFile[5] = 15;
         dut.reg_instance.registerFile[9] = 5;

        // for consecutive subtraction;
        dut.mem_instance.InstructionMemory[1] = 32'b00000000101000000000100000000001;

         //$display("Instruction at 0 = %b", dut.mem_instance.InstructionMemory[0]);

         #100
          $display("CALCULATIONS COMPLETED");
          $display("Register 0 = %0d", $signed(dut.reg_instance.registerFile[0]));
          $display("Register 5 = %0d", $signed(dut.reg_instance.registerFile[5]));
          $display("Register 9 = %0d", $signed(dut.reg_instance.registerFile[9]));

          $display("Register 1 = %0d", $signed(dut.reg_instance.registerFile[1]));


        
    
        $finish;
    end


endmodule