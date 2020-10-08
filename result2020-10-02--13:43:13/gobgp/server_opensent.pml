#define lb_for1220_0  -1
#define ub_for1220_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example938771801/pkg/server/fsm.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int cap_Tuples = 5;
	Wgdef wg;
	int fsm_pConf_AfiSafis = 5;
	bool state = false;
	run wgMonitor(wg);
	wg.Add!1;
	run go_hrecvMessage(wg);
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
		:: true -> 
			goto stop_process
		od
	od;
for10_exit:	wg.Wait?0
stop_process:}

proctype go_hrecvMessage(Wgdef wg) {
	bool closed; 
	int i;
	goto stop_process;
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
