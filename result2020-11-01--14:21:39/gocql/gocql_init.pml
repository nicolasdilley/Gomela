#define init_newHosts 1
#define init_hosts 0
#define init_hostMap 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example164907271/session.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int newHosts = init_newHosts;
	bool state = false;
	int hostMap = init_hostMap;
	Wgdef wg;
	int hosts = init_hosts;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			fi
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
						for(i : 0.. newHosts-1) {
for10:
			}
		:: true;
		fi
	:: true;
	fi;
		for(i : 0.. hosts-1) {
for20:
	};
	run wgMonitor(wg);
		for(i : 0.. hostMap-1) {
for30:		wg.Add!1;
		run Anonymous0(wg)
	};
	wg.Wait?0;
	
	if
	:: true -> 
				for(i : 0.. hosts-1) {
for40:
		}
	:: true -> 
				for(i : 0.. hosts-1) {
for40:
		}
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

