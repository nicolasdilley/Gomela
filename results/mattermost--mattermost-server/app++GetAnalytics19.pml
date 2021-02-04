
// https://github.com/mattermost/mattermost-server/blob/caeda90b246b2830ffc29901efce685a08d638fa/app/analytics.go#L19
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
		run go_Anonymous0(openChan,privateChan);
		run go_Anonymous1(openChan,privateChan);
		

		if
		:: true -> 
			

			if
			:: 1 > 0 -> 
				userInactiveChan.size = 1;
				run AsyncChan(userInactiveChan)
			:: else -> 
				run sync_monitor(userInactiveChan)
			fi;
			run go_Anonymous2(openChan,privateChan,userInactiveChan)
		:: true -> 
			

			if
			:: 1 > 0 -> 
				userChan.size = 1;
				run AsyncChan(userChan)
			:: else -> 
				run sync_monitor(userChan)
			fi;
			run go_Anonymous3(openChan,privateChan,userInactiveChan,userChan)
		fi;
		

		if
		:: true -> 
			

			if
			:: 1 > 0 -> 
				postChan.size = 1;
				run AsyncChan(postChan)
			:: else -> 
				run sync_monitor(postChan)
			fi;
			run go_Anonymous4(openChan,privateChan,userInactiveChan,userChan,postChan)
		:: true;
		fi;
		

		if
		:: 1 > 0 -> 
			teamCountChan.size = 1;
			run AsyncChan(teamCountChan)
		:: else -> 
			run sync_monitor(teamCountChan)
		fi;
		run go_Anonymous5(openChan,privateChan,userInactiveChan,userChan,postChan,teamCountChan);
		

		if
		:: 1 > 0 -> 
			dailyActiveChan.size = 1;
			run AsyncChan(dailyActiveChan)
		:: else -> 
			run sync_monitor(dailyActiveChan)
		fi;
		run go_Anonymous6(openChan,privateChan,userInactiveChan,userChan,postChan,teamCountChan,dailyActiveChan);
		

		if
		:: 1 > 0 -> 
			monthlyActiveChan.size = 1;
			run AsyncChan(monthlyActiveChan)
		:: else -> 
			run sync_monitor(monthlyActiveChan)
		fi;
		run go_Anonymous7(openChan,privateChan,userInactiveChan,userChan,postChan,teamCountChan,dailyActiveChan,monthlyActiveChan);
		

		if
		:: openChan.async_rcv?state,num_msgs;
		:: openChan.sync?state,num_msgs;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: privateChan.async_rcv?state,num_msgs;
		:: privateChan.sync?state,num_msgs;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			

			if
			:: postChan.async_rcv?state,num_msgs;
			:: postChan.sync?state,num_msgs;
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		fi;
		

		if
		:: true -> 
			

			if
			:: userChan.async_rcv?state,num_msgs;
			:: userChan.sync?state,num_msgs;
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		fi;
		

		if
		:: true -> 
			

			if
			:: userInactiveChan.async_rcv?state,num_msgs;
			:: userInactiveChan.sync?state,num_msgs;
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		fi;
		

		if
		:: teamCountChan.async_rcv?state,num_msgs;
		:: teamCountChan.sync?state,num_msgs;
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
		:: dailyActiveChan.async_rcv?state,num_msgs;
		:: dailyActiveChan.sync?state,num_msgs;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: monthlyActiveChan.async_rcv?state,num_msgs;
		:: monthlyActiveChan.sync?state,num_msgs;
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
						run go_Anonymous8(openChan,privateChan,userInactiveChan,userChan,postChan,teamCountChan,dailyActiveChan,monthlyActiveChan,iHookChan);
						

						if
						:: 1 > 0 -> 
							oHookChan.size = 1;
							run AsyncChan(oHookChan)
						:: else -> 
							run sync_monitor(oHookChan)
						fi;
						run go_Anonymous9(openChan,privateChan,userInactiveChan,userChan,postChan,teamCountChan,dailyActiveChan,monthlyActiveChan,iHookChan,oHookChan);
						

						if
						:: 1 > 0 -> 
							commandChan.size = 1;
							run AsyncChan(commandChan)
						:: else -> 
							run sync_monitor(commandChan)
						fi;
						run go_Anonymous10(openChan,privateChan,userInactiveChan,userChan,postChan,teamCountChan,dailyActiveChan,monthlyActiveChan,iHookChan,oHookChan,commandChan);
						

						if
						:: 1 > 0 -> 
							sessionChan.size = 1;
							run AsyncChan(sessionChan)
						:: else -> 
							run sync_monitor(sessionChan)
						fi;
						run go_Anonymous11(openChan,privateChan,userInactiveChan,userChan,postChan,teamCountChan,dailyActiveChan,monthlyActiveChan,iHookChan,oHookChan,commandChan,sessionChan);
						

						if
						:: true -> 
							

							if
							:: 1 > 0 -> 
								fileChan.size = 1;
								run AsyncChan(fileChan)
							:: else -> 
								run sync_monitor(fileChan)
							fi;
							run go_Anonymous12(openChan,privateChan,userInactiveChan,userChan,postChan,teamCountChan,dailyActiveChan,monthlyActiveChan,iHookChan,oHookChan,commandChan,sessionChan,fileChan);
							

							if
							:: 1 > 0 -> 
								hashtagChan.size = 1;
								run AsyncChan(hashtagChan)
							:: else -> 
								run sync_monitor(hashtagChan)
							fi;
							run go_Anonymous13(openChan,privateChan,userInactiveChan,userChan,postChan,teamCountChan,dailyActiveChan,monthlyActiveChan,iHookChan,oHookChan,commandChan,sessionChan,fileChan,hashtagChan)
						:: true;
						fi;
						

						if
						:: true -> 
							

							if
							:: fileChan.async_rcv?state,num_msgs;
							:: fileChan.sync?state,num_msgs;
							fi;
							

							if
							:: true -> 
								goto stop_process
							:: true;
							fi
						fi;
						

						if
						:: true -> 
							

							if
							:: hashtagChan.async_rcv?state,num_msgs;
							:: hashtagChan.sync?state,num_msgs;
							fi;
							

							if
							:: true -> 
								goto stop_process
							:: true;
							fi
						fi;
						

						if
						:: iHookChan.async_rcv?state,num_msgs;
						:: iHookChan.sync?state,num_msgs;
						fi;
						

						if
						:: true -> 
							goto stop_process
						:: true;
						fi;
						

						if
						:: oHookChan.async_rcv?state,num_msgs;
						:: oHookChan.sync?state,num_msgs;
						fi;
						

						if
						:: true -> 
							goto stop_process
						:: true;
						fi;
						

						if
						:: commandChan.async_rcv?state,num_msgs;
						:: commandChan.sync?state,num_msgs;
						fi;
						

						if
						:: true -> 
							goto stop_process
						:: true;
						fi;
						

						if
						:: sessionChan.async_rcv?state,num_msgs;
						:: sessionChan.sync?state,num_msgs;
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

proctype go_Anonymous0(Chandef openChan;Chandef privateChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: openChan.async_send!0;
	:: openChan.sync!false,0 -> 
		openChan.sending?state
	fi;
	openChan.closing!true;
	stop_process: skip
}
proctype go_Anonymous1(Chandef openChan;Chandef privateChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: privateChan.async_send!0;
	:: privateChan.sync!false,0 -> 
		privateChan.sending?state
	fi;
	privateChan.closing!true;
	stop_process: skip
}
proctype go_Anonymous2(Chandef openChan;Chandef privateChan;Chandef userInactiveChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: userInactiveChan.async_send!0;
	:: userInactiveChan.sync!false,0 -> 
		userInactiveChan.sending?state
	fi;
	userInactiveChan.closing!true;
	stop_process: skip
}
proctype go_Anonymous3(Chandef openChan;Chandef privateChan;Chandef userInactiveChan;Chandef userChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: userChan.async_send!0;
	:: userChan.sync!false,0 -> 
		userChan.sending?state
	fi;
	userChan.closing!true;
	stop_process: skip
}
proctype go_Anonymous4(Chandef openChan;Chandef privateChan;Chandef userInactiveChan;Chandef userChan;Chandef postChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: postChan.async_send!0;
	:: postChan.sync!false,0 -> 
		postChan.sending?state
	fi;
	postChan.closing!true;
	stop_process: skip
}
proctype go_Anonymous5(Chandef openChan;Chandef privateChan;Chandef userInactiveChan;Chandef userChan;Chandef postChan;Chandef teamCountChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: teamCountChan.async_send!0;
	:: teamCountChan.sync!false,0 -> 
		teamCountChan.sending?state
	fi;
	teamCountChan.closing!true;
	stop_process: skip
}
proctype go_Anonymous6(Chandef openChan;Chandef privateChan;Chandef userInactiveChan;Chandef userChan;Chandef postChan;Chandef teamCountChan;Chandef dailyActiveChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: dailyActiveChan.async_send!0;
	:: dailyActiveChan.sync!false,0 -> 
		dailyActiveChan.sending?state
	fi;
	dailyActiveChan.closing!true;
	stop_process: skip
}
proctype go_Anonymous7(Chandef openChan;Chandef privateChan;Chandef userInactiveChan;Chandef userChan;Chandef postChan;Chandef teamCountChan;Chandef dailyActiveChan;Chandef monthlyActiveChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: monthlyActiveChan.async_send!0;
	:: monthlyActiveChan.sync!false,0 -> 
		monthlyActiveChan.sending?state
	fi;
	monthlyActiveChan.closing!true;
	stop_process: skip
}
proctype go_Anonymous8(Chandef openChan;Chandef privateChan;Chandef userInactiveChan;Chandef userChan;Chandef postChan;Chandef teamCountChan;Chandef dailyActiveChan;Chandef monthlyActiveChan;Chandef iHookChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: iHookChan.async_send!0;
	:: iHookChan.sync!false,0 -> 
		iHookChan.sending?state
	fi;
	iHookChan.closing!true;
	stop_process: skip
}
proctype go_Anonymous9(Chandef openChan;Chandef privateChan;Chandef userInactiveChan;Chandef userChan;Chandef postChan;Chandef teamCountChan;Chandef dailyActiveChan;Chandef monthlyActiveChan;Chandef iHookChan;Chandef oHookChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: oHookChan.async_send!0;
	:: oHookChan.sync!false,0 -> 
		oHookChan.sending?state
	fi;
	oHookChan.closing!true;
	stop_process: skip
}
proctype go_Anonymous10(Chandef openChan;Chandef privateChan;Chandef userInactiveChan;Chandef userChan;Chandef postChan;Chandef teamCountChan;Chandef dailyActiveChan;Chandef monthlyActiveChan;Chandef iHookChan;Chandef oHookChan;Chandef commandChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: commandChan.async_send!0;
	:: commandChan.sync!false,0 -> 
		commandChan.sending?state
	fi;
	commandChan.closing!true;
	stop_process: skip
}
proctype go_Anonymous11(Chandef openChan;Chandef privateChan;Chandef userInactiveChan;Chandef userChan;Chandef postChan;Chandef teamCountChan;Chandef dailyActiveChan;Chandef monthlyActiveChan;Chandef iHookChan;Chandef oHookChan;Chandef commandChan;Chandef sessionChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: sessionChan.async_send!0;
	:: sessionChan.sync!false,0 -> 
		sessionChan.sending?state
	fi;
	sessionChan.closing!true;
	stop_process: skip
}
proctype go_Anonymous12(Chandef openChan;Chandef privateChan;Chandef userInactiveChan;Chandef userChan;Chandef postChan;Chandef teamCountChan;Chandef dailyActiveChan;Chandef monthlyActiveChan;Chandef iHookChan;Chandef oHookChan;Chandef commandChan;Chandef sessionChan;Chandef fileChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: fileChan.async_send!0;
	:: fileChan.sync!false,0 -> 
		fileChan.sending?state
	fi;
	fileChan.closing!true;
	stop_process: skip
}
proctype go_Anonymous13(Chandef openChan;Chandef privateChan;Chandef userInactiveChan;Chandef userChan;Chandef postChan;Chandef teamCountChan;Chandef dailyActiveChan;Chandef monthlyActiveChan;Chandef iHookChan;Chandef oHookChan;Chandef commandChan;Chandef sessionChan;Chandef fileChan;Chandef hashtagChan) {
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

