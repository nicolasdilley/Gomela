#define Process_obj_graph_IncomingGraphVertices7221  ??
#define Process_obj_graph_OutgoingGraphVertices21321  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example582553828/engine/graph/actions.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int obj_graph_OutgoingGraphVertices21321 = Process_obj_graph_OutgoingGraphVertices21321;
	int obj_graph_IncomingGraphVertices7221 = Process_obj_graph_IncomingGraphVertices7221;
	bool state = false;
	int updated = -2;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		Wgdef wg;
		run wgMonitor(wg);
				for(i : 0.. obj_graph_IncomingGraphVertices7221-1) {
for10:			wg.Add!1;
			run Anonymous0(wg,wg)
		};
		wg.Wait?0;
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
		:: true -> 
			
			if
			:: true -> 
								for(i : 0.. updated-1) {
for20:					
					if
					:: true -> 
						break
					:: true;
					fi
				};
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true;
			fi
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
				for(i : 0.. obj_graph_OutgoingGraphVertices21321-1) {
for30:			wg.Add!1;
			run Anonymous1(wg,wg)
		};
		wg.Wait?0
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
stop_process:	wg.Add!-1
}
proctype Anonymous1(Wgdef wg;Wgdef wg) {
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
