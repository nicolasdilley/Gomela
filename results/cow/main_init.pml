#define lb_for189_0  -1
#define ub_for189_1  -1
#define lb_for198_2  -1
#define ub_for198_3  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	int i;
	run go_maincloseStaleServerConn2(connPool.muxConn)
stop_process:}

proctype go_maincloseStaleServerConn2(Chandef ch) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		chan child_maincloseServerConn30 = [0] of {int};
		run maincloseServerConn3(ch,child_maincloseServerConn30);
		child_maincloseServerConn30?0;
		
		if
		:: true -> 
			break
		:: true;
		fi
	od;
for10_exit:	do
	:: true -> 
for20:		do
		:: ch.in?0 -> 
			break
		:: true -> 
			goto stop_process
		od
	od;
for20_exit:stop_process:
}
proctype maincloseServerConn3(Chandef ch;chan child) {
	bool closed; 
	int i;
	
	if
	:: 0 != -1 && lcnt-1 != -1 -> 
				for(i : 0.. lcnt-1) {
for11:			do
			:: ch.in?0 -> 
				
				if
				:: true -> 
					ch.in!0
				fi;
				break
			:: true -> 
				goto stop_process
			od
		}
	:: else -> 
		do
		:: true -> 
for11:			do
			:: ch.in?0 -> 
				
				if
				:: true -> 
					ch.in!0
				fi;
				break
			:: true -> 
				goto stop_process
			od
		:: true -> 
			break
		od
	fi;
for11_exit:	goto stop_process;
	child!0;
stop_process:
}
