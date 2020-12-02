#define lb_for170_0  -1
#define ub_for170_1  -1
#define lb_for184_2  -1
#define ub_for184_3  -1

// /tmp/clone-example903492413/consensus/ethash/algorithm.go
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
	Chandef done;
	int i;
	int rows = -2;
	bool state = false;
	run sync_monitor(done);
	run Anonymous0(done);
	
	if
	:: lb_for184_2 != -2 && ub_for184_3 != -2 -> 
				for(i : lb_for184_2.. ub_for184_3) {
for20:
		}
	:: else -> 
		do
		:: true -> 
for20:
		:: true -> 
			break
		od
	fi;
for20_exit:	
	if
	:: 0 != -2 && 3-1 != -3 -> 
				for(i : 0.. 3-1) {
for30:			
			if
			:: 0 != -2 && rows-1 != -3 -> 
								for(i : 0.. rows-1) {
for31:
				}
			:: else -> 
				do
				:: true -> 
for31:
				:: true -> 
					break
				od
			fi;
for31_exit:
		}
	:: else -> 
		do
		:: true -> 
for30:			
			if
			:: 0 != -2 && rows-1 != -3 -> 
								for(i : 0.. rows-1) {
for31:
				}
			:: else -> 
				do
				:: true -> 
for31:
				:: true -> 
					break
				od
			fi;
for31_exit:
		:: true -> 
			break
		od
	fi;
for30_exit:	done.closing!true
stop_process:}

proctype Anonymous0(Chandef done) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		do
		:: done.async_rcv?0 -> 
			goto stop_process
		:: done.sync?0 -> 
			goto stop_process
		:: true;
		od
	od;
for10_exit:stop_process:
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

