
// https://github.com/hello.go/blob//#L13
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



init { 
	run go_main()
stop_process:skip
}

proctype go_main() {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_natf0 = [0] of {int};
	chan child_natf1 = [0] of {int};
	chan child_natf2 = [0] of {int};
	chan child_natf3 = [0] of {int};
	Chandef a;
	Chandef event_queue;
	int zest2 = -2;
	run sync_monitor(event_queue);
	run sync_monitor(a);
	run go_Anonymous1(event_queue,a);
	

	if
	:: zest2-1 != -3 -> 
				for(i : 0.. zest2-1) {
			for20: skip;
			do
			:: event_queue.async_rcv?state,num_msgs -> 
				

				if
				:: true -> 
					run natf(a,child_natf0);
					child_natf0?0;
					goto loop
				:: true;
				fi;
				break
			:: event_queue.sync?state,num_msgs -> 
				

				if
				:: true -> 
					run natf(a,child_natf1);
					child_natf1?0;
					goto loop
				:: true;
				fi;
				break
			:: true -> 
				break
			:: true -> 
				goto for20_exit
			od;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for21: skip;
			do
			:: event_queue.async_rcv?state,num_msgs -> 
				

				if
				:: true -> 
					run natf(a,child_natf2);
					child_natf2?0;
					goto loop
				:: true;
				fi;
				break
			:: event_queue.sync?state,num_msgs -> 
				

				if
				:: true -> 
					run natf(a,child_natf3);
					child_natf3?0;
					goto loop
				:: true;
				fi;
				break
			:: true -> 
				break
			:: true -> 
				goto for21_exit
			od;
			for21_end: skip
		:: true -> 
			break
		od;
		for21_exit: skip
	fi;
	loop: skip;
	stop_process: skip
}
proctype go_Anonymous1(Chandef event_queue;Chandef a) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int zest = -2;
	

	if
	:: zest-1 != -3 -> 
				for(i : 0.. zest-1) {
			for10: skip;
			

			if
			:: event_queue.async_send!0;
			:: event_queue.sync!false,0 -> 
				event_queue.sending?state
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			

			if
			:: event_queue.async_send!0;
			:: event_queue.sync!false,0 -> 
				event_queue.sending?state
			fi;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	stop_process: skip
}
proctype natf(Chandef ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: ch.async_send!0;
	:: ch.sync!false,0 -> 
		ch.sending?state
	fi;
	stop_process: skip;
	child!0
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

