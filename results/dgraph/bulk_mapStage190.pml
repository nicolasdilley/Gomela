#define mapStage_ld_mappers  ??
#define mapStage_files  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example913407792/dgraph/cmd/bulk/loader.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef mapperWg;
	int i;
	int ld_mappers = mapStage_ld_mappers;
	Wgdef ld_xids_wg;
	Wgdef thr_wg;
	int files = mapStage_files;
	bool state = false;
	run wgMonitor(ld_xids_wg);
	run wgMonitor(mapperWg);
	mapperWg.Add!ld_mappers;
	run wgMonitor(thr_wg);
	mapperWg.Wait?0
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
	od
}
