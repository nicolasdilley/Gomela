#define MakeFBOsForExistingJournals_j_tlfJournals  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example093354317/libkbfs/journal_server.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int j_tlfJournals = MakeFBOsForExistingJournals_j_tlfJournals;
	bool state = false;
	run wgMonitor(wg);
		for(i : 1.. j_tlfJournals) {
for10:		wg.Add!1;
		run Anonymous0(wg)
	};
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Add!-1;
stop_process:
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
	od;
stop_process:
}
