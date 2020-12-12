
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example023954484/pkg/test/framework/components/istio/operator.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i_ctx_Clusters18927 = -2;
	bool state = false;
	int i;
	
	if
	:: true -> 
		Wgdef errG_wg;
		run wgMonitor(errG_wg);
				for(i : 0.. i_ctx_Clusters18927-1) {
for10:
		};
		goto stop_process
	:: true;
	fi;
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
