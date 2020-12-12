#define lb_for893_0  -1
#define ub_for893_1  -1
#define lb_for903_2  -1
#define ub_for903_3  -1
#define lb_for955_4  -1
#define ub_for955_5  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example087142814/gxutil/pm.go
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
	Chandef fetchedPackages;
	int i;
	Chandef fetchErrs;
	bool state = false;
	
	if
	:: 20 > 0 -> 
		fetchedPackages.size = 20;
		run AsyncChan(fetchedPackages)
	:: else -> 
		run sync_monitor(fetchedPackages)
	fi;
	
	if
	:: 20 > 0 -> 
		fetchErrs.size = 20;
		run AsyncChan(fetchErrs)
	:: else -> 
		run sync_monitor(fetchErrs)
	fi;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : lb_for903_2.. ub_for903_3) {
for11:			run Anonymous0(fetchedPackages,fetchErrs)
		};
for11_exit:		do
		:: fetchedPackages.async_rcv?0 -> 
			break
		:: fetchedPackages.sync?0 -> 
			break
		:: fetchErrs.async_rcv?0 -> 
			break
		:: fetchErrs.sync?0 -> 
			break
		od;
		
		if
		:: true -> 
			break
		:: true;
		fi
	od;
for10_exit:	
	if
	:: lb_for955_4 != -2 && ub_for955_5 != -2 -> 
				for(i : lb_for955_4.. ub_for955_5) {
for20:			do
			:: fetchErrs.async_rcv?0 -> 
				break
			:: fetchErrs.sync?0 -> 
				break
			:: fetchedPackages.async_rcv?0 -> 
				break
			:: fetchedPackages.sync?0 -> 
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for20:			do
			:: fetchErrs.async_rcv?0 -> 
				break
			:: fetchErrs.sync?0 -> 
				break
			:: fetchedPackages.async_rcv?0 -> 
				break
			:: fetchedPackages.sync?0 -> 
				break
			od
		:: true -> 
			break
		od
	fi;
for20_exit:	goto stop_process
stop_process:}

proctype Anonymous0(Chandef fetchedPackages;Chandef fetchErrs) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: fetchErrs.async_send!0;
		:: fetchErrs.sync!0 -> 
			fetchErrs.sending?0
		fi
	:: true -> 
		
		if
		:: fetchedPackages.async_send!0;
		:: fetchedPackages.sync!0 -> 
			fetchedPackages.sending?0
		fi
	:: true -> 
		
		if
		:: fetchedPackages.async_send!0;
		:: fetchedPackages.sync!0 -> 
			fetchedPackages.sending?0
		fi
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

