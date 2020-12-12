#define assembleTable_manuals  ??
#define assembleTable_copies  ??
#define assembleTable_numManualParts  ??
#define assembleTable_uint6434111  ??
#define lb_for365_4  -1
#define ub_for365_5  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example279013930/go/nbs/aws_table_persister.go
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
	int manuals = assembleTable_manuals;
	Chandef done;
	int i;
	Chandef sent;
	int numManualParts = assembleTable_numManualParts;
	Wgdef readWg;
	Chandef failed;
	Wgdef uploadWg;
	int copies = assembleTable_copies;
	int uint6434111 = assembleTable_uint6434111;
	bool state = false;
	run wgMonitor(readWg);
		for(i : 0.. manuals-1) {
for10:		readWg.Add!1;
		run Anonymous0(sent,failed,done,readWg,uploadWg)
	};
	readWg.Wait?0;
	run sync_monitor(done);
	run sync_monitor(failed);
	run sync_monitor(sent);
	run wgMonitor(uploadWg);
		for(i : 0.. copies-1) {
for20:		uploadWg.Add!1;
		run Anonymous1(sent,failed,done,readWg,uploadWg)
	};
		for(i : uint6434111.. numManualParts-1) {
for30:		uploadWg.Add!1;
		run Anonymous2(sent,failed,done,readWg,uploadWg)
	};
for30_exit:	run Anonymous3(sent,failed,done,readWg,uploadWg);
	
	if
	:: lb_for365_4 != -2 && ub_for365_5 != -2 -> 
				for(i : lb_for365_4.. ub_for365_5) {
for40:			do
			:: sent.async_rcv?0 -> 
				break
			:: sent.sync?0 -> 
				break
			:: failed.async_rcv?0 -> 
				
				if
				:: true -> 
					done.closing!true
				:: true;
				fi;
				break
			:: failed.sync?0 -> 
				
				if
				:: true -> 
					done.closing!true
				:: true;
				fi;
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for40:			do
			:: sent.async_rcv?0 -> 
				break
			:: sent.sync?0 -> 
				break
			:: failed.async_rcv?0 -> 
				
				if
				:: true -> 
					done.closing!true
				:: true;
				fi;
				break
			:: failed.sync?0 -> 
				
				if
				:: true -> 
					done.closing!true
				:: true;
				fi;
				break
			od
		:: true -> 
			break
		od
	fi;
for40_exit:	
	if
	:: true -> 
		done.closing!true
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef sent;Chandef failed;Chandef done;Wgdef readWg;Wgdef uploadWg) {
	bool closed; 
	int i;
	bool state;
stop_process:	readWg.Add!-1
}
proctype Anonymous1(Chandef sent;Chandef failed;Chandef done;Wgdef readWg;Wgdef uploadWg) {
	bool closed; 
	int i;
	bool state;
stop_process:
}
proctype Anonymous2(Chandef sent;Chandef failed;Chandef done;Wgdef readWg;Wgdef uploadWg) {
	bool closed; 
	int i;
	bool state;
stop_process:
}
proctype Anonymous3(Chandef sent;Chandef failed;Chandef done;Wgdef readWg;Wgdef uploadWg) {
	bool closed; 
	int i;
	bool state;
	uploadWg.Wait?0;
	sent.closing!true;
	failed.closing!true;
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

