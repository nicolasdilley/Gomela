#define Templates_jsa_templates 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example213061294/server/jetstream.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef __grWG;
	int i;
	int jsa_templates = Templates_jsa_templates;
	bool state = false;
	run wgMonitor(__grWG);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 0.. jsa_templates-1) {
for10:
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

