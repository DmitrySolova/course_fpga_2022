library verilog;
use verilog.vl_types.all;
entity course_3_mult_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        data            : in     vl_logic_vector(24 downto 1);
        sampler_tx      : out    vl_logic
    );
end course_3_mult_vlg_sample_tst;
