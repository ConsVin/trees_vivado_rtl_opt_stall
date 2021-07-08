architecture rtl of BDTTop is
  use work.Types.all;
  
  signal wire_y     :   tyArray(0 to nClasses-1) := (others => to_ty(0) );
  signal wire_y_vld : boolArray(0 to nClasses-1) := (others => false    ); 

  signal splitted_y       :    tyArray(0 to nClasses-1) := (others => to_ty(0) );
  signal splitted_y_vld   :  boolArray(0 to nClasses-1) := (others => false    ); 

use work.Arrays0;

  begin
  
  BDT0 : entity work.BDT
  generic map(
    iFeature => Arrays0.feature,
    iChildLeft => Arrays0.children_left,
    iChildRight => Arrays0.children_right,
    iParent => Arrays0.parent,
    iLeaf => Arrays0.iLeaf,
    depth => Arrays0.depth,
    threshold => Arrays0.threshold,
    value => Arrays0.value,
    initPredict => Arrays0.initPredict
  )
  port map(
    clk => clk,
    X => X,
    X_vld => X_vld,
    y => wire_y(0),
    y_vld => wire_y_vld(0)
  );

    
  -------------------------------
    
  y       <= wire_y;
  y_vld   <= wire_y_vld;

  -------------------------------
  
  BDT0_split : entity work.BDT_splitted
  port map(clk, X, X_vld, splitted_y(0), splitted_y_vld(0) );
  
  -------------------------------
  DBG: block
    signal err_y       : boolean;
    signal err_y_vld   : boolean;
  begin

    err_y     <= not(wire_y      = splitted_y    );
    err_y_vld <= not(wire_y_vld  = splitted_y_vld);
    
    process (clk) begin
      if rising_edge(clk) then
        assert not(err_y)       report "Splitted Tree error! y" severity ERROR;
        assert not(err_y_vld)   report "Splitted Tree error! y_vld" severity ERROR;
      end if;
    end process;

    end block;

  end rtl;