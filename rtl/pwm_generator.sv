`timescale 1ns / 1ps

module pwm_generator #(
    parameter int PERIOD_CYCLES = 50_000_000,
    parameter int DUTY_CYCLES   = 25_000_000
) (
    input  logic clk,
    input  logic rst,
    output logic pwm_out
);

  localparam int COUNT_WIDTH = $clog2(PERIOD_CYCLES);
  localparam int DUTY_WIDTH  = COUNT_WIDTH + 1;
  logic [COUNT_WIDTH-1:0] count;
  wire  [DUTY_WIDTH-1:0] count_ext = {{(DUTY_WIDTH-COUNT_WIDTH){1'b0}}, count};
  wire  [DUTY_WIDTH-1:0] duty_count = DUTY_CYCLES[DUTY_WIDTH-1:0];

  mod_n_counter #(
      .N(PERIOD_CYCLES),     // Setting the count limit (Mod-10)
      .WIDTH(COUNT_WIDTH)   // Setting the bit-width to accommodate N-1
  ) u_my_counter (
      .clk(clk),
      .rst(rst),
      .enable('1),
      .count(count)
  );

  always_comb begin
    if (count_ext < duty_count) begin
      pwm_out = '1;
    end else begin
      pwm_out = '0;
    end
  end

endmodule
