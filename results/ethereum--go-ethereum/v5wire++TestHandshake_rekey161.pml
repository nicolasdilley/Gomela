// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/ethereum/go-ethereum/blob//p2p/discover/v5wire/encoding_test.go#L161
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestHandshake_rekey1610 = [1] of {int};
	run TestHandshake_rekey161(child_TestHandshake_rekey1610);
	run receiver(child_TestHandshake_rekey1610)
stop_process:skip
}

proctype TestHandshake_rekey161(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_close5060 = [1] of {int};
	chan child_expectDecode54514 = [1] of {int};
	chan child_encode52113 = [1] of {int};
	chan child_expectDecode54512 = [1] of {int};
	chan child_encodeWithChallenge52611 = [1] of {int};
	chan child_addr57510 = [1] of {int};
	chan child_id5799 = [1] of {int};
	chan child_addr5758 = [1] of {int};
	chan child_id5797 = [1] of {int};
	chan child_expectDecode5456 = [1] of {int};
	chan child_encode5215 = [1] of {int};
	chan child_expectDecode5454 = [1] of {int};
	chan child_encode5213 = [1] of {int};
	chan child_addr5752 = [1] of {int};
	chan child_id5791 = [1] of {int};
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
	run id579(net_nodeB_c_localnode_mu,net_nodeB_ln_mu,child_id5791);
	child_id5791?0;
	run addr575(net_nodeB_c_localnode_mu,net_nodeB_ln_mu,child_addr5752);
	child_addr5752?0;
	run encode521(net_nodeA_c_localnode_mu,net_nodeA_ln_mu,net_nodeB_c_localnode_mu,net_nodeB_ln_mu,child_encode5213);
	child_encode5213?0;
	run expectDecode545(net_nodeB_c_localnode_mu,net_nodeB_ln_mu,child_expectDecode5454);
	child_expectDecode5454?0;
	run encode521(net_nodeB_c_localnode_mu,net_nodeB_ln_mu,net_nodeA_c_localnode_mu,net_nodeA_ln_mu,child_encode5215);
	child_encode5215?0;
	run expectDecode545(net_nodeA_c_localnode_mu,net_nodeA_ln_mu,child_expectDecode5456);
	child_expectDecode5456?0;
	run id579(net_nodeB_c_localnode_mu,net_nodeB_ln_mu,child_id5797);
	child_id5797?0;
	run addr575(net_nodeB_c_localnode_mu,net_nodeB_ln_mu,child_addr5758);
	child_addr5758?0;
	run id579(net_nodeA_c_localnode_mu,net_nodeA_ln_mu,child_id5799);
	child_id5799?0;
	run addr575(net_nodeA_c_localnode_mu,net_nodeA_ln_mu,child_addr57510);
	child_addr57510?0;
	run encodeWithChallenge526(net_nodeA_c_localnode_mu,net_nodeA_ln_mu,net_nodeB_c_localnode_mu,net_nodeB_ln_mu,child_encodeWithChallenge52611);
	child_encodeWithChallenge52611?0;
	run expectDecode545(net_nodeB_c_localnode_mu,net_nodeB_ln_mu,child_expectDecode54512);
	child_expectDecode54512?0;
	run encode521(net_nodeB_c_localnode_mu,net_nodeB_ln_mu,net_nodeA_c_localnode_mu,net_nodeA_ln_mu,child_encode52113);
	child_encode52113?0;
	run expectDecode545(net_nodeA_c_localnode_mu,net_nodeA_ln_mu,child_expectDecode54514);
	child_expectDecode54514?0;
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
proctype id579(Mutexdef n_c_localnode_mu;Mutexdef n_ln_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype addr575(Mutexdef n_c_localnode_mu;Mutexdef n_ln_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype encode521(Mutexdef n_c_localnode_mu;Mutexdef n_ln_mu;Mutexdef to_c_localnode_mu;Mutexdef to_ln_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_encodeWithChallenge5263 = [1] of {int};
	run encodeWithChallenge526(n_c_localnode_mu,n_ln_mu,to_c_localnode_mu,to_ln_mu,child_encodeWithChallenge5263);
	child_encodeWithChallenge5263?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype encodeWithChallenge526(Mutexdef n_c_localnode_mu;Mutexdef n_ln_mu;Mutexdef to_c_localnode_mu;Mutexdef to_ln_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Encode1614 = [1] of {int};
	chan child_n5713 = [1] of {int};
	

	if
	:: true -> 
		run n571(to_c_localnode_mu,to_ln_mu,child_n5713);
		child_n5713?0
	:: true;
	fi;
	run Encode161(n_c_localnode_mu,child_Encode1614);
	child_Encode1614?0;
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
	chan child_EncodeRaw21410 = [1] of {int};
	chan child_encryptMessage3999 = [1] of {int};
	chan child_writeHeaders2278 = [1] of {int};
	chan child_encodeWhoareyou2814 = [1] of {int};
	chan child_encodeHandshakeHeader3045 = [1] of {int};
	chan child_encodeMessageHeader3836 = [1] of {int};
	chan child_encodeRandom2627 = [1] of {int};
	

	if
	:: true -> 
		run encodeWhoareyou281(c_localnode_mu,child_encodeWhoareyou2814);
		child_encodeWhoareyou2814?0
	:: true -> 
		run encodeHandshakeHeader304(c_localnode_mu,child_encodeHandshakeHeader3045);
		child_encodeHandshakeHeader3045?0
	:: true -> 
		

		if
		:: true -> 
			run encodeMessageHeader383(c_localnode_mu,child_encodeMessageHeader3836);
			child_encodeMessageHeader3836?0
		:: true -> 
			run encodeRandom262(c_localnode_mu,child_encodeRandom2627);
			child_encodeRandom2627?0
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
	run writeHeaders227(c_localnode_mu,child_writeHeaders2278);
	child_writeHeaders2278?0;
	

	if
	:: true -> 
		

		if
		:: true -> 
			run encryptMessage399(c_localnode_mu,child_encryptMessage3999);
			child_encryptMessage3999?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
	fi;
	run EncodeRaw214(c_localnode_mu,child_EncodeRaw21410);
	child_EncodeRaw21410?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype encodeWhoareyou281(Mutexdef c_localnode_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_makeHeader2354 = [1] of {int};
	run makeHeader235(c_localnode_mu,child_makeHeader2354);
	child_makeHeader2354?0;
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
	chan child_makeHeader2356 = [1] of {int};
	chan child_makeHandshakeAuth3415 = [1] of {int};
	run makeHandshakeAuth341(c_localnode_mu,child_makeHandshakeAuth3415);
	child_makeHandshakeAuth3415?0;
	

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
	run makeHeader235(c_localnode_mu,child_makeHeader2356);
	child_makeHeader2356?0;
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
	chan child_makeHeader2356 = [1] of {int};
	run makeHeader235(c_localnode_mu,child_makeHeader2356);
	child_makeHeader2356?0;
	

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
	chan child_makeHeader2357 = [1] of {int};
	run makeHeader235(c_localnode_mu,child_makeHeader2357);
	child_makeHeader2357?0;
	

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
	chan child_writeHeaders22710 = [1] of {int};
	run writeHeaders227(c_localnode_mu,child_writeHeaders22710);
	child_writeHeaders22710?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype expectDecode545(Mutexdef n_c_localnode_mu;Mutexdef n_ln_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_decode5664 = [1] of {int};
	run decode566(n_c_localnode_mu,n_ln_mu,child_decode5664);
	child_decode5664?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype decode566(Mutexdef n_c_localnode_mu;Mutexdef n_ln_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Decode4174 = [1] of {int};
	run Decode417(n_c_localnode_mu,child_Decode4174);
	child_Decode4174?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Decode417(Mutexdef c_localnode_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_decodeWhoareyou4634 = [1] of {int};
	chan child_decodeHandshakeMessage4805 = [1] of {int};
	chan child_decodeMessage5876 = [1] of {int};
	

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
		run decodeWhoareyou463(c_localnode_mu,child_decodeWhoareyou4634);
		child_decodeWhoareyou4634?0
	:: true -> 
		run decodeHandshakeMessage480(c_localnode_mu,child_decodeHandshakeMessage4805);
		child_decodeHandshakeMessage4805?0
	:: true -> 
		run decodeMessage587(c_localnode_mu,child_decodeMessage5876);
		child_decodeMessage5876?0
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
	chan child_decryptMessage6066 = [1] of {int};
	chan child_decodeHandshake5005 = [1] of {int};
	run decodeHandshake500(c_localnode_mu,child_decodeHandshake5005);
	child_decodeHandshake5005?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run decryptMessage606(c_localnode_mu,child_decryptMessage6066);
	child_decryptMessage6066?0;
	

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
	chan child_decodeHandshakeRecord5626 = [1] of {int};
	chan child_decodeHandshakeAuthData5345 = [1] of {int};
	run decodeHandshakeAuthData534(c_localnode_mu,child_decodeHandshakeAuthData5345);
	child_decodeHandshakeAuthData5345?0;
	

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
	run decodeHandshakeRecord562(c_localnode_mu,child_decodeHandshakeRecord5626);
	child_decodeHandshakeRecord5626?0;
	

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
	chan child_decryptMessage6066 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run decryptMessage606(c_localnode_mu,child_decryptMessage6066);
	child_decryptMessage6066?0;
	

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

