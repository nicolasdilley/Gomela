#define lb_for189_0  -1
#define ub_for189_1  -1
#define lb_for123_2  -1
#define ub_for123_3  -1

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
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
		for(i : 1.. interfaces) {
for10:				for(i : 1.. {"urn:schemas-upnp-org:device:InternetGatewayDevice:1","urn:schemas-upnp-org:device:InternetGatewayDevice:2",}) {
for11:			run Anonymous0(_ch0)
		}
	};
	run Anonymous2(_ch0);
	do
	:: true -> 
for20:		do
		:: _ch0.in?0 -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		:: true -> 
			goto stop_process
		od
	od;
for20_exit:
stop_process:}

proctype upnpdiscover5(Chandef results;chan child) {
	bool closed; 
	int i;
	
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
loop:		do
	:: true -> 
for12:		
		if
		:: true -> 
			break
		:: true;
		fi;
		
		if
		:: true -> 
			do
			:: true -> 
				goto loop;
				break
			:: true -> 
				break
			od;
			break
		:: true;
		fi;
		do
		:: true -> 
for13:			do
			:: results.in!0 -> 
				results.sending?state;
				break
			:: true -> 
				goto stop_process
			od
		od
	od;
for12_exit:;
	child!0;
stop_process:
}
proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	chan child_upnpdiscover50 = [0] of {int};
	run upnpdiscover5(_ch0,child_upnpdiscover50);
	child_upnpdiscover50?0;
stop_process:
}
proctype Anonymous2(Chandef _ch0) {
	bool closed; 
	int i;
	_ch0.closing!true;
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
