`timescale 1ns / 1ps

module button_auto_repeat #(
    parameter int HOLD_CYCLES   = 50_000_000,
    parameter int REPEAT_CYCLES = 5_000_000
) (
    input  logic clk,
    input  logic button,
    output logic pulse
);

    logic rise;
    logic held;
    logic pulse_train;

    localparam int QualCycles = HOLD_CYCLES - REPEAT_CYCLES + 1;

    assign pulse = rise || (button && pulse_train);

    rising_edge_detector u_rise_detect (
        .clk(clk),
        .sig_in(button),
        .rise(rise)
    );

    button_hold_detect #(
        .HOLD_CYCLES(QualCycles)
    ) u_hold_detect (
        .clk(clk),
        .button(button),
        .held(held)
    );

    restartable_rate_generator #(
        .CYCLE_COUNT(REPEAT_CYCLES)
    ) u_rate_gen (
        .clk (clk),
        .run (held),
        .tick(pulse_train)
    );

endmodule
