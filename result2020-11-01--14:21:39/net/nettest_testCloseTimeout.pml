#define lb_for333_0  -1
#define ub_for333_1  -1
#define lb_for341_2  -1
#define ub_for341_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example618374887/nettest/conntest.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef wg;
	bool state = false;
	run wgMonitor(wg);
	wg.Add!3;
	run Anonymous0();
	run Anonymous1();
	run Anonymous2();
	wg.Wait?0
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	bool state;
stop_process:
}
proctype Anonymous1() {
	bool closed; 
	int i;
	bool state;
	
	if
	:: lb_for333_0 != -1 && ub_for333_1 != -1 -> 
				for(i : lb_for333_0.. ub_for333_1) {
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
for10_exit:stop_process:
}
proctype Anonymous2() {
	bool closed; 
	int i;
	bool state;
	
	if
	:: lb_for341_2 != -1 && ub_for341_3 != -1 -> 
				for(i : lb_for341_2.. ub_for341_3) {
for20:
		}
	:: else -> 
		do
		:: true -> 
for20:
		:: true -> 
			break
		od
	fi;
for20_exit:stop_process:
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
