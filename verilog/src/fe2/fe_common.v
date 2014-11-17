
/*
static uint64_t load_3(const unsigned char *in) {
    uint64_t result;

    result = (uint64_t) in[0];
    result |= ((uint64_t) in[1]) << 8;
    result |= ((uint64_t) in[2]) << 16;

    return result;
}
*/

function automatic [63:0] load_3;
input [23:0] in;
begin
    load_3 = {40'b0, in};
end
endfunction

function automatic [63:0] load_4;
input [32:0] in;
begin
    load_4 = {32'b0, in};
end
endfunction

//Returns f + g
function automatic [319:0] fe_add;
input [319:0] f;
input [319:0] g;
begin
    fe_add[ 0*32 +: 32] = $signed(f[0*32 +: 32]) + $signed(g[0*32 +: 32]);
    fe_add[ 1*32 +: 32] = $signed(f[1*32 +: 32]) + $signed(g[1*32 +: 32]);
    fe_add[ 2*32 +: 32] = $signed(f[2*32 +: 32]) + $signed(g[2*32 +: 32]);
    fe_add[ 3*32 +: 32] = $signed(f[3*32 +: 32]) + $signed(g[3*32 +: 32]);
    fe_add[ 4*32 +: 32] = $signed(f[4*32 +: 32]) + $signed(g[4*32 +: 32]);
    fe_add[ 5*32 +: 32] = $signed(f[5*32 +: 32]) + $signed(g[5*32 +: 32]);
    fe_add[ 6*32 +: 32] = $signed(f[6*32 +: 32]) + $signed(g[6*32 +: 32]);
    fe_add[ 7*32 +: 32] = $signed(f[7*32 +: 32]) + $signed(g[7*32 +: 32]);
    fe_add[ 8*32 +: 32] = $signed(f[8*32 +: 32]) + $signed(g[8*32 +: 32]);
    fe_add[ 9*32 +: 32] = $signed(f[9*32 +: 32]) + $signed(g[9*32 +: 32]);
end
endfunction


function automatic [255:0] fe_tobytes;
input [319:0] h;
begin : fe_tobytes_blk
    reg signed [31:0] h0; 
    reg signed [31:0] h1; 
    reg signed [31:0] h2; 
    reg signed [31:0] h3; 
    reg signed [31:0] h4; 
    reg signed [31:0] h5; 
    reg signed [31:0] h6; 
    reg signed [31:0] h7; 
    reg signed [31:0] h8; 
    reg signed [31:0] h9; 
    reg signed [31:0] q;
    reg signed [31:0] carry0;
    reg signed [31:0] carry1;
    reg signed [31:0] carry2;
    reg signed [31:0] carry3;
    reg signed [31:0] carry4;
    reg signed [31:0] carry5;
    reg signed [31:0] carry6;
    reg signed [31:0] carry7;
    reg signed [31:0] carry8;
    reg signed [31:0] carry9;
    reg signed [31:0] tmp;
    h0 = h[0*32 +: 32];
    h1 = h[1*32 +: 32];
    h2 = h[2*32 +: 32];
    h3 = h[3*32 +: 32];
    h4 = h[4*32 +: 32];
    h5 = h[5*32 +: 32];
    h6 = h[6*32 +: 32];
    h7 = h[7*32 +: 32];
    h8 = h[8*32 +: 32];
    h9 = h[9*32 +: 32];
    q = ((32'sd19 * h9) + (32'sd1 << 24)) >>> 25;
    q = (h0 + q) >>> 26;
    q = (h1 + q) >>> 25;
    q = (h2 + q) >>> 26;
    q = (h3 + q) >>> 25;
    q = (h4 + q) >>> 26;
    q = (h5 + q) >>> 25;
    q = (h6 + q) >>> 26;
    q = (h7 + q) >>> 25;
    q = (h8 + q) >>> 26;
    q = (h9 + q) >>> 25;
    h0 = h0 + 19 * q;
    
    carry0 = h0 >>> 26;
    h1 = h1 + carry0;
    h0 = h0 - (carry0 << 26);
    carry1 = h1 >>> 25;
    h2 = h2 + carry1;
    h1 = h1 - (carry1 << 25);
    carry2 = h2 >>> 26;
    h3 = h3 + carry2;
    h2 = h2 - (carry2 << 26);
    carry3 = h3 >>> 25;
    h4 = h4 + carry3;
    h3 = h3 - (carry3 << 25);
    carry4 = h4 >>> 26;
    h5 = h5 + carry4;
    h4 = h4 - (carry4 << 26);
    carry5 = h5 >> 25;
    h6 = h6 + carry5;
    h5 = h5 - (carry5 << 25);
    carry6 = h6 >> 26;
    h7 = h7 + carry6;
    h6 = h6 - (carry6 << 26);
    carry7 = h7 >> 25;
    h8 = h8 + carry7;
    h7 = h7 - (carry7 << 25);
    carry8 = h8 >> 26;
    h9 = h9 + carry8;
    h8 = h8 - (carry8 << 26);
    carry9 = h9 >> 25;
    h9 = h9 - (carry9 << 25); 
    /* h10 = carry9 */
    /*
    Goal: Output h0+...+2^255 h10-2^255 q, which is between 0 and 2^255-20.
    Have h0+...+2^230 h9 between 0 and 2^255-1;
    evidently 2^255 h10-2^255 q = 0.
    Goal: Output h0+...+2^230 h9.
    */

    tmp = (h0 >> 0);
    fe_tobytes[ 0*8+:8] = tmp[7:0];
    
    tmp = (h0 >> 8);
    fe_tobytes[ 1*8+:8] = tmp[7:0];
    
    tmp = (h0 >> 16);
    fe_tobytes[ 2*8+:8] = tmp[7:0];
    
    tmp = ((h0 >> 24) | (h1 << 2));
    fe_tobytes[ 3*8+:8] = tmp[7:0];
    
    tmp = (h1 >> 6);
    fe_tobytes[ 4*8+:8] = tmp[7:0];
    
    tmp = (h1 >> 14);
    fe_tobytes[ 5*8+:8] = tmp[7:0];
    
    tmp = ((h1 >> 22) | (h2 << 3));
    fe_tobytes[ 6*8+:8] = tmp[7:0];
    
    tmp = (h2 >> 5);
    fe_tobytes[ 7*8+:8] = tmp[7:0];
    
    tmp = (h2 >> 13);
    fe_tobytes[ 8*8+:8] = tmp[7:0];
    
    tmp = ((h2 >> 21) | (h3 << 5));
    fe_tobytes[ 9*8+:8] = tmp[7:0];
    
    tmp = (h3 >> 3);
    fe_tobytes[10*8+:8] = tmp[7:0];
    
    tmp = (h3 >> 11);
    fe_tobytes[11*8+:8] = tmp[7:0]; 
    
    tmp = ((h3 >> 19) | (h4 << 6));
    fe_tobytes[12*8+:8] = tmp[7:0];
    
    tmp = (h4 >> 2);
    fe_tobytes[13*8+:8] = tmp[7:0];
    
    tmp = (h4 >> 10);
    fe_tobytes[14*8+:8] = tmp[7:0];
    
    tmp = (h4 >> 18);
    fe_tobytes[15*8+:8] = tmp[7:0];
    
    tmp = (h5 >> 0);
    fe_tobytes[16*8+:8] = tmp[7:0];
    
    tmp = (h5 >> 8);
    fe_tobytes[17*8+:8] = tmp[7:0];
    
    tmp = (h5 >> 16);
    fe_tobytes[18*8+:8] = tmp[7:0];
    
    tmp = ((h5 >> 24) | (h6 << 1));
    fe_tobytes[19*8+:8] = tmp[7:0];
    
    tmp = (h6 >> 7);
    fe_tobytes[20*8+:8] = tmp[7:0];
    
    tmp = (h6 >> 15);
    fe_tobytes[21*8+:8] = tmp[7:0];
    
    tmp = ((h6 >> 23) | (h7 << 3));
    fe_tobytes[22*8+:8] = tmp[7:0];
    
    tmp = (h7 >> 5);
    fe_tobytes[23*8+:8] = tmp[7:0];
    
    tmp = (h7 >> 13);
    fe_tobytes[24*8+:8] = tmp[7:0];
    
    tmp = ((h7 >> 21) | (h8 << 4));
    fe_tobytes[25*8+:8] = tmp[7:0];
    
    tmp = (h8 >> 4);
    fe_tobytes[26*8+:8] = tmp[7:0];
    
    tmp = (h8 >> 12);
    fe_tobytes[27*8+:8] = tmp[7:0];
    
    tmp = ((h8 >> 20) | (h9 << 6));
    fe_tobytes[28*8+:8] = tmp[7:0];
    
    tmp = (h9 >> 2);
    fe_tobytes[29*8+:8] = tmp[7:0];
    
    tmp = (h9 >> 10);
    fe_tobytes[30*8+:8] = tmp[7:0];
    
    tmp = (h9 >> 18);
    fe_tobytes[31*8+:8] = tmp[7:0];
end
endfunction


//Returns f if b = 0 else g
/*
function automatic [319:0] fe_cmov
input [319:0] f;
input [319:0] g;
input b;
begin
    if (b)
        fe_cmov = g;
    else
        fe_cmov = f;
end
endfunction
*/

//TODO
// fe_invert

//Result is valid N clocks later

