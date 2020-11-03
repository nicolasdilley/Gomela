#define newServiceReply_b 0
#define newServiceReply_rn 0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example213061294/server/accounts.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int b = newServiceReply_b;
	Wgdef s_grWG;
	int rn = newServiceReply_rn;
	bool state = false;
	run wgMonitor(s_grWG);
	
	if
	:: rn != -1 && b-1-1 != -1 -> 
				for(i : rn.. b-1-1) {
for10:
		}
	:: else -> 
		do
		:: true -> 
for10:
		:: true -> 
			break
		od
	fi;
for10_exit:	goto stop_process
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

