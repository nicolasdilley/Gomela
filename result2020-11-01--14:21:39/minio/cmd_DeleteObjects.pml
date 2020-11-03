#define DeleteObjects_objects 3
#define DeleteObjects_storageDisks 3
#define DeleteObjects_delObjErrs 1
#define DeleteObjects_versions 0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example320658119/cmd/erasure-object.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int versions = DeleteObjects_versions;
	int storageDisks = DeleteObjects_storageDisks;
	bool state = false;
	int objects = DeleteObjects_objects;
	int delObjErrs = DeleteObjects_delObjErrs;
	int i;
		for(i : 0.. objects-1) {
for10:
	};
		for(i : 0.. objects-1) {
for20:
	};
	run wgMonitor(wg);
		for(i : 0.. storageDisks-1) {
for30:		wg.Add!1;
		run Anonymous0(wg)
	};
	wg.Wait?0;
		for(i : 0.. objects-1) {
for40:				for(i : 0.. delObjErrs-1) {
for41:
		}
	};
		for(i : 0.. versions-1) {
for50:				for(i : 0.. storageDisks-1) {
for51:			
			if
			:: true -> 
				break
			:: true;
			fi
		}
	};
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
stop_process:	wg.Add!-1
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

