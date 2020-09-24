#define lb_for86_0  -1
#define ub_for86_1  -1
#define resp_Messages  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example137307044/server/cloudformation/queue.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int resp_Messages = 5;
	bool state = false;
	run wgMonitor(wg);
	do
	:: true -> 
for10:		do
		:: true -> 
			wg.Wait?0;
			goto stop_process
		:: true -> 
						for(i : 1.. resp_Messages) {
for11:				wg.Add!1;
				run Anonymous0(wg)
			};
			break
		od
	od;
for10_exit:
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
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
