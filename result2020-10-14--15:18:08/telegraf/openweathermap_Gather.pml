#define Gather_n_Fetch  60
#define Gather_n_CityId  60
#define lb_for106_2  -1
#define ub_for106_3  -1
#define lb_for108_4  -1
#define ub_for108_5  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example985353586/plugins/inputs/openweathermap/openweathermap.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int n_Fetch = Gather_n_Fetch;
	Wgdef wg;
	int n_CityId = Gather_n_CityId;
	bool state = false;
	run wgMonitor(wg);
		for(i : 1.. n_Fetch) {
for10:		
		if
		:: true -> 
						for(i : 1.. n_CityId) {
for11:				wg.Add!1;
				run Anonymous0(wg)
			}
		:: true -> 
			
			if
			:: true -> 
								for(i : lb_for106_2.. ub_for106_3) {
for12:					
					if
					:: lb_for108_4 != -1 && ub_for108_5 != -1 -> 
												for(i : lb_for108_4.. ub_for108_5) {
for13:
						}
					:: else -> 
						do
						:: true -> 
for13:
						:: true -> 
							break
						od
					fi;
for13_exit:					wg.Add!1;
					run Anonymous1(wg)
				};
for12_exit:
			:: true;
			fi
		fi
	};
	wg.Wait?0;
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
	wg.Add!-1;
stop_process:
}
proctype Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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
