#define validate_workerCount  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example887737790/validate.go
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
	Wgdef wg;
	Chandef out;
	int i;
	Chandef in;
	int workerCount = validate_workerCount;
	bool state = false;
	run sync_monitor(out);
	run sync_monitor(in);
	run Anonymous0(out,in,wg);
	run wgMonitor(wg);
		for(i : 0.. workerCount-1) {
for20:		wg.Add!1;
		run Anonymous1(out,in,wg)
	};
for20_exit:	run Anonymous2(out,in,wg);
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef out;Chandef in;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		
		if
		:: in.async_send!0;
		:: in.sync!0 -> 
			in.sending?0
		fi
	:: true -> 
		break
	od;
	in.closing!true;
stop_process:
}
proctype Anonymous1(Chandef out;Chandef in;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: in.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: in.async_rcv?0;
			:: in.sync?0;
			fi;
			
			if
			:: out.async_send!0;
			:: out.sync!0 -> 
				out.sending?0
			fi
		fi
	od;
stop_process:	wg.Add!-1
}
proctype Anonymous2(Chandef out;Chandef in;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Wait?0;
	out.closing!true;
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
end:		
		if
		:: wg.Add?i -> 
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
		fi
	od
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

