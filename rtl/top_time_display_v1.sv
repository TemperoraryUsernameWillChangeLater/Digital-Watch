`timescale 1ns / 1ps

module top_time_display_v1 #(
    parameter int CYCLES_PER_SECOND = 50_000_000
) (
    input logic CLOCK_50 ,
    input logic [1:0] SW ,
    output logic [6:0] HEX5 = 7'b1000000,
    output logic [6:0] HEX4 = 7'b1000000,
    output logic [6:0] HEX3 = 7'b1000000,
    output logic [6:0] HEX2 = 7'b1000000,
    output logic [6:0] HEX1 = 7'b1000000,
    output logic [6:0] HEX0 = 7'b1000000
);

always_comb begin
    if (SW == 2'b00) begin
        tick_rate = 1;
    end else if (SW == 2'b01) begin
        tick_rate = 25;
    end else if (SW == 2'b10) begin
        tick_rate = 1000;
    end else begin
        tick_rate = 50000000;
    end
end

endmodule
