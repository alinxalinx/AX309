library verilog;
use verilog.vl_types.all;
entity glbl is
    generic(
        ROC_WIDTH       : integer := 100000;
        TOC_WIDTH       : integer := 0
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of ROC_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of TOC_WIDTH : constant is 1;
end glbl;
