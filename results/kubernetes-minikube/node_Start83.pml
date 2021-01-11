#define Start_toEnableList  0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example986923479/pkg/minikube/node/start.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	bool state = false;
	int i;
	int starter_ExistingAddons=1;
	int config_AddonList=1;
	

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
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		

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
		fi
	:: true -> 
		

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
		fi
	fi;
	run wgMonitor(wg);
	

	if
	:: true -> 
		run go_configureMounts(wg)
	:: true;
	fi;
	wg.Add!1;
	run go_Anonymous1(wg);
	

	if
	:: true -> 
		wg.Add!1;
		run go_Start(wg,config_AddonList,starter_ExistingAddons)
	:: true;
	fi;
	wg.Add!1;
	run go_Anonymous4(wg);
	

	if
	:: true -> 
		

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
		fi
	:: true -> 
		

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
		fi
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	wg.Wait?0;
	goto stop_process
stop_process:skip
}

proctype go_configureMounts(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Add!1;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Add!-1;
	stop_process: skip
}
proctype go_Start(Wgdef wg;int additional;int toEnable) {
	bool closed; 
	int i;
	bool state;
	Wgdef awg;
	int toEnableList = Start_toEnableList;
	run wgMonitor(awg);
		for(i : 0.. toEnableList-1) {
		for40: skip;
		run go_Anonymous3(awg);
		for40_end: skip
	};
	for40_exit: skip;
	stop_process: skip
}
proctype go_Anonymous3(Wgdef awg) {
	bool closed; 
	int i;
	bool state;
	stop_process: skip
}
proctype go_Anonymous4(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Add!-1;
	stop_process: skip
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
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}


