module load_3 (
    clk, 
    rst,
    s0,
    s1,
    s2,
    result
    );

input clk;
input rst;
input [7:0] s0;
input [7:0] s1;
input [7:0] s2;
output [63:0] result;
wire clk;
wire rst;
wire [7:0] s0;
wire [7:0] s1;
wire [7:0] s2;
reg [63:0] result;


always @ (posedge clk)
begin
    result <= s0 | (s1 << 8) | (s2 << 16);
end

endmodule