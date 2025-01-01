`timescale 1ns/1ps
module test_bench;
	parameter N = 8;

	reg [N - 1 : 0] a;
	reg [N - 1 : 0] b;
	wire [N - 1 : 0] sum;
	wire cout;

	full_adder_nbit #(N) dut (
		.a(a),
		.b(b),
		.sum(sum),
		.cout(cout)
	);

	integer i;

	initial begin
		$dumpfile("test_bench.vcd");
		$dumpvars(0, test_bench);
		
		$display("-------------------------------------------------------------------------------------------------");
		$display("-------------------------------TESTBENCH FOR FULL ADDER %D BIT-----------------------------------",N);
		$display("-------------------------------------------------------------------------------------------------");
		
		for (i = 0; i < 100; i = i + 1) begin
			a = $random % (1 << N);
			b = $random % (1 << N);
			#1;
			check_result(calc_expected(a,b));
			#10;
		end
		

	end

	function [N : 0] calc_expected (input [N - 1 : 0] a_val, input [N - 1 : 0] b_val);
		begin
			calc_expected = a_val + b_val;
		end
	endfunction

	task check_result(input [N : 0] expected_result);
		begin
			 $display("At time: %t, a =%b, b = %b",$time, a, b);
			 if (sum == expected_result[N - 1: 0] && cout == expected_result[N]) begin
				 $display("-------------------------------------------------------------------------------------------------");
				 $display("PASSED: Expected_sum: %b, Got_sum: %b, Expected_cout: 1'b%b, Got_cout: 1'b%b", expected_result[N - 1 : 0], sum, expected_result[N], cout);
				 $display("-------------------------------------------------------------------------------------------------");
			 end else begin
				 $display("-------------------------------------------------------------------------------------------------");
				 $display("FAILED: Expected_sum: %b, Got_sum: %b, Expected_cout: 1'b%b, Got_cout: 1'b%b", expected_result[N - 1 : 0], sum, expected_result[N], cout);
				 $display("-------------------------------------------------------------------------------------------------");
			 end
		 end
	 endtask
endmodule

