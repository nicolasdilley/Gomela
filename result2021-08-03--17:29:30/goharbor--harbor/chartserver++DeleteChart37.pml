// num_comm_params=2
// num_mand_comm_params=2
// num_opt_comm_params=0

// git_link=https://github.com/goharbor/harbor/blob/f8171cdf6e914a08ace62508eabef81ceacfe5a2/src/chartserver/handler_utility.go#L37
#define def_var_qSize64  ?? // mand qSize line 64
#define def_var_allVersions67  ?? // mand allVersions line 67
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
	chan child_DeleteChart370 = [1] of {int};
	run DeleteChart37(child_DeleteChart370);
	run receiver(child_DeleteChart370)
stop_process:skip
}

proctype DeleteChart37(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousDeleteChart98981 = [1] of {int};
	chan child_AnonymousDeleteChart77650 = [1] of {int};
	Chandef errWrapper_ch;
	Wgdef waitGroup;
	Chandef errChan_ch;
	Chandef tokenQueue_ch;
	int var_allVersions = def_var_allVersions67; // mand var_allVersions
	int var_qSize = def_var_qSize64; // mand var_qSize
	

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
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: var_qSize > 0 -> 
		tokenQueue_ch.size = var_qSize;
		run AsyncChan(tokenQueue_ch)
	:: else -> 
		run sync_monitor(tokenQueue_ch)
	fi;
	

	if
	:: 1 > 0 -> 
		errChan_ch.size = 1;
		run AsyncChan(errChan_ch)
	:: else -> 
		run sync_monitor(errChan_ch)
	fi;
	run wgMonitor(waitGroup);
	waitGroup.update!var_allVersions;
	

	if
	:: 0 != -2 && var_qSize-1 != -3 -> 
				for(i : 0.. var_qSize-1) {
			for11: skip;
			

			if
			:: tokenQueue_ch.enq!0;
			:: tokenQueue_ch.sync!false -> 
				tokenQueue_ch.sending!false
			fi;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			

			if
			:: tokenQueue_ch.enq!0;
			:: tokenQueue_ch.sync!false -> 
				tokenQueue_ch.sending!false
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	

	if
	:: 1 > 0 -> 
		errWrapper_ch.size = 1;
		run AsyncChan(errWrapper_ch)
	:: else -> 
		run sync_monitor(errWrapper_ch)
	fi;
	run AnonymousDeleteChart7765(errChan_ch,errWrapper_ch,tokenQueue_ch,waitGroup,child_AnonymousDeleteChart77650);
	run receiver(child_AnonymousDeleteChart77650);
		for(i : 0.. var_allVersions-1) {
		for30: skip;
		

		if
		:: tokenQueue_ch.deq?state,num_msgs;
		:: tokenQueue_ch.sync?state -> 
			tokenQueue_ch.rcving!false
		fi;
		run AnonymousDeleteChart9898(tokenQueue_ch,errChan_ch,errWrapper_ch,waitGroup,child_AnonymousDeleteChart98981);
		run receiver(child_AnonymousDeleteChart98981);
		for30_end: skip
	};
	for30_exit: skip;
	waitGroup.wait?0;
	errChan_ch.closing!true;
	

	if
	:: errWrapper_ch.deq?state,num_msgs;
	:: errWrapper_ch.sync?state -> 
		errWrapper_ch.rcving!false
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousDeleteChart7765(Chandef errChan_ch;Chandef errWrapper_ch;Chandef tokenQueue_ch;Wgdef waitGroup;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		num_msgs = 0;
		

		if
		:: errChan_ch.deq?state,num_msgs;
		:: errChan_ch.sync?state -> 
			errChan_ch.rcving!false
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
		defer1: skip;
	

	if
	:: true -> 
		

		if
		:: errWrapper_ch.enq!0;
		:: errWrapper_ch.sync!false -> 
			errWrapper_ch.sending!false
		fi
	:: true;
	fi;
	errWrapper_ch.closing!true;
	stop_process: skip;
	child!0
}
proctype AnonymousDeleteChart9898(Chandef tokenQueue_ch;Chandef errChan_ch;Chandef errWrapper_ch;Wgdef waitGroup;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errChan_ch.enq!0;
		:: errChan_ch.sync!false -> 
			errChan_ch.sending!false
		fi
	:: true;
	fi;
		defer1: skip;
	

	if
	:: tokenQueue_ch.enq!0;
	:: tokenQueue_ch.sync!false -> 
		tokenQueue_ch.sending!false
	fi;
	waitGroup.update!-1;
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

