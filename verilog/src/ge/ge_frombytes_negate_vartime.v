 module ge_frombytes_negate_vartime(
   input [0:255] s,
   output [319:0] h_x,
   output [319:0] h_y,
   output [319:0] h_z,
   output [319:0] h_t,
   output error,
   input clk,
   input rst,
   input valid,
   output done
);

`include "../fe/fe_common.v"

reg [319:0] mul_in1;
reg [319:0] mul_in2;
reg mul_valid;
wire [319:0] mul_res;
wire mul_done;

fe_mulx ML(
   .op_a(mul_in1),
   .op_b(mul_in2),
   .valid(mul_valid),
   .res(mul_res),
   .clk(clk),
   .rst(rst),
   .done(mul_done)
   );

reg [319:0] pow_in;
reg pow_valid;
wire [319:0] pow_res;
wire pow_done;

fe_pow22523 POW(
   .z(pow_in),
   .out(pow_res),
   .clk(clk),
   .rst(rst),
   .valid(pow_valid),
   .done(pow_done)
   );
 
integer cycle;

reg [319:0] u;
reg [319:0] v;
reg [319:0] v3;
reg [319:0] vxx;
reg [319:0] check;

reg [319:0] rh_x,
reg [319:0] rh_y,
reg [319:0] rh_z,
reg [319:0] rh_t,
assign h_x = rh_x;
assign h_y = rh_y;
assign h_z = rh_z;
assign h_t = rh_t;

reg rerror;
assign error = rerror;

reg rdone;
assign done = rdone;

reg [319:0] frombytes_in1;
reg [319:0] frombytes_res;
always @ (*)
begin
    frombytes_res = fe_frombytes(frombytes_in1);
end 

reg [319:0] add_in1;
reg [319:0] add_in2;
reg [319:0] add_res;
always @ (*)
begin
    add_res = fe_add(add_in1, add_in2);
end 

reg [319:0] sub_in1;
reg [319:0] sub_in2;
reg [319:0] sub_res;
always @ (*)
begin
    sub_res = fe_sub(sub_in1, sub_in2);
end 

reg if1;
reg if2;

always @ (posedge clk)
begin
   if (rst == 1'b0)
   begin
       cycle <= 0;
   end
   else 
   begin
       rdone <= 0;
       cycle <= cycle + 1;
       mul_valid <= 0;
       pow_valid <= 0;
       case (cycle)
           32'd0 :  begin
                       if (valid == 1'b1)
                       begin
                           // fe_frombytes(h->Y, s);
                           frombytes_in1 <= s;
                           // fe_1(h->Z);
                           rh_z <= 320'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;
                       end
                       else
                       begin
                           cycle <= 0;
                       end
                   end
           32'd1 :  begin
                         rh_y <= frombytes_res;
                         // fe_mul(u, h->Y, h->Y);
                         mul_in1 <= frombytes_res;
                         mul_in2 <= frombytes_res;
                         mul_valid <= 1;
                   end
           32'd2 :  begin
                       if (mul_done)
                       begin
                           u <= mul_res;
                           // fe_mul(v, u, d);
                           mul_in1 <= mul_res;
                           mul_in2 <= 320'hff480db4fee2b700ffce7199ffa03cbcff79e8980001c029006a0a0fff156ebd00d37285ff5978b6;
                           mul_valid <= 1;
                       end
                       else
                       begin
                           cycle <= 2;
                       end
                   end
           32'd3 :  begin
                       if (mul_done)
                       begin
                           v <= mul_res;
                           // fe_sub(u, u, h->Z);
                           sub_in1 <= u;
                           sub_in2 <= rh_z;
                           // fe_add(v, v, h->Z);
                           add_in1 <= mul_res;
                           add_in2 <= rh_z;
                       end
                       else
                       begin
                           cycle <= 3;
                       end
                   end
           32'd4 :  begin
                         u <= sub_res;
                         v <= add_res;
                         // fe_mul(v3, v, v);
                         mul_in1 <= add_res;
                         mul_in2 <= add_res;
                         mul_valid <= 1;
                   end
           32'd5 :  begin
                       if (mul_done)
                       begin
                           v3 <= mul_res;
                           // fe_mul(v3, v3, v);
                           mul_in1 <= mul_res;
                           mul_in2 <= v;
                           mul_valid <= 1;
                       end
                       else
                       begin
                           cycle <= 5;
                       end
                   end
           32'd6 :  begin
                       if (mul_done)
                       begin
                           v3 <= mul_res;
                           // fe_mul(h->X, v3, v3);
                           mul_in1 <= mul_res;
                           mul_in2 <= mul_res;
                           mul_valid <= 1;
                       end
                       else
                       begin
                           cycle <= 6;
                       end
                   end
           32'd7 :  begin
                       if (mul_done)
                       begin
                           rh_x <= mul_res;
                           // fe_mul(h->X, h->X, v);
                           mul_in1 <= mul_res;
                           mul_in2 <= v;
                           mul_valid <= 1;
                       end
                       else
                       begin
                           cycle <= 7;
                       end
                   end
           32'd8 :  begin
                       if (mul_done)
                       begin
                           rh_x <= mul_res;
                           // fe_mul(h->X, h->X, u);
                           mul_in1 <= mul_res;
                           mul_in2 <= u;
                           mul_valid <= 1;
                       end
                       else
                       begin
                           cycle <= 8;
                       end
                   end
           32'd9 :  begin
                       if (mul_done)
                       begin
                           rh_x <= mul_res;
                           // fe_pow22523(h->X, h->X);
                           pow_in <= mul_res;
                           pow_valid <= 1;
                       end
                       else
                       begin
                           cycle <= 9;
                       end
                   end
           32'd10 :  begin
                       if (pow_done)
                       begin
                           rh_x <= pow_res;
                           // fe_mul(h->X, h->X, v3);
                           mul_in1 <= pow_res;
                           mul_in2 <= v3;
                           mul_valid <= 1;
                       end
                       else
                       begin
                           cycle <= 10;
                       end
                   end
           32'd11 :  begin
                       if (mul_done)
                       begin
                           rh_x <= mul_res;
                           // fe_mul(h->X, h->X, u);
                           mul_in1 <= mul_res;
                           mul_in2 <= u;
                           mul_valid <= 1;
                       end
                       else
                       begin
                           cycle <= 11;
                       end
                   end
           32'd12 :  begin
                       if (mul_done)
                       begin
                           rh_x <= mul_res;
                           // fe_mul(vxx, h->X, h->X);
                           mul_in1 <= mul_res;
                           mul_in2 <= mul_res;
                           mul_valid <= 1;
                       end
                       else
                       begin
                           cycle <= 12;
                       end
                   end
           32'd13 :  begin
                       if (mul_done)
                       begin
                           vxx <= mul_res;
                           // fe_mul(vxx, vxx, v);
                           mul_in1 <= mul_res;
                           mul_in2 <= v;
                           mul_valid <= 1;
                       end
                       else
                       begin
                           cycle <= 13;
                       end
                   end
           32'd14 :  begin
                       if (mul_done)
                       begin
                           vxx <= mul_res;
                           // fe_sub(check, vxx, u); 
                           sub_in1 <= mul_res;
                           sub_in2 <= u;
                       end
                       else
                       begin
                           cycle <= 14;
                       end
                   end
           32'd15 :  begin
                         check <= sub_res;
                         if (sub_res != 320'b0)
                         begin
                            if1 <= 1'b1;
                            // fe_add(check, vxx, u);
                            add_in1 <= vxx;
                            add_in2 <= u;
                         end
                   end
           32'd16 :  begin
                         if (if1 == 1'b1)
                         begin
                             // fe_add(check, vxx, u);
                             add_in1 <= vxx;
                             add_in2 <= u;
                         end
                   end
           32'd17 :  begin
                         if (if1 == 1'b1)
                         begin
                             check <= add_res;
                             if (add_res != 320'b0)
                             begin
                                 if1 <= 0;
                                 error <= 1;
                                 rdone <= 1;
                                 cycle <= 0;
                             end
                             else
                             begin
                                 // fe_mul(h->X, h->X, sqrtm1);
                                 mul_in1 <= rh_x;
                                 mul_in2 <= sqrtm1;
                                 mul_valid <= 1;
                             end
                         end
                   end
           32'd18 :  begin
                         if (if1 == 1'b1)
                         begin
                             if (mul_done)
                             begin
                                 rh_x <= mul_res;
                                 if1 <= 0;
                             end
                             else
                             begin
                                 cycle <= 18;
                             end
                         end
                   end
           32'd19 :  begin
                       isneg_in <= rh_x;
                   end
           32'd20 :  begin
                       if (isneg_res == (s[31*8 +: 8] >> 7))
                       begin
                           f1 <= 1;
                           neg_in <= rh_x;
                       end
                   end
           32'd21 :  begin
                       if (f1 == 1)
                       begin
                           rh_x <= neg_res;
                       end
                   end
           32'd22 :  begin
                         // fe_mul(h->T, h->X, h->Y);
                         mul_in1 <= rh_x;
                         mul_in2 <= rh_y;
                         mul_valid <= 1;
                   end
           32'd23 :  begin
                       if (mul_done)
                       begin
                           rh_t <= mul_res;
                           error <= 0;
                           rdone <= 1;
                           cycle <= 0;
                       end
                       else
                       begin
                           cycle <= 23;
                       end
                   end
       endcase
   end

end

endmodule