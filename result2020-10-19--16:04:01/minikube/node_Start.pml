#define Start_assets_Addons  5
#define Start_toEnableList  5
#define Start_enabledAddons  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example510198664/pkg/minikube/node/start.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	bool state = false;
	int i;
	
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
		run go_nodeconfigureMounts(wg)
	:: true;
	fi;
	wg.Add!1;
	run Anonymous1(wg);
	
	if
	:: true -> 
		wg.Add!1;
		run go_addonsStart(wg,config_AddonList,starter_ExistingAddons)
	:: true;
	fi;
	wg.Add!1;
	run Anonymous4(wg);
	
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
stop_process:}

proctype go_nodeconfigureMounts(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Add!1;
	
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
	bool state;
	wg.Add!-1;
stop_process:
}
proctype go_addonsStart(Wgdef wg;int additional;int toEnable) {
	bool closed; 
	int i;
	bool state;
	Wgdef awg;
		for(i : 1.. assets_Addons) {
for10:
	};
		for(i : 1.. additional) {
for20:
	};
		for(i : 1.. toEnable) {
for30:
	};
	run wgMonitor(awg);
		for(i : 1.. toEnableList) {
for40:		run Anonymous3(awg)
	};
		for(i : 1.. enabledAddons) {
for50:
	};
stop_process:
}
proctype Anonymous3(Wgdef awg) {
	bool closed; 
	int i;
	bool state;
stop_process:
}
proctype Anonymous4(Wgdef wg) {
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
