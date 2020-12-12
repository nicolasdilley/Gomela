#define MarkComplete_incompleteChunks  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example851386018/storage/piece_resource.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int incompleteChunks = MarkComplete_incompleteChunks;
	bool state = false;
	int i;
	run Anonymous0(wg);
	
	if
	:: true -> 
		Wgdef wg;
		run wgMonitor(wg);
				for(i : 0.. incompleteChunks-1) {
for10:			wg.Add!1;
			run Anonymous1(wg)
		};
		wg.Wait?0
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
stop_process:
}
proctype Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
stop_process:	wg.Add!-1
}
proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
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
	od
}
