#define jacobianConcurrent_nWorkers  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example306907566/diff/fd/jacobian.go
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
	bool state = false;
	int n = -2;
	Chandef jobs;
	int formula_Stencil = -2;
	Wgdef wg;
	int m = -2;
	int nWorkers = jacobianConcurrent_nWorkers;
	int i;
	
	if
	:: 0 != -2 && m-1 != -3 -> 
				for(i : 0.. m-1) {
for10:for11_exit:
		}
	:: else -> 
		do
		:: true -> 
for10:for11_exit:
		:: true -> 
			break
		od
	fi;
for10_exit:	run wgMonitor(wg);
	
	if
	:: nWorkers > 0 -> 
		jobs.size = nWorkers;
		run AsyncChan(jobs)
	:: else -> 
		run sync_monitor(jobs)
	fi;
		for(i : 0.. nWorkers-1) {
for20:		wg.Add!1
	};
for20_exit:		for(i : 0.. formula_Stencil-1) {
for30:		
		if
		:: 0 != -2 && n-1 != -3 -> 
						for(i : 0.. n-1) {
for31:				
				if
				:: jobs.async_send!0;
				:: jobs.sync!0 -> 
					jobs.sending?0
				fi
			}
		:: else -> 
			do
			:: true -> 
for31:				
				if
				:: jobs.async_send!0;
				:: jobs.sync!0 -> 
					jobs.sending?0
				fi
			:: true -> 
				break
			od
		fi;
for31_exit:
	};
	jobs.closing!true;
	
	if
	:: true -> 
		wg.Add!1;
		run Anonymous0(jobs,wg)
	:: true;
	fi;
	wg.Wait?0;
	
	if
	:: true -> 
				for(i : 0.. formula_Stencil-1) {
for40:for41_exit:
		}
	:: true;
	fi
stop_process:}

proctype Anonymous0(Chandef jobs;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
stop_process:	wg.Add!-1
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

