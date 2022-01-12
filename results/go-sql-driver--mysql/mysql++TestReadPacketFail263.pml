// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/go-sql-driver/mysql/blob//packets_test.go#L263
typedef Chandef {
	chan sync = [0] of {bool};
	chan enq = [0] of {int};
	chan deq = [0] of {bool,int};
	chan sending = [0] of {bool};
	chan rcving = [0] of {bool};
	chan closing = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestReadPacketFail2630 = [1] of {int};
	run TestReadPacketFail263(child_TestReadPacketFail2630);
	run receiver(child_TestReadPacketFail2630)
stop_process:skip
}

proctype TestReadPacketFail263(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_readPacket282 = [1] of {int};
	chan child_readPacket281 = [1] of {int};
	chan child_readPacket280 = [1] of {int};
	Mutexdef mc_cfg_tls_mutex;
	Chandef mc_closech_ch;
	run sync_monitor(mc_closech_ch);
	run mutexMonitor(mc_cfg_tls_mutex);
	run readPacket28(mc_closech_ch,mc_cfg_tls_mutex,child_readPacket280);
	child_readPacket280?0;
	run readPacket28(mc_closech_ch,mc_cfg_tls_mutex,child_readPacket281);
	child_readPacket281?0;
	run readPacket28(mc_closech_ch,mc_cfg_tls_mutex,child_readPacket282);
	child_readPacket282?0;
	stop_process: skip;
	child!0
}
proctype readPacket28(Chandef mc_closech_ch;Mutexdef mc_cfg_tls_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close1242 = [1] of {int};
	chan child_Close1241 = [1] of {int};
	chan child_Close1240 = [1] of {int};
	do
	:: true -> 
		for10: skip;
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			run Close124(mc_closech_ch,mc_cfg_tls_mutex,child_Close1240);
			child_Close1240?0;
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
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			

			if
			:: true -> 
				run Close124(mc_closech_ch,mc_cfg_tls_mutex,child_Close1241);
				child_Close1241?0;
				goto stop_process
			:: true;
			fi;
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
			run Close124(mc_closech_ch,mc_cfg_tls_mutex,child_Close1242);
			child_Close1242?0;
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
			goto stop_process
		:: true;
		fi;
		for10_end: skip
	od;
	for10_exit: skip;
	stop_process: skip;
	child!0
}
proctype Close124(Chandef mc_closech_ch;Mutexdef mc_cfg_tls_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_cleanup1391 = [1] of {int};
	chan child_writeCommandPacket4210 = [1] of {int};
	

	if
	:: true -> 
		run writeCommandPacket421(mc_closech_ch,mc_cfg_tls_mutex,child_writeCommandPacket4210);
		child_writeCommandPacket4210?0
	:: true;
	fi;
	run cleanup139(mc_closech_ch,mc_cfg_tls_mutex,child_cleanup1391);
	child_cleanup1391?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype writeCommandPacket421(Chandef mc_closech_ch;Mutexdef mc_cfg_tls_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_writePacket930 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run writePacket93(mc_closech_ch,mc_cfg_tls_mutex,child_writePacket930);
	child_writePacket930?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype writePacket93(Chandef mc_closech_ch;Mutexdef mc_cfg_tls_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_cleanup1391 = [1] of {int};
	chan child_cleanup1392 = [1] of {int};
	chan child_Close1240 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			run Close124(mc_closech_ch,mc_cfg_tls_mutex,child_Close1240);
			child_Close1240?0;
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	do
	:: true -> 
		for11: skip;
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			goto for11_end
		:: true;
		fi;
		

		if
		:: true -> 
			run cleanup139(mc_closech_ch,mc_cfg_tls_mutex,child_cleanup1391);
			child_cleanup1391?0
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
			fi;
			run cleanup139(mc_closech_ch,mc_cfg_tls_mutex,child_cleanup1392);
			child_cleanup1392?0
		fi;
		goto stop_process;
		for11_end: skip
	od;
	for11_exit: skip;
	stop_process: skip;
	child!0
}
proctype cleanup139(Chandef mc_closech_ch;Mutexdef mc_cfg_tls_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	mc_closech_ch.closing!true;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype AsyncChan(Chandef ch) {
do
:: true ->
if
:: ch.closed -> 
end: if
  :: ch.num_msgs > 0 -> // cannot send on closed channel
    end4: if
    :: ch.enq?0-> // cannot send on closed channel
      assert(1 == 0)
    :: ch.closing?true -> // cannot close twice a channel
      assert(2 == 0)
    :: ch.rcving?false;
    :: ch.sending?false -> // sending state of channel (closed)
      assert(1 == 0)
    :: ch.deq!true,ch.num_msgs -> 
  		 ch.num_msgs = ch.num_msgs - 1
    fi;
  :: else ->    end5: if
    :: ch.enq?0-> // cannot send on closed channel
      assert(1 == 0)
    :: ch.closing?true -> // cannot close twice a channel
      assert(2 == 0)
    :: ch.rcving?false;
    :: ch.sending?false -> // sending state of channel (closed)
      assert(1 == 0)
    :: ch.sync!true; 
    fi;
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.deq!false,ch.num_msgs ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		    ch.closed = true
		   :: ch.rcving?false ->
 		    ch.sending?false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.enq?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.rcving?false ->
 		    ch.sending?false;
		fi;
		:: else -> 
		end3: if
		  :: ch.enq?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.deq!false,ch.num_msgs
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		     ch.closed = true
		  :: ch.rcving?false ->
 		    ch.sending?false;
		fi;
	fi;
fi;
od;
}

proctype sync_monitor(Chandef ch) {
do
:: true
if
:: ch.closed ->
end: if
  :: ch.enq?0-> // cannot send on closed channel
    assert(1 == 0)
  :: ch.closing?true -> // cannot close twice a channel
    assert(2 == 0)
  :: ch.sending?false -> // sending state of channel (closed)
    assert(1 == 0)
  :: ch.rcving?false;
  :: ch.sync!true; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.rcving?false ->
       ch.sending?false;
    :: ch.closing?true ->
      ch.closed = true
    fi;
fi;
od
stop_process:
}

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

