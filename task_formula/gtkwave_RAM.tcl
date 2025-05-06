gtkwave::loadFile "dump.vcd"
catch {wm attributes . -zoomed 1}  ;
set all_signals [list]

lappend all_signals tb.formula_DUT.clk
lappend all_signals tb.formula_DUT.rst

lappend all_signals tb.formula_DUT.vld_in
lappend all_signals tb.formula_DUT.a
lappend all_signals tb.formula_DUT.b
lappend all_signals tb.formula_DUT.c
lappend all_signals tb.formula_DUT.d

lappend all_signals tb.formula_DUT.a_minus_b
lappend all_signals tb.formula_DUT.c_mul_3
lappend all_signals tb.formula_DUT.d_mul_2

lappend all_signals tb.formula_DUT.a_minus_b_div_2
lappend all_signals tb.formula_DUT.c_mul_3_add_1

lappend all_signals tb.formula_DUT.ab_div_2_mul_3c_add_1

lappend all_signals tb.formula_DUT.q

lappend all_signals tb.res_expected




set num_added [ gtkwave::addSignalsFromList $all_signals ]

gtkwave::/Time/Zoom/Zoom_Full
