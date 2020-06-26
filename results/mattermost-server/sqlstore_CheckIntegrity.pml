
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [0] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	run go_sqlstoreCheckRelationalIntegrity2(_ch0);
	goto stop_process
stop_process:}

proctype go_sqlstoreCheckRelationalIntegrity2(Chandef results) {
	bool closed; 
	int i;
	chan child_sqlstorecheckUsersIntegrity26 = [0] of {int};
	chan child_sqlstorecheckTeamsIntegrity25 = [0] of {int};
	chan child_sqlstorecheckSessionsIntegrity24 = [0] of {int};
	chan child_sqlstorecheckSchemesIntegrity23 = [0] of {int};
	chan child_sqlstorecheckPostsIntegrity22 = [0] of {int};
	chan child_sqlstorecheckCommandsIntegrity21 = [0] of {int};
	chan child_sqlstorecheckChannelsIntegrity20 = [0] of {int};
	run sqlstorecheckChannelsIntegrity2(results,child_sqlstorecheckChannelsIntegrity20);
	chan child_sqlstorecheckCommandsIntegrity21 = [0] of {int};
	run sqlstorecheckCommandsIntegrity2(results,child_sqlstorecheckCommandsIntegrity21);
	chan child_sqlstorecheckPostsIntegrity22 = [0] of {int};
	run sqlstorecheckPostsIntegrity2(results,child_sqlstorecheckPostsIntegrity22);
	chan child_sqlstorecheckSchemesIntegrity23 = [0] of {int};
	run sqlstorecheckSchemesIntegrity2(results,child_sqlstorecheckSchemesIntegrity23);
	chan child_sqlstorecheckSessionsIntegrity24 = [0] of {int};
	run sqlstorecheckSessionsIntegrity2(results,child_sqlstorecheckSessionsIntegrity24);
	chan child_sqlstorecheckTeamsIntegrity25 = [0] of {int};
	run sqlstorecheckTeamsIntegrity2(results,child_sqlstorecheckTeamsIntegrity25);
	chan child_sqlstorecheckUsersIntegrity26 = [0] of {int};
	run sqlstorecheckUsersIntegrity2(results,child_sqlstorecheckUsersIntegrity26);
	child_sqlstorecheckUsersIntegrity26?0;
	results.closing!true;
stop_process:
}
proctype sqlstorecheckChannelsIntegrity2(Chandef results;chan child) {
	bool closed; 
	int i;
	results.in!0;
	results.sending?state;
	results.in!0;
	results.sending?state;
	results.in!0;
	results.sending?state;
	results.in!0;
	results.sending?state;
	results.in!0;
	results.sending?state;
	results.in!0;
	results.sending?state;
	child!0;
stop_process:
}
proctype sqlstorecheckCommandsIntegrity2(Chandef results;chan child) {
	bool closed; 
	int i;
	results.in!0;
	results.sending?state;
	child!0;
stop_process:
}
proctype sqlstorecheckPostsIntegrity2(Chandef results;chan child) {
	bool closed; 
	int i;
	results.in!0;
	results.sending?state;
	results.in!0;
	results.sending?state;
	results.in!0;
	results.sending?state;
	results.in!0;
	results.sending?state;
	child!0;
stop_process:
}
proctype sqlstorecheckSchemesIntegrity2(Chandef results;chan child) {
	bool closed; 
	int i;
	results.in!0;
	results.sending?state;
	results.in!0;
	results.sending?state;
	child!0;
stop_process:
}
proctype sqlstorecheckSessionsIntegrity2(Chandef results;chan child) {
	bool closed; 
	int i;
	results.in!0;
	results.sending?state;
	child!0;
stop_process:
}
proctype sqlstorecheckTeamsIntegrity2(Chandef results;chan child) {
	bool closed; 
	int i;
	results.in!0;
	results.sending?state;
	results.in!0;
	results.sending?state;
	results.in!0;
	results.sending?state;
	results.in!0;
	results.sending?state;
	results.in!0;
	results.sending?state;
	child!0;
stop_process:
}
proctype sqlstorecheckUsersIntegrity2(Chandef results;chan child) {
	bool closed; 
	int i;
	results.in!0;
	results.sending?state;
	results.in!0;
	results.sending?state;
	results.in!0;
	results.sending?state;
	results.in!0;
	results.sending?state;
	results.in!0;
	results.sending?state;
	results.in!0;
	results.sending?state;
	results.in!0;
	results.sending?state;
	results.in!0;
	results.sending?state;
	results.in!0;
	results.sending?state;
	results.in!0;
	results.sending?state;
	results.in!0;
	results.sending?state;
	results.in!0;
	results.sending?state;
	results.in!0;
	results.sending?state;
	results.in!0;
	results.sending?state;
	results.in!0;
	results.sending?state;
	results.in!0;
	results.sending?state;
	results.in!0;
	results.sending?state;
	results.in!0;
	results.sending?state;
	results.in!0;
	results.sending?state;
	results.in!0;
	results.sending?state;
	results.in!0;
	results.sending?state;
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
