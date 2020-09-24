
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example141763555/server/jetstream.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int fis = 5;
	Wgdef s_grWG;
	int i;
	int omdirs = 5;
	int ofis = 5;
	bool state = false;
	run wgMonitor(s_grWG);
	
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
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		do
		:: true -> 
for10:
		:: true -> 
			break
		od
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		do
		:: true -> 
for20:
		:: true -> 
			break
		od
	:: true;
	fi;
	do
	:: true -> 
for30:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		do
		:: true -> 
for31:
		:: true -> 
			break
		od
	:: true -> 
		break
	od;
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
