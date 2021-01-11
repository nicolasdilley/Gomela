#define perform_infos  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example193809987/pkg/kube/client.go
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
	Chandef errs;
	bool state = false;
	int i;
	int infos = perform_infos;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(errs);
	run go_batchPerform(errs,infos);
	

	if
	:: infos-1 != -3 -> 
				for(i : 0.. infos-1) {
			for20: skip;
			

			if
			:: errs.async_rcv?0;
			:: errs.sync?0;
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for20363: skip;
			

			if
			:: errs.async_rcv?0;
			:: errs.sync?0;
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for20_end363: skip
		:: true -> 
			break
		od;
		for20_exit363: skip
	fi;
	goto stop_process
stop_process:skip
}

proctype go_batchPerform(Chandef errs;int infos) {
	bool closed; 
	int i;
	bool state;
	Wgdef wg;
	run wgMonitor(wg);
		for(i : 0.. infos-1) {
		for10: skip;
		

		if
		:: true -> 
			wg.Wait?0
		:: true;
		fi;
		wg.Add!1;
		run go_Anonymous1(errs,wg);
		for10_end: skip
	};
	for10_exit: skip;
	stop_process: skip
}
proctype go_Anonymous1(Chandef errs;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: errs.async_send!0;
	:: errs.sync!0 -> 
		errs.sending?0
	fi;
	wg.Add!-1;
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

