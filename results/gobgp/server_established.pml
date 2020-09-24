#define lb_for1682_0  -1
#define ub_for1682_1  -1
#define lb_for1720_2  -1
#define ub_for1720_3  -1
#define lb_for1756_4  -1
#define ub_for1756_5  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example117802945/pkg/server/fsm.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef wg;
	bool state = false;
	run wgMonitor(wg);
	wg.Add!2;
	run go_hsendMessageloop(wg);
	run go_hrecvMessageloop(wg);
	do
	:: true -> 
for30:		do
		:: true -> 
			do
			:: true -> 
				break
			od;
			goto stop_process
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		od
	od;
for30_exit:	wg.Wait?0
stop_process:}

proctype go_hsendMessageloop(Wgdef wg) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		do
		:: true -> 
			goto stop_process
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		od
	od;
for10_exit:	wg.Add!-1;
stop_process:
}
proctype go_hrecvMessageloop(Wgdef wg) {
	bool closed; 
	int i;
	do
	:: true -> 
for20:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
for20_exit:	wg.Add!-1;
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
