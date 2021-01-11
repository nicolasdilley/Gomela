#define GetUserPolicies_groups_Groups  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example710248287/aws/services/manual_services.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Chandef errc;
	Wgdef wg;
	bool state = false;
	int i;
	run wgMonitor(wg);
	

	if
	:: 4 > 0 -> 
		errc.size = 4;
		run AsyncChan(errc)
	:: else -> 
		run sync_monitor(errc)
	fi;
	wg.Add!1;
	run go_Anonymous0(errc,wg);
	wg.Add!1;
	run go_Anonymous1(errc,wg);
	wg.Add!1;
	run go_Anonymous2(errc,wg);
	run go_Anonymous5(errc,wg);
	do
	:: errc.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			

			if
			:: errc.async_rcv?0;
			:: errc.sync?0;
			fi;
			for50: skip;
			goto stop_process;
			for50_end: skip
		fi
	od;
	for50_exit: skip;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!0 -> 
			errc.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous1(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!0 -> 
			errc.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous2(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	Wgdef wgg;
	Chandef resultC;
	int groups_Groups = GetUserPolicies_groups_Groups;
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!0 -> 
			errc.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	run sync_monitor(resultC);
	run wgMonitor(wgg);
		for(i : 0.. groups_Groups-1) {
		for30: skip;
		wgg.Add!1;
		run go_Anonymous3(resultC,errc,wgg);
		for30_end: skip
	};
	for30_exit: skip;
	run go_Anonymous4(resultC,errc,wgg);
	do
	:: resultC.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			

			if
			:: resultC.async_rcv?0;
			:: resultC.sync?0;
			fi;
			for40: skip;
			for40_end: skip
		fi
	od;
	for40_exit: skip;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous3(Chandef resultC;Chandef errc;Wgdef wgg) {
	bool closed; 
	int i;
	bool state;
	int output_AttachedPolicies = -2;
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!0 -> 
			errc.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: output_AttachedPolicies-1 != -3 -> 
				for(i : 0.. output_AttachedPolicies-1) {
			for31: skip;
			

			if
			:: resultC.async_send!0;
			:: resultC.sync!0 -> 
				resultC.sending?0
			fi;
			for31_end: skip
		};
		for31_exit: skip
	:: else -> 
		do
		:: true -> 
			for31818: skip;
			

			if
			:: resultC.async_send!0;
			:: resultC.sync!0 -> 
				resultC.sending?0
			fi;
			for31_end818: skip
		:: true -> 
			break
		od;
		for31_exit818: skip
	fi;
	stop_process: skip;
	wgg.Add!-1
}
proctype go_Anonymous4(Chandef resultC;Chandef errc;Wgdef wgg) {
	bool closed; 
	int i;
	bool state;
	wgg.Wait?0;
	resultC.closing!true;
	stop_process: skip
}
proctype go_Anonymous5(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Wait?0;
	errc.closing!true;
	stop_process: skip
}
proctype AsyncChan(Chandef ch) {
do
:: true ->
if
:: ch.closed -> 
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!0 ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false; // sending channel is open 
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.is_closed!false;
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!0
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false;  // sending channel is open
		  :: ch.sending!false;  // sending channel is open
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
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    :: ch.is_closed!false ->
    fi;
fi;
od
stop_process:
}

proctype wgMonitor(Wgdef wg) {
bool closed;
int i;
bool state;
do
	:: wg.Add?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}

