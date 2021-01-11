
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example217529528/service/service.go
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
	Wgdef s_doneGroup;
	Chandef s_doneChan;
	Chandef c;
	Wgdef bindWait;
	bool state = false;
	int i;
	run wgMonitor(bindWait);
	bindWait.Add!1;
	run go_listen(bindWait);
	

	if
	:: 1 > 0 -> 
		c.size = 1;
		run AsyncChan(c)
	:: else -> 
		run sync_monitor(c)
	fi;
	run go_watchSignals(c);
	

	if
	:: 1 > 0 -> 
		s_doneChan.size = 1;
		run AsyncChan(s_doneChan)
	:: else -> 
		run sync_monitor(s_doneChan)
	fi;
	bindWait.Wait?0;
	run wgMonitor(s_doneGroup);
	run go_Anonymous2(c,s_doneChan,bindWait,s_doneGroup);
	goto stop_process
stop_process:skip
}

proctype go_listen(Wgdef bindWait) {
	bool closed; 
	int i;
	bool state;
	bindWait.Add!-1;
	stop_process: skip
}
proctype go_watchSignals(Chandef c) {
	bool closed; 
	int i;
	bool state;
	do
	:: c.async_send!0 -> 
		break
	:: c.sync!0 -> 
		c.sending?0;
		break
	:: true -> 
		break
	od;
	do
	:: true -> 
		for20: skip;
		do
		:: c.async_rcv?0 -> 
			break
		:: c.sync?0 -> 
			break
		od;
		for20_end: skip
	od;
	for20_exit: skip;
	stop_process: skip
}
proctype go_Anonymous2(Chandef c;Chandef s_doneChan;Wgdef bindWait;Wgdef s_doneGroup) {
	bool closed; 
	int i;
	bool state;
	s_doneGroup.Add!-1;
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

