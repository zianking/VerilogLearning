`timescale 1ns/1ps

module top_tb;

reg clk;
reg rst_n;
reg keyplus;
reg keyminus;
reg keysetzero;
reg keysetnum;
reg startswitch;

wire uartout;
wire point;
wire [6:0]digitout;
wire [3:0]cs;

parameter KEY_PLUS=2'd0;
parameter KEY_MINUS=2'd1;
parameter KEY_SETZERO=2'd2;
parameter KEY_SETNUM=2'd3;

top #(
    .DEBOUNCE_SAMPLE(10),
    .CLK_FREQ(50000000),
    .BAUD_RATE(1000000),
    .SCAN_FREQ(1000000)
)
dut(
    .clk(clk),
    .rst_n(rst_n),
    .keyplus(keyplus),
    .keyminus(keyminus),
    .keysetzero(keysetzero),
    .keysetnum(keysetnum),
    .startswitch(startswitch),
    .uartout(uartout),
    .point(point),
    .digitout(digitout),
    .cs(cs)
);

initial begin
    clk=0;
    forever #10 clk=~clk;
end

task press_key;
    input [1:0]key_select;
    begin

        // 按下抖动
        case(key_select)
            KEY_PLUS:keyplus=0;
            KEY_MINUS:keyminus=0;
            KEY_SETZERO:keysetzero=0;
            KEY_SETNUM:keysetnum=0;
        endcase

        #40;

        case(key_select)
            KEY_PLUS:keyplus=1;
            KEY_MINUS:keyminus=1;
            KEY_SETZERO:keysetzero=1;
            KEY_SETNUM:keysetnum=1;
        endcase

        #40;

        case(key_select)
            KEY_PLUS:keyplus=0;
            KEY_MINUS:keyminus=0;
            KEY_SETZERO:keysetzero=0;
            KEY_SETNUM:keysetnum=0;
        endcase

        #60;

        case(key_select)
            KEY_PLUS:keyplus=1;
            KEY_MINUS:keyminus=1;
            KEY_SETZERO:keysetzero=1;
            KEY_SETNUM:keysetnum=1;
        endcase

        #40;

        case(key_select)
            KEY_PLUS:keyplus=0;
            KEY_MINUS:keyminus=0;
            KEY_SETZERO:keysetzero=0;
            KEY_SETNUM:keysetnum=0;
        endcase

        // 稳定按下
        #1000;

        // 松开抖动
        case(key_select)
            KEY_PLUS:keyplus=1;
            KEY_MINUS:keyminus=1;
            KEY_SETZERO:keysetzero=1;
            KEY_SETNUM:keysetnum=1;
        endcase

        #40;

        case(key_select)
            KEY_PLUS:keyplus=0;
            KEY_MINUS:keyminus=0;
            KEY_SETZERO:keysetzero=0;
            KEY_SETNUM:keysetnum=0;
        endcase

        #40;

        case(key_select)
            KEY_PLUS:keyplus=1;
            KEY_MINUS:keyminus=1;
            KEY_SETZERO:keysetzero=1;
            KEY_SETNUM:keysetnum=1;
        endcase

        #60;

        case(key_select)
            KEY_PLUS:keyplus=0;
            KEY_MINUS:keyminus=0;
            KEY_SETZERO:keysetzero=0;
            KEY_SETNUM:keysetnum=0;
        endcase

        #40;

        case(key_select)
            KEY_PLUS:keyplus=1;
            KEY_MINUS:keyminus=1;
            KEY_SETZERO:keysetzero=1;
            KEY_SETNUM:keysetnum=1;
        endcase

        // 稳定松开
        #1000;

    end
endtask

task check_num;
    input [5:0]expected;
    begin
        if(dut.num!==expected)begin
            $display(
                "ERROR: time=%0t, expected num=%0d, actual num=%0d",
                $time,
                expected,
                dut.num
            );
        end
        else begin
            $display(
                "PASS: time=%0t, num=%0d",
                $time,
                dut.num
            );
        end
    end
endtask

initial begin
    rst_n=0;
    keyplus=1;
    keyminus=1;
    keysetzero=1;
    keysetnum=1;
    startswitch=0;
    #100;
    rst_n=1;
    #500;
    check_num(0);
    // 第一次加1
    press_key(KEY_PLUS);
    #500;
    check_num(1);
    // 第二次加1
    press_key(KEY_PLUS);
    #500;
    check_num(2);
    // 减1
    press_key(KEY_MINUS);
    #500;
    check_num(1);
    // 置数23
    press_key(KEY_SETNUM);
    #500;
    check_num(23);
    // 清零
    press_key(KEY_SETZERO);
    #500;
    check_num(0);
    // 再加1，确认系统清零后仍可继续工作
    press_key(KEY_PLUS);
    #500;
    check_num(1);
    // UART整体联调
    startswitch=1;
    #15000;
    startswitch=0;
    #1000;
    $display("TOP LEVEL TEST FINISHED");
    $finish;
end
endmodule