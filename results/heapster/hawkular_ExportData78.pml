#define ExportData_db_MetricSets  ??
#define ExportData_lms  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example459467514/metrics/sinks/hawkular/driver.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int h_filters = -2;
	int db_MetricSets = ExportData_db_MetricSets;
	bool state = false;
	int lms = ExportData_lms;
	int i;
	
	if
	:: true -> 
		Wgdef wg;
		run wgMonitor(wg);
				for(i : 0.. db_MetricSets-1) {
for20:Store:									for(i : 0.. lms-1) {
for21:								for(i : 0.. h_filters-1) {
for22:
				};
				chan child_registerLabeledIfNecessaryInline0 = [0] of {int};
				run registerLabeledIfNecessaryInline(wg,child_registerLabeledIfNecessaryInline0);
				child_registerLabeledIfNecessaryInline0?0
			}
		};
		chan child_sendData1 = [0] of {int};
		run sendData(wg,tmhs,child_sendData1);
		child_sendData1?0;
		wg.Wait?0
	:: true;
	fi
stop_process:}

proctype registerLabeledIfNecessaryInline(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		run Anonymous0()
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype sendData(Wgdef wg;int tmhs;chan child) {
	bool closed; 
	int i;
	bool state;
stop_process:	child!0
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
