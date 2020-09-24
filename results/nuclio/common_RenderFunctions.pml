
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example136647744/pkg/nuctl/command/common/renderers.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef waitGroup;
	bool state = false;
	run wgMonitor(waitGroup);
	waitGroup.Add!functions;
	do
	:: true -> 
for10:		run Anonymous0()
	:: true -> 
		break
	od;
	waitGroup.Wait?0;
	

	if
	:: true -> 
		do
		:: true -> 
for20:
		:: true -> 
			break
		od
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0() {
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
