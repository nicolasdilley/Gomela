#define resetVia_c_pending  60
#define resetVia_ids  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example371341485/pkg/store/consume.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int c_pending = resetVia_c_pending;
	Wgdef wg;
	int ids = resetVia_ids;
	bool state = false;
	run wgMonitor(wg);
		for(i : 1.. c_pending) {
for10:		wg.Add!ids;
				for(i : 1.. ids) {
for11:			run Anonymous0(wg)
		}
	};
	wg.Wait?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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
