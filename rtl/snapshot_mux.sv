`timescale 1ns / 1ps

module snapshot_mux #(
    parameter int WIDTH = 1
) (
    input logic clk,
    input logic hold,
    input logic [WIDTH -1:0] d,
    output logic [WIDTH -1:0] q
);

    logic [WIDTH-1:0] d_reg;
    initial d_reg = 1'b0;

    always_ff @(posedge clk) begin
        if (!hold) d_reg <= d;
    end

    assign q = hold ? d_reg : d;
endmodule
