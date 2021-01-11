#define ub_for33_0  -2
#define ub_for45_1  -2

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example463920930/html-distance/feature.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}



init { 
	Chandef cs;
	Chandef cf;
	bool state = false;
	int i;
	

	if
	:: 1000 > 0 -> 
		cf.size = 1000;
		run AsyncChan(cf)
	:: else -> 
		run sync_monitor(cf)
	fi;
	

	if
	:: 1000 > 0 -> 
		cs.size = 1000;
		run AsyncChan(cs)
	:: else -> 
		run sync_monitor(cs)
	fi;
	run go_Anonymous0(cf,cs);
	run go_Anonymous2(cf,cs);
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef cf;Chandef cs) {
	bool closed; 
	int i;
	bool state;
	chan child_distancegenFeatures0 = [0] of {int};
	chan child_distancegenFeatures0 = [0] of {int};
	

	if
	:: 0 != -2 && ub_for33_0 != -2 -> 
				for(i : 0.. ub_for33_0) {
			for101419: skip;
			run distancegenFeatures(cf,child_distancegenFeatures0);
			child_distancegenFeatures0?0;
			for10_end1419: skip
		};
		for10_exit1419: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run distancegenFeatures(cf,child_distancegenFeatures0);
			child_distancegenFeatures0?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	stop_process: skip;
	cf.closing!true
}
proctype distancegenFeatures(Chandef cf;chan child) {
	bool closed; 
	int i;
	bool state;
	int t_Attr = -2;
	

	if
	:: cf.async_send!0;
	:: cf.sync!0 -> 
		cf.sending?0
	fi;
	

	if
	:: t_Attr-1 != -3 -> 
				for(i : 0.. t_Attr-1) {
			for11: skip;
			

			if
			:: cf.async_send!0;
			:: cf.sync!0 -> 
				cf.sending?0
			fi;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for111418: skip;
			

			if
			:: cf.async_send!0;
			:: cf.sync!0 -> 
				cf.sending?0
			fi;
			for11_end1418: skip
		:: true -> 
			break
		od;
		for11_exit1418: skip
	fi;
	stop_process: skip;
	child!0
}
proctype go_Anonymous2(Chandef cf;Chandef cs) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: cf.async_rcv?0;
	:: cf.sync?0;
	fi;
	

	if
	:: cf.async_rcv?0;
	:: cf.sync?0;
	fi;
	

	if
	:: 0 != -2 && ub_for45_1 != -2 -> 
				for(i : 0.. ub_for45_1) {
			for201420: skip;
			

			if
			:: cs.async_send!0;
			:: cs.sync!0 -> 
				cs.sending?0
			fi;
			for20_end1420: skip
		};
		for20_exit1420: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: cs.async_send!0;
			:: cs.sync!0 -> 
				cs.sending?0
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	stop_process: skip;
	cs.closing!true
}
proctype AsyncChan(Chandef ch) {
do
:: true ->
if
:: ch.closed -> 
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!0 ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false; // sending channel is open 
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.is_closed!false;
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!0
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false;  // sending channel is open
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
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    :: ch.is_closed!false ->
    fi;
fi;
od
stop_process:
}

