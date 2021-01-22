#define ub_for1600_0  -2

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example500871849/pkg/search/query.go
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
	Chandef errch;
	Chandef ch;
	int num_msgs = 0;
	bool state = false;
	int i;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(ch);
	run sync_monitor(errch);
	run go_Anonymous0(ch,errch);
	do
	:: true -> 
		

		if
		:: ch.async_rcv?state,num_msgs;
		:: ch.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for30: skip;
			for30_end: skip
		fi
	od;
	for30_exit: skip;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef ch;Chandef errch) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetDirMembers0 = [0] of {int};
	run GetDirMembers(ch,child_GetDirMembers0);
	child_GetDirMembers0?0;
	

	if
	:: errch.async_send!0;
	:: errch.sync!false,0 -> 
		errch.sending?state
	fi;
	stop_process: skip
}
proctype GetDirMembers(Chandef dest;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int children=0;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: children-1 != -3 -> 
						for(i : 0.. children-1) {
				for10: skip;
				

				if
				:: dest.async_send!0;
				:: dest.sync!false,0 -> 
					dest.sending?state
				fi;
				

				if
				:: true -> 
					break
				:: true;
				fi;
				for10_end: skip
			};
			for10_exit: skip
		:: else -> 
			do
			:: true -> 
				for1030: skip;
				

				if
				:: dest.async_send!0;
				:: dest.sync!false,0 -> 
					dest.sending?state
				fi;
				

				if
				:: true -> 
					break
				:: true;
				fi;
				for10_end30: skip
			:: true -> 
				break
			od;
			for10_exit30: skip
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: 0 != -2 && ub_for1600_0 != -2 -> 
				for(i : 0.. ub_for1600_0) {
			for2031: skip;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				goto for20_end31
			:: true;
			fi;
			

			if
			:: dest.async_send!0;
			:: dest.sync!false,0 -> 
				dest.sending?state
			fi;
			

			if
			:: true -> 
				break
			:: true;
			fi;
			for20_end31: skip
		};
		for20_exit31: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				goto for20_end
			:: true;
			fi;
			

			if
			:: dest.async_send!0;
			:: dest.sync!false,0 -> 
				dest.sending?state
			fi;
			

			if
			:: true -> 
				break
			:: true;
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	dest.closing!true;
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


