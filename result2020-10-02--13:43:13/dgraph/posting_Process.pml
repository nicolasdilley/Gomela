#define lb_for141_0  -1
#define ub_for141_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example076238862/posting/mvcc.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int batch = 5;
	Wgdef writer_wg;
	int m = 5;
	bool state = false;
	run wgMonitor(writer_wg);
	do
	:: true -> 
for10:		do
		:: true -> 
			goto stop_process
		:: true -> 
						for(i : 1.. m) {
for11:
			}
		:: true;
		od
	od;
for10_exit:
stop_process:}

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
