#define lb_for367_0  -1
#define ub_for367_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	int i;
		for(i : lb_for367_0.. ub_for367_1) {
for10:		do
		:: true -> 
			goto stop_process
		:: true -> 
			do
			:: true -> 
				break
			:: true -> 
				

				if
				:: true -> 
					chain_errorChan.closing!true
				:: true;
				fi;
				break
			od;
			do
			:: true -> 
				run go_kafkasendConnectMessage4(chain.haltChan);
				break
			:: true -> 
				break
			od;
			break
		:: true -> 
			chan child_saramaLoggerRemoveListener22 = [0] of {int};
			run saramaLoggerRemoveListener2(child_saramaLoggerRemoveListener22);
			child_saramaLoggerRemoveListener22?0;
			break
		:: true -> 
			chan child_saramaLoggerRemoveListener23 = [0] of {int};
			run saramaLoggerRemoveListener2(child_saramaLoggerRemoveListener23);
			child_saramaLoggerRemoveListener23?0;
			chain_errorChan.closing!true;
			run go_kafkasendConnectMessage4(chain.haltChan);
			break
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				chan child_saramaLoggerRemoveListener24 = [0] of {int};
				run saramaLoggerRemoveListener2(child_saramaLoggerRemoveListener24);
				child_saramaLoggerRemoveListener24?0
			:: true;
			fi;
			do
			:: true -> 
				break
			:: true -> 
				break
			od;
			break
		:: true -> 
			break
		od
	};
for10_exit:	chain_doneProcessingMessagesToBlocks.closing!true;
	do
	:: true -> 
		break
	:: true -> 
		chain_errorChan.closing!true;
		break
	od
stop_process:}

proctype go_kafkasendConnectMessage4(Chandef exitChan) {
	bool closed; 
	int i;
	chan child_kafkanewRetryProcess50 = [0] of {int};
	run kafkanewRetryProcess5(exitChan,child_kafkanewRetryProcess50);
	child_kafkanewRetryProcess50?0;
	goto stop_process;
stop_process:
}
proctype kafkanewRetryProcess5(Chandef exit;chan child) {
	bool closed; 
	int i;
	goto stop_process;
	child!0;
stop_process:
}
proctype saramaLoggerRemoveListener2(chan child) {
	bool closed; 
	int i;
	chan child_l_eventListenerSupportremoveListener21 = [0] of {int};
	run l_eventListenerSupportremoveListener2(child_l_eventListenerSupportremoveListener21);
	child_l_eventListenerSupportremoveListener21?0;
	child!0;
stop_process:
}
proctype l_eventListenerSupportremoveListener2(chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		do
		:: true -> 
for11:
		od
	:: true;
	fi;
	child!0;
stop_process:
}
proctype chanMonitor(Chandef ch) {
	bool closed; 
	int i;
	state = false;
	do
	:: true -> 
		if
		:: state -> 
end:			if
			:: ch.sending!state -> 
				assert(false)
			:: ch.closing?true -> 
				assert(false)
			:: ch.in!0;
			:: ch.is_closed!state;
			fi
		:: else -> 
end1:			if
			:: ch.sending!state;
			:: ch.closing?true -> 
				state = true
			:: ch.is_closed!state;
			fi
		fi
	od;
stop_process:
}
