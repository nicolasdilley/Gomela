#define count92  3

// https://github.com/zyedidia/micro/blob/master/internal/config/plugin_installer.go#L92
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
	chan child_fetchAllSources920 = [1] of {int};
	run fetchAllSources92(count92,child_fetchAllSources920)
stop_process:skip
}

proctype fetchAllSources92(int count;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousfetchAllSources107962 = [1] of {int};
	chan child_AnonymousfetchAllSources1021020 = [1] of {int};
	Wgdef wgDone;
	Chandef results;
	Wgdef wgQuery;
	run wgMonitor(wgQuery);
	wgQuery.update!count;
	run sync_monitor(results);
	run wgMonitor(wgDone);
	wgDone.update!1;
		for(i : 0.. count-1) {
		for10: skip;
		run AnonymousfetchAllSources102102(results,wgDone,wgQuery,child_AnonymousfetchAllSources1021020);
		for10_end: skip
	};
	for10_exit: skip;
	run AnonymousfetchAllSources10796(results,wgQuery,wgDone,child_AnonymousfetchAllSources107962);
	wgQuery.wait?0;
	results.closing!true;
	wgDone.wait?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousfetchAllSources102102(Chandef results;Wgdef wgDone;Wgdef wgQuery;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: results.enq!0;
	:: results.sync!false -> 
		results.sending!false
	fi;
	wgQuery.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousfetchAllSources10796(Chandef results;Wgdef wgQuery;Wgdef wgDone;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		

		if
		:: results.deq?state,num_msgs;
		:: results.sync?state -> 
			results.rcving!false
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for20: skip;
			for20_end: skip
		fi
	od;
	for20_exit: skip;
	wgDone.update!-1;
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
  :: ch.enq?0-> // cannot send on closed channel
    assert(1 == 0)
  :: ch.closing?true -> // cannot close twice a channel
    assert(2 == 0)
  :: ch.rcving?false;
  :: ch.sending?false -> // sending state of channel (closed)
    assert(1 == 0)
  :: ch.sync!true -> 
		 ch.num_msgs = ch.num_msgs - 1
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

