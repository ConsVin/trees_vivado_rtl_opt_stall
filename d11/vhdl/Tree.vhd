library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

library work;
use work.Constants.all;
use work.Types.all;

entity Tree is
  generic(
      iFeature   : intArray(0 to nNodes  -1)
    ; iChildLeft : intArray(0 to nNodes  -1)
    ; iChildRight: intArray(0 to nNodes  -1)
    ; iParent    : intArray(0 to nNodes  -1)
    ; iLeaf      : intArray(0 to nLeaves -1)
    ; depth      : intArray(0 to nNodes  -1)
    ; threshold  : txArray( 0 to nNodes  -1)
    ; value      : tyArray( 0 to nNodes  -1)
    ; idx        : integer                  := 0
  );
  port(
    clk   : in  std_logic;  -- clock
    X     : in  txArray(0 to nFeatures-1) := (others => to_tx(0));           -- input features
    X_vld : in  boolean := false; -- input valid
    y     : out ty := to_ty(0);           -- output score
    y_vld : out boolean := false -- output valid
  );
end tree;

architecture rtl of tree is

  signal comparison : boolArray(0 to nNodes-1) := (others => false);
  signal comparisonPipe : boolArray2D(0 to maxdepth)(0 to nNodes-1) := (others => (others => false));
  signal activation : boolArray(0 to nNodes-1) := (others => false);
  signal vld_pipe : boolArray(0 to maxdepth + 3) := (others => false);
  constant log_en : boolean   := LOG_TREE_MASK(idx);

  
begin

  process
  begin
    if (log_en) then
      report "============================================";
      report " TREE :: " & integer'image(idx);
      report "============================================";
      report "iFeature     : " & integer'image(iFeature(iFeature'low))        & "...." & integer'image(iFeature(iFeature'high))       ;
      report "iChildLeft   : " & integer'image(iChildLeft(iChildLeft'low))    & "...." & integer'image(iChildLeft(iChildLeft'high))   ;
      report "iChildRight  : " & integer'image(iChildRight(iChildRight'low))  & "...." & integer'image(iChildRight(iChildRight'high)) ;
      report "iParent      : " & integer'image(iParent(iParent'low))          & "...." & integer'image(iParent(iParent'high))         ;
      report "iLeaf        : " & integer'image(iLeaf(iLeaf'low))              & "...." & integer'image(iLeaf(iLeaf'high))             ;
      report "depth        : " & integer'image(depth(depth'low))              & "...." & integer'image(depth(depth'high))             ;
    end if;
    wait;
  end process;


  -- propagate the valid signal
  vld_pipe(0) <= X_vld;
  vld_pipe(1 to maxdepth + 3) <= vld_pipe(0 to maxdepth + 3 - 1) when rising_edge(clk);
  y_vld <= vld_pipe(maxdepth + 3);

  LOG: process(clk) 
    variable v_compar_slv : std_logic_vector(comparison'range);
  begin
    if rising_edge(clk) then
      if ((X_vld) and (log_en)) then
          for i in v_compar_slv'range loop
           v_compar_slv(i) := '1' when comparison(i) else '0';
          end loop;
          report "IDX(" & integer'image(idx) & "), v_compar_slv =  "  & to_hstring(v_compar_slv);
       end if;
     end if;
  end process;


  -- do all the comparisons
  GenComp:
  for i in 0 to nNodes-1 generate
    NonLeaf: if iFeature(i) /= -2 generate
      process(clk)
      begin
        -- Compare feature for this node to threshold for this node
        if rising_edge(clk) then
          comparison(i) <= X(iFeature(i)) <= threshold(i);
        end if;
      end process;
    end generate NonLeaf;
    -- Leaf nodes don't do comparisons
    Leaf: if iFeature(i) = -2 generate
      process(clk)
      begin
        -- Leaves are always active
        comparison(i) <= true;
      end process;
    end generate Leaf;
  end generate GenComp;

  -- Pipeline the comparisons
  comparisonPipe(0) <= comparison;
  process(clk)
  begin
    if rising_edge(clk) then
      comparisonPipe(1 to maxdepth) <= comparisonPipe(0 to maxdepth-1);
    end if;
  end process;

  -- do all the node activations
  -- the root node is always active
  activation(0) <= true; 
  GenAct:
  for i in 1 to nNodes-1 generate
    -- the root node is always active
    LeftChild:
    if i = iChildLeft(iParent(i)) generate
      process(clk)
      begin
        if rising_edge(clk) then
          activation(i) <= comparisonPipe(depth(i))(iParent(i)) and activation(iParent(i));
        end if;
      end process;    
    end generate LeftChild;
    RightChild:
    if i = iChildRight(iParent(i)) generate
      process(clk)
      begin
        if rising_edge(clk) then
          activation(i) <= (not comparisonPipe(depth(i))(iParent(i))) and activation(iParent(i));
        end if;
      end process;    
    end generate RightChild;
  end generate GenAct;

  -- Assign the score from the active leaf
  GenScore:
  process(clk)
  begin
    if rising_edge(clk) then
     for i in 0 to nLeaves-1 loop
        if activation(iLeaf(i)) then
          y <= value(iLeaf(i));
          exit;
        end if;
        y <= to_ty(0);
      end loop;
    end if;
  end process;

end rtl;
