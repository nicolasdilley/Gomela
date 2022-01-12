// num_comm_params=4
// num_mand_comm_params=0
// num_opt_comm_params=4

// git_link=https://github.com/caddyserver/caddy/blob//modules/caddyhttp/reverseproxy/fastcgi/client_test.go#L121
#define def_var_posts  -2 // opt posts line 121
#define def_var_files  -2 // opt files line 121
#define def_var_p  -2 // opt pairs line 245
#define def_var_values  -2 // opt data line 513
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_sendFcgi1210 = [1] of {int};
	run sendFcgi121(def_var_posts,def_var_files,child_sendFcgi1210);
	run receiver(child_sendFcgi1210)
stop_process:skip
}

proctype sendFcgi121(int var_posts;int var_files;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close2184 = [1] of {int};
	chan child_Post4820 = [1] of {int};
	chan child_PostForm5051 = [1] of {int};
	chan child_Get4542 = [1] of {int};
	chan child_PostFile5133 = [1] of {int};
	int var_values = def_var_values;
	Mutexdef fcgi_mutex;
	run mutexMonitor(fcgi_mutex);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			run Post482(fcgi_mutex,child_Post4820);
			child_Post4820?0
		:: true -> 
			

			if
			:: true -> 
				run PostForm505(fcgi_mutex,child_PostForm5051);
				child_PostForm5051?0
			:: true -> 
				run Get454(fcgi_mutex,child_Get4542);
				child_Get4542?0
			fi
		fi
	:: true -> 
		run PostFile513(fcgi_mutex,var_values,var_files,child_PostFile5133);
		child_PostFile5133?0
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Close218(fcgi_mutex,child_Close2184);
	child_Close2184?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Post482(Mutexdef c_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Request4100 = [1] of {int};
	run Request410(c_mutex,child_Request4100);
	child_Request4100?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Request410(Mutexdef c_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Do3780 = [1] of {int};
	run Do378(c_mutex,child_Do3780);
	child_Do3780?0;
	

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
		fi
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Do378(Mutexdef c_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_newWriter3032 = [1] of {int};
	chan child_writePairs2451 = [1] of {int};
	int var_p = def_var_p;
	chan child_writeBeginRequest2400 = [1] of {int};
	run writeBeginRequest240(c_mutex,child_writeBeginRequest2400);
	child_writeBeginRequest2400?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run writePairs245(c_mutex,var_p,child_writePairs2451);
	child_writePairs2451?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run newWriter303(c_mutex,child_newWriter3032);
	child_newWriter3032?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype writeBeginRequest240(Mutexdef c_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_writeRecord2220 = [1] of {int};
	run writeRecord222(c_mutex,child_writeRecord2220);
	child_writeRecord2220?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype writeRecord222(Mutexdef c_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_mutex.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	c_mutex.Unlock!false;
	stop_process: skip;
	child!0
}
proctype writePairs245(Mutexdef c_mutex;int var_pairs;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_newWriter3031 = [1] of {int};
	run newWriter303(c_mutex,child_newWriter3031);
	child_newWriter3031?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype newWriter303(Mutexdef c_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef s_c_mutex;
	run mutexMonitor(s_c_mutex);
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype PostForm505(Mutexdef c_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Post4821 = [1] of {int};
	run Post482(c_mutex,child_Post4821);
	child_Post4821?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Get454(Mutexdef c_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Request4102 = [1] of {int};
	run Request410(c_mutex,child_Request4102);
	child_Request4102?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype PostFile513(Mutexdef c_mutex;int var_data;int var_file;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Post4823 = [1] of {int};
	int var_val = -2; // opt var_val
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Post482(c_mutex,child_Post4823);
	child_Post4823?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Close218(Mutexdef c_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype mutexMonitor(Mutexdef m) {
bool locked = false;
do
:: true ->
	if
	:: m.Counter > 0 ->
		if 
		:: m.RUnlock?false -> 
			m.Counter = m.Counter - 1;
		:: m.RLock?false -> 
			m.Counter = m.Counter + 1;
		fi;
	:: locked ->
		m.Unlock?false;
		locked = false;
	:: else ->	 end:	if
		:: m.Unlock?false ->
			assert(0==32);		:: m.Lock?false ->
			locked =true;
		:: m.RUnlock?false ->
			assert(0==32);		:: m.RLock?false ->
			m.Counter = m.Counter + 1;
		fi;
	fi;
od
}

proctype receiver(chan c) {
c?0
}

