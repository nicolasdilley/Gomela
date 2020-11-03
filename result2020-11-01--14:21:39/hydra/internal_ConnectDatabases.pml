#define ConnectDatabases_dbs 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example088505792/internal/driver.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int dbs = ConnectDatabases_dbs;
	bool state = false;
	run wgMonitor(wg);
	wg.Add!3;
	run Anonymous0();
	run Anonymous1();
	run Anonymous2();
	wg.Wait?0;
	goto stop_process
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
stop_process:
}
proctype Anonymous2() {
	bool closed; 
	int i;
	bool state;
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

