
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name ad9226_test -dir "E:/Project/AX545/verilog/ad9226_test/planAhead_run_3" -part xc6slx45csg324-2
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "E:/Project/AX545/verilog/ad9226_test/ad9226_test.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {E:/Project/AX545/verilog/ad9226_test} }
set_property target_constrs_file "ad9226_test.ucf" [current_fileset -constrset]
add_files [list {ad9226_test.ucf}] -fileset [get_property constrset [current_run]]
link_design
