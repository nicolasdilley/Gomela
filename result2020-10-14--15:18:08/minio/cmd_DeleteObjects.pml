#define DeleteObjects_objects  60
#define DeleteObjects_storageDisks  60
#define DeleteObjects_delObjErrs  60
#define DeleteObjects_versions  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example604607877/cmd/erasure-object.go
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
		for(i : 1.. objects) {
for10:
	};
		for(i : 1.. objects) {
for20:
	};
	run wgMonitor(wg);
		for(i : 1.. storageDisks) {
for30:		wg.Add!1;
		run Anonymous0(wg)
	};
	wg.Wait?0;
		for(i : 1.. objects) {
for40:				for(i : 1.. delObjErrs) {
for41:
		}
	};
		for(i : 1.. versions) {
for50:				for(i : 1.. storageDisks) {
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
	wg.Add!-1;
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
