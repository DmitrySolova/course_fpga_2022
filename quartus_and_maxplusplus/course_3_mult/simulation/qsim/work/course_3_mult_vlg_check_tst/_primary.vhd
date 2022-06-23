library verilog;
use verilog.vl_types.all;
entity course_3_mult_vlg_check_tst is
    port(
        inv_CLK_Count   : in     vl_logic_vector(6 downto 1);
        \out\           : in     vl_logic_vector(24 downto 1);
        s_reg           : in     vl_logic_vector(5 downto 0);
        sampler_rx      : in     vl_logic
    );
end course_3_mult_vlg_check_tst;
