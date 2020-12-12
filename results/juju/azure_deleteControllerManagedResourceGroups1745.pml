#define deleteControllerManagedResourceGroups_groupNames  ??
#define lb_for1762_1  -1
#define ub_for1762_2  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example787825356/provider/azure/environ.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int groupNames = deleteControllerManagedResourceGroups_groupNames;
	Wgdef wg;
	bool state = false;
	int result_Values176625 = -2;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: lb_for1762_1 != -2 && ub_for1762_2 != -2 -> 
				for(i : lb_for1762_1.. ub_for1762_2) {
for10:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
						for(i : 0.. result_Values176625-1) {
for11:
			}
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
						for(i : 0.. result_Values176625-1) {
for11:
			}
		:: true -> 
			break
		od
	fi;
for10_exit:	run wgMonitor(wg);
		for(i : 0.. groupNames-1) {
for20:		wg.Add!1;
		run Anonymous0(wg)
	};
	wg.Wait?0;
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
