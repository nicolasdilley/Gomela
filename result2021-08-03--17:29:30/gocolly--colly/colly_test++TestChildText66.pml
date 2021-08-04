// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/gocolly/colly/blob/91e0074c7c0c7a09e3d57e277a9182a82b39b04c/xmlelement_test.go#L66
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestChildText660 = [1] of {int};
	run TestChildText66(child_TestChildText660);
	run receiver(child_TestChildText660)
stop_process:skip
}

proctype TestChildText66(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewXMLElementFromHTMLNode430 = [1] of {int};
	Mutexdef resp_Ctx_lock;
	run mutexMonitor(resp_Ctx_lock);
	run NewXMLElementFromHTMLNode43(resp_Ctx_lock,child_NewXMLElementFromHTMLNode430);
	child_NewXMLElementFromHTMLNode430?0;
	stop_process: skip;
	child!0
}
proctype NewXMLElementFromHTMLNode43(Mutexdef resp_Ctx_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
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

