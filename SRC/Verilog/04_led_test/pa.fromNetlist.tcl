
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name LED -dir "H:/Siga_S16/LED/planAhead_run_4" -part xc6slx16csg324-3
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "H:/Siga_S16/LED/led.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {H:/Siga_S16/LED} }
set_param project.pinAheadLayout  yes
set_param project.paUcfFile  "led.ucf"
add_files "led.ucf" -fileset [get_property constrset [current_run]]
open_netlist_design
