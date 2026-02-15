    ifndef dff_reset
    define dff_reset

// parameter list

module dff_reset(Q, Qn, D, Rst, CLK
);

input D, Rst, CLK; 
output Q, Qn; 

// module logic 
    logic G1_out, G2_out, G3_out, G4_out, G5_out, G1a_out, G1b_out;
    
    assign Q = G4_out;
    assign Qn = G5_out;

//  {gate} {#delay} {gate instance name}()
    not #0 G1b(G1b_out, Rst)
    and #0 G1a(G1a_out, D, G1b_out);
    nand #0 (G1_out, G1a_out,CLK);
    not #0 G2(G2_out, G1a_out);
    nand #0 G3(G3_out,G2_out,CLK);
    nand #0 G4(G4_out,G1_out,G5_out);
    nand #0 G5(G5_out,G3_out,G4_out);
endmodule

// Register stores a value
