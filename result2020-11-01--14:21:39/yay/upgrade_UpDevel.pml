#define UpDevel_remote 1
#define UpDevel_localCache_OriginsByPackage 0
#define UpDevel_toUpdate 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example834641366/pkg/upgrade/sources.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int localCache_OriginsByPackage = UpDevel_localCache_OriginsByPackage;
	Wgdef wg;
	int i;
	int remote = UpDevel_remote;
	int toUpdate = UpDevel_toUpdate;
	bool state = false;
	run wgMonitor(wg);
		for(i : 0.. localCache_OriginsByPackage-1) {
for10:		wg.Add!1
	};
	wg.Wait?0;
		for(i : 0.. toUpdate-1) {
for20:
	};
	goto stop_process
stop_process:}

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

