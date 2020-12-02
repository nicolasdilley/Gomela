#define Execute_c_Args_Paths  0
#define lb_for68_1  -1
#define ub_for68_2  -1
#define lb_for86_3  -1
#define ub_for86_4  -1

// /tmp/clone-example136178959/cli/lint_cmd.go
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
	Chandef quitc;
	int i;
	int c_Args_Paths = Execute_c_Args_Paths;
	Chandef issuec;
	Wgdef wg;
	int pcs = -2;
	bool state = false;
	run sync_monitor(issuec);
	run sync_monitor(quitc);
	run Anonymous0(issuec,quitc,wg);
	run wgMonitor(wg);
		for(i : 0.. c_Args_Paths-1) {
for20:				for(i : lb_for86_3.. ub_for86_4) {
for21:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi;
					
					if
					:: true -> 
						
						if
						:: true -> 
							goto stop_process
						:: true;
						fi;
												for(i : 0.. pcs-1) {
for22:							
							if
							:: true -> 
								break
							:: true;
							fi
						}
					:: true;
					fi;
					
					if
					:: true -> 
												for(i : 0.. pcs-1) {
for23:							
							if
							:: true -> 
								break
							:: true;
							fi
						}
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
							goto stop_process
						:: true;
						fi
					:: true;
					fi;
					wg.Add!1;
					run Anonymous1(issuec,quitc,wg)
				:: true;
				fi
			:: true;
			fi
		};
for21_exit:
	};
	wg.Wait?0;
	quitc.closing!true;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef issuec;Chandef quitc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		do
		:: issuec.async_rcv?0 -> 
			break
		:: issuec.sync?0 -> 
			break
		:: quitc.async_rcv?0 -> 
			goto stop_process
		:: quitc.sync?0 -> 
			goto stop_process
		od
	od;
for10_exit:stop_process:
}
proctype Anonymous1(Chandef issuec;Chandef quitc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
		for(i : 0.. prependLabelToStrings15429-1) {
for24:		
		if
		:: issuec.async_send!0;
		:: issuec.sync!0 -> 
			issuec.sending?0
		fi
	};
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

