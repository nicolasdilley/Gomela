#define BuildArtifactsE_artifactNameToOptions  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example611766508/modules/packer/packer.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef waitForArtifacts;
	int i;
	int artifactNameToOptions = BuildArtifactsE_artifactNameToOptions;
	bool state = false;
	run wgMonitor(waitForArtifacts);
	waitForArtifacts.Add!artifactNameToOptions;
		for(i : 1.. artifactNameToOptions) {
for10:		run Anonymous0(waitForArtifacts)
	};
	waitForArtifacts.Wait?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef waitForArtifacts) {
	bool closed; 
	int i;
	bool state;
	waitForArtifacts.Add!-1;
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
	od;
stop_process:
}
