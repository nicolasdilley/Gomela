#define lb_for198_0  -1
#define ub_for198_1  -1
#define lb_for244_2  -1
#define ub_for244_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example440247525/ethstats/ethstats.go
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



init { 
	Chandef txEventCh;
	int i;
	Chandef headCh;
	Chandef chainHeadCh;
	Chandef quitCh;
	Chandef txCh;
	bool state = false;
	
	if
	:: 10 > 0 -> 
		chainHeadCh.size = 10;
		run AsyncChan(chainHeadCh)
	:: else -> 
		run sync_monitor(chainHeadCh)
	fi;
	
	if
	:: 4096 > 0 -> 
		txEventCh.size = 4096;
		run AsyncChan(txEventCh)
	:: else -> 
		run sync_monitor(txEventCh)
	fi;
	run sync_monitor(quitCh);
	
	if
	:: 1 > 0 -> 
		headCh.size = 1;
		run AsyncChan(headCh)
	:: else -> 
		run sync_monitor(headCh)
	fi;
	
	if
	:: 1 > 0 -> 
		txCh.size = 1;
		run AsyncChan(txCh)
	:: else -> 
		run sync_monitor(txCh)
	fi;
	run Anonymous0(chainHeadCh,txEventCh,quitCh,headCh,txCh);
for20_exit:
stop_process:}

proctype Anonymous0(Chandef chainHeadCh;Chandef txEventCh;Chandef quitCh;Chandef headCh;Chandef txCh) {
	bool closed; 
	int i;
	bool state;
HandleLoop:		do
	:: true -> 
for10:		do
		:: chainHeadCh.async_rcv?0 -> 
			do
			:: headCh.async_send!0 -> 
				break
			:: headCh.sync!0 -> 
				headCh.sending?0;
				break
			:: true -> 
				break
			od;
			break
		:: chainHeadCh.sync?0 -> 
			do
			:: headCh.async_send!0 -> 
				break
			:: headCh.sync!0 -> 
				headCh.sending?0;
				break
			:: true -> 
				break
			od;
			break
		:: txEventCh.async_rcv?0 -> 
			do
			:: txCh.async_send!0 -> 
				break
			:: txCh.sync!0 -> 
				txCh.sending?0;
				break
			:: true -> 
				break
			od;
			break
		:: txEventCh.sync?0 -> 
			do
			:: txCh.async_send!0 -> 
				break
			:: txCh.sync!0 -> 
				txCh.sending?0;
				break
			:: true -> 
				break
			od;
			break
		od
	od;
for10_exit:;
	quitCh.closing!true;
stop_process:
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

