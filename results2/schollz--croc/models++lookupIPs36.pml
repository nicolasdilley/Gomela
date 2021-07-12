// num_comm_params=2
// num_mand_comm_params=1
// num_opt_comm_params=1

// git_link=https://github.com/schollz/croc/blob/cd2802b8b524cea7ca357512632f0a1013f6f543/src/models/constants.go#L36
#define lookupIPs_publicDns  ??
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
	run lookupIPs36(child_lookupIPs360);
	run receiver(child_lookupIPs360)
stop_process:skip
}

proctype lookupIPs36(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymouslookupIPs47471 = [1] of {int};
	chan child_AnonymouslookupIPs39380 = [1] of {int};
	Chandef result_ch;
	int var_publicDns = lookupIPs_publicDns; // mand var_publicDns
	

	if
	:: var_publicDns + 1 > 0 -> 
		result_ch.size = var_publicDns + 1;
		run AsyncChan(result_ch)
	:: else -> 
		run sync_monitor(result_ch)
	fi;
	run AnonymouslookupIPs3938(result_ch,child_AnonymouslookupIPs39380);
	run receiver(child_AnonymouslookupIPs39380);
		for(i : 0.. var_publicDns-1) {
		for20: skip;
		run AnonymouslookupIPs4747(result_ch,child_AnonymouslookupIPs47471);
		run receiver(child_AnonymouslookupIPs47471);
		for20_end: skip
	};
	for20_exit: skip;
	

	if
	:: 0 != -2 && var_publicDns-1 != -3 -> 
				for(i : 0.. var_publicDns-1) {
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
proctype AnonymouslookupIPs3938(Chandef result_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_ipsips = -2; // opt var_ipsips
	

	if
	:: var_ips-1 != -3 -> 
				for(i : 0.. var_ips-1) {
			for10: skip;
			

			if
			:: result_ch.enq!0;
			:: result_ch.sync!false -> 
				result_ch.sending!false
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			

			if
			:: result_ch.enq!0;
			:: result_ch.sync!false -> 
				result_ch.sending!false
			fi;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	

	if
	:: result_ch.enq!0;
	:: result_ch.sync!false -> 
		result_ch.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymouslookupIPs4747(Chandef result_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: result_ch.enq!0;
	:: result_ch.sync!false -> 
		result_ch.sending!false
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

