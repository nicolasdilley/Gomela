#define lb_for4519_0  -1
#define ub_for4519_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example982303966/rpcserver.go
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
	Chandef errChan;
	int i;
	Wgdef wg;
	Chandef payChan;
	Chandef htlcSema;
	Chandef reqQuit;
	bool state = false;
	run sync_monitor(payChan);
	
	if
	:: 1 > 0 -> 
		errChan.size = 1;
		run AsyncChan(errChan)
	:: else -> 
		run sync_monitor(errChan)
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: 2000 > 0 -> 
		htlcSema.size = 2000;
		run AsyncChan(htlcSema)
	:: else -> 
		run sync_monitor(htlcSema)
	fi;
	
	if
	:: 0 != -2 && 2000-1 != -3 -> 
				for(i : 0.. 2000-1) {
for10:			
			if
			:: htlcSema.async_send!0;
			:: htlcSema.sync!0 -> 
				htlcSema.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: htlcSema.async_send!0;
			:: htlcSema.sync!0 -> 
				htlcSema.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	run wgMonitor(wg);
	run sync_monitor(reqQuit);
	wg.Add!1;
	run Anonymous0(payChan,errChan,htlcSema,reqQuit,wg);
sendLoop:			for(i : lb_for4519_0.. ub_for4519_1) {
for30:		do
		:: errChan.async_rcv?0 -> 
			goto stop_process
		:: errChan.sync?0 -> 
			goto stop_process
		:: payChan.async_rcv?0 -> 
			
			if
			:: true -> 
				goto sendLoop
			:: true;
			fi;
			wg.Add!1;
			run Anonymous1(payChan,errChan,htlcSema,reqQuit,wg);
			break
		:: payChan.sync?0 -> 
			
			if
			:: true -> 
				goto sendLoop
			:: true;
			fi;
			wg.Add!1;
			run Anonymous1(payChan,errChan,htlcSema,reqQuit,wg);
			break
		od
	};
for30_exit:;
	wg.Wait?0;
	goto stop_process;
	reqQuit.closing!true
stop_process:}

proctype Anonymous0(Chandef payChan;Chandef errChan;Chandef htlcSema;Chandef reqQuit;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for20:		do
		:: reqQuit.async_rcv?0 -> 
			goto stop_process
		:: reqQuit.sync?0 -> 
			goto stop_process
		:: true -> 
			
			if
			:: true -> 
				payChan.closing!true;
				goto stop_process
			:: true -> 
				
				if
				:: true -> 
					do
					:: errChan.async_send!0 -> 
						break
					:: errChan.sync!0 -> 
						errChan.sending?0;
						break
					:: true -> 
						break
					od;
					goto stop_process
				:: true;
				fi
			fi;
			
			if
			:: true -> 
				
				if
				:: true -> 
					do
					:: errChan.async_send!0 -> 
						break
					:: errChan.sync!0 -> 
						errChan.sending?0;
						break
					:: true -> 
						break
					od;
					goto stop_process
				:: true;
				fi
			:: true;
			fi;
			do
			:: payChan.async_send!0 -> 
				break
			:: payChan.sync!0 -> 
				payChan.sending?0;
				break
			:: reqQuit.async_rcv?0 -> 
				goto stop_process
			:: reqQuit.sync?0 -> 
				goto stop_process
			od;
			break
		od
	od;
for20_exit:stop_process:	wg.Add!-1
}
proctype Anonymous1(Chandef payChan;Chandef errChan;Chandef htlcSema;Chandef reqQuit;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: htlcSema.async_rcv?0 -> 
		break
	:: htlcSema.sync?0 -> 
		break
	:: reqQuit.async_rcv?0 -> 
		goto stop_process
	:: reqQuit.sync?0 -> 
		goto stop_process
	od;
	
	if
	:: true -> 
		
		if
		:: errChan.async_send!0;
		:: errChan.sync!0 -> 
			errChan.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		do
		:: errChan.async_send!0 -> 
			break
		:: errChan.sync!0 -> 
			errChan.sending?0;
			break
		:: true -> 
			break
		od;
		goto stop_process
	:: true;
	fi;
stop_process:	wg.Add!-1;
	
	if
	:: htlcSema.async_send!0;
	:: htlcSema.sync!0 -> 
		htlcSema.sending?0
	fi
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

