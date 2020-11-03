#define createDevelDB_srcinfos 1
#define createDevelDB_srcinfos[i]_Packages 0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example834641366/vcs.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int srcinfos = createDevelDB_srcinfos;
	Wgdef wg;
	int srcinfos[i]_Packages = createDevelDB_srcinfos[i]_Packages;
	bool state = false;
	run wgMonitor(wg);
	
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
		for(i : 0.. srcinfos-1) {
for10:				for(i : 0.. srcinfos[i]_Packages-1) {
for11:			wg.Add!1;
			run go_config_Runtime_VCSStoreUpdate(wg,srcinfos[i]_Source)
		}
	};
	wg.Wait?0;
	goto stop_process
stop_process:}

proctype go_config_Runtime_VCSStoreUpdate(Wgdef wg;int sources) {
	bool closed; 
	int i;
	bool state;
		for(i : 0.. sources-1) {
for12:
	};
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
	od
}

