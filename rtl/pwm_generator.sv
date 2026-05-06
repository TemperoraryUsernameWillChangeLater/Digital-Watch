`timescale 1ns / 1ps

module pwm_generator #(
    parameter int PERIOD_CYCLES = 50_000_000,
    parameter int DUTY_CYCLES   = 25_000_000
) (
    input  logic clk,
    input  logic rst,
    output logic pwm_out
);

  logic [$clog2(PERIOD_CYCLES)-1:0] count;

  mod_n_counter #(
      .N(PERIOD_CYCLES),     // Setting the count limit (Mod-10)
      .WIDTH($clog2(PERIOD_CYCLES))   // Setting the bit-width to accommodate N-1
  ) u_my_counter (
      .clk(clk),
      .rst(rst),
      .enable('1),
      .count(count)
  );

  always_comb begin
    if (count < DUTY_CYCLES) begin
      pwm_out = '1;
    end else begin
      pwm_out = '0;
    end
  end

endmodule
