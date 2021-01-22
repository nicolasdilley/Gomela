#define Convert_convert_ProcessNum  0
#define ub_for201_1  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example215349780/converter/converter.go
typedef Chandef {
	chan sync = [0] of {bool,int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {bool,int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef group;
	Chandef convert_limitChan;
	Chandef convert_process;
	int num_msgs = 0;
	bool state = false;
	int i;
	int convert_ProcessNum = Convert_convert_ProcessNum;
	

	if
	:: true -> 
		

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
				for101619: skip;
				

				if
				:: convert_limitChan.async_send!0;
				:: convert_limitChan.sync!false,0 -> 
					convert_limitChan.sending?state
				fi;
				for10_end1619: skip
			};
			for10_exit1619: skip
		:: else -> 
			do
			:: true -> 
				for10: skip;
				

				if
				:: convert_limitChan.async_send!0;
				:: convert_limitChan.sync!false,0 -> 
					convert_limitChan.sending?state
				fi;
				for10_end: skip
			:: true -> 
				break
			od;
			for10_exit: skip
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
			run wgMonitor(group);
						for(i : 0.. ub_for201_1) {
				for20: skip;
				

				if
				:: true -> 
					break
				:: true;
				fi;
				group.Add!1;
				

				if
				:: convert_limitChan.async_rcv?state,num_msgs;
				:: convert_limitChan.sync?state,num_msgs;
				fi;
				run go_Anonymous0(group,convert_process,convert_limitChan);
				for20_end: skip
			};
			for20_exit: skip;
			group.Wait?0
		fi
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Wgdef group;Chandef convert_process;Chandef convert_limitChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	group.Add!-1;
	stop_process: skip
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
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
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,ch.num_msgs -> // can always receive on a closed chan
		 ch.num_msgs = ch.num_msgs - 1
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!false,ch.num_msgs ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!false,ch.num_msgs
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
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
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
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

