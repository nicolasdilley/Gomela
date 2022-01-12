// num_comm_params=2
// num_mand_comm_params=2
// num_opt_comm_params=0

// git_link=https://github.com/pingcap/tidb/blob//executor/checksum.go#L43
#define def_var_tasks58  ?? // mand tasks line 58
#define def_var_concurrency60  ?? // mand concurrency line 60
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



init { 
	chan child_Open430 = [1] of {int};
	run Open43(child_Open430);
	run receiver(child_Open430)
stop_process:skip
}

proctype Open43(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_checksumWorker1210 = [1] of {int};
	Chandef resultCh_ch;
	Chandef taskCh_ch;
	int var_concurrency = def_var_concurrency60; // mand var_concurrency
	int var_tasks = def_var_tasks58; // mand var_tasks
	

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
	:: var_tasks > 0 -> 
		taskCh_ch.size = var_tasks;
		run AsyncChan(taskCh_ch)
	:: else -> 
		run sync_monitor(taskCh_ch)
	fi;
	

	if
	:: var_tasks > 0 -> 
		resultCh_ch.size = var_tasks;
		run AsyncChan(resultCh_ch)
	:: else -> 
		run sync_monitor(resultCh_ch)
	fi;
		for(i : 0.. var_concurrency-1) {
		for10: skip;
		run checksumWorker121(taskCh_ch,resultCh_ch,child_checksumWorker1210);
		run receiver(child_checksumWorker1210);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: var_tasks-1 != -3 -> 
				for(i : 0.. var_tasks-1) {
			for20: skip;
			

			if
			:: taskCh_ch.enq!0;
			:: taskCh_ch.sync!false -> 
				taskCh_ch.sending!false
			fi;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for21: skip;
			

			if
			:: taskCh_ch.enq!0;
			:: taskCh_ch.sync!false -> 
				taskCh_ch.sending!false
			fi;
			for21_end: skip
		:: true -> 
			break
		od;
		for21_exit: skip
	fi;
	taskCh_ch.closing!true;
	

	if
	:: 0 != -2 && var_tasks-1 != -3 -> 
				for(i : 0.. var_tasks-1) {
			for31: skip;
			

			if
			:: resultCh_ch.deq?state,num_msgs;
			:: resultCh_ch.sync?state -> 
				resultCh_ch.rcving!false
			fi;
			

			if
			:: true -> 
				goto for31_end
			:: true;
			fi;
			for31_end: skip
		};
		for31_exit: skip
	:: else -> 
		do
		:: true -> 
			for30: skip;
			

			if
			:: resultCh_ch.deq?state,num_msgs;
			:: resultCh_ch.sync?state -> 
				resultCh_ch.rcving!false
			fi;
			

			if
			:: true -> 
				goto for30_end
			:: true;
			fi;
			for30_end: skip
		:: true -> 
			break
		od;
		for30_exit: skip
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype checksumWorker121(Chandef taskCh_ch;Chandef resultCh_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		num_msgs = 0;
		

		if
		:: taskCh_ch.deq?state,num_msgs;
		:: taskCh_ch.sync?state -> 
			taskCh_ch.rcving!false
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for11: skip;
			

			if
			:: resultCh_ch.enq!0;
			:: resultCh_ch.sync!false -> 
				resultCh_ch.sending!false
			fi;
			for11_end: skip
		fi
	od;
	for11_exit: skip;
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

proctype receiver(chan c) {
c?0
}

