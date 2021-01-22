#define Process_obj_graph_IncomingGraphVertices7221  1
#define Process_obj_graph_OutgoingGraphVertices21321  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example784394314/engine/graph/actions.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int obj_graph_OutgoingGraphVertices21321 = Process_obj_graph_OutgoingGraphVertices21321;
	int obj_graph_IncomingGraphVertices7221 = Process_obj_graph_IncomingGraphVertices7221;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run wgMonitor(wg);
				for(i : 0.. obj_graph_IncomingGraphVertices7221-1) {
			for10: skip;
			

			if
			:: true -> 
				goto for10_end
			:: true;
			fi;
			wg.Add!1;
			run go_Anonymous0(wg,wg);
			for10_end: skip
		};
		for10_exit: skip;
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
			for30: skip;
			

			if
			:: true -> 
				goto for30_end
			:: true;
			fi;
			

			if
			:: true -> 
				goto for30_end
			:: true;
			fi;
			wg.Add!1;
			run go_Anonymous1(wg,wg);
			for30_end: skip
		};
		for30_exit: skip;
		wg.Wait?0
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Wgdef wg;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous1(Wgdef wg;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	wg.Add!-1
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
bool closed;
int i;
bool state;
do
	:: wg.Add?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}

