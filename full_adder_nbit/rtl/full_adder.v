module full_adder (
	input wire a,
	input wire b,
	input wire cin,
	output wire sum,
	output wire carry
);

	wire sum1, carry1, carry2;

	half_adder ha1 (.a(a), .b(b), .sum(sum1), .carry(carry1));
	half_adder ha2 (.a(sum1), .b(cin), .sum(sum), .carry(carry2));

	assign carry = carry1 | carry2;

endmodule

