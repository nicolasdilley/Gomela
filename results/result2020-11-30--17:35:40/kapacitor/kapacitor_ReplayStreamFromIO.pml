
// /tmp/clone-example660668482/replay.go
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
	int i;
	Chandef errC;
	Chandef allErrs;
	Chandef points;
	bool state = false;
	
	if
	:: 2 > 0 -> 
		allErrs.size = 2;
		run AsyncChan(allErrs)
	:: else -> 
		run sync_monitor(allErrs)
	fi;
	
	if
	:: 1 > 0 -> 
		errC.size = 1;
		run AsyncChan(errC)
	:: else -> 
		run sync_monitor(errC)
	fi;
	run sync_monitor(points);
	run Anonymous0(allErrs,errC,points);
	run Anonymous2(allErrs,errC,points);
	run Anonymous4(allErrs,errC,points);
	goto stop_process
stop_process:}

proctype kapacitorreplayStreamFromChan(Chandef points;chan child) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		break
	od;
	goto stop_process;
stop_process:	child!0
}
proctype Anonymous0(Chandef allErrs;Chandef errC;Chandef points) {
	bool closed; 
	int i;
	bool state;
	chan child_kapacitorreplayStreamFromChan0 = [0] of {int};
	run kapacitorreplayStreamFromChan(points,child_kapacitorreplayStreamFromChan0);
	child_kapacitorreplayStreamFromChan0?0;
	
	if
	:: allErrs.async_send!0;
	:: allErrs.sync!0 -> 
		allErrs.sending?0
	fi;
stop_process:
}
proctype kapacitorreadPointsFromIO(Chandef points;chan child) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: lb_for80_0 != -2 && ub_for80_1 != -2 -> 
				for(i : lb_for80_0.. ub_for80_1) {
for20:			
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
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:			
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
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype Anonymous2(Chandef allErrs;Chandef errC;Chandef points) {
	bool closed; 
	int i;
	bool state;
	chan child_kapacitorreadPointsFromIO1 = [0] of {int};
	run kapacitorreadPointsFromIO(points,child_kapacitorreadPointsFromIO1);
	child_kapacitorreadPointsFromIO1?0;
	
	if
	:: allErrs.async_send!0;
	:: allErrs.sync!0 -> 
		allErrs.sending?0
	fi;
stop_process:
}
proctype Anonymous4(Chandef allErrs;Chandef errC;Chandef points) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: 0 != -2 && cap3719-1 != -3 -> 
				for(i : 0.. cap3719-1) {
for30:			
			if
			:: allErrs.async_rcv?0;
			:: allErrs.sync?0;
			fi;
			
			if
			:: true -> 
				
				if
				:: errC.async_send!0;
				:: errC.sync!0 -> 
					errC.sending?0
				fi;
				goto stop_process
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for30:			
			if
			:: allErrs.async_rcv?0;
			:: allErrs.sync?0;
			fi;
			
			if
			:: true -> 
				
				if
				:: errC.async_send!0;
				:: errC.sync!0 -> 
					errC.sending?0
				fi;
				goto stop_process
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for30_exit:	
	if
	:: errC.async_send!0;
	:: errC.sync!0 -> 
		errC.sending?0
	fi;
stop_process:
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

