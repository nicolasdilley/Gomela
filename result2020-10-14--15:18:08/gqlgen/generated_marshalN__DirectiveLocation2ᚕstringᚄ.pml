#define marshalN__DirectiveLocation2ᚕstringᚄ_v  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example092873566/example/starwars/generated/exec.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int v = marshalN__DirectiveLocation2ᚕstringᚄ_v;
	bool state = false;
	run wgMonitor(wg);
	
	if
	:: true -> 
		wg.Add!v
	:: true;
	fi;
		for(i : 1.. v) {
for10:
	};
	wg.Wait?0;
	goto stop_process
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
