#!/bin/sh
#
# This file was automatically generated.
#
# It can be overwritten by nios2-flash-generate-files.
#

$SOPC_KIT_NIOS2/bin/sof2flash --input="C:/stage_Jeremie/Peripheriques_vhdl/peripheriques.sof" --output="C:/stage_Jeremie/Peripheriques_vhdl/flash/peripheriques_epcs_flash_controller_0.flash" --epcs --verbose 

$SOPC_KIT_NIOS2/bin/nios2-flash-programmer "C:/stage_Jeremie/Peripheriques_vhdl/flash/peripheriques_epcs_flash_controller_0.flash" --base=0x11800 --epcs --accept-bad-sysid --device=1 --instance=1 '--cable=USB-Blaster [USB-0]' --erase-all --go --program --verbose 

$SOPC_KIT_NIOS2/bin/elf2flash --input="C:/stage_Jeremie/Peripheriques_vhdl/software/processeur_robot_timer/processeur_robot_timer.elf" --output="C:/stage_Jeremie/Peripheriques_vhdl/flash/processeur_robot_timer_epcs_flash_controller_0.flash" --epcs --after="C:/stage_Jeremie/Peripheriques_vhdl/flash/peripheriques_epcs_flash_controller_0.flash" --verbose 

$SOPC_KIT_NIOS2/bin/nios2-flash-programmer "C:/stage_Jeremie/Peripheriques_vhdl/flash/processeur_robot_timer_epcs_flash_controller_0.flash" --base=0x11800 --epcs --accept-bad-sysid --device=1 --instance=1 '--cable=USB-Blaster [USB-0]' --erase-all --go --program --verbose 

