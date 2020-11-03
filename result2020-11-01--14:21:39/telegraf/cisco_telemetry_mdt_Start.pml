#define Start_c_Aliases 0
#define Start_c_EmbeddedTags 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example729075595/plugins/inputs/cisco_telemetry_mdt/cisco_telemetry_mdt.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int c_EmbeddedTags = Start_c_EmbeddedTags;
	int c_Aliases = Start_c_Aliases;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 0.. c_Aliases-1) {
for10:
	};
		for(i : 0.. c_EmbeddedTags-1) {
for20:
	};
	

	if
	:: true -> 
		run Anonymous0()
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		fi;
		Wgdef c_grpcServer_serveWG;
		run wgMonitor(c_grpcServer_serveWG);
		run Anonymous1()
	:: true -> 
		goto stop_process
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	bool state;
stop_process:
}
proctype Anonymous1() {
	bool closed; 
	int i;
	bool state;
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

