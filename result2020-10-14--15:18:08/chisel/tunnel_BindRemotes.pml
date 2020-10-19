#define BindRemotes_remotes  60
#define BindRemotes_proxies  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example961284866/share/tunnel/tunnel.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int proxies = BindRemotes_proxies;
	Wgdef eg_wg;
	bool state = false;
	int remotes = BindRemotes_remotes;
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
		for(i : 1.. remotes) {
for10:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
	run wgMonitor(eg_wg);
		for(i : 1.. proxies) {
for20:
	};
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
