// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/chrislusf/seaweedfs/blob//weed/messaging/msgclient/subscriber.go#L100
#define def_var_s_subscriberClients102  ?? // mand s.subscriberClients line 102
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_Subscribe1000 = [1] of {int};
	run Subscribe100(child_Subscribe1000);
	run receiver(child_Subscribe1000)
stop_process:skip
}

proctype Subscribe100(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousSubscribe1051050 = [1] of {int};
	Wgdef wg;
	int var_s_subscriberClients = def_var_s_subscriberClients102; // mand var_s_subscriberClients
	run wgMonitor(wg);
		for(i : 0.. var_s_subscriberClients-1) {
		for10: skip;
		

		if
		:: true -> 
			wg.update!1;
			run AnonymousSubscribe105105(wg,child_AnonymousSubscribe1051050);
			run receiver(child_AnonymousSubscribe1051050)
		:: true;
		fi;
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousSubscribe105105(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

proctype receiver(chan c) {
c?0
}

