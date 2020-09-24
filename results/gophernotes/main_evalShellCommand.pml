
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example568155364/kernel.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef writersWG;
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(writersWG);
	writersWG.Add!2;
	run Anonymous0(writersWG);
	run Anonymous1(writersWG);
	writersWG.Wait?0
stop_process:}

proctype Anonymous0(Wgdef writersWG) {
	bool closed; 
	int i;
	writersWG.Add!-1;
stop_process:
}
proctype Anonymous1(Wgdef writersWG) {
	bool closed; 
	int i;
	writersWG.Add!-1;
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
