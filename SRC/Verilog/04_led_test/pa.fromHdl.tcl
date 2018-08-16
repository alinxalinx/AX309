
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name LED -dir "H:/Siga_S16/LED/planAhead_run_5" -part xc6slx16csg324-3
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property top led $srcset
set_param project.paUcfFile  "led.ucf"
set hdlfile [add_files [list {LED.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
add_files "led.ucf" -fileset [get_property constrset [current_run]]
open_rtl_design -part xc6slx16csg324-3
