	NIOS_ROBOT_LAST u0 (
		.clk_clk                                                 (<connected-to-clk_clk>),                                                 //                                         clk.clk
		.reset_reset_n                                           (<connected-to-reset_reset_n>),                                           //                                       reset.reset_n
		.to_external_bus_bridge_0_external_interface_acknowledge (<connected-to-to_external_bus_bridge_0_external_interface_acknowledge>), // to_external_bus_bridge_0_external_interface.acknowledge
		.to_external_bus_bridge_0_external_interface_irq         (<connected-to-to_external_bus_bridge_0_external_interface_irq>),         //                                            .irq
		.to_external_bus_bridge_0_external_interface_address     (<connected-to-to_external_bus_bridge_0_external_interface_address>),     //                                            .address
		.to_external_bus_bridge_0_external_interface_bus_enable  (<connected-to-to_external_bus_bridge_0_external_interface_bus_enable>),  //                                            .bus_enable
		.to_external_bus_bridge_0_external_interface_byte_enable (<connected-to-to_external_bus_bridge_0_external_interface_byte_enable>), //                                            .byte_enable
		.to_external_bus_bridge_0_external_interface_rw          (<connected-to-to_external_bus_bridge_0_external_interface_rw>),          //                                            .rw
		.to_external_bus_bridge_0_external_interface_write_data  (<connected-to-to_external_bus_bridge_0_external_interface_write_data>),  //                                            .write_data
		.to_external_bus_bridge_0_external_interface_read_data   (<connected-to-to_external_bus_bridge_0_external_interface_read_data>)    //                                            .read_data
	);

