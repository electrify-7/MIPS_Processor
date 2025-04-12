module ProgramCounter #(
    parameter WIDTH = 5
)(
    input clk,
    input reset,
    input [WIDTH-1:0] nextAddress,
    output logic [WIDTH-1:0] currentAddress
);

    always @(posedge clk) begin
        if(reset) currentAddress <= 5'b0;
        else begin 
            $display("Program Counter: %b", currentAddress);
            currentAddress <= nextAddress;
        end
    end


endmodule