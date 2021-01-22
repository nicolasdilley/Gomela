
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example036208822/app/analytics.go
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
	Chandef monthlyActiveChan;
	Chandef dailyActiveChan;
	Chandef teamCountChan;
	Chandef postChan;
	Chandef userInactiveChan;
	Chandef userChan;
	Chandef privateChan;
	Chandef openChan;
	Chandef hashtagChan;
	Chandef fileChan;
	Chandef sessionChan;
	Chandef commandChan;
	Chandef oHookChan;
	Chandef iHookChan;
	int num_msgs = 0;
	bool state = false;
	int i;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: 1 > 0 -> 
			openChan.size = 1;
			run AsyncChan(openChan)
		:: else -> 
			run sync_monitor(openChan)
		fi;
		

		if
		:: 1 > 0 -> 
			privateChan.size = 1;
			run AsyncChan(privateChan)
		:: else -> 
			run sync_monitor(privateChan)
		fi;
		

		if
		:: true -> 
			

			if
			:: 1 > 0 -> 
				userInactiveChan.size = 1;
				run AsyncChan(userInactiveChan)
			:: else -> 
				run sync_monitor(userInactiveChan)
			fi
		:: true -> 
			

			if
			:: 1 > 0 -> 
				userChan.size = 1;
				run AsyncChan(userChan)
			:: else -> 
				run sync_monitor(userChan)
			fi
		fi;
		

		if
		:: true -> 
			

			if
			:: 1 > 0 -> 
				postChan.size = 1;
				run AsyncChan(postChan)
			:: else -> 
				run sync_monitor(postChan)
			fi
		:: true;
		fi;
		

		if
		:: 1 > 0 -> 
			teamCountChan.size = 1;
			run AsyncChan(teamCountChan)
		:: else -> 
			run sync_monitor(teamCountChan)
		fi;
		

		if
		:: 1 > 0 -> 
			dailyActiveChan.size = 1;
			run AsyncChan(dailyActiveChan)
		:: else -> 
			run sync_monitor(dailyActiveChan)
		fi;
		

		if
		:: 1 > 0 -> 
			monthlyActiveChan.size = 1;
			run AsyncChan(monthlyActiveChan)
		:: else -> 
			run sync_monitor(monthlyActiveChan)
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
				goto stop_process
			:: true;
			fi
		fi;
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		fi;
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
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
		goto stop_process
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
				goto stop_process
			:: true;
			fi;
			goto stop_process
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
					goto stop_process
				:: true;
				fi;
				goto stop_process
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
						goto stop_process
					:: true;
					fi;
					goto stop_process
				:: true -> 
					

					if
					:: true -> 
						

						if
						:: 1 > 0 -> 
							iHookChan.size = 1;
							run AsyncChan(iHookChan)
						:: else -> 
							run sync_monitor(iHookChan)
						fi;
						

						if
						:: 1 > 0 -> 
							oHookChan.size = 1;
							run AsyncChan(oHookChan)
						:: else -> 
							run sync_monitor(oHookChan)
						fi;
						

						if
						:: 1 > 0 -> 
							commandChan.size = 1;
							run AsyncChan(commandChan)
						:: else -> 
							run sync_monitor(commandChan)
						fi;
						

						if
						:: 1 > 0 -> 
							sessionChan.size = 1;
							run AsyncChan(sessionChan)
						:: else -> 
							run sync_monitor(sessionChan)
						fi;
						

						if
						:: true -> 
							

							if
							:: 1 > 0 -> 
								fileChan.size = 1;
								run AsyncChan(fileChan)
							:: else -> 
								run sync_monitor(fileChan)
							fi;
							

							if
							:: 1 > 0 -> 
								hashtagChan.size = 1;
								run AsyncChan(hashtagChan)
							:: else -> 
								run sync_monitor(hashtagChan)
							fi;
							run go_Anonymous0(openChan,privateChan,userInactiveChan,userChan,postChan,teamCountChan,dailyActiveChan,monthlyActiveChan,iHookChan,oHookChan,commandChan,sessionChan,fileChan,hashtagChan)
						:: true;
						fi;
						

						if
						:: true -> 
							

							if
							:: true -> 
								goto stop_process
							:: true;
							fi
						fi;
						

						if
						:: true -> 
							

							if
							:: true -> 
								goto stop_process
							:: true;
							fi
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
						goto stop_process
					:: true;
					fi
				fi
			fi
		fi
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef openChan;Chandef privateChan;Chandef userInactiveChan;Chandef userChan;Chandef postChan;Chandef teamCountChan;Chandef dailyActiveChan;Chandef monthlyActiveChan;Chandef iHookChan;Chandef oHookChan;Chandef commandChan;Chandef sessionChan;Chandef fileChan;Chandef hashtagChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: hashtagChan.async_send!0;
	:: hashtagChan.sync!false,0 -> 
		hashtagChan.sending?state
	fi;
	hashtagChan.closing!true;
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

