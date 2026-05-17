    `timescale 1ns / 1ps
    // A parameterised counter that increments or decrements based on an input signal and cleanly wraps between 0 and MAX.

module up_down_counter_rst #(
    parameter int MAX   = 2,
    parameter int WIDTH = 2
) (
    input logic clk,
    input logic rst,
    input logic enable,
    input logic up,
    output logic [WIDTH - 1:0] count
);

    localparam logic [WIDTH-1:0] Max = WIDTH'(MAX);
    logic [WIDTH-1:0] next_count;
    initial count = '0;

    always_ff @(posedge clk) begin
        if (rst) count <= '0;
        else if (enable) count <= next_count;
    end

    always_comb begin
        if (up) begin //Increment
        if (count == Max) begin
            next_count = '0;
        end else begin
            next_count = count + WIDTH'(1);
        end
        end else begin //Decrement
        if (count == '0) begin
            next_count = Max;
        end else begin
            next_count = count - WIDTH'(1);
        end
        end
    end

    endmodule
