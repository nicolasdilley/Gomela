
// /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/source/hello.go
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
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef wg;
	Chandef results;
	chan child_v2a0 = [0] of {int};
	bool state = false;
	
	if
	:: 2 > 0 -> 
		results.size = 2;
		run AsyncChan(results)
	:: else -> 
		run sync_monitor(results)
	fi;
	run wgMonitor(wg);
	
	if
	:: 0 != -2 && 3-1 != -3 -> 
				for(i : 0.. 3-1) {
for10:			wg.Add!1;
			
			if
			:: results.async_rcv?0;
			:: results.sync?0;
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			wg.Add!1;
			
			if
			:: results.async_rcv?0;
			:: results.sync?0;
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	
	if
	:: 0 != -2 && 3-1 != -3 -> 
				for(i : 0.. 3-1) {
for20:			
			if
			:: results.async_rcv?0;
			:: results.sync?0;
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:			
			if
			:: results.async_rcv?0;
			:: results.sync?0;
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:	
	if
	:: 0 != -2 && 3-1 != -3 -> 
				for(i : 0.. 3-1) {
for30:			
			if
			:: results.async_rcv?0;
			:: results.sync?0;
			fi
		}
	:: else -> 
		do
		:: true -> 
for30:			
			if
			:: results.async_rcv?0;
			:: results.sync?0;
			fi
		:: true -> 
			break
		od
	fi;
for30_exit:	run v2a(results,child_v2a0);
	child_v2a0?0;
	run go_v2a(results)
stop_process:}

proctype v2a(Chandef ch;chan child) {
	bool closed; 
	int i;
	bool state;
for50_exit:stop_process:	child!0
}
proctype go_v2a(Chandef ch) {
	bool closed; 
	int i;
	bool state;
for70_exit:stop_process:
}
proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: wg.Add?i -> 
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 -> 
end:		
		if
		:: wg.Add?i -> 
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
		fi
	od
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

