// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/gravitational/teleport/blob//lib/reversetunnel/srv.go#L1103
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



init { 
	chan child_sendVersionRequest11030 = [1] of {int};
	run sendVersionRequest1103(child_sendVersionRequest11030);
	run receiver(child_sendVersionRequest11030)
stop_process:skip
}

proctype sendVersionRequest1103(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymoussendVersionRequest110711040 = [1] of {int};
	Chandef versionCh_ch;
	Chandef errorCh_ch;
	

	if
	:: 1 > 0 -> 
		errorCh_ch.size = 1;
		run AsyncChan(errorCh_ch)
	:: else -> 
		run sync_monitor(errorCh_ch)
	fi;
	

	if
	:: 1 > 0 -> 
		versionCh_ch.size = 1;
		run AsyncChan(versionCh_ch)
	:: else -> 
		run sync_monitor(versionCh_ch)
	fi;
	run AnonymoussendVersionRequest11071104(errorCh_ch,versionCh_ch,child_AnonymoussendVersionRequest110711040);
	run receiver(child_AnonymoussendVersionRequest110711040);
	do
	:: versionCh_ch.deq?state,num_msgs -> 
		goto stop_process
	:: versionCh_ch.sync?state -> 
		versionCh_ch.rcving!false;
		goto stop_process
	:: errorCh_ch.deq?state,num_msgs -> 
		goto stop_process
	:: errorCh_ch.sync?state -> 
		errorCh_ch.rcving!false;
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	od;
	for10_exit: skip;
	for10_end: skip;
	stop_process: skip;
	child!0
}
proctype AnonymoussendVersionRequest11071104(Chandef errorCh_ch;Chandef versionCh_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errorCh_ch.enq!0;
		:: errorCh_ch.sync!false -> 
			errorCh_ch.sending!false
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: errorCh_ch.enq!0;
		:: errorCh_ch.sync!false -> 
			errorCh_ch.sending!false
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: versionCh_ch.enq!0;
	:: versionCh_ch.sync!false -> 
		versionCh_ch.sending!false
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

proctype receiver(chan c) {
c?0
}

