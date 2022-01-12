// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/sirupsen/logrus/blob//logrus_test.go#L705
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestLogLevelEnabled7050 = [1] of {int};
	run TestLogLevelEnabled705(child_TestLogLevelEnabled7050);
	run receiver(child_TestLogLevelEnabled7050)
stop_process:skip
}

proctype TestLogLevelEnabled705(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_IsLevelEnabled37355 = [1] of {int};
	chan child_IsLevelEnabled37354 = [1] of {int};
	chan child_IsLevelEnabled37353 = [1] of {int};
	chan child_IsLevelEnabled37352 = [1] of {int};
	chan child_IsLevelEnabled37351 = [1] of {int};
	chan child_IsLevelEnabled37350 = [1] of {int};
	chan child_IsLevelEnabled37349 = [1] of {int};
	chan child_SetLevel35648 = [1] of {int};
	chan child_IsLevelEnabled37347 = [1] of {int};
	chan child_IsLevelEnabled37346 = [1] of {int};
	chan child_IsLevelEnabled37345 = [1] of {int};
	chan child_IsLevelEnabled37344 = [1] of {int};
	chan child_IsLevelEnabled37343 = [1] of {int};
	chan child_IsLevelEnabled37342 = [1] of {int};
	chan child_IsLevelEnabled37341 = [1] of {int};
	chan child_SetLevel35640 = [1] of {int};
	chan child_IsLevelEnabled37339 = [1] of {int};
	chan child_IsLevelEnabled37338 = [1] of {int};
	chan child_IsLevelEnabled37337 = [1] of {int};
	chan child_IsLevelEnabled37336 = [1] of {int};
	chan child_IsLevelEnabled37335 = [1] of {int};
	chan child_IsLevelEnabled37334 = [1] of {int};
	chan child_IsLevelEnabled37333 = [1] of {int};
	chan child_SetLevel35632 = [1] of {int};
	chan child_IsLevelEnabled37331 = [1] of {int};
	chan child_IsLevelEnabled37330 = [1] of {int};
	chan child_IsLevelEnabled37329 = [1] of {int};
	chan child_IsLevelEnabled37328 = [1] of {int};
	chan child_IsLevelEnabled37327 = [1] of {int};
	chan child_IsLevelEnabled37326 = [1] of {int};
	chan child_IsLevelEnabled37325 = [1] of {int};
	chan child_SetLevel35624 = [1] of {int};
	chan child_IsLevelEnabled37323 = [1] of {int};
	chan child_IsLevelEnabled37322 = [1] of {int};
	chan child_IsLevelEnabled37321 = [1] of {int};
	chan child_IsLevelEnabled37320 = [1] of {int};
	chan child_IsLevelEnabled37319 = [1] of {int};
	chan child_IsLevelEnabled37318 = [1] of {int};
	chan child_IsLevelEnabled37317 = [1] of {int};
	chan child_SetLevel35616 = [1] of {int};
	chan child_IsLevelEnabled37315 = [1] of {int};
	chan child_IsLevelEnabled37314 = [1] of {int};
	chan child_IsLevelEnabled37313 = [1] of {int};
	chan child_IsLevelEnabled37312 = [1] of {int};
	chan child_IsLevelEnabled37311 = [1] of {int};
	chan child_IsLevelEnabled37310 = [1] of {int};
	chan child_IsLevelEnabled3739 = [1] of {int};
	chan child_SetLevel3568 = [1] of {int};
	chan child_IsLevelEnabled3737 = [1] of {int};
	chan child_IsLevelEnabled3736 = [1] of {int};
	chan child_IsLevelEnabled3735 = [1] of {int};
	chan child_IsLevelEnabled3734 = [1] of {int};
	chan child_IsLevelEnabled3733 = [1] of {int};
	chan child_IsLevelEnabled3732 = [1] of {int};
	chan child_IsLevelEnabled3731 = [1] of {int};
	chan child_SetLevel3560 = [1] of {int};
	Mutexdef log_mu_lock;
	run mutexMonitor(log_mu_lock);
	run SetLevel356(log_mu_lock,child_SetLevel3560);
	child_SetLevel3560?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled3731);
	child_IsLevelEnabled3731?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled3732);
	child_IsLevelEnabled3732?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled3733);
	child_IsLevelEnabled3733?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled3734);
	child_IsLevelEnabled3734?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled3735);
	child_IsLevelEnabled3735?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled3736);
	child_IsLevelEnabled3736?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled3737);
	child_IsLevelEnabled3737?0;
	run SetLevel356(log_mu_lock,child_SetLevel3568);
	child_SetLevel3568?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled3739);
	child_IsLevelEnabled3739?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37310);
	child_IsLevelEnabled37310?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37311);
	child_IsLevelEnabled37311?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37312);
	child_IsLevelEnabled37312?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37313);
	child_IsLevelEnabled37313?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37314);
	child_IsLevelEnabled37314?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37315);
	child_IsLevelEnabled37315?0;
	run SetLevel356(log_mu_lock,child_SetLevel35616);
	child_SetLevel35616?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37317);
	child_IsLevelEnabled37317?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37318);
	child_IsLevelEnabled37318?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37319);
	child_IsLevelEnabled37319?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37320);
	child_IsLevelEnabled37320?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37321);
	child_IsLevelEnabled37321?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37322);
	child_IsLevelEnabled37322?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37323);
	child_IsLevelEnabled37323?0;
	run SetLevel356(log_mu_lock,child_SetLevel35624);
	child_SetLevel35624?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37325);
	child_IsLevelEnabled37325?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37326);
	child_IsLevelEnabled37326?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37327);
	child_IsLevelEnabled37327?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37328);
	child_IsLevelEnabled37328?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37329);
	child_IsLevelEnabled37329?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37330);
	child_IsLevelEnabled37330?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37331);
	child_IsLevelEnabled37331?0;
	run SetLevel356(log_mu_lock,child_SetLevel35632);
	child_SetLevel35632?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37333);
	child_IsLevelEnabled37333?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37334);
	child_IsLevelEnabled37334?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37335);
	child_IsLevelEnabled37335?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37336);
	child_IsLevelEnabled37336?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37337);
	child_IsLevelEnabled37337?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37338);
	child_IsLevelEnabled37338?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37339);
	child_IsLevelEnabled37339?0;
	run SetLevel356(log_mu_lock,child_SetLevel35640);
	child_SetLevel35640?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37341);
	child_IsLevelEnabled37341?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37342);
	child_IsLevelEnabled37342?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37343);
	child_IsLevelEnabled37343?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37344);
	child_IsLevelEnabled37344?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37345);
	child_IsLevelEnabled37345?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37346);
	child_IsLevelEnabled37346?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37347);
	child_IsLevelEnabled37347?0;
	run SetLevel356(log_mu_lock,child_SetLevel35648);
	child_SetLevel35648?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37349);
	child_IsLevelEnabled37349?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37350);
	child_IsLevelEnabled37350?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37351);
	child_IsLevelEnabled37351?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37352);
	child_IsLevelEnabled37352?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37353);
	child_IsLevelEnabled37353?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37354);
	child_IsLevelEnabled37354?0;
	run IsLevelEnabled373(log_mu_lock,child_IsLevelEnabled37355);
	child_IsLevelEnabled37355?0;
	stop_process: skip;
	child!0
}
proctype SetLevel356(Mutexdef logger_mu_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype IsLevelEnabled373(Mutexdef logger_mu_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_level3511 = [1] of {int};
	run level351(logger_mu_lock,child_level3511);
	child_level3511?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype level351(Mutexdef logger_mu_lock;chan child) {
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

