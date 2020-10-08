#define lb_for161_0  -1
#define ub_for161_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example288455409/internal/network/listener/listener.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int m_matchers = 5;
	bool state = false;
	run wgMonitor(wg);
		for(i : lb_for161_0.. ub_for161_1) {
for20:		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		wg.Add!1;
		run go_mserve(wg)
	};
for20_exit:	wg.Wait?0;
		for(i : 1.. m_matchers) {
for10:		do
		:: true -> 
for11:
		:: true -> 
			break
		od
	}
stop_process:}

proctype go_mserve(Wgdef wg) {
	bool closed; 
	int i;
		for(i : 1.. m_matchers) {
for21:				for(i : 1.. sl_matchers) {
for22:			
			if
			:: true -> 
				do
				:: true;
				:: true;
				od;
				goto stop_process
			:: true;
			fi
		}
	};
	wg.Add!-1;
stop_process:
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
