
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example281999128/proxy/server/conn_query.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int rs = 5;
	Wgdef wg;
	bool state = false;
	int execSqls = 5;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	wg.Add!conns;
		for(i : 1.. sqls) {
for10:
	};
		for(i : 1.. conns) {
for20:
	};
	wg.Wait?0;
		for(i : 1.. rs) {
for30:		
		if
		:: true -> 
			break
		:: true;
		fi
	};
	goto stop_process
stop_process:}

proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
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
