#define Gather_d_Domains  ??
#define Gather_d_Servers  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example359059926/plugins/inputs/dns_query/dns_query.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int d_Domains = Gather_d_Domains;
	Wgdef wg;
	int d_Servers = Gather_d_Servers;
	bool state = false;
	run wgMonitor(wg);
		for(i : 0.. d_Domains-1) {
for10:				for(i : 0.. d_Servers-1) {
for11:			wg.Add!1;
			run Anonymous0(wg)
		}
	};
	wg.Wait?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
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
	od
}
