#define readBlobsP_rs  60
#define readBlobsP_blobs  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example581771142/go/types/blob.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int blobs = readBlobsP_blobs;
	Wgdef wg;
	bool state = false;
	int rs = readBlobsP_rs;
	int i;
	

	if
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	fi;
	run wgMonitor(wg);
	wg.Add!rs;
		for(i : 1.. rs) {
for10:		run Anonymous0()
	};
	wg.Wait?0;
	
	if
	:: 1 != -1 && blobs-1 != -1 -> 
				for(i : 1.. blobs-1) {
for20:
		}
	:: else -> 
		do
		:: true -> 
for20:
		:: true -> 
			break
		od
	fi;
for20_exit:	goto stop_process
stop_process:}

proctype Anonymous0() {
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
	od;
stop_process:
}
