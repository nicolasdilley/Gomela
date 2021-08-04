// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/helm/helm/blob/43853ea772e779b617b011a8d4e69205636fa4f9/pkg/kube/client.go#L343
#define def_var_infos  ?? // mand infos line 343
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
	chan child_perform3430 = [1] of {int};
	run perform343(def_var_infos,child_perform3430);
	run receiver(child_perform3430)
stop_process:skip
}

proctype perform343(int var_infos;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_batchPerform3600 = [1] of {int};
	Chandef errs_ch;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(errs_ch);
	run batchPerform360(errs_ch,var_infos,child_batchPerform3600);
	run receiver(child_batchPerform3600);
	

	if
	:: var_infos-1 != -3 -> 
				for(i : 0.. var_infos-1) {
			for20: skip;
			

			if
			:: errs_ch.deq?state,num_msgs;
			:: errs_ch.sync?state -> 
				errs_ch.rcving!false
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for21: skip;
			

			if
			:: errs_ch.deq?state,num_msgs;
			:: errs_ch.sync?state -> 
				errs_ch.rcving!false
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for21_end: skip
		:: true -> 
			break
		od;
		for21_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype batchPerform360(Chandef errs_ch;int var_infos;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousbatchPerform3703700 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
		for(i : 0.. var_infos-1) {
		for10: skip;
		

		if
		:: true -> 
			wg.wait?0
		:: true;
		fi;
		wg.update!1;
		run AnonymousbatchPerform370370(errs_ch,wg,child_AnonymousbatchPerform3703700);
		run receiver(child_AnonymousbatchPerform3703700);
		for10_end: skip
	};
	for10_exit: skip;
	stop_process: skip;
	child!0
}
proctype AnonymousbatchPerform370370(Chandef errs_ch;Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: errs_ch.enq!0;
	:: errs_ch.sync!false -> 
		errs_ch.sending!false
	fi;
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

