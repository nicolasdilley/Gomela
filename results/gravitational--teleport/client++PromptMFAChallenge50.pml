// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/gravitational/teleport/blob//lib/client/mfa.go#L50
#define def_var_numGoroutines72  ?? // mand numGoroutines line 72
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
	chan child_PromptMFAChallenge500 = [1] of {int};
	run PromptMFAChallenge50(child_PromptMFAChallenge500);
	run receiver(child_PromptMFAChallenge500)
stop_process:skip
}

proctype PromptMFAChallenge50(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousPromptMFAChallenge113721 = [1] of {int};
	chan child_AnonymousPromptMFAChallenge121722 = [1] of {int};
	chan child_AnonymousPromptMFAChallenge76720 = [1] of {int};
	Chandef respC_ch;
	int var_numGoroutines = def_var_numGoroutines72; // mand var_numGoroutines
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: var_numGoroutines > 0 -> 
		respC_ch.size = var_numGoroutines;
		run AsyncChan(respC_ch)
	:: else -> 
		run sync_monitor(respC_ch)
	fi;
	

	if
	:: true -> 
		run AnonymousPromptMFAChallenge7672(respC_ch,child_AnonymousPromptMFAChallenge76720);
		run receiver(child_AnonymousPromptMFAChallenge76720)
	fi;
	

	if
	:: true -> 
		run AnonymousPromptMFAChallenge11372(respC_ch,child_AnonymousPromptMFAChallenge113721);
		run receiver(child_AnonymousPromptMFAChallenge113721)
	:: true -> 
		run AnonymousPromptMFAChallenge12172(respC_ch,child_AnonymousPromptMFAChallenge121722);
		run receiver(child_AnonymousPromptMFAChallenge121722)
	fi;
	

	if
	:: 0 != -2 && var_numGoroutines-1 != -3 -> 
				for(i : 0.. var_numGoroutines-1) {
			for12: skip;
			do
			:: respC_ch.deq?state,num_msgs -> 
				

				if
				:: true -> 
					goto for13_end
				:: true;
				fi;
				goto stop_process
			:: respC_ch.sync?state -> 
				respC_ch.rcving!false;
				

				if
				:: true -> 
					goto for13_end
				:: true;
				fi;
				goto stop_process
			:: true -> 
				goto stop_process
			od;
			for13_exit: skip;
			for13_end: skip;
			for12_end: skip
		};
		for12_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			do
			:: respC_ch.deq?state,num_msgs -> 
				

				if
				:: true -> 
					goto for11_end
				:: true;
				fi;
				goto stop_process
			:: respC_ch.sync?state -> 
				respC_ch.rcving!false;
				

				if
				:: true -> 
					goto for11_end
				:: true;
				fi;
				goto stop_process
			:: true -> 
				goto stop_process
			od;
			for11_exit: skip;
			for11_end: skip;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousPromptMFAChallenge7672(Chandef respC_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: respC_ch.enq!0;
		:: respC_ch.sync!false -> 
			respC_ch.sending!false
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: respC_ch.enq!0;
	:: respC_ch.sync!false -> 
		respC_ch.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousPromptMFAChallenge11372(Chandef respC_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: respC_ch.enq!0;
	:: respC_ch.sync!false -> 
		respC_ch.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousPromptMFAChallenge12172(Chandef respC_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: respC_ch.enq!0;
	:: respC_ch.sync!false -> 
		respC_ch.sending!false
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

