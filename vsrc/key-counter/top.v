module top
#(
    parameter DEBOUNCE_SAMPLE=1000000,
    parameter CLK_FREQ=50000000,
    parameter BAUD_RATE=9600,
    parameter SCAN_FREQ=2000   
)
(
    input clk,
    input rst_n,
    input keyplus,
    input keyminus,
    input keysetzero,
    input keysetnum,
    input startswitch,
    output uartout,
    output point,
    output [6:0]digitout,
    output [3:0]cs
);
wire debouncedplus;
wire debouncedminus;
wire debouncedsetzero;
wire debouncedsetnum;
wire [5:0]num;
wire [6:0]ones;
wire [6:0]tens;
wire pointwire;
debounce #(
    .SAMPLE(DEBOUNCE_SAMPLE)
)
u_debounce_plus(
    .rst_n(rst_n),
    .clk(clk),
    .key(~keyplus),
    .out(debouncedplus)
);
debounce #(
    .SAMPLE(DEBOUNCE_SAMPLE)
)
u_debounce_minus(
    .rst_n(rst_n),
    .clk(clk),
    .key(~keyminus),
    .out(debouncedminus)
);
debounce #(
    .SAMPLE(DEBOUNCE_SAMPLE)
)
u_debounce_setzero(
    .rst_n(rst_n),
    .clk(clk),
    .key(~keysetzero),
    .out(debouncedsetzero)
);
debounce #(
    .SAMPLE(DEBOUNCE_SAMPLE)
)
u_debounce_setnum(
    .rst_n(rst_n),
    .clk(clk),
    .key(~keysetnum),
    .out(debouncedsetnum)
);
counter u_counter(
    .clk(clk),
    .rst_n(rst_n),
    .plus(debouncedplus),
    .minus(debouncedminus),
    .setzero(debouncedsetzero),
    .setnum(debouncedsetnum),
    .num(num)
);
bcd_decoder u_bcd_decoder(
    .clk(clk),
    .num(num),
    .ones(ones),
    .tens(tens),
    .point(pointwire)
);
digitron_scan #(
    .CLK_FREQ(CLK_FREQ),
    .SCAN_FREQ(SCAN_FREQ)
)
u_digitron_scan(
    .rst_n(rst_n),
    .clk(clk),
    .ones(ones),
    .tens(tens),
    .pointwire(pointwire),
    .digitout(digitout),
    .point(point),
    .cs(cs)
);
uart_tx #(
    .CLK_FREQ(CLK_FREQ),
    .BAUD_RATE(BAUD_RATE)
)
u_uart_tx(
    .rst_n(rst_n),
    .clk(clk),
    .num(num),
    .startswitch(startswitch),
    .out(uartout)
);
endmodule