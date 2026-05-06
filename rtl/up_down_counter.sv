`timescale 1ns / 1ps

module up_down_counter #(
    parameter int MAX   = 2,
    parameter int WIDTH = 2
) (
    input logic clk,
    input logic enable,
    input logic up,
    output logic [WIDTH-1:0] count
);

localparam logic [WIDTH-1:0] Max = WIDTH'(MAX);
logic [WIDTH-1:0] next_count;

always_ff @(posedge clk) begin
    if (enable) count <= next_count;
end

always_comb begin
    if (up) begin
        if (count == Max) begin
            next_count = '0;
        end else begin
            next_count = count + WIDTH'(1);
        end
    end else begin
        if (count == '0) begin
            next_count = Max;
        end else begin
            next_count = count - WIDTH'(1);
        end
    end
end

endmodule
