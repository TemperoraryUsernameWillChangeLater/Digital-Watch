`timescale 1ns / 1ps

module stopwatch_control (
    input logic clk,
    input logic rise_start_stop, // Button[0]
    input logic rise_lap, // Button[1]
    output logic counter_rst,
    output logic counter_enable,
    output logic lap_hold
);
    logic lap_hold_state, lap_hold_next_state;
    initial rise_lap = 0;

    initial begin
        counter_rst = 1'b0;
        counter_enable = 1'b0;
        lap_hold = 1'b0;
    end

    always_ff @(posedge clk) begin
        lap_hold_state <= lap_hold_next_state;
    end

    always_comb begin
        if(rise_lap && counter_enable) begin
            lap_hold_next_state = 0;
        end else 
    end

    assign lap_hold = lap_hold_next_state;

endmodule
