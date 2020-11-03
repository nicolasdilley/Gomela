#define initGatewaySdsService_maxRetryTimes 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example178551585/security/pkg/nodeagent/sds/server.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef s_grpcGatewayServer_serveWG;
	int i;
	int maxRetryTimes = initGatewaySdsService_maxRetryTimes;
	bool state = false;
	run wgMonitor(s_grpcGatewayServer_serveWG);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Anonymous0();
	goto stop_process
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	bool state;
	
	if
	:: 0 != -1 && maxRetryTimes-1 != -1 -> 
				for(i : 0.. maxRetryTimes-1) {
for10:			
			if
			:: true -> 
				break
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				break
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:stop_process:
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

