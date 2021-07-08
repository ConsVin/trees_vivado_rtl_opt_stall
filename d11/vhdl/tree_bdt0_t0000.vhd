library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

library work;
use work.Constants.all;
use work.Types.all;

entity tree_bdt0_t0000 is
  port(
    clk   : in  std_logic;  -- clock
    X     : in  std_logic_vector( (tx'length * nFeatures) -1 downto 0);
    X_vld : in  std_logic;
    y     : out std_logic_vector( (ty'length            ) -1 downto 0);
    y_vld : out std_logic
  );

end tree_bdt0_t0000 ;

architecture rtl of tree_bdt0_t0000 is

  use work.Arrays0_0000;
  constant TREE_IDX  : natural  := 0;
  
  --  Inverse Tree Index
  constant C_ARR_IDX : natural  := nTrees-1 - TREE_IDX;
  
  --  Inverse Order of elements in each array
  constant C_iFeature   : intArray(0 to nNodes  -1) := Arrays0_0000.feature(nNodes  -1 downto 0);
  constant C_iChildLeft : intArray(0 to nNodes  -1) := Arrays0_0000.children_left(nNodes  -1 downto 0);
  constant C_iChildRight: intArray(0 to nNodes  -1) := Arrays0_0000.children_right(nNodes  -1 downto 0);
  constant C_iParent    : intArray(0 to nNodes  -1) := Arrays0_0000.parent(nNodes  -1 downto 0);
  constant C_iLeaf      : intArray(0 to nLeaves -1) := Arrays0_0000.iLeaf(nLeaves -1 downto 0);
  constant C_depth      : intArray(0 to nNodes  -1) := Arrays0_0000.depth(nNodes  -1 downto 0);
  constant C_threshold  : txArray( 0 to nNodes  -1) := Arrays0_0000.threshold(nNodes  -1 downto 0);
  constant C_value      : tyArray( 0 to nNodes  -1) := Arrays0_0000.value(nNodes  -1 downto 0);


  signal w_X     : txArray(0 to nFeatures-1);
  signal w_X_vld : boolean;
  signal w_y     : ty;
  signal w_y_vld : boolean;

  constant BWX : natural := tx'length;
  constant BWY : natural := ty'length;

begin

  --- Remap
  GEN_X: for GI in w_X'range generate
      w_X(GI) <=  signed(X( (GI+1)*BWX -1 downto GI*BWX));
  end generate;
  w_X_vld <= true when (X_vld = '1') else false;

  y     <=  std_logic_vector(w_y);
  y_vld <= '1' when w_y_vld else '0';

U : entity work.Tree
  generic map(
      iFeature    => C_iFeature
    , iChildLeft  => C_iChildLeft
    , iChildRight => C_iChildRight
    , iParent     => C_iParent
    , iLeaf       => C_iLeaf
    , depth       => C_depth
    , threshold   => C_threshold
    , value       => C_value
    , idx         => TREE_IDX
  )
  port map(
      clk   => clk
    , X     => w_X  
    , X_vld => w_X_vld
    , y     => w_y
    , y_vld => w_y_vld
);

end rtl;
