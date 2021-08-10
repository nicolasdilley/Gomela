// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/valyala/fasthttp/blob/19fcd408632d6dae8425ae95c6c62a25c823ff81/stackless/func_test.go#L27
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
	run TestNewFuncMulti27(child_TestNewFuncMulti270);
	run receiver(child_TestNewFuncMulti270)
stop_process:skip
}

proctype TestNewFuncMulti27(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestNewFuncMulti51381 = [1] of {int};
	Chandef f2Done_ch;
	chan child_AnonymousTestNewFuncMulti39380 = [1] of {int};
	Chandef f1Done_ch;
	

	if
	:: 1 > 0 -> 
		f1Done_ch.size = 1;
		run AsyncChan(f1Done_ch)
	:: else -> 
		run sync_monitor(f1Done_ch)
	fi;
	run AnonymousTestNewFuncMulti3938(f1Done_ch,child_AnonymousTestNewFuncMulti39380);
	run receiver(child_AnonymousTestNewFuncMulti39380);
	

	if
	:: 1 > 0 -> 
		f2Done_ch.size = 1;
		run AsyncChan(f2Done_ch)
	:: else -> 
		run sync_monitor(f2Done_ch)
	fi;
	run AnonymousTestNewFuncMulti5138(f1Done_ch,f2Done_ch,child_AnonymousTestNewFuncMulti51381);
	run receiver(child_AnonymousTestNewFuncMulti51381);
	do
	:: f1Done_ch.deq?state,num_msgs -> 
		break
	:: f1Done_ch.sync?state -> 
		f1Done_ch.rcving!false;
		break
	:: true -> 
		break
	od;
	for30_exit: skip;
	for30_end: skip;
	do
	:: f2Done_ch.deq?state,num_msgs -> 
		break
	:: f2Done_ch.sync?state -> 
		f2Done_ch.rcving!false;
		break
	:: true -> 
		break
	od;
	for40_exit: skip;
	for40_end: skip;
	stop_process: skip;
	child!0
}
proctype AnonymousTestNewFuncMulti3938(Chandef f1Done_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_iterations = -2; // opt var_iterations
	

	if
	:: f1Done_ch.enq!0;
	:: f1Done_ch.sync!false -> 
		f1Done_ch.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestNewFuncMulti5138(Chandef f1Done_ch;Chandef f2Done_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_iterations = -2; // opt var_iterations
	

	if
	:: f2Done_ch.enq!0;
	:: f2Done_ch.sync!false -> 
		f2Done_ch.sending!false
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
