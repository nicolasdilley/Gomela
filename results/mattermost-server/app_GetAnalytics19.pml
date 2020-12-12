
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example135141040/app/analytics.go
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



init { 
	int stats = -2;
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		Chandef openChan;
		
		if
		:: 1 > 0 -> 
			openChan.size = 1;
			run AsyncChan(openChan)
		:: else -> 
			run sync_monitor(openChan)
		fi;
		Chandef privateChan;
		
		if
		:: 1 > 0 -> 
			privateChan.size = 1;
			run AsyncChan(privateChan)
		:: else -> 
			run sync_monitor(privateChan)
		fi;
		run Anonymous0(openChan,privateChan,userInactiveChan,userChan,postChan,teamCountChan,dailyActiveChan,monthlyActiveChan,iHookChan,oHookChan,commandChan,sessionChan,fileChan,hashtagChan);
		run Anonymous1(openChan,privateChan,userInactiveChan,userChan,postChan,teamCountChan,dailyActiveChan,monthlyActiveChan,iHookChan,oHookChan,commandChan,sessionChan,fileChan,hashtagChan);
		
		if
		:: true -> 
			Chandef userInactiveChan;
			
			if
			:: 1 > 0 -> 
				userInactiveChan.size = 1;
				run AsyncChan(userInactiveChan)
			:: else -> 
				run sync_monitor(userInactiveChan)
			fi;
			run Anonymous2(openChan,privateChan,userInactiveChan,userChan,postChan,teamCountChan,dailyActiveChan,monthlyActiveChan,iHookChan,oHookChan,commandChan,sessionChan,fileChan,hashtagChan)
		:: true -> 
			Chandef userChan;
			
			if
			:: 1 > 0 -> 
				userChan.size = 1;
				run AsyncChan(userChan)
			:: else -> 
				run sync_monitor(userChan)
			fi;
			run Anonymous3(openChan,privateChan,userInactiveChan,userChan,postChan,teamCountChan,dailyActiveChan,monthlyActiveChan,iHookChan,oHookChan,commandChan,sessionChan,fileChan,hashtagChan)
		:: true -> 
			Chandef userChan;
			
			if
			:: 1 > 0 -> 
				userChan.size = 1;
				run AsyncChan(userChan)
			:: else -> 
				run sync_monitor(userChan)
			fi;
			run Anonymous3(openChan,privateChan,userInactiveChan,userChan,postChan,teamCountChan,dailyActiveChan,monthlyActiveChan,iHookChan,oHookChan,commandChan,sessionChan,fileChan,hashtagChan)
		fi;
		
		if
		:: true -> 
			Chandef postChan;
			
			if
			:: 1 > 0 -> 
				postChan.size = 1;
				run AsyncChan(postChan)
			:: else -> 
				run sync_monitor(postChan)
			fi;
			run Anonymous4(openChan,privateChan,userInactiveChan,userChan,postChan,teamCountChan,dailyActiveChan,monthlyActiveChan,iHookChan,oHookChan,commandChan,sessionChan,fileChan,hashtagChan)
		:: true;
		fi;
		Chandef teamCountChan;
		
		if
		:: 1 > 0 -> 
			teamCountChan.size = 1;
			run AsyncChan(teamCountChan)
		:: else -> 
			run sync_monitor(teamCountChan)
		fi;
		run Anonymous5(openChan,privateChan,userInactiveChan,userChan,postChan,teamCountChan,dailyActiveChan,monthlyActiveChan,iHookChan,oHookChan,commandChan,sessionChan,fileChan,hashtagChan);
		Chandef dailyActiveChan;
		
		if
		:: 1 > 0 -> 
			dailyActiveChan.size = 1;
			run AsyncChan(dailyActiveChan)
		:: else -> 
			run sync_monitor(dailyActiveChan)
		fi;
		run Anonymous6(openChan,privateChan,userInactiveChan,userChan,postChan,teamCountChan,dailyActiveChan,monthlyActiveChan,iHookChan,oHookChan,commandChan,sessionChan,fileChan,hashtagChan);
		Chandef monthlyActiveChan;
		
		if
		:: 1 > 0 -> 
			monthlyActiveChan.size = 1;
			run AsyncChan(monthlyActiveChan)
		:: else -> 
			run sync_monitor(monthlyActiveChan)
		fi;
		run Anonymous7(openChan,privateChan,userInactiveChan,userChan,postChan,teamCountChan,dailyActiveChan,monthlyActiveChan,iHookChan,oHookChan,commandChan,sessionChan,fileChan,hashtagChan);
		
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
			fi;
						for(i : 0.. stats-1) {
for10:
			}
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
						Chandef iHookChan;
						
						if
						:: 1 > 0 -> 
							iHookChan.size = 1;
							run AsyncChan(iHookChan)
						:: else -> 
							run sync_monitor(iHookChan)
						fi;
						run Anonymous8(openChan,privateChan,userInactiveChan,userChan,postChan,teamCountChan,dailyActiveChan,monthlyActiveChan,iHookChan,oHookChan,commandChan,sessionChan,fileChan,hashtagChan);
						Chandef oHookChan;
						
						if
						:: 1 > 0 -> 
							oHookChan.size = 1;
							run AsyncChan(oHookChan)
						:: else -> 
							run sync_monitor(oHookChan)
						fi;
						run Anonymous9(openChan,privateChan,userInactiveChan,userChan,postChan,teamCountChan,dailyActiveChan,monthlyActiveChan,iHookChan,oHookChan,commandChan,sessionChan,fileChan,hashtagChan);
						Chandef commandChan;
						
						if
						:: 1 > 0 -> 
							commandChan.size = 1;
							run AsyncChan(commandChan)
						:: else -> 
							run sync_monitor(commandChan)
						fi;
						run Anonymous10(openChan,privateChan,userInactiveChan,userChan,postChan,teamCountChan,dailyActiveChan,monthlyActiveChan,iHookChan,oHookChan,commandChan,sessionChan,fileChan,hashtagChan);
						Chandef sessionChan;
						
						if
						:: 1 > 0 -> 
							sessionChan.size = 1;
							run AsyncChan(sessionChan)
						:: else -> 
							run sync_monitor(sessionChan)
						fi;
						run Anonymous11(openChan,privateChan,userInactiveChan,userChan,postChan,teamCountChan,dailyActiveChan,monthlyActiveChan,iHookChan,oHookChan,commandChan,sessionChan,fileChan,hashtagChan);
						
						if
						:: true -> 
							Chandef fileChan;
							
							if
							:: 1 > 0 -> 
								fileChan.size = 1;
								run AsyncChan(fileChan)
							:: else -> 
								run sync_monitor(fileChan)
							fi;
							run Anonymous12(openChan,privateChan,userInactiveChan,userChan,postChan,teamCountChan,dailyActiveChan,monthlyActiveChan,iHookChan,oHookChan,commandChan,sessionChan,fileChan,hashtagChan);
							Chandef hashtagChan;
							
							if
							:: 1 > 0 -> 
								hashtagChan.size = 1;
								run AsyncChan(hashtagChan)
							:: else -> 
								run sync_monitor(hashtagChan)
							fi;
							run Anonymous13(openChan,privateChan,userInactiveChan,userChan,postChan,teamCountChan,dailyActiveChan,monthlyActiveChan,iHookChan,oHookChan,commandChan,sessionChan,fileChan,hashtagChan)
						:: true;
						fi;
						
						if
						:: true -> 
							
							if
							:: true -> 
								goto stop_process
							:: true;
							fi
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
stop_process:}

proctype Anonymous0(Chandef openChan;Chandef privateChan;Chandef userInactiveChan;Chandef userChan;Chandef postChan;Chandef teamCountChan;Chandef dailyActiveChan;Chandef monthlyActiveChan;Chandef iHookChan;Chandef oHookChan;Chandef commandChan;Chandef sessionChan;Chandef fileChan;Chandef hashtagChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: openChan.async_send!0;
	:: openChan.sync!0 -> 
		openChan.sending?0
	fi;
	openChan.closing!true;
stop_process:
}
proctype Anonymous1(Chandef openChan;Chandef privateChan;Chandef userInactiveChan;Chandef userChan;Chandef postChan;Chandef teamCountChan;Chandef dailyActiveChan;Chandef monthlyActiveChan;Chandef iHookChan;Chandef oHookChan;Chandef commandChan;Chandef sessionChan;Chandef fileChan;Chandef hashtagChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: privateChan.async_send!0;
	:: privateChan.sync!0 -> 
		privateChan.sending?0
	fi;
	privateChan.closing!true;
stop_process:
}
proctype Anonymous2(Chandef openChan;Chandef privateChan;Chandef userInactiveChan;Chandef userChan;Chandef postChan;Chandef teamCountChan;Chandef dailyActiveChan;Chandef monthlyActiveChan;Chandef iHookChan;Chandef oHookChan;Chandef commandChan;Chandef sessionChan;Chandef fileChan;Chandef hashtagChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: userInactiveChan.async_send!0;
	:: userInactiveChan.sync!0 -> 
		userInactiveChan.sending?0
	fi;
	userInactiveChan.closing!true;
stop_process:
}
proctype Anonymous3(Chandef openChan;Chandef privateChan;Chandef userInactiveChan;Chandef userChan;Chandef postChan;Chandef teamCountChan;Chandef dailyActiveChan;Chandef monthlyActiveChan;Chandef iHookChan;Chandef oHookChan;Chandef commandChan;Chandef sessionChan;Chandef fileChan;Chandef hashtagChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: userChan.async_send!0;
	:: userChan.sync!0 -> 
		userChan.sending?0
	fi;
	userChan.closing!true;
stop_process:
}
proctype Anonymous4(Chandef openChan;Chandef privateChan;Chandef userInactiveChan;Chandef userChan;Chandef postChan;Chandef teamCountChan;Chandef dailyActiveChan;Chandef monthlyActiveChan;Chandef iHookChan;Chandef oHookChan;Chandef commandChan;Chandef sessionChan;Chandef fileChan;Chandef hashtagChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: postChan.async_send!0;
	:: postChan.sync!0 -> 
		postChan.sending?0
	fi;
	postChan.closing!true;
stop_process:
}
proctype Anonymous5(Chandef openChan;Chandef privateChan;Chandef userInactiveChan;Chandef userChan;Chandef postChan;Chandef teamCountChan;Chandef dailyActiveChan;Chandef monthlyActiveChan;Chandef iHookChan;Chandef oHookChan;Chandef commandChan;Chandef sessionChan;Chandef fileChan;Chandef hashtagChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: teamCountChan.async_send!0;
	:: teamCountChan.sync!0 -> 
		teamCountChan.sending?0
	fi;
	teamCountChan.closing!true;
stop_process:
}
proctype Anonymous6(Chandef openChan;Chandef privateChan;Chandef userInactiveChan;Chandef userChan;Chandef postChan;Chandef teamCountChan;Chandef dailyActiveChan;Chandef monthlyActiveChan;Chandef iHookChan;Chandef oHookChan;Chandef commandChan;Chandef sessionChan;Chandef fileChan;Chandef hashtagChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: dailyActiveChan.async_send!0;
	:: dailyActiveChan.sync!0 -> 
		dailyActiveChan.sending?0
	fi;
	dailyActiveChan.closing!true;
stop_process:
}
proctype Anonymous7(Chandef openChan;Chandef privateChan;Chandef userInactiveChan;Chandef userChan;Chandef postChan;Chandef teamCountChan;Chandef dailyActiveChan;Chandef monthlyActiveChan;Chandef iHookChan;Chandef oHookChan;Chandef commandChan;Chandef sessionChan;Chandef fileChan;Chandef hashtagChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: monthlyActiveChan.async_send!0;
	:: monthlyActiveChan.sync!0 -> 
		monthlyActiveChan.sending?0
	fi;
	monthlyActiveChan.closing!true;
stop_process:
}
proctype Anonymous8(Chandef openChan;Chandef privateChan;Chandef userInactiveChan;Chandef userChan;Chandef postChan;Chandef teamCountChan;Chandef dailyActiveChan;Chandef monthlyActiveChan;Chandef iHookChan;Chandef oHookChan;Chandef commandChan;Chandef sessionChan;Chandef fileChan;Chandef hashtagChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: iHookChan.async_send!0;
	:: iHookChan.sync!0 -> 
		iHookChan.sending?0
	fi;
	iHookChan.closing!true;
stop_process:
}
proctype Anonymous9(Chandef openChan;Chandef privateChan;Chandef userInactiveChan;Chandef userChan;Chandef postChan;Chandef teamCountChan;Chandef dailyActiveChan;Chandef monthlyActiveChan;Chandef iHookChan;Chandef oHookChan;Chandef commandChan;Chandef sessionChan;Chandef fileChan;Chandef hashtagChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: oHookChan.async_send!0;
	:: oHookChan.sync!0 -> 
		oHookChan.sending?0
	fi;
	oHookChan.closing!true;
stop_process:
}
proctype Anonymous10(Chandef openChan;Chandef privateChan;Chandef userInactiveChan;Chandef userChan;Chandef postChan;Chandef teamCountChan;Chandef dailyActiveChan;Chandef monthlyActiveChan;Chandef iHookChan;Chandef oHookChan;Chandef commandChan;Chandef sessionChan;Chandef fileChan;Chandef hashtagChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: commandChan.async_send!0;
	:: commandChan.sync!0 -> 
		commandChan.sending?0
	fi;
	commandChan.closing!true;
stop_process:
}
proctype Anonymous11(Chandef openChan;Chandef privateChan;Chandef userInactiveChan;Chandef userChan;Chandef postChan;Chandef teamCountChan;Chandef dailyActiveChan;Chandef monthlyActiveChan;Chandef iHookChan;Chandef oHookChan;Chandef commandChan;Chandef sessionChan;Chandef fileChan;Chandef hashtagChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: sessionChan.async_send!0;
	:: sessionChan.sync!0 -> 
		sessionChan.sending?0
	fi;
	sessionChan.closing!true;
stop_process:
}
proctype Anonymous12(Chandef openChan;Chandef privateChan;Chandef userInactiveChan;Chandef userChan;Chandef postChan;Chandef teamCountChan;Chandef dailyActiveChan;Chandef monthlyActiveChan;Chandef iHookChan;Chandef oHookChan;Chandef commandChan;Chandef sessionChan;Chandef fileChan;Chandef hashtagChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: fileChan.async_send!0;
	:: fileChan.sync!0 -> 
		fileChan.sending?0
	fi;
	fileChan.closing!true;
stop_process:
}
proctype Anonymous13(Chandef openChan;Chandef privateChan;Chandef userInactiveChan;Chandef userChan;Chandef postChan;Chandef teamCountChan;Chandef dailyActiveChan;Chandef monthlyActiveChan;Chandef iHookChan;Chandef oHookChan;Chandef commandChan;Chandef sessionChan;Chandef fileChan;Chandef hashtagChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: hashtagChan.async_send!0;
	:: hashtagChan.sync!0 -> 
		hashtagChan.sending?0
	fi;
	hashtagChan.closing!true;
stop_process:
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

