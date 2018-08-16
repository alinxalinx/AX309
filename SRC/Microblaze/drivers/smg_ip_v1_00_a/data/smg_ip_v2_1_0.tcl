##############################################################################
## Filename:          E:\Project\AX309\Microblaze/drivers/smg_ip_v1_00_a/data/smg_ip_v2_1_0.tcl
## Description:       Microprocess Driver Command (tcl)
## Date:              Tue Jul 21 14:34:51 2015 (by Create and Import Peripheral Wizard)
##############################################################################

#uses "xillib.tcl"

proc generate {drv_handle} {
  xdefine_include_file $drv_handle "xparameters.h" "smg_ip" "NUM_INSTANCES" "DEVICE_ID" "C_BASEADDR" "C_HIGHADDR" 
}
