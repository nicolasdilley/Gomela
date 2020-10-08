#define lb_for232_0  -1
#define ub_for232_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example076238862/dgraph/cmd/bulk/loader.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int ld_mappers = 5;
	Wgdef mapperWg;
	int files = 5;
	bool state = false;
	run wgMonitor(mapperWg);
	mapperWg.Add!ld_mappers;
		for(i : 1.. ld_mappers) {
for10:		run Anonymous0(mapperWg)
	};
		for(i : 1.. files) {
for20:		run Anonymous1(mapperWg)
	};
	mapperWg.Wait?0;
		for(i : 1.. ld_mappers) {
for30:
	}
stop_process:}

proctype Anonymous0(Wgdef mapperWg) {
	bool closed; 
	int i;
	mapperWg.Add!-1;
stop_process:
}
proctype Anonymous1(Wgdef mapperWg) {
	bool closed; 
	int i;
	do
	:: true -> 
for21:		
		if
		:: true -> 
			break
		fi
	od;
for21_exit:stop_process:
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
