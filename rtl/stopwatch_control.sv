`timescale 1ns / 1ps

module stopwatch_control (
    input logic clk,
    input logic rise_start_stop,
    input logic rise_lap,
    output logic counter_rst = 1'b0,
    output logic counter_enable = 1'b0,
    output logic lap_hold = 1'b0
);

    logic next_counter_rst;
    logic next_counter_enable;
    logic next_lap_hold;

    always_ff @(posedge clk) begin
        counter_rst <= next_counter_rst;
        counter_enable <= next_counter_enable;
        lap_hold <= next_lap_hold;
    end

    assign next_counter_rst = (rise_lap && !rise_start_stop && !counter_enable && !lap_hold);
    assign next_counter_enable = (rise_start_stop && !rise_lap) ? !counter_enable : counter_enable;

    always_comb begin
        next_lap_hold = lap_hold;
        if (rise_lap && !rise_start_stop) begin
            if (counter_enable) begin
                next_lap_hold = !lap_hold;
            end else begin
                next_lap_hold = 1'b0;
            end
        end
    end

endmodule
