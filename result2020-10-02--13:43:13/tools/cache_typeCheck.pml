
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example906103686/internal/lsp/cache/check.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int parseErrors = 5;
	int m_errors = 5;
	bool state = false;
	int m_goFiles = 5;
	int rawErrors = 5;
	Wgdef wg;
	int m_compiledGoFiles = 5;
	int actualErrors = 5;
	int files = 5;
	int i;
		for(i : 1.. m_errors) {
for10:
	};
	run wgMonitor(wg);
		for(i : 1.. m_compiledGoFiles) {
for20:		wg.Add!1;
		run Anonymous0(wg)
	};
		for(i : 1.. m_goFiles) {
for30:		wg.Add!1;
		run Anonymous1(wg)
	};
	wg.Wait?0;
		for(i : 1.. actualErrors) {
for40:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
		for(i : 1.. parseErrors) {
for50:
	};
		for(i : 1.. files) {
for60:
	};
	
	if
	:: true -> 
		goto stop_process
	:: true -> 
		
		if
		:: true -> 
						for(i : 1.. rawErrors) {
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
				for(i : 1.. rawErrors) {
for80:
		}
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
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
	wg.Add!-1;
stop_process:
}
proctype Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	wg.Add!-1;
stop_process:
}
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
