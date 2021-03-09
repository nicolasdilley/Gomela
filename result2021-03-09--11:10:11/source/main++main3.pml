
// https://github.com/hello.go/blob//#L3
typedef Chandef {
	chan sync = [0] of {bool,int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {bool,int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}



init { 
	run go_main()
stop_process:skip
}

proctype go_main() {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Chandef ch1;
	Chandef ch;
	run sync_monitor(ch);
	;
	run sync_monitor(ch1);
	;
	run go_Anonymousmain7(ch,ch1);
	

	if
	:: ch1.async_send!0;
	:: ch1.sync!false,0 -> 
		ch1.sending?state
	fi;
	ch.closing!true;
	stop_process: skip
}
proctype go_Anonymousmain7(Chandef ch;Chandef ch1) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: ch.async_send!0;
	:: ch.sync!false,0 -> 
		ch.sending?state
	fi;
	

	if
	:: ch1.async_rcv?state,num_msgs;
	:: ch1.sync?state,num_msgs;
	fi;
	stop_process: skip
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
  :: ch.async_send?0-> // cannot send on closed channel
    assert(1 == 0)
  :: ch.closing?true -> // cannot close twice a channel
    assert(2 == 0)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(1 == 0)
  :: ch.sync!true,ch.num_msgs -> // can always receive on a closed chan
		 ch.num_msgs = ch.num_msgs - 1
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!false,ch.num_msgs ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!false,ch.num_msgs
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.sending!false;  // sending channel is open
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
  :: ch.async_send?0-> // cannot send on closed channel
    assert(1 == 0)
  :: ch.closing?true -> // cannot close twice a channel
    assert(2 == 0)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(1 == 0)
  :: ch.sync!true,0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    fi;
fi;
od
stop_process:
}

