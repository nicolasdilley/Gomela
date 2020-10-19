#define LookupHost_recordsA  60
#define LookupHost_recordsAAAA  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example340194181/bdns/dns.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int recordsA = LookupHost_recordsA;
	Wgdef wg;
	int recordsAAAA = LookupHost_recordsAAAA;
	bool state = false;
	run wgMonitor(wg);
	wg.Add!1;
	run Anonymous0(wg);
	wg.Add!1;
	run Anonymous1(wg);
	wg.Wait?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. recordsA) {
for10:
	};
		for(i : 1.. recordsAAAA) {
for20:
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
proctype Anonymous1(Wgdef wg) {
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
