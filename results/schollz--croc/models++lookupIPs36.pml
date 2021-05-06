#define lookupIPs_publicDns  3

// https://github.com/schollz/croc/blob/master/src/models/constants.go#L36
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
	chan child_lookupIPs360 = [1] of {int};
	run lookupIPs36(child_lookupIPs360)
stop_process:skip
}

proctype lookupIPs36(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymouslookupIPs47471 = [1] of {int};
	chan child_AnonymouslookupIPs39380 = [1] of {int};
	Chandef result;
	int publicDns = lookupIPs_publicDns;
	

	if
	:: publicDns + 1 > 0 -> 
		result.size = publicDns + 1;
		run AsyncChan(result)
	:: else -> 
		run sync_monitor(result)
	fi;
	run AnonymouslookupIPs3938(result,child_AnonymouslookupIPs39380);
		for(i : 0.. publicDns-1) {
		for20: skip;
		run AnonymouslookupIPs4747(result,child_AnonymouslookupIPs47471);
		for20_end: skip
	};
	for20_exit: skip;
	

	if
	:: 0 != -2 && publicDns-1 != -3 -> 
				for(i : 0.. publicDns-1) {
			for31: skip;
			

			if
			:: result.deq?state,num_msgs;
			:: result.sync?state -> 
				result.rcving!false
			fi;
			

			if
			:: true -> 
				goto stop_process
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
			:: result.deq?state,num_msgs;
			:: result.sync?state -> 
				result.rcving!false
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for30_end: skip
		:: true -> 
			break
		od;
		for30_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymouslookupIPs3938(Chandef result;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int ips=0;
	

	if
	:: ips-1 != -3 -> 
				for(i : 0.. ips-1) {
			for10: skip;
			

			if
			:: result.enq!0;
			:: result.sync!false -> 
				result.sending!false
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			

			if
			:: result.enq!0;
			:: result.sync!false -> 
				result.sending!false
			fi;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	

	if
	:: result.enq!0;
	:: result.sync!false -> 
		result.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymouslookupIPs4747(Chandef result;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: result.enq!0;
	:: result.sync!false -> 
		result.sending!false
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


