#define lms  5
#define db_MetricSets  5
#define parts  5
#define tmhs  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example474659540/metrics/sinks/hawkular/driver.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int h_filters = 5;
	int db_MetricSets = 5;
	bool state = false;
	int lms = 5;
	int i;
	do
	:: true -> 
for10:
	:: true -> 
		break
	od;
	
	if
	:: true -> 
		Wgdef wg;
		run wgMonitor(wg);
				for(i : 1.. db_MetricSets) {
for20:Store:									for(i : 1.. lms) {
for21:				do
				:: true -> 
for22:
				:: true -> 
					break
				od;
				chan child_hregisterLabeledIfNecessaryInline0 = [0] of {int};
				run hregisterLabeledIfNecessaryInline(wg,child_hregisterLabeledIfNecessaryInline0);
				child_hregisterLabeledIfNecessaryInline0?0
			}
		};
		chan child_hsendData1 = [0] of {int};
		run hsendData(wg,tmhs,child_hsendData1);
		child_hsendData1?0;
		wg.Wait?0
	:: true;
	fi
stop_process:}

proctype hregisterLabeledIfNecessaryInline(Wgdef wg;chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		wg.Add!1;
		run Anonymous1()
	:: true;
	fi;
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous1() {
	bool closed; 
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
stop_process:
}
proctype hsendData(Wgdef wg;int tmhs;chan child) {
	bool closed; 
	int i;
		for(i : 1.. tmhs) {
for30:				for(i : 1.. parts) {
for31:			wg.Add!1;
			run Anonymous3()
		}
	};
	child!0;
stop_process:
}
proctype Anonymous3() {
	bool closed; 
	int i;
stop_process:
}
proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
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
