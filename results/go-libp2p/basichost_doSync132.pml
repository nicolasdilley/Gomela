#define doSync_nmgr_nat_Mappings18520  ??
#define doSync_ports  ??
#define doSync_pports  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example911231190/p2p/host/basic/natmgr.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int ports = doSync_ports;
	Wgdef wg;
	int i;
	int nmgr_nat_Mappings18520 = doSync_nmgr_nat_Mappings18520;
	int pports = doSync_pports;
	bool state = false;
	run wgMonitor(wg);
		for(i : 0.. nmgr_nat_Mappings18520-1) {
for20:		
		if
		:: true -> 
			wg.Add!1;
			run Anonymous0(wg)
		fi
	};
		for(i : 0.. ports-1) {
for30:				for(i : 0.. pports-1) {
for31:			wg.Add!1;
			run Anonymous1(wg)
		}
	};
	wg.Wait?0
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
stop_process:	wg.Add!-1
}
proctype Anonymous1(Wgdef wg) {
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
