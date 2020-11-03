#define executeInMultiNodes_conns 0
#define executeInMultiNodes_sqls 3
#define executeInMultiNodes_execSqls 1
#define executeInMultiNodes_rs 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example766208928/proxy/server/conn_query.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int rs = executeInMultiNodes_rs;
	int sqls = executeInMultiNodes_sqls;
	bool state = false;
	int conns = executeInMultiNodes_conns;
	int execSqls = executeInMultiNodes_execSqls;
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
		for(i : 0.. sqls-1) {
for10:
	};
		for(i : 0.. conns-1) {
for20:
	};
	wg.Wait?0;
		for(i : 0.. rs-1) {
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

