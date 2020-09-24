#define linksToStop  5
#define lb_for1539_1  -1
#define ub_for1539_2  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example671499408/htlcswitch/switch.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int s_linkIndex = 5;
	bool state = false;
	int linksToStop = 5;
	Wgdef wg;
	int s_pendingLinkIndex = 5;
	int i;
out:			for(i : lb_for1539_1.. ub_for1539_2) {
for40:		do
		:: true -> 
			run Anonymous1(wg)
		:: true -> 
			do
			:: true -> 
for41:
			:: true -> 
				break
			od
		:: true;
		:: true -> 
			goto stop_process
		od
	};
for40_exit:;
	do
	:: true -> 
for10:
	:: true -> 
		break
	od;
	do
	:: true -> 
for20:
	:: true -> 
		break
	od;
	run wgMonitor(wg);
		for(i : 1.. linksToStop) {
for30:		wg.Add!1;
		run Anonymous0(wg)
	};
	wg.Wait?0
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	wg.Add!-1;
stop_process:
}
proctype Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
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
