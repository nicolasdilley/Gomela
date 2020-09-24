
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example592136038/test/helpers/kubectl.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int results = 5;
	Wgdef wg;
	bool state = false;
	int pods = 5;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
	wg.Add!2;
	run Anonymous0(wg);
	run Anonymous1(wg);
	do
	:: true -> 
for10:		do
		:: true -> 
for11:
		:: true -> 
			break
		od
	:: true -> 
		break
	od;
	wg.Wait?0;
	do
	:: true -> 
for20:
	:: true -> 
		break
	od
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
