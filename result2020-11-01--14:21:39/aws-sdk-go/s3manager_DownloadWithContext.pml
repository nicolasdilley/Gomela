#define DownloadWithContext_options 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example906491796/service/s3/s3manager/download.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef impl_wg;
	int i;
	int options = DownloadWithContext_options;
	bool state = false;
	run wgMonitor(impl_wg);
		for(i : 0.. options-1) {
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

