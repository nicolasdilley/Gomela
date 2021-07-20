// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/prometheus/prometheus/blob/27b78c336e436e9eed8b55ab0b162b888ec641d8/tsdb/wal.go#L867
#define ub_for915_2  -2
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
	chan child_Read8670 = [1] of {int};
	run Read867(child_Read8670);
	run receiver(child_Read8670)
stop_process:skip
}

proctype Read867(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousRead8848810 = [1] of {int};
	Chandef datac_ch;
	Chandef donec_ch;
	int var_s_Intervalss_Intervals = -2; // opt var_s_Intervalss_Intervals
	int var_deletesdeletes = -2; // opt var_deletesdeletes
	int var_samplessamples = -2; // opt var_samplessamples
	int var_seriesseries = -2; // opt var_seriesseries
	run sync_monitor(donec_ch);
	

	if
	:: 100 > 0 -> 
		datac_ch.size = 100;
		run AsyncChan(datac_ch)
	:: else -> 
		run sync_monitor(datac_ch)
	fi;
	run AnonymousRead884881(donec_ch,datac_ch,child_AnonymousRead8848810);
	run receiver(child_AnonymousRead8848810);
	

	if
	:: 0 != -2 && ub_for915_2 != -2 -> 
				for(i : 0.. ub_for915_2) {
			for211: skip;
			

			if
			:: true -> 
				

				if
				:: true -> 
					break
				:: true;
				fi;
				

				if
				:: datac_ch.enq!0;
				:: datac_ch.sync!false -> 
					datac_ch.sending!false
				fi
			:: true -> 
				

				if
				:: true -> 
					break
				:: true;
				fi;
				

				if
				:: datac_ch.enq!0;
				:: datac_ch.sync!false -> 
					datac_ch.sending!false
				fi
			:: true -> 
				

				if
				:: true -> 
					break
				:: true;
				fi;
				

				if
				:: datac_ch.enq!0;
				:: datac_ch.sync!false -> 
					datac_ch.sending!false
				fi
			fi;
			for211_end: skip
		};
		for211_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: true -> 
				

				if
				:: true -> 
					break
				:: true;
				fi;
				

				if
				:: datac_ch.enq!0;
				:: datac_ch.sync!false -> 
					datac_ch.sending!false
				fi
			:: true -> 
				

				if
				:: true -> 
					break
				:: true;
				fi;
				

				if
				:: datac_ch.enq!0;
				:: datac_ch.sync!false -> 
					datac_ch.sending!false
				fi
			:: true -> 
				

				if
				:: true -> 
					break
				:: true;
				fi;
				

				if
				:: datac_ch.enq!0;
				:: datac_ch.sync!false -> 
					datac_ch.sending!false
				fi
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	datac_ch.closing!true;
	

	if
	:: donec_ch.deq?state,num_msgs;
	:: donec_ch.sync?state -> 
		donec_ch.rcving!false
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
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousRead884881(Chandef donec_ch;Chandef datac_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		num_msgs = 0;
		

		if
		:: datac_ch.deq?state,num_msgs;
		:: datac_ch.sync?state -> 
			datac_ch.rcving!false
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for10: skip;
			

			if
			:: true;
			:: true;
			:: true;
			:: true;
			fi;
			for10_end: skip
		fi
	od;
	for10_exit: skip;
		defer1: skip;
	donec_ch.closing!true;
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

