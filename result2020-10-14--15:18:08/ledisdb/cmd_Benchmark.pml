#define Benchmark_clients  60
#define Benchmark_round  60
#define Benchmark_ts  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example937833009/cmd/benchmark.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int round = Benchmark_round;
	Wgdef client_wg;
	int i;
	int clients = Benchmark_clients;
	int ts = Benchmark_ts;
	bool state = false;
	run wgMonitor(client_wg);
	
	if
	:: 0 != -1 && clients-1 != -1 -> 
				for(i : 0.. clients-1) {
for10:
		}
	:: else -> 
		do
		:: true -> 
for10:
		:: true -> 
			break
		od
	fi;
for10_exit:	
	if
	:: 0 != -1 && round-1 != -1 -> 
				for(i : 0.. round-1) {
for20:						for(i : 1.. ts) {
for21:				

				if
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				fi
			}
		}
	:: else -> 
		do
		:: true -> 
for20:						for(i : 1.. ts) {
for21:				

				if
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				fi
			}
		:: true -> 
			break
		od
	fi;
for20_exit:
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
