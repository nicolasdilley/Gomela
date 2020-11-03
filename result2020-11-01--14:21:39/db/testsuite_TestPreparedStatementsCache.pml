#define TestPreparedStatementsCache_limit 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example751211831/internal/testsuite/sql_suite.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int limit = TestPreparedStatementsCache_limit;
	bool state = false;
	run wgMonitor(wg);
		for(i : 0.. limit-1) {
for10:		wg.Add!1;
		run Anonymous0(wg)
	};
for10_exit:	wg.Wait?0;
	

	if
	:: true;
	:: true;
	fi;
		for(i : 0.. limit-1) {
for20:		wg.Add!1;
		run Anonymous1(wg)
	};
for20_exit:	wg.Wait?0;
		for(i : 0.. limit-1) {
for30:		wg.Add!1;
		run Anonymous2(wg)
	};
for30_exit:	wg.Wait?0
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
proctype Anonymous2(Wgdef wg) {
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

