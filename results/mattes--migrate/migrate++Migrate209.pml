#define Migrate_m_PrefetchMigrations  1
#define ub_for440_1  -2
#define ub_for465_2  -2

// https://github.com/mattes/migrate/blob/4768a648fbd9e04389a73a21139d14a4ccb1a61a/migrate.go#L209
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
	Chandef ret;
	int num_msgs = 0;
	bool state = false;
	int i;
	int m_PrefetchMigrations = Migrate_m_PrefetchMigrations;
	

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
	:: m_PrefetchMigrations > 0 -> 
		ret.size = m_PrefetchMigrations;
		run AsyncChan(ret)
	:: else -> 
		run sync_monitor(ret)
	fi;
	run go_read(ret);
	goto stop_process
stop_process:skip
}

proctype go_read(Chandef ret) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: ret.async_send!0;
			:: ret.sync!false,0 -> 
				ret.sending?state
			fi;
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: ret.async_send!0;
			:: ret.sync!false,0 -> 
				ret.sending?state
			fi;
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: ret.async_send!0;
		:: ret.sync!false,0 -> 
			ret.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				

				if
				:: ret.async_send!0;
				:: ret.sync!false,0 -> 
					ret.sending?state
				fi;
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: ret.async_send!0;
				:: ret.sync!false,0 -> 
					ret.sending?state
				fi;
				goto stop_process
			:: true;
			fi;
			

			if
			:: ret.async_send!0;
			:: ret.sync!false,0 -> 
				ret.sending?state
			fi
		:: true;
		fi;
		

		if
		:: 0 != -2 && ub_for440_1 != -2 -> 
						for(i : 0.. ub_for440_1) {
				for10170: skip;
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				

				if
				:: true -> 
					

					if
					:: ret.async_send!0;
					:: ret.sync!false,0 -> 
						ret.sending?state
					fi;
					goto stop_process
				:: true;
				fi;
				

				if
				:: true -> 
					

					if
					:: ret.async_send!0;
					:: ret.sync!false,0 -> 
						ret.sending?state
					fi;
					goto stop_process
				:: true;
				fi;
				

				if
				:: ret.async_send!0;
				:: ret.sync!false,0 -> 
					ret.sending?state
				fi;
				for10_end170: skip
			};
			for10_exit170: skip
		:: else -> 
			do
			:: true -> 
				for10: skip;
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				

				if
				:: true -> 
					

					if
					:: ret.async_send!0;
					:: ret.sync!false,0 -> 
						ret.sending?state
					fi;
					goto stop_process
				:: true;
				fi;
				

				if
				:: true -> 
					

					if
					:: ret.async_send!0;
					:: ret.sync!false,0 -> 
						ret.sending?state
					fi;
					goto stop_process
				:: true;
				fi;
				

				if
				:: ret.async_send!0;
				:: ret.sync!false,0 -> 
					ret.sending?state
				fi;
				for10_end: skip
			:: true -> 
				break
			od;
			for10_exit: skip
		fi
	:: true -> 
		

		if
		:: 0 != -2 && ub_for465_2 != -2 -> 
						for(i : 0.. ub_for465_2) {
				for20171: skip;
				

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
						:: ret.async_send!0;
						:: ret.sync!false,0 -> 
							ret.sending?state
						fi;
						goto stop_process
					:: true;
					fi;
					

					if
					:: ret.async_send!0;
					:: ret.sync!false,0 -> 
						ret.sending?state
					fi;
					goto stop_process
				:: true -> 
					

					if
					:: true -> 
						

						if
						:: ret.async_send!0;
						:: ret.sync!false,0 -> 
							ret.sending?state
						fi;
						goto stop_process
					:: true;
					fi
				fi;
				

				if
				:: true -> 
					

					if
					:: ret.async_send!0;
					:: ret.sync!false,0 -> 
						ret.sending?state
					fi;
					goto stop_process
				:: true;
				fi;
				

				if
				:: ret.async_send!0;
				:: ret.sync!false,0 -> 
					ret.sending?state
				fi;
				for20_end171: skip
			};
			for20_exit171: skip
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
					

					if
					:: true -> 
						

						if
						:: ret.async_send!0;
						:: ret.sync!false,0 -> 
							ret.sending?state
						fi;
						goto stop_process
					:: true;
					fi;
					

					if
					:: ret.async_send!0;
					:: ret.sync!false,0 -> 
						ret.sending?state
					fi;
					goto stop_process
				:: true -> 
					

					if
					:: true -> 
						

						if
						:: ret.async_send!0;
						:: ret.sync!false,0 -> 
							ret.sending?state
						fi;
						goto stop_process
					:: true;
					fi
				fi;
				

				if
				:: true -> 
					

					if
					:: ret.async_send!0;
					:: ret.sync!false,0 -> 
						ret.sending?state
					fi;
					goto stop_process
				:: true;
				fi;
				

				if
				:: ret.async_send!0;
				:: ret.sync!false,0 -> 
					ret.sending?state
				fi;
				for20_end: skip
			:: true -> 
				break
			od;
			for20_exit: skip
		fi
	fi;
	stop_process: skip;
	ret.closing!true
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

