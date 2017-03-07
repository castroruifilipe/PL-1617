BEGIN					{ RS = "<TRANSACCAO>" }
					{ print $2 }
END					{ }
