#define lb_for915_0  -1
#define ub_for915_1  -1
#define lb_for920_2  -1
#define ub_for920_3  -1

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
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
	run go_tikvrpcCheckStreamTimeoutLoop2(a.streamTimeout,a.done);
	goto stop_process
stop_process:}

proctype go_tikvrpcCheckStreamTimeoutLoop2(Chandef ch;Chandef done) {
	bool closed; 
	int i;
	do
	:: true -> 
for20:		do
		:: done.in?0 -> 
drainLoop:						do
			:: true -> 
for21:				do
				:: ch.in?0 -> 
					break
				:: true -> 
					goto drainLoop;
					break
				od
			od;
for21_exit:;
			goto stop_process
		:: ch.in?0 -> 
			break
		:: true -> 
			break
		od
	od;
for20_exit:stop_process:
}
