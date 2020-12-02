
// /tmp/clone-example115657414/util/exec_util.go
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
	Wgdef wg;
	int i;
	Chandef errChan;
	bool state = false;
	run wgMonitor(wg);
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: true -> 
					wg.Add!1;
					
					if
					:: true -> 
						run go_utilChannelToLineWriter(wg)
					:: true -> 
						run go_utilLineReaderToChannel(wg)
					:: true -> 
						run go_utilLineReaderToChannel(wg)
					fi
				:: true -> 
					wg.Add!1;
					
					if
					:: true -> 
						run go_utilChannelToLineWriter(wg)
					:: true -> 
						run go_utilLineReaderToChannel(wg)
					:: true -> 
						run go_utilLineReaderToChannel(wg)
					fi
				fi
			:: true -> 
				
				if
				:: true -> 
					wg.Add!1;
					
					if
					:: true -> 
						run go_utilChannelToLineWriter(wg)
					:: true -> 
						run go_utilLineReaderToChannel(wg)
					:: true -> 
						run go_utilLineReaderToChannel(wg)
					fi
				:: true -> 
					wg.Add!1;
					
					if
					:: true -> 
						run go_utilChannelToLineWriter(wg)
					:: true -> 
						run go_utilLineReaderToChannel(wg)
					:: true -> 
						run go_utilLineReaderToChannel(wg)
					fi
				fi
			fi
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(errChan);
	run Anonymous2(errChan,wg);
	do
	od
stop_process:}

proctype go_utilChannelToLineWriter(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
stop_process:	wg.Add!-1
}
proctype go_utilLineReaderToChannel(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int parts = -2;
	
	if
	:: lb_for153_0 != -2 && ub_for153_1 != -2 -> 
				for(i : lb_for153_0.. ub_for153_1) {
for10:						for(i : 0.. parts-1) {
for11:
			}
		}
	:: else -> 
		do
		:: true -> 
for10:						for(i : 0.. parts-1) {
for11:
			}
		:: true -> 
			break
		od
	fi;
for10_exit:stop_process:	wg.Add!-1
}
proctype Anonymous2(Chandef errChan;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Wait?0;
	
	if
	:: errChan.async_send!0;
	:: errChan.sync!0 -> 
		errChan.sending?0
	fi;
stop_process:
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

