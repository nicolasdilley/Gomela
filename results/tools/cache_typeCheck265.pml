#define typeCheck_m_compiledGoFiles  ??
#define typeCheck_m_goFiles  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example109322714/internal/lsp/cache/check.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int m_goFiles = typeCheck_m_goFiles;
	Wgdef wg;
	int i;
	int m_compiledGoFiles = typeCheck_m_compiledGoFiles;
	int rawErrors = -2;
	bool state = false;
	run wgMonitor(wg);
		for(i : 0.. m_compiledGoFiles-1) {
for20:		wg.Add!1;
		run Anonymous0(wg)
	};
		for(i : 0.. m_goFiles-1) {
for30:		wg.Add!1;
		run Anonymous1(wg)
	};
	wg.Wait?0;
	
	if
	:: true -> 
		goto stop_process
	:: true -> 
		
		if
		:: true -> 
						for(i : 0.. rawErrors-1) {
for70:
			};
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			goto stop_process
		fi
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
				for(i : 0.. rawErrors-1) {
for80:
		}
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
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
stop_process:	wg.Add!-1
}
proctype Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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
