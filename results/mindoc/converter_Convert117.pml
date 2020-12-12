#define Convert_convert_ProcessNum  ??
#define lb_for201_1  -1
#define ub_for201_2  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example697626622/converter/converter.go
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
	int convert_ProcessNum = Convert_convert_ProcessNum;
	bool state = false;
	int i;
	
	if
	:: true -> 
		Chandef convert_process;
		
		if
		:: 4 > 0 -> 
			convert_process.size = 4;
			run AsyncChan(convert_process)
		:: else -> 
			run sync_monitor(convert_process)
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		Chandef convert_limitChan;
		
		if
		:: convert_ProcessNum > 0 -> 
			convert_limitChan.size = convert_ProcessNum;
			run AsyncChan(convert_limitChan)
		:: else -> 
			run sync_monitor(convert_limitChan)
		fi;
		
		if
		:: 0 != -2 && convert_ProcessNum-1 != -3 -> 
						for(i : 0.. convert_ProcessNum-1) {
for10:				
				if
				:: convert_limitChan.async_send!0;
				:: convert_limitChan.sync!0 -> 
					convert_limitChan.sending?0
				fi
			}
		:: else -> 
			do
			:: true -> 
for10:				
				if
				:: convert_limitChan.async_send!0;
				:: convert_limitChan.sync!0 -> 
					convert_limitChan.sending?0
				fi
			:: true -> 
				break
			od
		fi;
for10_exit:
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
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			run Anonymous0(convert_process,convert_limitChan,group);
			Wgdef group;
			run wgMonitor(group);
						for(i : lb_for201_1.. ub_for201_2) {
for30:				
				if
				:: true -> 
					break
				:: true;
				fi;
				group.Add!1;
				
				if
				:: convert_limitChan.async_rcv?0;
				:: convert_limitChan.sync?0;
				fi;
				run Anonymous1(group,convert_process,convert_limitChan)
			};
for30_exit:			group.Wait?0
		fi
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef convert_process;Chandef convert_limitChan;Wgdef group) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for20:
	:: true -> 
		break
	od;
stop_process:
}
proctype Anonymous1(Wgdef group;Chandef convert_process;Chandef convert_limitChan) {
	bool closed; 
	int i;
	bool state;
	group.Add!-1;
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

