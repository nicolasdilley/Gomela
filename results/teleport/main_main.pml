
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example434544031/socket/example/socket_client_ab.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int loop = 5;
	Wgdef count;
	int group = 5;
	bool state = false;
	run wgMonitor(count);
	
	if
	:: 0 != -1 && loop-1 != -1 -> 
				for(i : 0.. loop-1) {
for10:			count.Add!group;
						for(i : 0.. group-1) {
for11:				run Anonymous0(count)
			};
for11_exit:			count.Wait?0
		}
	:: else -> 
		do
		:: true -> 
for10:			count.Add!group;
						for(i : 0.. group-1) {
for11:				run Anonymous0(count)
			};
for11_exit:			count.Wait?0
		:: true -> 
			break
		od
	fi;
for10_exit:
stop_process:}

proctype Anonymous0(Wgdef count) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	count.Add!-1;
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
