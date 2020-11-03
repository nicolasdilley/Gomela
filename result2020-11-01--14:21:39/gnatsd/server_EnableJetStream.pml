#define EnableJetStream_omdirs 3
#define EnableJetStream_fis 1
#define EnableJetStream_ofis 0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example213061294/server/jetstream.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int fis = EnableJetStream_fis;
	Wgdef s_grWG;
	int i;
	int omdirs = EnableJetStream_omdirs;
	int ofis = EnableJetStream_ofis;
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
				for(i : 0.. omdirs-1) {
for10:
		}
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. fis-1) {
for20:
		}
	:: true;
	fi;
		for(i : 0.. fis-1) {
for30:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. ofis-1) {
for31:
		}
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

