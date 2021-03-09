#define execList_concurrency  1
#define execList_l  3

// https://github.com/graph-gophers/graphql-go/blob/beb923fada293249384c7a9fa0c5078ea92466f3/internal/exec/exec.go#L312
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
	Chandef sem;
	int num_msgs = 0;
	bool state = false;
	int i;
	int l = execList_l;
	int concurrency = execList_concurrency;
	

	if
	:: true -> 
		

		if
		:: concurrency > 0 -> 
			sem.size = concurrency;
			run AsyncChan(sem)
		:: else -> 
			run sync_monitor(sem)
		fi;
				for(i : 0.. l-1) {
			for10: skip;
			

			if
			:: sem.async_send!0;
			:: sem.sync!false,0 -> 
				sem.sending?state
			fi;
			run go_Anonymous0(sem);
			for10_end: skip
		};
		for10_exit: skip;
		

		if
		:: 0 != -2 && concurrency-1 != -3 -> 
						for(i : 0.. concurrency-1) {
				for20105: skip;
				

				if
				:: sem.async_send!0;
				:: sem.sync!false,0 -> 
					sem.sending?state
				fi;
				for20_end105: skip
			};
			for20_exit105: skip
		:: else -> 
			do
			:: true -> 
				for20: skip;
				

				if
				:: sem.async_send!0;
				:: sem.sync!false,0 -> 
					sem.sending?state
				fi;
				for20_end: skip
			:: true -> 
				break
			od;
			for20_exit: skip
		fi
	fi
stop_process:skip
}

proctype go_Anonymous0(Chandef sem) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	

	if
	:: sem.async_rcv?state,num_msgs;
	:: sem.sync?state,num_msgs;
	fi
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

