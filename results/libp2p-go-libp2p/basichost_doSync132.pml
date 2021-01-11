#define doSync_nmgr_nat_Mappings18520  3
#define doSync_ports  0
#define doSync_pports  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example562283484/p2p/host/basic/natmgr.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	bool state = false;
	int i;
	int pports = doSync_pports;
	int ports = doSync_ports;
	int nmgr_nat_Mappings18520 = doSync_nmgr_nat_Mappings18520;
	run wgMonitor(wg);
		for(i : 0.. nmgr_nat_Mappings18520-1) {
		for20: skip;
		

		if
		:: true -> 
			wg.Add!1;
			run go_Anonymous0(wg)
		fi;
		for20_end: skip
	};
	for20_exit: skip;
		for(i : 0.. ports-1) {
		for30: skip;
				for(i : 0.. pports-1) {
			for31: skip;
			

			if
			:: true -> 
				goto for31_end
			:: true;
			fi;
			wg.Add!1;
			run go_Anonymous1(wg);
			for31_end: skip
		};
		for31_exit: skip;
		for30_end: skip
	};
	for30_exit: skip;
	wg.Wait?0
stop_process:skip
}

proctype go_Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	stop_process: skip;
	wg.Add!-1
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
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}

