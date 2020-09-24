#define m_masterURLs  5
#define m_slaveURLs  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example628089191/plugins/inputs/mesos/mesos.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int m_slaveURLs = 5;
	Wgdef wg;
	bool state = false;
	int m_masterURLs = 5;
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
		for(i : 1.. m_masterURLs) {
for10:		wg.Add!1;
		run Anonymous0(wg)
	};
		for(i : 1.. m_slaveURLs) {
for20:		wg.Add!1;
		run Anonymous1(wg)
	};
	wg.Wait?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	wg.Add!-1;
	goto stop_process;
stop_process:
}
proctype Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
	wg.Add!-1;
	goto stop_process;
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
