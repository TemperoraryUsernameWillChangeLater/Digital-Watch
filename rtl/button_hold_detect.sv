`timescale 1ns / 1ps

module button_hold_detect #(
    parameter int HOLD_CYCLES = 50_000_000
) (
    input logic clk,
    input logic button,
    output logic held
);

    localparam int CountMax = HOLD_CYCLES - 1;
    localparam int CountWidth = $clog2(CountMax + 1);

    logic count_rst = !button;
    logic count_enable = button;
    logic [CountWidth-1:0] count;

    mod_n_counter #(
        .N(CountMax + 1),
        .WIDTH(CountWidth)
    ) u_counter (
        .clk(clk),
        .rst(count_rst),
        .enable(count_enable),
        .count(count)
    );

    always_comb begin
        if (count == CountMax) begin
            held = '1;
        end else begin
            held = '0;
        end
    end
endmodule
