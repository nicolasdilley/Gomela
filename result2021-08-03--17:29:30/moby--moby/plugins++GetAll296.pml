// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/moby/moby/blob/5a82cee6d499e51bc903a743e4f0f205adb161a9/pkg/plugins/plugins.go#L296
#define def_var_pluginNames307  ?? // mand pluginNames line 307
typedef Chandef {
	chan sync = [0] of {bool};
	chan enq = [0] of {int};
	chan deq = [0] of {bool,int};
	chan sending = [0] of {bool};
	chan rcving = [0] of {bool};
	chan closing = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_GetAll2960 = [1] of {int};
	run GetAll296(child_GetAll2960);
	run receiver(child_GetAll2960)
stop_process:skip
}

proctype GetAll296(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousGetAll3193190 = [1] of {int};
	Wgdef wg;
	Chandef chPl_ch;
	int var_pluginNames = def_var_pluginNames307; // mand var_pluginNames
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: var_pluginNames > 0 -> 
		chPl_ch.size = var_pluginNames;
		run AsyncChan(chPl_ch)
	:: else -> 
		run sync_monitor(chPl_ch)
	fi;
	run wgMonitor(wg);
		for(i : 0.. var_pluginNames-1) {
		for10: skip;
		

		if
		:: true -> 
			

			if
			:: chPl_ch.enq!0;
			:: chPl_ch.sync!false -> 
				chPl_ch.sending!false
			fi;
			goto for10_end
		:: true;
		fi;
		wg.update!1;
		run AnonymousGetAll319319(chPl_ch,wg,child_AnonymousGetAll3193190);
		run receiver(child_AnonymousGetAll3193190);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	chPl_ch.closing!true;
	do
	:: true -> 
		num_msgs = 0;
		

		if
		:: chPl_ch.deq?state,num_msgs;
		:: chPl_ch.sync?state -> 
			chPl_ch.rcving!false
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for20: skip;
			

			if
			:: true -> 
				goto for20_end
			:: true;
			fi;
			for20_end: skip
		fi
	od;
	for20_exit: skip;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousGetAll319319(Chandef chPl_ch;Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: chPl_ch.enq!0;
	:: chPl_ch.sync!false -> 
		chPl_ch.sending!false
	fi;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype AsyncChan(Chandef ch) {
do
:: true ->
if
:: ch.closed -> 
end: if
  :: ch.num_msgs > 0 -> // cannot send on closed channel
    end4: if
    :: ch.enq?0-> // cannot send on closed channel
      assert(1 == 0)
    :: ch.closing?true -> // cannot close twice a channel
      assert(2 == 0)
    :: ch.rcving?false;
    :: ch.sending?false -> // sending state of channel (closed)
      assert(1 == 0)
    :: ch.deq!true,ch.num_msgs -> 
  		 ch.num_msgs = ch.num_msgs - 1
    fi;
  :: else ->    end5: if
    :: ch.enq?0-> // cannot send on closed channel
      assert(1 == 0)
    :: ch.closing?true -> // cannot close twice a channel
      assert(2 == 0)
    :: ch.rcving?false;
    :: ch.sending?false -> // sending state of channel (closed)
      assert(1 == 0)
    :: ch.sync!true; 
    fi;
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.deq!false,ch.num_msgs ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		    ch.closed = true
		   :: ch.rcving?false ->
 		    ch.sending?false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.enq?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.rcving?false ->
 		    ch.sending?false;
		fi;
		:: else -> 
		end3: if
		  :: ch.enq?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.deq!false,ch.num_msgs
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		     ch.closed = true
		  :: ch.rcving?false ->
 		    ch.sending?false;
		fi;
	fi;
fi;
od;
}

proctype sync_monitor(Chandef ch) {
do
:: true
if
:: ch.closed ->
end: if
  :: ch.enq?0-> // cannot send on closed channel
    assert(1 == 0)
  :: ch.closing?true -> // cannot close twice a channel
    assert(2 == 0)
  :: ch.sending?false -> // sending state of channel (closed)
    assert(1 == 0)
  :: ch.rcving?false;
  :: ch.sync!true; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.rcving?false ->
       ch.sending?false;
    :: ch.closing?true ->
      ch.closed = true
    fi;
fi;
od
stop_process:
}

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

