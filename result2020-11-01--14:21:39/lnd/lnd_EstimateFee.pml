#define EstimateFee_tx_Tx_TxOut 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example581033907/rpcserver.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int tx_Tx_TxOut = EstimateFee_tx_Tx_TxOut;
	Wgdef wallet_wg;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wallet_wg);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 0.. tx_Tx_TxOut-1) {
for10:
	};
	goto stop_process
stop_process:}

proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: wg.Add?i -> 
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 -> 
end:		
		if
		:: wg.Add?i -> 
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
		fi
	od
}

