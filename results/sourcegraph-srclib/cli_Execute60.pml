#define Execute_c_Args_Paths  3
#define ub_for86_1  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example995147381/cli/lint_cmd.go
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
	Chandef quitc;
	Chandef issuec;
	bool state = false;
	int i;
	int c_Args_Paths = Execute_c_Args_Paths;
	run sync_monitor(issuec);
	run sync_monitor(quitc);
	run wgMonitor(wg);
		for(i : 0.. c_Args_Paths-1) {
		for10: skip;
				for(i : 0.. ub_for86_1) {
			for11: skip;
			

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
						fi
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
					run go_Anonymous0(issuec,quitc,wg)
				:: true;
				fi
			:: true;
			fi;
			for11_end: skip
		};
		for11_exit: skip;
		for10_end: skip
	};
	for10_exit: skip;
	wg.Wait?0;
	quitc.closing!true;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef issuec;Chandef quitc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int prependLabelToStrings15429=0;
	

	if
	:: prependLabelToStrings15429-1 != -3 -> 
				for(i : 0.. prependLabelToStrings15429-1) {
			for14: skip;
			

			if
			:: issuec.async_send!0;
			:: issuec.sync!0 -> 
				issuec.sending?0
			fi;
			for14_end: skip
		};
		for14_exit: skip
	:: else -> 
		do
		:: true -> 
			for142259: skip;
			

			if
			:: issuec.async_send!0;
			:: issuec.sync!0 -> 
				issuec.sending?0
			fi;
			for14_end2259: skip
		:: true -> 
			break
		od;
		for14_exit2259: skip
	fi;
	stop_process: skip;
	wg.Add!-1
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

proctype wgMonitor(Wgdef wg) {
bool closed;
int i;
bool state;
do
	:: wg.Add?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}


