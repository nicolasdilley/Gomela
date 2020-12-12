#define Gather_m_Servers  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example359059926/plugins/inputs/ipmi_sensor/ipmi.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int m_Servers = Gather_m_Servers;
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		Wgdef wg;
		run wgMonitor(wg);
				for(i : 0.. m_Servers-1) {
for10:			wg.Add!1;
			run Anonymous0(wg)
		};
		wg.Wait?0
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
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
