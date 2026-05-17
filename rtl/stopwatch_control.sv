`timescale 1ns / 1ps

module stopwatch_control (
    input logic clk,
    input logic rise_start_stop, // Button[0]
    input logic rise_lap, // Button[1]
    output logic counter_rst,
    output logic counter_enable, /*High: The stopwatch is running || Low: stopwatch is stopped */
    output logic lap_hold /*High: Display is frozen || Low: Display is live*/
);

    logic [2: 0] state = {counter_rst, counter_enable, lap_hold};

    logic [2: 0] next_state;

    always_comb begin
        if (rise_lap) begin
            casez (state)
                3'b?10 : next_state = 3'b011;
                3'b?11 : next_state = 3'b010;
                3'b?01 : next_state = 3'b000;
                3'b?00 : next_state = 3'b100;
                default: next_state = state;
            endcase
        end
    end

    always_ff @(posedge clk) begin
        if (rise_start_stop) begin
            casez (state)
                3'b?00 : state <= 3'b001;
                3'b?01 : state <= 3'b000;
                3'b?10 : state <= 3'b101;
                3'b?11 : state <= 3'b100;
                default: state <= state;
            endcase
        end else begin
            state <= next_state;
        end
    end
endmodule
