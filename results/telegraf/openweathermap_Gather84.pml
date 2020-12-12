#define Gather_n_Fetch  ??
#define Gather_n_CityId  ??
#define lb_for106_2  -1
#define ub_for106_3  -1
#define lb_for108_4  -1
#define ub_for108_5  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example359059926/plugins/inputs/openweathermap/openweathermap.go
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
		for(i : 0.. n_Fetch-1) {
for10:		
		if
		:: true -> 
						for(i : 0.. n_CityId-1) {
for11:				wg.Add!1;
				run Anonymous0(wg)
			}
		:: true -> 
			
			if
			:: true -> 
								for(i : lb_for106_2.. ub_for106_3) {
for12:for13_exit:					wg.Add!1;
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
stop_process:	wg.Add!-1
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
