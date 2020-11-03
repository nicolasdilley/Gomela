#define processJob_srcList 1
#define processJob_srcOnly 0
#define processJob_dstOnly 1
#define processJob_matches 0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example640579557/fs/march/march.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int srcList = processJob_srcList;
	int i;
	int dstOnly = processJob_dstOnly;
	Wgdef wg;
	int srcOnly = processJob_srcOnly;
	int matches = processJob_matches;
	bool state = false;
	run wgMonitor(wg);
	
	if
	:: true -> 
		wg.Add!1;
		run Anonymous0(wg)
	:: true;
	fi;
	
	if
	:: true -> 
		wg.Add!1;
		run Anonymous1(wg)
	:: true;
	fi;
	wg.Wait?0;
	
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
		fi
	fi;
	
	if
	:: true -> 
				for(i : 0.. srcList-1) {
for10:
		}
	:: true;
	fi;
		for(i : 0.. srcOnly-1) {
for20:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
		for(i : 0.. dstOnly-1) {
for30:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
		for(i : 0.. matches-1) {
for40:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
	goto stop_process
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

