#define AURInfo_tempInfo 3
#define AURInfo_info 0
#define AURInfo_names 0
#define lb_for40_3  -1
#define ub_for40_4  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example834641366/pkg/query/aur_info.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int info = AURInfo_info;
	Wgdef wg;
	int i;
	int tempInfo = AURInfo_tempInfo;
	int names = AURInfo_names;
	bool state = false;
	run wgMonitor(wg);
		for(i : lb_for40_3.. ub_for40_4) {
for10:		wg.Add!1
	};
for10_exit:	wg.Wait?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 0.. info-1) {
for20:
	};
		for(i : 0.. names-1) {
for30:
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

