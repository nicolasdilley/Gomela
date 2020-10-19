#define processJob_srcList  5
#define processJob_srcOnly  5
#define processJob_dstOnly  5
#define processJob_matches  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example032656846/fs/march/march.go
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
				for(i : 1.. srcList) {
for10:
		}
	:: true;
	fi;
		for(i : 1.. srcOnly) {
for20:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
		for(i : 1.. dstOnly) {
for30:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
		for(i : 1.. matches) {
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
	wg.Add!-1;
stop_process:
}
proctype Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Add!-1;
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
	od;
stop_process:
}
