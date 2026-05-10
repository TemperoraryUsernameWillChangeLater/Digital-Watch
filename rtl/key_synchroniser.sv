`timescale 1ns / 1ps

module key_synchroniser (
    input logic clk ,
    input logic [3:0] key_n , // active -low , asynchronous
    output logic [3:0] key_sync // active -high , synchronised
);

logic [3:0] inverted_key_n, shift1 = 4'd0, shift2 = 4'd0;

assign inverted_key_n = ~key_n;

//Shift register to simulate synchronizer
always_ff @(posedge clk) begin
    shift1 <= inverted_key_n;
    shift2 <= shift1;end

assign key_sync = shift2;
endmodule

