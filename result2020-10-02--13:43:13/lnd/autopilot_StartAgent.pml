#define lb_for146_0  -1
#define ub_for146_1  -1
#define lb_for174_2  -1
#define ub_for174_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example473489835/autopilot/manager.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef m_pilot_wg;
	bool state = false;
	int topChange_ClosedChannels = 5;
	Wgdef pilot_wg;
	int topChange_ChannelEdgeUpdates = 5;
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
	run wgMonitor(pilot_wg);
	
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
	run wgMonitor(m_pilot_wg);
	run Anonymous0();
	run Anonymous1();
	goto stop_process
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		do
		:: true;
		:: true;
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		od
	od;
for10_exit:stop_process:
}
proctype Anonymous1() {
	bool closed; 
	int i;
	do
	:: true -> 
for20:		do
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		od
	od;
for20_exit:stop_process:
}
proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
	do
	:: wg.Add?i -> 
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 -> 
end:		
		if
		:: wg.Add?i -> 
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
		fi
	od;
stop_process:
}
