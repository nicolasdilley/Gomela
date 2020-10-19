#define wait_a_sds  60
#define lb_for105_1  -1
#define ub_for105_2  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example016666533/gracehttp/http.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int a_sds = wait_a_sds;
	bool state = false;
	run wgMonitor(wg);
	wg.Add!a_sds * 2;
	run go_asignalHandler(wg);
		for(i : 1.. a_sds) {
for20:		run Anonymous3(wg)
	};
	wg.Wait?0
stop_process:}

proctype go_asignalHandler(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	Chandef ch;
	
	if
	:: 10 > 0 -> 
		ch.size = 10;
		run emptyChan(ch)
	:: else -> 
		run sync_monitor(ch)
	fi;
	do
	:: true -> 
for10:		
		if
		:: ch.async_rcv?0;
		:: ch.sync?0;
		fi;
		

		if
		:: true -> 
			chan child_aterm0 = [0] of {int};
			run aterm(wg,child_aterm0);
			child_aterm0?0;
			goto stop_process
		:: true;
		fi
	od;
for10_exit:stop_process:
}
proctype aterm(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
		for(i : 1.. a_sds) {
for11:		run Anonymous2()
	};
	child!0;
stop_process:
}
proctype Anonymous2() {
	bool closed; 
	int i;
	bool state;
stop_process:
}
proctype Anonymous3(Wgdef wg) {
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
	od;
stop_process:
}
