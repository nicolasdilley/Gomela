#define mapStage_ld_mappers  60
#define mapStage_files  60
#define lb_for235_2  -1
#define ub_for235_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example897304492/dgraph/cmd/bulk/loader.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int ld_mappers = mapStage_ld_mappers;
	Wgdef mapperWg;
	int i;
	Wgdef thr_wg;
	int files = mapStage_files;
	bool state = false;
	run wgMonitor(mapperWg);
	mapperWg.Add!ld_mappers;
		for(i : 1.. ld_mappers) {
for10:		run Anonymous0(mapperWg)
	};
	run wgMonitor(thr_wg);
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
	bool state;
	mapperWg.Add!-1;
stop_process:
}
proctype Anonymous1(Wgdef mapperWg) {
	bool closed; 
	int i;
	bool state;
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
