// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/ethereum/go-ethereum/blob//p2p/discover/v5wire/encoding_test.go#L274
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestDecodeErrorsV52740 = [1] of {int};
	run TestDecodeErrorsV5274(child_TestDecodeErrorsV52740);
	run receiver(child_TestDecodeErrorsV52740)
stop_process:skip
}

proctype TestDecodeErrorsV5274(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_close5060 = [1] of {int};
	chan child_expectDecodeErr5591 = [1] of {int};
	Mutexdef net_clock_mu;
	Mutexdef net_nodeB_c_localnode_mu;
	Mutexdef net_nodeB_ln_mu;
	Mutexdef net_nodeA_c_localnode_mu;
	Mutexdef net_nodeA_ln_mu;
	run mutexMonitor(net_nodeA_ln_mu);
	run mutexMonitor(net_nodeA_c_localnode_mu);
	run mutexMonitor(net_nodeB_ln_mu);
	run mutexMonitor(net_nodeB_c_localnode_mu);
	run mutexMonitor(net_clock_mu);
	run expectDecodeErr559(net_nodeA_c_localnode_mu,net_nodeA_ln_mu,child_expectDecodeErr5591);
	child_expectDecodeErr5591?0;
		defer1: skip;
	run close506(net_clock_mu,net_nodeA_c_localnode_mu,net_nodeA_ln_mu,net_nodeB_c_localnode_mu,net_nodeB_ln_mu,child_close5060);
	child_close5060?0;
	stop_process: skip;
	child!0
}
proctype close506(Mutexdef t_clock_mu;Mutexdef t_nodeA_c_localnode_mu;Mutexdef t_nodeA_ln_mu;Mutexdef t_nodeB_c_localnode_mu;Mutexdef t_nodeB_ln_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype expectDecodeErr559(Mutexdef n_c_localnode_mu;Mutexdef n_ln_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_decode5661 = [1] of {int};
	run decode566(n_c_localnode_mu,n_ln_mu,child_decode5661);
	child_decode5661?0;
	stop_process: skip;
	child!0
}
proctype decode566(Mutexdef n_c_localnode_mu;Mutexdef n_ln_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Decode4171 = [1] of {int};
	run Decode417(n_c_localnode_mu,child_Decode4171);
	child_Decode4171?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Decode417(Mutexdef c_localnode_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_decodeWhoareyou4631 = [1] of {int};
	chan child_decodeHandshakeMessage4802 = [1] of {int};
	chan child_decodeMessage5873 = [1] of {int};
	

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
	

	if
	:: true -> 
		run decodeWhoareyou463(c_localnode_mu,child_decodeWhoareyou4631);
		child_decodeWhoareyou4631?0
	:: true -> 
		run decodeHandshakeMessage480(c_localnode_mu,child_decodeHandshakeMessage4802);
		child_decodeHandshakeMessage4802?0
	:: true -> 
		run decodeMessage587(c_localnode_mu,child_decodeMessage5873);
		child_decodeMessage5873?0
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype decodeWhoareyou463(Mutexdef c_localnode_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype decodeHandshakeMessage480(Mutexdef c_localnode_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_decryptMessage6063 = [1] of {int};
	chan child_decodeHandshake5002 = [1] of {int};
	run decodeHandshake500(c_localnode_mu,child_decodeHandshake5002);
	child_decodeHandshake5002?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run decryptMessage606(c_localnode_mu,child_decryptMessage6063);
	child_decryptMessage6063?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype decodeHandshake500(Mutexdef c_localnode_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_decodeHandshakeRecord5623 = [1] of {int};
	chan child_decodeHandshakeAuthData5342 = [1] of {int};
	run decodeHandshakeAuthData534(c_localnode_mu,child_decodeHandshakeAuthData5342);
	child_decodeHandshakeAuthData5342?0;
	

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
	run decodeHandshakeRecord562(c_localnode_mu,child_decodeHandshakeRecord5623);
	child_decodeHandshakeRecord5623?0;
	

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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype decodeHandshakeAuthData534(Mutexdef c_localnode_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype decodeHandshakeRecord562(Mutexdef c_localnode_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype decryptMessage606(Mutexdef c_localnode_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype decodeMessage587(Mutexdef c_localnode_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_decryptMessage6063 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run decryptMessage606(c_localnode_mu,child_decryptMessage6063);
	child_decryptMessage6063?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype mutexMonitor(Mutexdef m) {
bool locked = false;
do
:: true ->
	if
	:: m.Counter > 0 ->
		if 
		:: m.RUnlock?false -> 
			m.Counter = m.Counter - 1;
		:: m.RLock?false -> 
			m.Counter = m.Counter + 1;
		fi;
	:: locked ->
		m.Unlock?false;
		locked = false;
	:: else ->	 end:	if
		:: m.Unlock?false ->
			assert(0==32);		:: m.Lock?false ->
			locked =true;
		:: m.RUnlock?false ->
			assert(0==32);		:: m.RLock?false ->
			m.Counter = m.Counter + 1;
		fi;
	fi;
od
}

proctype receiver(chan c) {
c?0
}

