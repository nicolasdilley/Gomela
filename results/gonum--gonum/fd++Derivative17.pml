#define Derivative_formula_Stencil  3

// https://github.com/gonum/gonum/blob/090a5d652c892e8d5460a07eca1c1ddf480b04d9/diff/fd/derivative.go#L17
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int formula_Stencil = Derivative_formula_Stencil;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
		for(i : 0.. formula_Stencil-1) {
		for20: skip;
		

		if
		:: true -> 
			goto for20_end
		:: true;
		fi;
		wg.Add!1;
		run go_Anonymous0(wg);
		for20_end: skip
	};
	for20_exit: skip;
	wg.Wait?0;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	wg.Add!-1
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
bool closed;
int i;
bool state;
do
	:: wg.Add?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}

