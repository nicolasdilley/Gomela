
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example799171946/commands.go
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
	chan child_formatZoneList0 = [0] of {int};
	Chandef zones;
	bool state = false;
	int i;
	run sync_monitor(zones);
	run go_Anonymous0(zones);
	run formatZoneList(zones,child_formatZoneList0);
	child_formatZoneList0?0
stop_process:skip
}

proctype go_Anonymous0(Chandef zones) {
	bool closed; 
	int i;
	bool state;
	int resp_HostedZones = -2;
	do
	:: true -> 
		for10: skip;
		

		if
		:: resp_HostedZones-1 != -3 -> 
						for(i : 0.. resp_HostedZones-1) {
				for11: skip;
				

				if
				:: zones.async_send!0;
				:: zones.sync!0 -> 
					zones.sending?0
				fi;
				for11_end: skip
			};
			for11_exit: skip
		:: else -> 
			do
			:: true -> 
				for111976: skip;
				

				if
				:: zones.async_send!0;
				:: zones.sync!0 -> 
					zones.sending?0
				fi;
				for11_end1976: skip
			:: true -> 
				break
			od;
			for11_exit1976: skip
		fi;
		

		if
		:: true -> 
			break
		:: true -> 
			break
		fi;
		for10_end: skip
	od;
	for10_exit: skip;
	zones.closing!true;
	stop_process: skip
}
proctype formatZoneList(Chandef zones;chan child) {
	bool closed; 
	int i;
	bool state;
	do
	:: zones.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			

			if
			:: zones.async_rcv?0;
			:: zones.sync?0;
			fi;
			for20: skip;
			for20_end: skip
		fi
	od;
	for20_exit: skip;
	stop_process: skip;
	child!0
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

