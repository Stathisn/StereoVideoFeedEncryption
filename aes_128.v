/*
 * Copyright 2012, Homer Hsing <homer.hsing@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

module aes_128(clk, state, key, dout, reset);
    input          clk, reset;
    input  [127:0] state, key;
    output reg [127:0] dout;
    reg    [127:0] s0, k0;
//    wire   [127:0] s1, s2, s3, s4, s5, s6, s7, s8, s9,
//                   k1, k2, k3, k4, k5, k6, k7, k8, k9,
//                   k0b, k1b, k2b, k3b, k4b, k5b, k6b, k7b, k8b, k9b;
						 
	wire	[127:0]	s1_1_4, s1_5_8, s1_9_10, s1_final,
						k1_1_4, k1_5_8, k1_9_10,
						k0b_1_4, k0b_5_8, k0b_9_10;
	reg	[127:0]	s0_1_4, s0_5_8, s0_9_10, k0_1_4, k0_5_8, k0_9_10;
		
		
	wire	[2:0]	count_8;
	reg	[7:0]	rcon_1_4, rcon_5_8, rcon_9_10;
	

    always @ (posedge clk)
      begin
        s0 <= state ^ key;
        k0 <= key;
      end

//    expand_key_128
//        a1 (clk, k0, k1, k0b, 8'h1),
//        a2 (clk, k1, k2, k1b, 8'h2),
//        a3 (clk, k2, k3, k2b, 8'h4),
//        a4 (clk, k3, k4, k3b, 8'h8),
//        a5 (clk, k4, k5, k4b, 8'h10),
//        a6 (clk, k5, k6, k5b, 8'h20),
//        a7 (clk, k6, k7, k6b, 8'h40),
//        a8 (clk, k7, k8, k7b, 8'h80),
//        a9 (clk, k8, k9, k8b, 8'h1b),
//       a10 (clk, k9,   , k9b, 8'h36);
	
	counter #(.COUNT_WIDTH(3), .UP_DOWN_COUNT(1), .COUNT_LIMIT(7))	
		counter (.clk(clk), .reset(reset),.count(count_8));
		 
	expand_key_128
		a1_4 	(clk, k0_1_4,  k1_1_4,  k0b_1_4,  rcon_1_4), // key expansion for rounds 1 to 4
		a5_8 	(clk, k0_5_8,  k1_5_8,  k0b_5_8,  rcon_5_8), // key expansion for rounds 5 to 8
		a9_10 (clk, k0_9_10, k1_9_10, k0b_9_10, rcon_9_10); // key expansion for rounds 9 to 10
	one_round
		r1_4  (clk, s0_1_4,  k0b_1_4,  s1_1_4), // round for rounds 1 to 4
		r5_8  (clk, s0_5_8,  k0b_5_8,  s1_5_8), // round for rounds 5 to 8
		r9_10 (clk, s0_9_10, k0b_9_10, s1_9_10); // round for rounds 9 to 10
		 
	always @ (clk) // Feedback loop for rounds 1 to 3
		case (count_8)
			0: begin  // round 4
					k0_1_4 <= k1_1_4;
					rcon_1_4 <= 8'h8;
					s0_1_4 <= s1_1_4;
				end
			1: begin  // round 1
					k0_1_4 <= k0;
					rcon_1_4 <= 8'h1;
					s0_1_4 <= s0;
				end
			2: begin  // round 1
					k0_1_4 <= k0;
					rcon_1_4 <= 8'h1;
					s0_1_4 <= s0;
				end
			3:	begin  // round 2
					k0_1_4 <= k1_1_4;
					rcon_1_4 <= 8'h2;
					s0_1_4 <= s1_1_4;
				end
			4: begin  // round 2
					k0_1_4 <= k1_1_4;
					rcon_1_4 <= 8'h2;
					s0_1_4 <= s1_1_4;
				end
			5: begin  // round 3
					k0_1_4 <= k1_1_4;
					rcon_1_4 <= 8'h4;
					s0_1_4 <= s1_1_4;
				end
			6: begin  // round 3
					k0_1_4 <= k1_1_4;
					rcon_1_4 <= 8'h4;
					s0_1_4 <= s1_1_4;
				end
			7: begin  // round 4
					k0_1_4 <= k1_1_4;
					rcon_1_4 <= 8'h8;
					s0_1_4 <= s1_1_4;
				end
			default: begin  // round 1
					k0_1_4 <= k0;
					rcon_1_4 <= 8'h1;
					s0_1_4 <= s0;
				end
		endcase
	always @ (clk) // Feedback loop for rounds 5 to 8
		case (count_8)
			1: begin  // round 5
					k0_5_8 <= k1_1_4;
					rcon_5_8 <= 8'h10;
					s0_5_8 <= s1_1_4;
				end
			2: begin  // round 5
					k0_5_8 <= k1_1_4;
					rcon_5_8 <= 8'h10;
					s0_5_8 <= s1_1_4;
				end
			3:	begin  // round 6
					k0_5_8 <= k1_5_8;
					rcon_5_8 <= 8'h20;
					s0_5_8 <= s1_5_8;
				end
			4: begin  // round 6
					k0_5_8 <= k1_5_8;
					rcon_5_8 <= 8'h20;
					s0_5_8 <= s1_5_8;
				end
			5: begin  // round 7
					k0_5_8 <= k1_5_8;
					rcon_5_8 <= 8'h40;
					s0_5_8 <= s1_5_8;
				end
			6: begin  // round 7
					k0_5_8 <= k1_5_8;
					rcon_5_8 <= 8'h40;
					s0_5_8 <= s1_5_8;
				end
			7: begin  // round 8
					k0_5_8 <= k1_5_8;
					rcon_5_8 <= 8'h80;
					s0_5_8 <= s1_5_8;
				end
			0: begin  // round 8
					k0_5_8 <= k1_5_8;
					rcon_5_8 <= 8'h80;
					s0_5_8 <= s1_5_8;
				end
			default: begin  // round 5
					k0_5_8 <= k0;
					rcon_5_8 <= 8'h10;
					s0_5_8 <= s1_1_4;
				end
		endcase
		
	always @ (clk) // Feedback loop for rounds 9 to 10
		case (count_8)
			1: begin  // round 9
					k0_9_10 <= k1_5_8;
					rcon_9_10 <= 8'h1b;
					s0_9_10 <= s1_5_8;
				end
			2: begin  // round 9
					k0_9_10 <= k1_5_8;
					rcon_9_10 <= 8'h1b;
					s0_9_10 <= s1_5_8;
				end
			3:	begin  // round 10
					k0_9_10 <= k1_9_10;
					rcon_9_10 <= 8'h36;
					s0_9_10 <= s1_9_10;
				end
			4: begin  // round 10
					k0_9_10 <= k1_9_10;
					rcon_9_10 <= 8'h36;
					s0_9_10 <= s1_9_10;
				end
			5: dout <= s1_final;
			6: dout <= s1_final;
			7: dout <= s1_final;
			0: dout <= s1_final;
			default: begin  // round 9
					k0_9_10 <= k0;
					rcon_9_10 <= 8'h1b;
					s0_9_10 <= s1_1_4;
				end
		endcase

//    one_round
//        r1 (clk, s0, k0b, s1),
//        r2 (clk, s1, k1b, s2),
//        r3 (clk, s2, k2b, s3),
//        r4 (clk, s3, k3b, s4),
//        r5 (clk, s4, k4b, s5),
//        r6 (clk, s5, k5b, s6),
//        r7 (clk, s6, k6b, s7),
//        r8 (clk, s7, k7b, s8),
//        r9 (clk, s8, k8b, s9);
//
    final_round
        rf (clk, s0_9_10, k0b_9_10, s1_final);
endmodule

module expand_key_128(clk, in, out_1, out_2, rcon);
    input              clk;
    input      [127:0] in;
    input      [7:0]   rcon;
    output reg [127:0] out_1;
    output     [127:0] out_2;
    wire       [31:0]  k0, k1, k2, k3,
                       v0, v1, v2, v3;
    reg        [31:0]  k0a, k1a, k2a, k3a;
    wire       [31:0]  k0b, k1b, k2b, k3b, k4a;

    assign {k0, k1, k2, k3} = in;
    
    assign v0 = {k0[31:24] ^ rcon, k0[23:0]};
    assign v1 = v0 ^ k1;
    assign v2 = v1 ^ k2;
    assign v3 = v2 ^ k3;

    always @ (posedge clk)
        {k0a, k1a, k2a, k3a} <= {v0, v1, v2, v3};

    S4
        S4_0 (clk, {k3[23:0], k3[31:24]}, k4a);

    assign k0b = k0a ^ k4a;
    assign k1b = k1a ^ k4a;
    assign k2b = k2a ^ k4a;
    assign k3b = k3a ^ k4a;

    always @ (posedge clk)
        out_1 <= {k0b, k1b, k2b, k3b};

    assign out_2 = {k0b, k1b, k2b, k3b};
endmodule

