#define AdoptExistingResources_envs_Items  1
#define AdoptExistingResources_podList_Items  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example794430105/pkg/executor/executortype/poolmgr/gpm.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	bool state = false;
	int i;
	int podList_Items = AdoptExistingResources_podList_Items;
	int envs_Items = AdoptExistingResources_envs_Items;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
		for(i : 0.. envs_Items-1) {
		for10: skip;
		

		if
		:: true -> 
			wg.Add!1;
			run go_Anonymous0(wg)
		:: true;
		fi;
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 0.. podList_Items-1) {
		for20: skip;
		

		if
		:: true -> 
			goto for20_end
		:: true;
		fi;
		wg.Add!1;
		run go_Anonymous1(wg);
		for20_end: skip
	};
	for20_exit: skip;
	wg.Wait?0
stop_process:skip
}

proctype go_Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous1(Wgdef wg) {
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
	stop_process: skip;
	wg.Add!-1
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
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}

