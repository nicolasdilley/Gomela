#define AttackCredentials_targets  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example465160148/attack.go
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
	Chandef resChan;
	int num_msgs = 0;
	bool state = false;
	int i;
	int targets = AttackCredentials_targets;
	run sync_monitor(resChan);
		for(i : 0.. targets-1) {
		for10: skip;
		run go_attackCameraCredentials(resChan);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: targets-1 != -3 -> 
				for(i : 0.. targets-1) {
			for20: skip;
			

			if
			:: resChan.async_rcv?state,num_msgs;
			:: resChan.sync?state,num_msgs;
			fi;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for201872: skip;
			

			if
			:: resChan.async_rcv?state,num_msgs;
			:: resChan.sync?state,num_msgs;
			fi;
			for20_end1872: skip
		:: true -> 
			break
		od;
		for20_exit1872: skip
	fi;
	goto stop_process;
	resChan.closing!true
stop_process:skip
}

proctype go_attackCameraCredentials(Chandef resChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int s_credentials_Passwords = -2;
	int s_credentials_Usernames = -2;
	

	if
	:: s_credentials_Usernames-1 != -3 -> 
				for(i : 0.. s_credentials_Usernames-1) {
			for11: skip;
			

			if
			:: s_credentials_Passwords-1 != -3 -> 
								for(i : 0.. s_credentials_Passwords-1) {
					for12: skip;
					

					if
					:: true -> 
						

						if
						:: resChan.async_send!0;
						:: resChan.sync!false,0 -> 
							resChan.sending?state
						fi;
						goto stop_process
					:: true;
					fi;
					for12_end: skip
				};
				for12_exit: skip
			:: else -> 
				do
				:: true -> 
					for121870: skip;
					

					if
					:: true -> 
						

						if
						:: resChan.async_send!0;
						:: resChan.sync!false,0 -> 
							resChan.sending?state
						fi;
						goto stop_process
					:: true;
					fi;
					for12_end1870: skip
				:: true -> 
					break
				od;
				for12_exit1870: skip
			fi;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for111871: skip;
			

			if
			:: s_credentials_Passwords-1 != -3 -> 
								for(i : 0.. s_credentials_Passwords-1) {
					for121871: skip;
					

					if
					:: true -> 
						

						if
						:: resChan.async_send!0;
						:: resChan.sync!false,0 -> 
							resChan.sending?state
						fi;
						goto stop_process
					:: true;
					fi;
					for12_end1871: skip
				};
				for12_exit1871: skip
			:: else -> 
				do
				:: true -> 
					for1218701871: skip;
					

					if
					:: true -> 
						

						if
						:: resChan.async_send!0;
						:: resChan.sync!false,0 -> 
							resChan.sending?state
						fi;
						goto stop_process
					:: true;
					fi;
					for12_end18701871: skip
				:: true -> 
					break
				od;
				for12_exit18701871: skip
			fi;
			for11_end1871: skip
		:: true -> 
			break
		od;
		for11_exit1871: skip
	fi;
	

	if
	:: resChan.async_send!0;
	:: resChan.sync!false,0 -> 
		resChan.sending?state
	fi;
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

