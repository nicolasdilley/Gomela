// num_comm_params=2
// num_mand_comm_params=2
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//agent/agent.go#L847
#define def_var_a_Config_AggProcessors898  ?? // mand a.Config.AggProcessors line 898
#define def_var_a_Config_Processors909  ?? // mand a.Config.Processors line 909
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
	chan child_Test8470 = [1] of {int};
	run Test847(child_Test8470);
	run receiver(child_Test8470)
stop_process:skip
}

proctype Test847(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_test8821 = [1] of {int};
	chan child_AnonymousTest8528480 = [1] of {int};
	Wgdef wg;
	Chandef src_ch;
	

	if
	:: 100 > 0 -> 
		src_ch.size = 100;
		run AsyncChan(src_ch)
	:: else -> 
		run sync_monitor(src_ch)
	fi;
	run wgMonitor(wg);
	wg.update!1;
	run AnonymousTest852848(src_ch,wg,child_AnonymousTest8528480);
	run receiver(child_AnonymousTest8528480);
	run test882(src_ch,child_test8821);
	child_test8821?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	wg.wait?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousTest852848(Chandef src_ch;Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		num_msgs = 0;
		

		if
		:: src_ch.deq?state,num_msgs;
		:: src_ch.sync?state -> 
			src_ch.rcving!false
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for10: skip;
			for10_end: skip
		fi
	od;
	for10_exit: skip;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype test882(Chandef outputC_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Anonymoustest9418824 = [1] of {int};
	chan child_Anonymoustest9348823 = [1] of {int};
	chan child_Anonymoustest9268822 = [1] of {int};
	chan child_Anonymoustest9208821 = [1] of {int};
	Wgdef wg;
	int var_a_Config_Inputs = -2; // opt var_a_Config_Inputs
	int var_a_Config_Processors = def_var_a_Config_Processors909; // mand var_a_Config_Processors
	int var_a_Config_AggProcessors = def_var_a_Config_AggProcessors898; // mand var_a_Config_AggProcessors
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	run wgMonitor(wg);
	

	if
	:: true -> 
		wg.update!1;
		run Anonymoustest920882(outputC_ch,wg,child_Anonymoustest9208821);
		run receiver(child_Anonymoustest9208821);
		wg.update!1;
		run Anonymoustest926882(outputC_ch,wg,child_Anonymoustest9268822);
		run receiver(child_Anonymoustest9268822)
	:: true;
	fi;
	

	if
	:: true -> 
		wg.update!1;
		run Anonymoustest934882(outputC_ch,wg,child_Anonymoustest9348823);
		run receiver(child_Anonymoustest9348823)
	:: true;
	fi;
	wg.update!1;
	run Anonymoustest941882(outputC_ch,wg,child_Anonymoustest9418824);
	run receiver(child_Anonymoustest9418824);
	wg.wait?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Anonymoustest920882(Chandef outputC_ch;Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype Anonymoustest926882(Chandef outputC_ch;Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype Anonymoustest934882(Chandef outputC_ch;Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype Anonymoustest941882(Chandef outputC_ch;Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
		defer1: skip;
	wg.update!-1;
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

