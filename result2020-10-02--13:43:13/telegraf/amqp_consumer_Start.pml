#define lb_for238_0  -1
#define ub_for238_1  -1
#define lb_for245_2  -1
#define ub_for245_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example070058214/plugins/inputs/amqp_consumer/amqp_consumer.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef a_wg;
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(a_wg);
	run Anonymous0();
	run Anonymous1();
	goto stop_process
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
stop_process:
}
proctype Anonymous1() {
	bool closed; 
	int i;
stop_process:
}
proctype Anonymous1() {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			break
		:: true;
		fi;
				for(i : lb_for245_2.. ub_for245_3) {
for11:			run Anonymous1();
			break
		};
for11_exit:
	od;
for10_exit:stop_process:
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
