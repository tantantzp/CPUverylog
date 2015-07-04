
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name CPU -dir "E:/computerOrg/CPU/planAhead_run_2" -part xc3s1200efg320-4
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "E:/computerOrg/CPU/CPU.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {E:/computerOrg/CPU} }
set_param project.paUcfFile  "CPU.ucf"
add_files "CPU.ucf" -fileset [get_property constrset [current_run]]
open_netlist_design
