#define ParseSpecFiles_limit  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example222538930/parser/parse.go
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
	Chandef piChan;
	bool state = false;
	int i;
	int limit = ParseSpecFiles_limit;
	run sync_monitor(piChan);
	run go_parseSpecFiles(piChan,limit);
	do
	:: piChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			

			if
			:: piChan.async_rcv?0;
			:: piChan.sync?0;
			fi;
			for20: skip;
			for20_end: skip
		fi
	od;
	for20_exit: skip;
	goto stop_process
stop_process:skip
}

proctype go_parseSpecFiles(Chandef piChan;int limit) {
	bool closed; 
	int i;
	bool state;
	Wgdef wg;
	run wgMonitor(wg);
		for(i : 0.. limit-1) {
		for10: skip;
		wg.Add!1;
		run go_parse(wg,piChan);
		for10_end: skip
	};
	for10_exit: skip;
	wg.Wait?0;
	piChan.closing!true;
	stop_process: skip
}
proctype go_parse(Wgdef wg;Chandef piChan) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
		for11: skip;
		

		if
		:: true -> 
			

			if
			:: piChan.async_send!0;
			:: piChan.sync!0 -> 
				piChan.sending?0
			fi
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		fi;
		for11_end: skip
	od;
	for11_exit: skip;
	stop_process: skip;
	wg.Add!-1
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

