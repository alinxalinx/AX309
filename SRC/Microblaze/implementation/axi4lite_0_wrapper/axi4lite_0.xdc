###############################################################################################################
# Core-Level Timing Constraints for AXI Interconnect Component axi4lite_0
###############################################################################################################
#
# Global timing constraints:
set_false_path -through [get_ports "INTERCONNECT_ARESETN"]
#
# This component is not configured to perform asynchronous clock-domain-crossing.
# No further timing core-level constraints are needed.
# (Synchronous clock-domain-crossings, if any, remain covered by your system-level PERIOD constraints.)
