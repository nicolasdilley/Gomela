// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/ethereum/go-ethereum/blob//p2p/discover/v5wire/encoding_test.go#L127
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestHandshake_norecord1270 = [1] of {int};
	run TestHandshake_norecord127(child_TestHandshake_norecord1270);
	run receiver(child_TestHandshake_norecord1270)
stop_process:skip
}

proctype TestHandshake_norecord127(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_close5060 = [1] of {int};
	chan child_expectDecode5459 = [1] of {int};
	chan child_encode5218 = [1] of {int};
	chan child_expectDecode5457 = [1] of {int};
	chan child_encodeWithChallenge5266 = [1] of {int};
	chan child_expectDecode5455 = [1] of {int};
	chan child_encode5214 = [1] of {int};
	chan child_n5713 = [1] of {int};
	chan child_expectDecode5452 = [1] of {int};
	chan child_encode5211 = [1] of {int};
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
	run encode521(net_nodeA_c_localnode_mu,net_nodeA_ln_mu,net_nodeB_c_localnode_mu,net_nodeB_ln_mu,child_encode5211);
	child_encode5211?0;
	run expectDecode545(net_nodeB_c_localnode_mu,net_nodeB_ln_mu,child_expectDecode5452);
	child_expectDecode5452?0;
	run n571(net_nodeA_c_localnode_mu,net_nodeA_ln_mu,child_n5713);
	child_n5713?0;
	run encode521(net_nodeB_c_localnode_mu,net_nodeB_ln_mu,net_nodeA_c_localnode_mu,net_nodeA_ln_mu,child_encode5214);
	child_encode5214?0;
	run expectDecode545(net_nodeA_c_localnode_mu,net_nodeA_ln_mu,child_expectDecode5455);
	child_expectDecode5455?0;
	run encodeWithChallenge526(net_nodeA_c_localnode_mu,net_nodeA_ln_mu,net_nodeB_c_localnode_mu,net_nodeB_ln_mu,child_encodeWithChallenge5266);
	child_encodeWithChallenge5266?0;
	run expectDecode545(net_nodeB_c_localnode_mu,net_nodeB_ln_mu,child_expectDecode5457);
	child_expectDecode5457?0;
	run encode521(net_nodeB_c_localnode_mu,net_nodeB_ln_mu,net_nodeA_c_localnode_mu,net_nodeA_ln_mu,child_encode5218);
	child_encode5218?0;
	run expectDecode545(net_nodeA_c_localnode_mu,net_nodeA_ln_mu,child_expectDecode5459);
	child_expectDecode5459?0;
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
proctype encode521(Mutexdef n_c_localnode_mu;Mutexdef n_ln_mu;Mutexdef to_c_localnode_mu;Mutexdef to_ln_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_encodeWithChallenge5261 = [1] of {int};
	run encodeWithChallenge526(n_c_localnode_mu,n_ln_mu,to_c_localnode_mu,to_ln_mu,child_encodeWithChallenge5261);
	child_encodeWithChallenge5261?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype encodeWithChallenge526(Mutexdef n_c_localnode_mu;Mutexdef n_ln_mu;Mutexdef to_c_localnode_mu;Mutexdef to_ln_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Encode1612 = [1] of {int};
	chan child_n5711 = [1] of {int};
	

	if
	:: true -> 
		run n571(to_c_localnode_mu,to_ln_mu,child_n5711);
		child_n5711?0
	:: true;
	fi;
	run Encode161(n_c_localnode_mu,child_Encode1612);
	child_Encode1612?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype n571(Mutexdef n_c_localnode_mu;Mutexdef n_ln_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Encode161(Mutexdef c_localnode_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_EncodeRaw2148 = [1] of {int};
	chan child_encryptMessage3997 = [1] of {int};
	chan child_writeHeaders2276 = [1] of {int};
	chan child_encodeWhoareyou2812 = [1] of {int};
	chan child_encodeHandshakeHeader3043 = [1] of {int};
	chan child_encodeMessageHeader3834 = [1] of {int};
	chan child_encodeRandom2625 = [1] of {int};
	

	if
	:: true -> 
		run encodeWhoareyou281(c_localnode_mu,child_encodeWhoareyou2812);
		child_encodeWhoareyou2812?0
	:: true -> 
		run encodeHandshakeHeader304(c_localnode_mu,child_encodeHandshakeHeader3043);
		child_encodeHandshakeHeader3043?0
	:: true -> 
		

		if
		:: true -> 
			run encodeMessageHeader383(c_localnode_mu,child_encodeMessageHeader3834);
			child_encodeMessageHeader3834?0
		:: true -> 
			run encodeRandom262(c_localnode_mu,child_encodeRandom2625);
			child_encodeRandom2625?0
		fi
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
	run writeHeaders227(c_localnode_mu,child_writeHeaders2276);
	child_writeHeaders2276?0;
	

	if
	:: true -> 
		

		if
		:: true -> 
			run encryptMessage399(c_localnode_mu,child_encryptMessage3997);
			child_encryptMessage3997?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
	fi;
	run EncodeRaw214(c_localnode_mu,child_EncodeRaw2148);
	child_EncodeRaw2148?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype encodeWhoareyou281(Mutexdef c_localnode_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_makeHeader2352 = [1] of {int};
	run makeHeader235(c_localnode_mu,child_makeHeader2352);
	child_makeHeader2352?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype makeHeader235(Mutexdef c_localnode_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true;
	:: true;
	:: true;
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype encodeHandshakeHeader304(Mutexdef c_localnode_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_makeHeader2354 = [1] of {int};
	chan child_makeHandshakeAuth3413 = [1] of {int};
	run makeHandshakeAuth341(c_localnode_mu,child_makeHandshakeAuth3413);
	child_makeHandshakeAuth3413?0;
	

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
	run makeHeader235(c_localnode_mu,child_makeHeader2354);
	child_makeHeader2354?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype makeHandshakeAuth341(Mutexdef c_localnode_mu;chan child) {
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
proctype encodeMessageHeader383(Mutexdef c_localnode_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_makeHeader2354 = [1] of {int};
	run makeHeader235(c_localnode_mu,child_makeHeader2354);
	child_makeHeader2354?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype encodeRandom262(Mutexdef c_localnode_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_makeHeader2355 = [1] of {int};
	run makeHeader235(c_localnode_mu,child_makeHeader2355);
	child_makeHeader2355?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype writeHeaders227(Mutexdef c_localnode_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype encryptMessage399(Mutexdef c_localnode_mu;chan child) {
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
proctype EncodeRaw214(Mutexdef c_localnode_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_writeHeaders2278 = [1] of {int};
	run writeHeaders227(c_localnode_mu,child_writeHeaders2278);
	child_writeHeaders2278?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype expectDecode545(Mutexdef n_c_localnode_mu;Mutexdef n_ln_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_decode5662 = [1] of {int};
	run decode566(n_c_localnode_mu,n_ln_mu,child_decode5662);
	child_decode5662?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype decode566(Mutexdef n_c_localnode_mu;Mutexdef n_ln_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Decode4172 = [1] of {int};
	run Decode417(n_c_localnode_mu,child_Decode4172);
	child_Decode4172?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Decode417(Mutexdef c_localnode_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_decodeWhoareyou4632 = [1] of {int};
	chan child_decodeHandshakeMessage4803 = [1] of {int};
	chan child_decodeMessage5874 = [1] of {int};
	

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
		run decodeWhoareyou463(c_localnode_mu,child_decodeWhoareyou4632);
		child_decodeWhoareyou4632?0
	:: true -> 
		run decodeHandshakeMessage480(c_localnode_mu,child_decodeHandshakeMessage4803);
		child_decodeHandshakeMessage4803?0
	:: true -> 
		run decodeMessage587(c_localnode_mu,child_decodeMessage5874);
		child_decodeMessage5874?0
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
	chan child_decryptMessage6064 = [1] of {int};
	chan child_decodeHandshake5003 = [1] of {int};
	run decodeHandshake500(c_localnode_mu,child_decodeHandshake5003);
	child_decodeHandshake5003?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run decryptMessage606(c_localnode_mu,child_decryptMessage6064);
	child_decryptMessage6064?0;
	

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
	chan child_decodeHandshakeRecord5624 = [1] of {int};
	chan child_decodeHandshakeAuthData5343 = [1] of {int};
	run decodeHandshakeAuthData534(c_localnode_mu,child_decodeHandshakeAuthData5343);
	child_decodeHandshakeAuthData5343?0;
	

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
	run decodeHandshakeRecord562(c_localnode_mu,child_decodeHandshakeRecord5624);
	child_decodeHandshakeRecord5624?0;
	

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
	chan child_decryptMessage6064 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run decryptMessage606(c_localnode_mu,child_decryptMessage6064);
	child_decryptMessage6064?0;
	

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

