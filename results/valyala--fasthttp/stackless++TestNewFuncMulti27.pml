
// https://github.com/valyala/fasthttp/blob/master/stackless/func_test.go#L27
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
	chan child_TestNewFuncMulti270 = [1] of {int};
	run TestNewFuncMulti27(child_TestNewFuncMulti270)
stop_process:skip
}

proctype TestNewFuncMulti27(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestNewFuncMulti51501 = [1] of {int};
	Chandef f2Done;
	chan child_AnonymousTestNewFuncMulti39380 = [1] of {int};
	Chandef f1Done;
	

	if
	:: 1 > 0 -> 
		f1Done.size = 1;
		run AsyncChan(f1Done)
	:: else -> 
		run sync_monitor(f1Done)
	fi;
	run AnonymousTestNewFuncMulti3938(f1Done,child_AnonymousTestNewFuncMulti39380);
	

	if
	:: 1 > 0 -> 
		f2Done.size = 1;
		run AsyncChan(f2Done)
	:: else -> 
		run sync_monitor(f2Done)
	fi;
	run AnonymousTestNewFuncMulti5150(f2Done,f1Done,child_AnonymousTestNewFuncMulti51501);
	do
	:: f1Done.deq?state,num_msgs -> 
		break
	:: f1Done.sync?state -> 
		f1Done.rcving!false;
		break
	:: true -> 
		break
	od;
	do
	:: f2Done.deq?state,num_msgs -> 
		break
	:: f2Done.sync?state -> 
		f2Done.rcving!false;
		break
	:: true -> 
		break
	od;
	stop_process: skip;
	child!0
}
proctype AnonymousTestNewFuncMulti3938(Chandef f1Done;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: f1Done.enq!0;
	:: f1Done.sync!false -> 
		f1Done.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestNewFuncMulti5150(Chandef f2Done;Chandef f1Done;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: f2Done.enq!0;
	:: f2Done.sync!false -> 
		f2Done.sending!false
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

