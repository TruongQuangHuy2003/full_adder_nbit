module full_adder_nbit #(parameter N = 8) (
	input wire [N - 1 : 0] a,
	input wire [N - 1 : 0] b,
	output reg [N - 1 : 0] sum,
	output reg cout
);

wire [N - 1: 0] carry_internal;
wire [N - 1: 0] sum_internal;

genvar i;

initial begin
	if (N < 2 || N > 32) begin
		$display("-------------------------------------------------------------------------");
		$display("-----------------ERROR: N out of range (1 < N < 33)----------------------");
		$display("-------------------------------------------------------------------------");
	end
end
generate
	for (i = 0; i < N; i = i + 1) begin
		if (i == 0) begin
			full_adder ic (.a(a[i]), .b(b[i]), .cin(1'b0), .sum(sum_internal[i]), .carry(carry_internal[i]));
		end else begin
			full_adder ic (.a(a[i]), .b(b[i]), .cin(carry_internal[i-1]), .sum(sum_internal[i]), .carry(carry_internal[i]));
		end
	end
endgenerate

always @(*) begin
	sum = sum_internal;
	cout = carry_internal[N-1];
end

endmodule

