
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example880849486/instruction/union.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef wg;
	bool state = false;
	run wgMonitor(wg);
	wg.Add!readers;
	
	if
	:: true -> 
		do
		:: true -> 
for10:
		:: true -> 
			break
		od
	:: true -> 
		run Anonymous0(wg)
	:: true -> 
		run Anonymous0(wg)
	fi;
	goto stop_process;
	wg.Wait?0
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	do
	:: true -> 
for20:
	:: true -> 
		break
	od;
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
