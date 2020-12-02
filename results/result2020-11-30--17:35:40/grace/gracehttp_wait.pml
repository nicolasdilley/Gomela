#define wait_a_sds  0

// /tmp/clone-example603874129/gracehttp/http.go
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
		run AsyncChan(ch)
	:: else -> 
		run sync_monitor(ch)
	fi;
	do
	:: ch!0 -> 
		break
	:: true -> 
		break
	od;
	do
	:: true -> 
for10:		
		if
		:: ch.async_rcv?0;
		:: ch.sync?0;
		fi;
		

		if
		:: true -> 
			break
		fi
	od;
for10_exit:stop_process:
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
