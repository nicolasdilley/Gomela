#define lb_for56_0  -1
#define ub_for56_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example382100172/html-distance/feature.go
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
	Chandef cf;
	int i;
	Chandef cs;
	bool state = false;
	
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
	run Anonymous0(cf,cs);
	run Anonymous1(cf,cs);
	
	if
	:: lb_for56_0 != -2 && ub_for56_1 != -2 -> 
				for(i : lb_for56_0.. ub_for56_1) {
for30:for31_exit:
		}
	:: else -> 
		do
		:: true -> 
for30:for31_exit:
		:: true -> 
			break
		od
	fi;
for30_exit:	goto stop_process
stop_process:}

proctype Anonymous0(Chandef cf;Chandef cs) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: lb_for33_0 != -2 && ub_for33_1 != -2 -> 
				for(i : lb_for33_0.. ub_for33_1) {
for10:			chan child_distancegenFeatures0 = [0] of {int};
			run distancegenFeatures(cf,child_distancegenFeatures0);
			child_distancegenFeatures0?0
		}
	:: else -> 
		do
		:: true -> 
for10:			chan child_distancegenFeatures0 = [0] of {int};
			run distancegenFeatures(cf,child_distancegenFeatures0);
			child_distancegenFeatures0?0
		:: true -> 
			break
		od
	fi;
for10_exit:stop_process:	cf.closing!true
}
proctype Anonymous1(Chandef cf;Chandef cs) {
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
	:: lb_for45_0 != -2 && ub_for45_1 != -2 -> 
				for(i : lb_for45_0.. ub_for45_1) {
for20:			
			if
			:: cs.async_send!0;
			:: cs.sync!0 -> 
				cs.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:			
			if
			:: cs.async_send!0;
			:: cs.sync!0 -> 
				cs.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:stop_process:	cs.closing!true
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

