#define m_compiledGoFiles  5
#define m_goFiles  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example207211691/internal/lsp/cache/check.go
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
	do
	:: true -> 
for10:
	:: true -> 
		break
	od;
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
	do
	:: true -> 
for40:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		break
	od;
	do
	:: true -> 
for50:
	:: true -> 
		break
	od;
	do
	:: true -> 
for60:
	:: true -> 
		break
	od;
	
	if
	:: true -> 
		goto stop_process
	:: true -> 
		
		if
		:: true -> 
			do
			:: true -> 
for70:
			:: true -> 
				break
			od;
			
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
		do
		:: true -> 
for80:
		:: true -> 
			break
		od
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
