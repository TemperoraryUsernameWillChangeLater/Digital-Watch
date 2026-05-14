`timescale 1ns / 1ps

// --------------
// Mode Selection
// --------------

logic [2:0] mode_enable;
edit_mode_selector #(
    .HOLD_CYCLES (...) // Fill in, based on CYCLES_PER_SECOND
) u_mode_selector (
    // Fill in
);

// Put your pwm_generator instantiation here
