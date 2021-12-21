.text
main:
    andi x0, x0, 0
    andi x5, x5, 0        # x5 = 0; // Counter
    andi x6, x6, 0        # x6 = 0; // Command record
    lui  x2, 8
    lw   x3, -0xf0(x2)    # x3 = PORT_B;
    sw   x3, -0xe0(x2)    # PORT_C = PORT_B;

begin:                    # while (true) {
    lw   x7, -0xf0(x2)    #   x7 = PORT_B;
    bne  x7, x3, change_b #   if (x7 != x3) { x3 = PORT_B; PORT_C = x7; continue; }
    lw   x8, -0x100(x2)   #   x8 = PORT_A;
    bne  x8, x0, change_a #   else if (x8) goto change_a;
    j    begin            # }

change_b:
    or   x3, x7, x0       # x3 = PORT_B;
    sw   x7, -0xe0(x2)    # PORT_C = x7;
    j    begin

change_a:
    lw   x4, -0x100(x2)   # // x4 = PORT_A;
    bne  x4, x0, change_a # while (PORT_A) { }
                          # // else the button is released
    beq  x6, x0, copy     # if (x6 == 0) { x6 = x8; x5 = x7; goto cmd_done; }
    andi x4, x6, 1        #
    bne  x4, x0, cmd_eq   # if (x6 & 1) goto cmd_eq;
    srli x6, x6, 1        #
    andi x4, x6, 1        #
    bne  x4, x0, cmd_div  # if ((x6 >> 1) & 1) goto cmd_div;
    srli x6, x6, 1        #
    andi x4, x6, 1        #
    bne  x4, x0, cmd_sub  # if ((x6 >> 2) & 1) goto cmd_sub;
    srli x6, x6, 1        #
    andi x4, x6, 1        #
    bne  x4, x0, cmd_add  # if ((x6 >> 3) & 1) goto cmd_add;
cmd_eq:
cmd_done:
    sw   x5, -0xe0(x2)    # PORT_C = x5;
    or   x6, x8, x0       # x6 = x8;
    j    begin

cmd_add:
    add  x5, x5, x7       # x5 += x7;
    j    cmd_done         # PORT_C = x5;

cmd_sub:
    sub  x5, x5, x7       # PORT_B -= PORT_C;
    j    cmd_done

cmd_div:
    or   x4, x5, x0
    andi x5, x0, 0
    slli x7, x7, 16
    addi x9, x0, 17
div_loop:
    sub  x4, x4, x7
    slt  x11, x4, x0
    slli x5, x5, 1
    beq  x11, x0, case_2
    add  x4, x4, x7
    j    case_1
case_2:
    addi x5, x5, 1
case_1:
    srli x7, x7, 1
    addi x9, x9, -1
    bne  x9, x0, div_loop
    j    cmd_done

copy:
    or   x6, x8, x0
    or   x5, x7, x0
    j    cmd_done