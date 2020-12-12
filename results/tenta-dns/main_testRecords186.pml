#define testRecords_num  ??
#define testRecords_int1909  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example070518908/stresser/stresser.go
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
	Chandef work;
	int i;
	int num = testRecords_num;
	Wgdef wg;
	Chandef rc;
	int int1909 = testRecords_int1909;
	bool state = false;
	run wgMonitor(wg);
	
	if
	:: num * 50 > 0 -> 
		work.size = num * 50;
		run AsyncChan(work)
	:: else -> 
		run sync_monitor(work)
	fi;
	
	if
	:: num * 30 > 0 -> 
		rc.size = num * 30;
		run AsyncChan(rc)
	:: else -> 
		run sync_monitor(rc)
	fi;
	wg.Add!int1909;
for10_exit:	run Anonymous0(work,rc,wg);
	run Anonymous1(work,rc,wg);
	do
	:: rc.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: rc.async_rcv?0;
			:: rc.sync?0;
			fi
		fi
	od
stop_process:}

proctype Anonymous0(Chandef work;Chandef rc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Wait?0;
	rc.closing!true;
stop_process:
}
proctype Anonymous1(Chandef work;Chandef rc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: uint21012 != -2 && limit-1 != -3 -> 
				for(i : uint21012.. limit-1) {
for20:			
			if
			:: true -> 
				break
			:: true;
			fi;
			
			if
			:: work.async_send!0;
			:: work.sync!0 -> 
				work.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:			
			if
			:: true -> 
				break
			:: true;
			fi;
			
			if
			:: work.async_send!0;
			:: work.sync!0 -> 
				work.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:	work.closing!true;
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

