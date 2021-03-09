#define Gather_m_masterURLs  3
#define Gather_m_slaveURLs  1

// https://github.com/influxdata/telegraf/blob/6ed1431348c200760443c2a0422b0d54bea927ec/plugins/inputs/mesos/mesos.go#L172
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int m_slaveURLs = Gather_m_slaveURLs;
	int m_masterURLs = Gather_m_masterURLs;
	

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
		for10: skip;
		wg.Add!1;
		run go_Anonymous0(wg);
		for10_end: skip
	};
	for10_exit: skip;
		for(i : 0.. m_slaveURLs-1) {
		for20: skip;
		wg.Add!1;
		run go_Anonymous1(wg);
		for20_end: skip
	};
	for20_exit: skip;
	wg.Wait?0;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.Add!-1;
	goto stop_process;
	stop_process: skip
}
proctype go_Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.Add!-1;
	goto stop_process;
	stop_process: skip
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
bool closed;
int i;
bool state;
do
	:: wg.Add?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}

