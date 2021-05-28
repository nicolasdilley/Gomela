// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/istio/istio/blob/9a5df21188426a6a7dd7d7503e01330a79db8a48/pkg/wasm/convert.go#L69
#define MaybeConvertWasmExtensionConfigDelta_numResources  ??
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_MaybeConvertWasmExtensionConfigDelta690 = [1] of {int};
	run MaybeConvertWasmExtensionConfigDelta69(child_MaybeConvertWasmExtensionConfigDelta690);
	run receiver(child_MaybeConvertWasmExtensionConfigDelta690)
stop_process:skip
}

proctype MaybeConvertWasmExtensionConfigDelta69(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousMaybeConvertWasmExtensionConfigDelta80800 = [1] of {int};
	Wgdef wg;
	int numResources = MaybeConvertWasmExtensionConfigDelta_numResources; // mand numResources
	run wgMonitor(wg);
	wg.update!numResources;
		for(i : 0.. numResources-1) {
		for10: skip;
		run AnonymousMaybeConvertWasmExtensionConfigDelta8080(wg,child_AnonymousMaybeConvertWasmExtensionConfigDelta80800);
		run receiver(child_AnonymousMaybeConvertWasmExtensionConfigDelta80800);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	goto stop_process;
		stop_process: skip;
	stop_process: skip;
	child!0
}
proctype AnonymousMaybeConvertWasmExtensionConfigDelta8080(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

proctype receiver(chan c) {
c?0
}

