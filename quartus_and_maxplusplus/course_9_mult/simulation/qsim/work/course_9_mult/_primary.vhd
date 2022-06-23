library verilog;
use verilog.vl_types.all;
entity course_9_mult is
    port(
        clk             : in     vl_logic;
        data            : in     vl_logic_vector(24 downto 1);
        \out\           : out    vl_logic_vector(24 downto 1);
        s_reg           : out    vl_logic_vector(5 downto 1);
        inv_CLK_Count   : out    vl_logic_vector(6 downto 1)
    );
end course_9_mult;
