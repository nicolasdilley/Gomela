#define lb_for97_0  -1
#define ub_for97_1  -1
#define lb_for113_2  -1
#define ub_for113_3  -1
#define lb_for233_4  -1
#define ub_for233_5  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		
		if
		:: true -> 
			run Anonymous0(credCh)
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		Chandef _ch0;
		chan _ch0_in = [0] of {int};
		_ch0.in = _ch0_in;
		run chanMonitor(_ch0)
	:: true;
	fi;
		for(i : lb_for113_2.. ub_for113_3) {
for20:		do
		:: true -> 
			goto stop_process
		:: true -> 
			break
		od;
		do
		:: true -> 
for21:			do
			:: true -> 
for22:
			od
		od;
		

		if
		:: true -> 
			ah_OutputCh.in!0;
			ah_OutputCh.sending?state;
			
			if
			:: true -> 
				ah_TemplateTokenCh.in!0;
				ah_TemplateTokenCh.sending?state
			:: true;
			fi;
			do
			:: true -> 
				break
			:: true -> 
				break
			od
		:: true -> 
			ah_OutputCh.in!0;
			ah_OutputCh.sending?state;
			
			if
			:: true -> 
				ah_TemplateTokenCh.in!0;
				ah_TemplateTokenCh.sending?state
			:: true;
			fi
		fi;
LifetimeWatcherLoop:				do
		:: true -> 
for23:			do
			:: true -> 
				goto LifetimeWatcherLoop;
				break
			:: true -> 
				goto LifetimeWatcherLoop;
				break
			:: true -> 
				break
			:: true -> 
				goto LifetimeWatcherLoop;
				break
			od
		od;
for23_exit:
	};
for20_exit:	ah_OutputCh.closing!true;
	ah_DoneCh.closing!true;
	ah_TemplateTokenCh.closing!true
stop_process:}

proctype Anonymous0(Chandef credCh) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		do
		:: true -> 
			goto stop_process
		:: true -> 
			break
		od
	od;
for10_exit:stop_process:
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
