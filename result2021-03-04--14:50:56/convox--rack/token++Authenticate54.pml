#define Authenticate_ds  0

// https://github.com/convox/rack/blob/ee5e31801fa5f2e69aa3bd41339db0b4f64c82fe/pkg/token/token.go#L54
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
	run go_Authenticate()
stop_process:skip
}

proctype go_Authenticate() {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Chandef ch;
	int ds = Authenticate_ds;
	

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
	run sync_monitor(ch);
		for(i : 0.. ds-1) {
		for10: skip;
		run go_authenticateDevice(ch);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: ds-1 != -3 -> 
				for(i : 0.. ds-1) {
			for20: skip;
			

			if
			:: ch.async_rcv?state,num_msgs;
			:: ch.sync?state,num_msgs;
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
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for21: skip;
			

			if
			:: ch.async_rcv?state,num_msgs;
			:: ch.sync?state,num_msgs;
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
			for21_end: skip
		:: true -> 
			break
		od;
		for21_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	
}
proctype go_authenticateDevice(Chandef rch) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int req_RegisteredKeys = -2;
	

	if
	:: true -> 
		

		if
		:: rch.async_send!0;
		:: rch.sync!false,0 -> 
			rch.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: req_RegisteredKeys-1 != -3 -> 
				for(i : 0.. req_RegisteredKeys-1) {
			for11: skip;
			

			if
			:: true -> 
				

				if
				:: rch.async_send!0;
				:: rch.sync!false,0 -> 
					rch.sending?state
				fi;
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				goto for11_end
			:: true;
			fi;
			do
			:: true -> 
				for12: skip;
				

				if
				:: true -> 
					goto for12_end
				:: true;
				fi;
				

				if
				:: true -> 
					goto for12_end
				:: true;
				fi;
				

				if
				:: true -> 
					

					if
					:: rch.async_send!0;
					:: rch.sync!false,0 -> 
						rch.sending?state
					fi;
					goto stop_process
				:: true;
				fi;
				

				if
				:: rch.async_send!0;
				:: rch.sync!false,0 -> 
					rch.sending?state
				fi;
				goto stop_process;
				for12_end: skip
			od;
			for12_exit: skip;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for14: skip;
			

			if
			:: true -> 
				

				if
				:: rch.async_send!0;
				:: rch.sync!false,0 -> 
					rch.sending?state
				fi;
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				goto for14_end
			:: true;
			fi;
			do
			:: true -> 
				for15: skip;
				

				if
				:: true -> 
					goto for15_end
				:: true;
				fi;
				

				if
				:: true -> 
					goto for15_end
				:: true;
				fi;
				

				if
				:: true -> 
					

					if
					:: rch.async_send!0;
					:: rch.sync!false,0 -> 
						rch.sending?state
					fi;
					goto stop_process
				:: true;
				fi;
				

				if
				:: rch.async_send!0;
				:: rch.sync!false,0 -> 
					rch.sending?state
				fi;
				goto stop_process;
				for15_end: skip
			od;
			for15_exit: skip;
			for14_end: skip
		:: true -> 
			break
		od;
		for14_exit: skip
	fi;
	

	if
	:: rch.async_send!0;
	:: rch.sync!false,0 -> 
		rch.sending?state
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

