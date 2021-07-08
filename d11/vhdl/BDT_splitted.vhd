library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

library work;
use work.Constants.all;
use work.Types.all;
--use libBDT.Tree;
--use libBDT.AddReduce;

entity BDT_splitted is
  port(
      clk     : in  std_logic
    ; X       : in  txArray(0 to nFeatures-1)
    ; X_vld   : in  boolean
    ; y       : out ty
    ; y_vld   : out boolean
  );
end BDT_splitted;

architecture rtl_separate of BDT_splitted is
    
    use work.Arrays0;
    signal yTrees    :   tyArray(0 to nTrees+1  -1); -- The score output by each tree (1 extra element for the initial predict)
    signal y_vld_arr : boolArray(0 to nTrees+1  -1);
    signal yV : tyArray(0 to 0); -- A vector container
    signal y_vld_arr_v: boolArray(0 to 0); -- A container
    
    type tySlvArray is array(0 to nTrees -1) of std_logic_vector(ty'range);
    signal slv_yTrees     : tySlvArray;
    signal slv_y_vld_arr  : std_logic_vector(0 to nTrees  -1);
    signal slv_X          : std_logic_vector( (tx'length * nFeatures) -1 downto 0);
    signal slv_X_vld      : std_logic;

    constant BWX : natural := tx'length;

  begin
    GEN_X: for GI in X'range generate
      slv_X( (GI+1)*BWX-1 downto GI*BWX )  <= std_logic_vector( X(GI) );
    end generate;
    slv_X_vld <= '1' when (X_vld = true) else '0';


    -----------------------------------------------------
    -- Instantiate trees as separate instances
    -----------------------------------------------------

tree_0000 : entity work.tree_bdt0_t0000 port map(clk, slv_X, slv_X_vld, slv_yTrees(   0), slv_y_vld_arr(   0) );
tree_0001 : entity work.tree_bdt0_t0001 port map(clk, slv_X, slv_X_vld, slv_yTrees(   1), slv_y_vld_arr(   1) );
tree_0002 : entity work.tree_bdt0_t0002 port map(clk, slv_X, slv_X_vld, slv_yTrees(   2), slv_y_vld_arr(   2) );
tree_0003 : entity work.tree_bdt0_t0003 port map(clk, slv_X, slv_X_vld, slv_yTrees(   3), slv_y_vld_arr(   3) );
tree_0004 : entity work.tree_bdt0_t0004 port map(clk, slv_X, slv_X_vld, slv_yTrees(   4), slv_y_vld_arr(   4) );
tree_0005 : entity work.tree_bdt0_t0005 port map(clk, slv_X, slv_X_vld, slv_yTrees(   5), slv_y_vld_arr(   5) );
tree_0006 : entity work.tree_bdt0_t0006 port map(clk, slv_X, slv_X_vld, slv_yTrees(   6), slv_y_vld_arr(   6) );
tree_0007 : entity work.tree_bdt0_t0007 port map(clk, slv_X, slv_X_vld, slv_yTrees(   7), slv_y_vld_arr(   7) );
tree_0008 : entity work.tree_bdt0_t0008 port map(clk, slv_X, slv_X_vld, slv_yTrees(   8), slv_y_vld_arr(   8) );
tree_0009 : entity work.tree_bdt0_t0009 port map(clk, slv_X, slv_X_vld, slv_yTrees(   9), slv_y_vld_arr(   9) );
tree_0010 : entity work.tree_bdt0_t0010 port map(clk, slv_X, slv_X_vld, slv_yTrees(  10), slv_y_vld_arr(  10) );
tree_0011 : entity work.tree_bdt0_t0011 port map(clk, slv_X, slv_X_vld, slv_yTrees(  11), slv_y_vld_arr(  11) );
tree_0012 : entity work.tree_bdt0_t0012 port map(clk, slv_X, slv_X_vld, slv_yTrees(  12), slv_y_vld_arr(  12) );
tree_0013 : entity work.tree_bdt0_t0013 port map(clk, slv_X, slv_X_vld, slv_yTrees(  13), slv_y_vld_arr(  13) );
tree_0014 : entity work.tree_bdt0_t0014 port map(clk, slv_X, slv_X_vld, slv_yTrees(  14), slv_y_vld_arr(  14) );
tree_0015 : entity work.tree_bdt0_t0015 port map(clk, slv_X, slv_X_vld, slv_yTrees(  15), slv_y_vld_arr(  15) );
tree_0016 : entity work.tree_bdt0_t0016 port map(clk, slv_X, slv_X_vld, slv_yTrees(  16), slv_y_vld_arr(  16) );
tree_0017 : entity work.tree_bdt0_t0017 port map(clk, slv_X, slv_X_vld, slv_yTrees(  17), slv_y_vld_arr(  17) );
tree_0018 : entity work.tree_bdt0_t0018 port map(clk, slv_X, slv_X_vld, slv_yTrees(  18), slv_y_vld_arr(  18) );
tree_0019 : entity work.tree_bdt0_t0019 port map(clk, slv_X, slv_X_vld, slv_yTrees(  19), slv_y_vld_arr(  19) );
tree_0020 : entity work.tree_bdt0_t0020 port map(clk, slv_X, slv_X_vld, slv_yTrees(  20), slv_y_vld_arr(  20) );
tree_0021 : entity work.tree_bdt0_t0021 port map(clk, slv_X, slv_X_vld, slv_yTrees(  21), slv_y_vld_arr(  21) );
tree_0022 : entity work.tree_bdt0_t0022 port map(clk, slv_X, slv_X_vld, slv_yTrees(  22), slv_y_vld_arr(  22) );
tree_0023 : entity work.tree_bdt0_t0023 port map(clk, slv_X, slv_X_vld, slv_yTrees(  23), slv_y_vld_arr(  23) );
tree_0024 : entity work.tree_bdt0_t0024 port map(clk, slv_X, slv_X_vld, slv_yTrees(  24), slv_y_vld_arr(  24) );
tree_0025 : entity work.tree_bdt0_t0025 port map(clk, slv_X, slv_X_vld, slv_yTrees(  25), slv_y_vld_arr(  25) );
tree_0026 : entity work.tree_bdt0_t0026 port map(clk, slv_X, slv_X_vld, slv_yTrees(  26), slv_y_vld_arr(  26) );
tree_0027 : entity work.tree_bdt0_t0027 port map(clk, slv_X, slv_X_vld, slv_yTrees(  27), slv_y_vld_arr(  27) );
tree_0028 : entity work.tree_bdt0_t0028 port map(clk, slv_X, slv_X_vld, slv_yTrees(  28), slv_y_vld_arr(  28) );
tree_0029 : entity work.tree_bdt0_t0029 port map(clk, slv_X, slv_X_vld, slv_yTrees(  29), slv_y_vld_arr(  29) );
tree_0030 : entity work.tree_bdt0_t0030 port map(clk, slv_X, slv_X_vld, slv_yTrees(  30), slv_y_vld_arr(  30) );
tree_0031 : entity work.tree_bdt0_t0031 port map(clk, slv_X, slv_X_vld, slv_yTrees(  31), slv_y_vld_arr(  31) );
tree_0032 : entity work.tree_bdt0_t0032 port map(clk, slv_X, slv_X_vld, slv_yTrees(  32), slv_y_vld_arr(  32) );
tree_0033 : entity work.tree_bdt0_t0033 port map(clk, slv_X, slv_X_vld, slv_yTrees(  33), slv_y_vld_arr(  33) );
tree_0034 : entity work.tree_bdt0_t0034 port map(clk, slv_X, slv_X_vld, slv_yTrees(  34), slv_y_vld_arr(  34) );
tree_0035 : entity work.tree_bdt0_t0035 port map(clk, slv_X, slv_X_vld, slv_yTrees(  35), slv_y_vld_arr(  35) );
tree_0036 : entity work.tree_bdt0_t0036 port map(clk, slv_X, slv_X_vld, slv_yTrees(  36), slv_y_vld_arr(  36) );
tree_0037 : entity work.tree_bdt0_t0037 port map(clk, slv_X, slv_X_vld, slv_yTrees(  37), slv_y_vld_arr(  37) );
tree_0038 : entity work.tree_bdt0_t0038 port map(clk, slv_X, slv_X_vld, slv_yTrees(  38), slv_y_vld_arr(  38) );
tree_0039 : entity work.tree_bdt0_t0039 port map(clk, slv_X, slv_X_vld, slv_yTrees(  39), slv_y_vld_arr(  39) );
tree_0040 : entity work.tree_bdt0_t0040 port map(clk, slv_X, slv_X_vld, slv_yTrees(  40), slv_y_vld_arr(  40) );
tree_0041 : entity work.tree_bdt0_t0041 port map(clk, slv_X, slv_X_vld, slv_yTrees(  41), slv_y_vld_arr(  41) );
tree_0042 : entity work.tree_bdt0_t0042 port map(clk, slv_X, slv_X_vld, slv_yTrees(  42), slv_y_vld_arr(  42) );
tree_0043 : entity work.tree_bdt0_t0043 port map(clk, slv_X, slv_X_vld, slv_yTrees(  43), slv_y_vld_arr(  43) );
tree_0044 : entity work.tree_bdt0_t0044 port map(clk, slv_X, slv_X_vld, slv_yTrees(  44), slv_y_vld_arr(  44) );
tree_0045 : entity work.tree_bdt0_t0045 port map(clk, slv_X, slv_X_vld, slv_yTrees(  45), slv_y_vld_arr(  45) );
tree_0046 : entity work.tree_bdt0_t0046 port map(clk, slv_X, slv_X_vld, slv_yTrees(  46), slv_y_vld_arr(  46) );
tree_0047 : entity work.tree_bdt0_t0047 port map(clk, slv_X, slv_X_vld, slv_yTrees(  47), slv_y_vld_arr(  47) );
tree_0048 : entity work.tree_bdt0_t0048 port map(clk, slv_X, slv_X_vld, slv_yTrees(  48), slv_y_vld_arr(  48) );
tree_0049 : entity work.tree_bdt0_t0049 port map(clk, slv_X, slv_X_vld, slv_yTrees(  49), slv_y_vld_arr(  49) );
tree_0050 : entity work.tree_bdt0_t0050 port map(clk, slv_X, slv_X_vld, slv_yTrees(  50), slv_y_vld_arr(  50) );
tree_0051 : entity work.tree_bdt0_t0051 port map(clk, slv_X, slv_X_vld, slv_yTrees(  51), slv_y_vld_arr(  51) );
tree_0052 : entity work.tree_bdt0_t0052 port map(clk, slv_X, slv_X_vld, slv_yTrees(  52), slv_y_vld_arr(  52) );
tree_0053 : entity work.tree_bdt0_t0053 port map(clk, slv_X, slv_X_vld, slv_yTrees(  53), slv_y_vld_arr(  53) );
tree_0054 : entity work.tree_bdt0_t0054 port map(clk, slv_X, slv_X_vld, slv_yTrees(  54), slv_y_vld_arr(  54) );
tree_0055 : entity work.tree_bdt0_t0055 port map(clk, slv_X, slv_X_vld, slv_yTrees(  55), slv_y_vld_arr(  55) );
tree_0056 : entity work.tree_bdt0_t0056 port map(clk, slv_X, slv_X_vld, slv_yTrees(  56), slv_y_vld_arr(  56) );
tree_0057 : entity work.tree_bdt0_t0057 port map(clk, slv_X, slv_X_vld, slv_yTrees(  57), slv_y_vld_arr(  57) );
tree_0058 : entity work.tree_bdt0_t0058 port map(clk, slv_X, slv_X_vld, slv_yTrees(  58), slv_y_vld_arr(  58) );
tree_0059 : entity work.tree_bdt0_t0059 port map(clk, slv_X, slv_X_vld, slv_yTrees(  59), slv_y_vld_arr(  59) );
tree_0060 : entity work.tree_bdt0_t0060 port map(clk, slv_X, slv_X_vld, slv_yTrees(  60), slv_y_vld_arr(  60) );
tree_0061 : entity work.tree_bdt0_t0061 port map(clk, slv_X, slv_X_vld, slv_yTrees(  61), slv_y_vld_arr(  61) );
tree_0062 : entity work.tree_bdt0_t0062 port map(clk, slv_X, slv_X_vld, slv_yTrees(  62), slv_y_vld_arr(  62) );
tree_0063 : entity work.tree_bdt0_t0063 port map(clk, slv_X, slv_X_vld, slv_yTrees(  63), slv_y_vld_arr(  63) );
tree_0064 : entity work.tree_bdt0_t0064 port map(clk, slv_X, slv_X_vld, slv_yTrees(  64), slv_y_vld_arr(  64) );
tree_0065 : entity work.tree_bdt0_t0065 port map(clk, slv_X, slv_X_vld, slv_yTrees(  65), slv_y_vld_arr(  65) );
tree_0066 : entity work.tree_bdt0_t0066 port map(clk, slv_X, slv_X_vld, slv_yTrees(  66), slv_y_vld_arr(  66) );
tree_0067 : entity work.tree_bdt0_t0067 port map(clk, slv_X, slv_X_vld, slv_yTrees(  67), slv_y_vld_arr(  67) );
tree_0068 : entity work.tree_bdt0_t0068 port map(clk, slv_X, slv_X_vld, slv_yTrees(  68), slv_y_vld_arr(  68) );
tree_0069 : entity work.tree_bdt0_t0069 port map(clk, slv_X, slv_X_vld, slv_yTrees(  69), slv_y_vld_arr(  69) );
tree_0070 : entity work.tree_bdt0_t0070 port map(clk, slv_X, slv_X_vld, slv_yTrees(  70), slv_y_vld_arr(  70) );
tree_0071 : entity work.tree_bdt0_t0071 port map(clk, slv_X, slv_X_vld, slv_yTrees(  71), slv_y_vld_arr(  71) );
tree_0072 : entity work.tree_bdt0_t0072 port map(clk, slv_X, slv_X_vld, slv_yTrees(  72), slv_y_vld_arr(  72) );
tree_0073 : entity work.tree_bdt0_t0073 port map(clk, slv_X, slv_X_vld, slv_yTrees(  73), slv_y_vld_arr(  73) );
tree_0074 : entity work.tree_bdt0_t0074 port map(clk, slv_X, slv_X_vld, slv_yTrees(  74), slv_y_vld_arr(  74) );
tree_0075 : entity work.tree_bdt0_t0075 port map(clk, slv_X, slv_X_vld, slv_yTrees(  75), slv_y_vld_arr(  75) );
tree_0076 : entity work.tree_bdt0_t0076 port map(clk, slv_X, slv_X_vld, slv_yTrees(  76), slv_y_vld_arr(  76) );
tree_0077 : entity work.tree_bdt0_t0077 port map(clk, slv_X, slv_X_vld, slv_yTrees(  77), slv_y_vld_arr(  77) );
tree_0078 : entity work.tree_bdt0_t0078 port map(clk, slv_X, slv_X_vld, slv_yTrees(  78), slv_y_vld_arr(  78) );
tree_0079 : entity work.tree_bdt0_t0079 port map(clk, slv_X, slv_X_vld, slv_yTrees(  79), slv_y_vld_arr(  79) );
tree_0080 : entity work.tree_bdt0_t0080 port map(clk, slv_X, slv_X_vld, slv_yTrees(  80), slv_y_vld_arr(  80) );
tree_0081 : entity work.tree_bdt0_t0081 port map(clk, slv_X, slv_X_vld, slv_yTrees(  81), slv_y_vld_arr(  81) );
tree_0082 : entity work.tree_bdt0_t0082 port map(clk, slv_X, slv_X_vld, slv_yTrees(  82), slv_y_vld_arr(  82) );
tree_0083 : entity work.tree_bdt0_t0083 port map(clk, slv_X, slv_X_vld, slv_yTrees(  83), slv_y_vld_arr(  83) );
tree_0084 : entity work.tree_bdt0_t0084 port map(clk, slv_X, slv_X_vld, slv_yTrees(  84), slv_y_vld_arr(  84) );
tree_0085 : entity work.tree_bdt0_t0085 port map(clk, slv_X, slv_X_vld, slv_yTrees(  85), slv_y_vld_arr(  85) );
tree_0086 : entity work.tree_bdt0_t0086 port map(clk, slv_X, slv_X_vld, slv_yTrees(  86), slv_y_vld_arr(  86) );
tree_0087 : entity work.tree_bdt0_t0087 port map(clk, slv_X, slv_X_vld, slv_yTrees(  87), slv_y_vld_arr(  87) );
tree_0088 : entity work.tree_bdt0_t0088 port map(clk, slv_X, slv_X_vld, slv_yTrees(  88), slv_y_vld_arr(  88) );
tree_0089 : entity work.tree_bdt0_t0089 port map(clk, slv_X, slv_X_vld, slv_yTrees(  89), slv_y_vld_arr(  89) );
tree_0090 : entity work.tree_bdt0_t0090 port map(clk, slv_X, slv_X_vld, slv_yTrees(  90), slv_y_vld_arr(  90) );
tree_0091 : entity work.tree_bdt0_t0091 port map(clk, slv_X, slv_X_vld, slv_yTrees(  91), slv_y_vld_arr(  91) );
tree_0092 : entity work.tree_bdt0_t0092 port map(clk, slv_X, slv_X_vld, slv_yTrees(  92), slv_y_vld_arr(  92) );
tree_0093 : entity work.tree_bdt0_t0093 port map(clk, slv_X, slv_X_vld, slv_yTrees(  93), slv_y_vld_arr(  93) );
tree_0094 : entity work.tree_bdt0_t0094 port map(clk, slv_X, slv_X_vld, slv_yTrees(  94), slv_y_vld_arr(  94) );
tree_0095 : entity work.tree_bdt0_t0095 port map(clk, slv_X, slv_X_vld, slv_yTrees(  95), slv_y_vld_arr(  95) );
tree_0096 : entity work.tree_bdt0_t0096 port map(clk, slv_X, slv_X_vld, slv_yTrees(  96), slv_y_vld_arr(  96) );
tree_0097 : entity work.tree_bdt0_t0097 port map(clk, slv_X, slv_X_vld, slv_yTrees(  97), slv_y_vld_arr(  97) );
tree_0098 : entity work.tree_bdt0_t0098 port map(clk, slv_X, slv_X_vld, slv_yTrees(  98), slv_y_vld_arr(  98) );
tree_0099 : entity work.tree_bdt0_t0099 port map(clk, slv_X, slv_X_vld, slv_yTrees(  99), slv_y_vld_arr(  99) );
tree_0100 : entity work.tree_bdt0_t0100 port map(clk, slv_X, slv_X_vld, slv_yTrees( 100), slv_y_vld_arr( 100) );
tree_0101 : entity work.tree_bdt0_t0101 port map(clk, slv_X, slv_X_vld, slv_yTrees( 101), slv_y_vld_arr( 101) );
tree_0102 : entity work.tree_bdt0_t0102 port map(clk, slv_X, slv_X_vld, slv_yTrees( 102), slv_y_vld_arr( 102) );
tree_0103 : entity work.tree_bdt0_t0103 port map(clk, slv_X, slv_X_vld, slv_yTrees( 103), slv_y_vld_arr( 103) );
tree_0104 : entity work.tree_bdt0_t0104 port map(clk, slv_X, slv_X_vld, slv_yTrees( 104), slv_y_vld_arr( 104) );
tree_0105 : entity work.tree_bdt0_t0105 port map(clk, slv_X, slv_X_vld, slv_yTrees( 105), slv_y_vld_arr( 105) );
tree_0106 : entity work.tree_bdt0_t0106 port map(clk, slv_X, slv_X_vld, slv_yTrees( 106), slv_y_vld_arr( 106) );
tree_0107 : entity work.tree_bdt0_t0107 port map(clk, slv_X, slv_X_vld, slv_yTrees( 107), slv_y_vld_arr( 107) );
tree_0108 : entity work.tree_bdt0_t0108 port map(clk, slv_X, slv_X_vld, slv_yTrees( 108), slv_y_vld_arr( 108) );
tree_0109 : entity work.tree_bdt0_t0109 port map(clk, slv_X, slv_X_vld, slv_yTrees( 109), slv_y_vld_arr( 109) );
tree_0110 : entity work.tree_bdt0_t0110 port map(clk, slv_X, slv_X_vld, slv_yTrees( 110), slv_y_vld_arr( 110) );
tree_0111 : entity work.tree_bdt0_t0111 port map(clk, slv_X, slv_X_vld, slv_yTrees( 111), slv_y_vld_arr( 111) );
tree_0112 : entity work.tree_bdt0_t0112 port map(clk, slv_X, slv_X_vld, slv_yTrees( 112), slv_y_vld_arr( 112) );
tree_0113 : entity work.tree_bdt0_t0113 port map(clk, slv_X, slv_X_vld, slv_yTrees( 113), slv_y_vld_arr( 113) );
tree_0114 : entity work.tree_bdt0_t0114 port map(clk, slv_X, slv_X_vld, slv_yTrees( 114), slv_y_vld_arr( 114) );
tree_0115 : entity work.tree_bdt0_t0115 port map(clk, slv_X, slv_X_vld, slv_yTrees( 115), slv_y_vld_arr( 115) );
tree_0116 : entity work.tree_bdt0_t0116 port map(clk, slv_X, slv_X_vld, slv_yTrees( 116), slv_y_vld_arr( 116) );
tree_0117 : entity work.tree_bdt0_t0117 port map(clk, slv_X, slv_X_vld, slv_yTrees( 117), slv_y_vld_arr( 117) );
tree_0118 : entity work.tree_bdt0_t0118 port map(clk, slv_X, slv_X_vld, slv_yTrees( 118), slv_y_vld_arr( 118) );
tree_0119 : entity work.tree_bdt0_t0119 port map(clk, slv_X, slv_X_vld, slv_yTrees( 119), slv_y_vld_arr( 119) );
tree_0120 : entity work.tree_bdt0_t0120 port map(clk, slv_X, slv_X_vld, slv_yTrees( 120), slv_y_vld_arr( 120) );
tree_0121 : entity work.tree_bdt0_t0121 port map(clk, slv_X, slv_X_vld, slv_yTrees( 121), slv_y_vld_arr( 121) );
tree_0122 : entity work.tree_bdt0_t0122 port map(clk, slv_X, slv_X_vld, slv_yTrees( 122), slv_y_vld_arr( 122) );
tree_0123 : entity work.tree_bdt0_t0123 port map(clk, slv_X, slv_X_vld, slv_yTrees( 123), slv_y_vld_arr( 123) );
tree_0124 : entity work.tree_bdt0_t0124 port map(clk, slv_X, slv_X_vld, slv_yTrees( 124), slv_y_vld_arr( 124) );
tree_0125 : entity work.tree_bdt0_t0125 port map(clk, slv_X, slv_X_vld, slv_yTrees( 125), slv_y_vld_arr( 125) );
tree_0126 : entity work.tree_bdt0_t0126 port map(clk, slv_X, slv_X_vld, slv_yTrees( 126), slv_y_vld_arr( 126) );
tree_0127 : entity work.tree_bdt0_t0127 port map(clk, slv_X, slv_X_vld, slv_yTrees( 127), slv_y_vld_arr( 127) );
    
    -----------------------------------------------------
    -- Sum the output scores using the add tree-reduce
    -----------------------------------------------------

    yTrees( nTrees ) <= Arrays0.initPredict;
    y_vld_arr( nTrees ) <= true;
    GenY: for GI in slv_yTrees'range generate
      yTrees(GI) <= signed(slv_yTrees(GI));
      y_vld_arr(GI) <= true when (slv_y_vld_arr(GI)='1') else false;
    end generate;
  

    AddTree : entity work.AddReduce
    port map(clk => clk, d => yTrees, d_vld => y_vld_arr, q => yV, q_vld => y_vld_arr_v);
    y <= yV(0);
    y_vld <= y_vld_arr_v(0);
  
  end rtl_separate;
  