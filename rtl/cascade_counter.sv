`timescale 1ns / 1ps

module cascade_counter #(
    parameter int N2 = 3, // count2 rolls over after N2 cycles of count1
    parameter int N1 = 4, // count1 rolls over after N1 cycles of count0
    parameter int N0 = 5, // count0 rolls over after N0 cycles of the input clock

    // Output port widths
    parameter int W2 = 2,
    parameter int W1 = 2,
    parameter int W0 = 3
) (
    input logic clk,
    input logic rst,
    input logic enable,
    output logic [W2-1:0] count2,
    output logic [W1-1:0] count1,
    output logic [W0-1:0] count0
);

    logic enable1, enable2;

    assign enable1 = enable && (count0 == N0 - 1);
    assign enable2 = enable && (count0 == N0 - 1) && (count1 == N1 - 1);

    mod_n_counter #(
        .N(N0),
        .WIDTH(W0)
    ) u_count0 (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .count(count0)  // OUTPUT
    );

    mod_n_counter #(
        .N(N1),
        .WIDTH(W1)
    ) u_count1 (
        .clk(clk),
        .rst(rst),
        .enable(enable1),
        .count(count1)  // OUTPUT
    );

    mod_n_counter #(
        .N(N2),
        .WIDTH(W2)
    ) u_count2 (
        .clk(clk),
        .rst(rst),
        .enable(enable2),
        .count(count2)  // OUTPUT
    );
endmodule
