
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example279013930/samples/go/csv/write.go
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
	Chandef structChan;
	int i;
	chan child_csvwriteValuesFromChan0 = [0] of {int};
	bool state = false;
	
	if
	:: 1024 > 0 -> 
		structChan.size = 1024;
		run AsyncChan(structChan)
	:: else -> 
		run sync_monitor(structChan)
	fi;
	run Anonymous0(structChan);
	run csvwriteValuesFromChan(structChan,child_csvwriteValuesFromChan0);
	child_csvwriteValuesFromChan0?0
stop_process:}

proctype Anonymous0(Chandef structChan) {
	bool closed; 
	int i;
	bool state;
	chan child_csvsendMapValuesToChan0 = [0] of {int};
	run csvsendMapValuesToChan(structChan,child_csvsendMapValuesToChan0);
	child_csvsendMapValuesToChan0?0;
	structChan.closing!true;
stop_process:
}
proctype csvwriteValuesFromChan(Chandef structChan;chan child) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:
	:: true -> 
		break
	od;
stop_process:	child!0
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

