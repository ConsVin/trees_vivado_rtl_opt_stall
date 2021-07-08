library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

package Constants is

  constant nTrees     : natural := 128;
  constant maxDepth   : natural := 11;
  constant nNodes     : natural := 4095;
  constant nLeaves    : natural := 2048;
  constant nFeatures  : natural := 485;
  constant nClasses   : natural := 1;
  constant BW_X       : natural := 15;
  constant BW_Y       : natural := 15;  
  constant CORE_LATENCY :natural:= maxDepth*3 + 1;

  subtype tx is signed(BW_X-1 downto 0);
  subtype ty is signed(BW_Y-1 downto 0);
  
  function to_tx(x : integer) return tx;
  function to_ty(y : integer) return ty;

  type boolArray is array(natural range <>) of boolean;
  type txArray is array(natural range <>) of tx;
  type tyArray is array(natural range <>) of ty;

  constant LOG_TREE_MASK : boolArray(0 to nTrees-1):=(
    -- 0        => true,  
    -- nTrees-1 => true,
    others   => false
  );

end package;

package body Constants is

  function to_tx(x : integer) return tx is
  begin
    return to_signed(x, tx'length);
  end to_tx;

  function to_ty(y : integer) return ty is
  begin
    return to_signed(y, ty'length);
  end to_ty;

end package body;
