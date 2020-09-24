#define lb_for155_0  -1
#define ub_for155_1  -1
#define lb_for296_2  -1
#define ub_for296_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example244624373/les/server_handler.go
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
	run wgMonitor(wg);
		for(i : lb_for155_0.. ub_for155_1) {
for10:		do
		:: true -> 
			break
		od;
		chan child_hhandleMsg0 = [0] of {int};
		run hhandleMsg(wg,child_hhandleMsg0);
		child_hhandleMsg0?0;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
for10_exit:	wg.Wait?0
stop_process:}

proctype hhandleMsg(Wgdef wg;chan child) {
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
	

	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			wg.Add!1;
			run Anonymous1()
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
			wg.Add!1;
			run Anonymous2()
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
			wg.Add!1;
			run Anonymous3()
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
			wg.Add!1;
			run Anonymous4()
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
			wg.Add!1;
			run Anonymous5()
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
			wg.Add!1;
			run Anonymous6()
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
			wg.Add!1;
			run Anonymous7()
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
			wg.Add!1;
			run Anonymous8()
		:: true;
		fi
	:: true -> 
		goto stop_process
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous1() {
	bool closed; 
	int i;
	
	if
	:: lb_for296_2 != -1 && ub_for296_3 != -1 -> 
				for(i : lb_for296_2.. ub_for296_3) {
for11:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				break
			:: true;
			fi;
			

			if
			:: true;
			:: true;
			:: true;
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for11:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				break
			:: true;
			fi;
			

			if
			:: true;
			:: true;
			:: true;
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for11_exit:stop_process:
}
proctype Anonymous2() {
	bool closed; 
	int i;
	do
	:: true -> 
for12:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			break
		:: true;
		fi
	:: true -> 
		break
	od;
stop_process:
}
proctype Anonymous3() {
	bool closed; 
	int i;
	do
	:: true -> 
for13:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			break
		:: true;
		fi
	:: true -> 
		break
	od;
stop_process:
}
proctype Anonymous4() {
	bool closed; 
	int i;
	do
	:: true -> 
for14:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			break
		:: true;
		fi
	:: true -> 
		break
	od;
stop_process:
}
proctype Anonymous5() {
	bool closed; 
	int i;
	do
	:: true -> 
for15:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true;
		:: true;
		fi;
		
		if
		:: true -> 
			break
		:: true;
		fi
	:: true -> 
		break
	od;
stop_process:
}
proctype Anonymous6() {
	bool closed; 
	int i;
	do
	:: true -> 
for16:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			break
		:: true;
		fi
	:: true -> 
		break
	od;
stop_process:
}
proctype Anonymous7() {
	bool closed; 
	int i;
	do
	:: true -> 
for17:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		break
	od;
stop_process:
}
proctype Anonymous8() {
	bool closed; 
	int i;
	do
	:: true -> 
for18:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		break
	od;
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
