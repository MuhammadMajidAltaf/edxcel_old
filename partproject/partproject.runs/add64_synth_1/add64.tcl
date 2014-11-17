# 
# Synthesis run script generated by Vivado
# 

set_param gui.test TreeTableDev
debug::add_scope template.lib 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

create_project -in_memory -part xc7z010clg400-1
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir /home/immesys/w/FPGA/edxcel/partproject/partproject.cache/wt [current_project]
set_property parent.project_path /home/immesys/w/FPGA/edxcel/partproject/partproject.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part em.avnet.com:microzed_7010:part0:1.0 [current_project]
read_ip /home/immesys/w/FPGA/edxcel/partproject/partproject.srcs/sources_1/ip/add64/add64.xci
set_property used_in_implementation false [get_files /home/immesys/w/FPGA/edxcel/partproject/partproject.srcs/sources_1/ip/add64/add64.dcp]
set_property used_in_implementation false [get_files -all /home/immesys/w/FPGA/edxcel/partproject/partproject.srcs/sources_1/ip/add64/add64.dcp]
set_property is_locked true [get_files /home/immesys/w/FPGA/edxcel/partproject/partproject.srcs/sources_1/ip/add64/add64.xci]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
catch { write_hwdef -file add64.hwdef }
synth_design -top add64 -part xc7z010clg400-1 -mode out_of_context
rename_ref -prefix_all add64_
write_checkpoint -noxdef add64.dcp
catch { report_utilization -file add64_utilization_synth.rpt -pb add64_utilization_synth.pb }
if { [catch {
  file copy -force /home/immesys/w/FPGA/edxcel/partproject/partproject.runs/add64_synth_1/add64.dcp /home/immesys/w/FPGA/edxcel/partproject/partproject.srcs/sources_1/ip/add64/add64.dcp
} _RESULT ] } { 
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}
if { [catch {
  write_verilog -force -mode synth_stub /home/immesys/w/FPGA/edxcel/partproject/partproject.srcs/sources_1/ip/add64/add64_stub.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}
if { [catch {
  write_vhdl -force -mode synth_stub /home/immesys/w/FPGA/edxcel/partproject/partproject.srcs/sources_1/ip/add64/add64_stub.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}
if { [catch {
  write_verilog -force -mode funcsim /home/immesys/w/FPGA/edxcel/partproject/partproject.srcs/sources_1/ip/add64/add64_funcsim.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}
if { [catch {
  write_vhdl -force -mode funcsim /home/immesys/w/FPGA/edxcel/partproject/partproject.srcs/sources_1/ip/add64/add64_funcsim.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}
