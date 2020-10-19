#define listLogsFromPods_pods  60
#define listLogsFromPods_logs  60
#define listLogsFromPods_errs  60
#define lb_for165_3  -1
#define ub_for165_4  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example490499155/provision/kubernetes/logs.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int logs = listLogsFromPods_logs;
	Wgdef wg;
	int i;
	int pods = listLogsFromPods_pods;
	int errs = listLogsFromPods_errs;
	bool state = false;
	run wgMonitor(wg);
		for(i : 1.. pods) {
for10:		wg.Add!1;
		run Anonymous0(wg)
	};
	wg.Wait?0;
		for(i : 1.. logs) {
for20:
	};
		for(i : 1.. errs) {
for30:
	};
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: lb_for165_3 != -1 && ub_for165_4 != -1 -> 
				for(i : lb_for165_3.. ub_for165_4) {
for11:
		}
	:: else -> 
		do
		:: true -> 
for11:
		:: true -> 
			break
		od
	fi;
for11_exit:	wg.Add!-1;
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
