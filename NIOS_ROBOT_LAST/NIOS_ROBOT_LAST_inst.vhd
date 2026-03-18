	component NIOS_ROBOT_LAST is
		port (
			clk_clk                                                 : in  std_logic                     := 'X';             -- clk
			reset_reset_n                                           : in  std_logic                     := 'X';             -- reset_n
			to_external_bus_bridge_0_external_interface_acknowledge : in  std_logic                     := 'X';             -- acknowledge
			to_external_bus_bridge_0_external_interface_irq         : in  std_logic                     := 'X';             -- irq
			to_external_bus_bridge_0_external_interface_address     : out std_logic_vector(5 downto 0);                     -- address
			to_external_bus_bridge_0_external_interface_bus_enable  : out std_logic;                                        -- bus_enable
			to_external_bus_bridge_0_external_interface_byte_enable : out std_logic_vector(1 downto 0);                     -- byte_enable
			to_external_bus_bridge_0_external_interface_rw          : out std_logic;                                        -- rw
			to_external_bus_bridge_0_external_interface_write_data  : out std_logic_vector(15 downto 0);                    -- write_data
			to_external_bus_bridge_0_external_interface_read_data   : in  std_logic_vector(15 downto 0) := (others => 'X')  -- read_data
		);
	end component NIOS_ROBOT_LAST;

	u0 : component NIOS_ROBOT_LAST
		port map (
			clk_clk                                                 => CONNECTED_TO_clk_clk,                                                 --                                         clk.clk
			reset_reset_n                                           => CONNECTED_TO_reset_reset_n,                                           --                                       reset.reset_n
			to_external_bus_bridge_0_external_interface_acknowledge => CONNECTED_TO_to_external_bus_bridge_0_external_interface_acknowledge, -- to_external_bus_bridge_0_external_interface.acknowledge
			to_external_bus_bridge_0_external_interface_irq         => CONNECTED_TO_to_external_bus_bridge_0_external_interface_irq,         --                                            .irq
			to_external_bus_bridge_0_external_interface_address     => CONNECTED_TO_to_external_bus_bridge_0_external_interface_address,     --                                            .address
			to_external_bus_bridge_0_external_interface_bus_enable  => CONNECTED_TO_to_external_bus_bridge_0_external_interface_bus_enable,  --                                            .bus_enable
			to_external_bus_bridge_0_external_interface_byte_enable => CONNECTED_TO_to_external_bus_bridge_0_external_interface_byte_enable, --                                            .byte_enable
			to_external_bus_bridge_0_external_interface_rw          => CONNECTED_TO_to_external_bus_bridge_0_external_interface_rw,          --                                            .rw
			to_external_bus_bridge_0_external_interface_write_data  => CONNECTED_TO_to_external_bus_bridge_0_external_interface_write_data,  --                                            .write_data
			to_external_bus_bridge_0_external_interface_read_data   => CONNECTED_TO_to_external_bus_bridge_0_external_interface_read_data    --                                            .read_data
		);

