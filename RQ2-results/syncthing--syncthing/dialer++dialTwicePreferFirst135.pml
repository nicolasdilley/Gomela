
// https://github.com/syncthing/syncthing/blob/master/lib/dialer/public.go#L135
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
	chan child_dialTwicePreferFirst1350 = [1] of {int};
	run dialTwicePreferFirst135(child_dialTwicePreferFirst1350)
stop_process:skip
}

proctype dialTwicePreferFirst135(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousdialTwicePreferFirst1781502 = [1] of {int};
	chan child_AnonymousdialTwicePreferFirst1571501 = [1] of {int};
	chan child_AnonymousdialTwicePreferFirst1521500 = [1] of {int};
	Chandef secondDone;
	Chandef firstDone;
	run sync_monitor(firstDone);
	run sync_monitor(secondDone);
	run AnonymousdialTwicePreferFirst152150(firstDone,secondDone,child_AnonymousdialTwicePreferFirst1521500);
	run AnonymousdialTwicePreferFirst157150(firstDone,secondDone,child_AnonymousdialTwicePreferFirst1571501);
	

	if
	:: firstDone.deq?state,num_msgs;
	:: firstDone.sync?state -> 
		firstDone.rcving!false
	fi;
	

	if
	:: true -> 
		run AnonymousdialTwicePreferFirst178150(firstDone,secondDone,child_AnonymousdialTwicePreferFirst1781502);
		goto stop_process
	:: true;
	fi;
	

	if
	:: secondDone.deq?state,num_msgs;
	:: secondDone.sync?state -> 
		secondDone.rcving!false
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousdialTwicePreferFirst152150(Chandef firstDone;Chandef secondDone;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	firstDone.closing!true;
	stop_process: skip;
	child!0
}
proctype AnonymousdialTwicePreferFirst157150(Chandef firstDone;Chandef secondDone;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: firstDone.deq?state,num_msgs -> 
		

		if
		:: true -> 
			secondDone.closing!true;
			goto stop_process
		:: true;
		fi;
		break
	:: firstDone.sync?state -> 
		firstDone.rcving!false;
		

		if
		:: true -> 
			secondDone.closing!true;
			goto stop_process
		:: true;
		fi;
		break
	:: true -> 
		secondDone.closing!true;
		goto stop_process
	:: true -> 
		break
	od;
	secondDone.closing!true;
	stop_process: skip;
	child!0
}
proctype AnonymousdialTwicePreferFirst178150(Chandef firstDone;Chandef secondDone;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: secondDone.deq?state,num_msgs;
	:: secondDone.sync?state -> 
		secondDone.rcving!false
	fi;
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

