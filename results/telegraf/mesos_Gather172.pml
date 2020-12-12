#define Gather_m_masterURLs  ??
#define Gather_m_slaveURLs  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example359059926/plugins/inputs/mesos/mesos.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int m_slaveURLs = Gather_m_slaveURLs;
	Wgdef wg;
	bool state = false;
	int m_masterURLs = Gather_m_masterURLs;
	int i;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	run wgMonitor(wg);
		for(i : 0.. m_masterURLs-1) {
for10:		wg.Add!1;
		run Anonymous0(wg)
	};
		for(i : 0.. m_slaveURLs-1) {
for20:		wg.Add!1;
		run Anonymous1(wg)
	};
	wg.Wait?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Add!-1;
	goto stop_process;
stop_process:
}
proctype Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Add!-1;
	goto stop_process;
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
	od
}
