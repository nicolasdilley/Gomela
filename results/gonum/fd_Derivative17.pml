#define Derivative_formula_Stencil  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example306907566/diff/fd/derivative.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int formula_Stencil = Derivative_formula_Stencil;
	Wgdef wg;
	int i;
	
	if
	:: true -> 
				for(i : 0.. formula_Stencil-1) {
for10:
		};
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
		for(i : 0.. formula_Stencil-1) {
for20:		wg.Add!1;
		run Anonymous0(wg)
	};
	wg.Wait?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
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
