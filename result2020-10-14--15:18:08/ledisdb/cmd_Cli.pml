#define Cli_args  60
#define lb_for198_1  -1
#define ub_for198_2  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example937833009/cmd/cli.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef c_wg;
	int i;
	int args = Cli_args;
	bool state = false;
	run wgMonitor(c_wg);
	do
	:: true -> 
for10:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
						for(i : 1.. args) {
for11:
			}
		:: true -> 
						for(i : 1.. args) {
for11:
			}
		fi
	od;
for10_exit:
stop_process:}

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
