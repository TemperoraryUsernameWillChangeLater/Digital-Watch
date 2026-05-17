`timescale 1ns / 1ps

module stopwatch_counter #(
    parameter int CYCLES_PER_SECOND = 50_000_000
) (
    input logic clk,
    input logic rst, // Takes priority over enable
    input logic enable,
    output logic [6:0] minutes,
    output logic [5:0] seconds,
    output logic [6:0] centiseconds // hundredths of a second
);

    logic tick;

    cascade_counter #(
        .N2(10),  // minutes
        .N1(6),   // seconds
        .N0(100), // centiseconds
        .W2(7),
        .W1(6),
        .W0(7)
    ) u_cascade_counter (
        .clk(tick),
        .rst(rst),
        .enable(enable),
        .count2(minutes),
        .count1(seconds),
        .count0(centiseconds)
    );

    restartable_rate_generator #(
        .CYCLE_COUNT(CYCLES_PER_SECOND / 500_000) // 500_000 cycles per centisecond
    ) u_rate_gen (
        .clk(clk),
        .run(enable),
        .tick(tick)
    );

endmodule
