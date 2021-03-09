
// https://github.com/attic-labs/noms/blob/26620a34bc8c95812037588869d4790b5581b34d/samples/go/csv/write.go#L90
typedef Chandef {
	chan sync = [0] of {bool,int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {bool,int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}



init { 
	chan child_csvwriteValuesFromChan0 = [0] of {int};
	Chandef structChan;
	int num_msgs = 0;
	bool state = false;
	int i;
	

	if
	:: 1024 > 0 -> 
		structChan.size = 1024;
		run AsyncChan(structChan)
	:: else -> 
		run sync_monitor(structChan)
	fi;
	run go_Anonymous0(structChan);
	run csvwriteValuesFromChan(structChan,child_csvwriteValuesFromChan0);
	child_csvwriteValuesFromChan0?0
stop_process:skip
}

proctype go_Anonymous0(Chandef structChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_csvsendMapValuesToChan0 = [0] of {int};
	run csvsendMapValuesToChan(structChan,child_csvsendMapValuesToChan0);
	child_csvsendMapValuesToChan0?0;
	structChan.closing!true;
	stop_process: skip
}
proctype csvsendMapValuesToChan(Chandef structChan;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype csvwriteValuesFromChan(Chandef structChan;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		

		if
		:: structChan.async_rcv?state,num_msgs;
		:: structChan.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for10: skip;
			for10_end: skip
		fi
	od;
	for10_exit: skip;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
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
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,ch.num_msgs -> // can always receive on a closed chan
		 ch.num_msgs = ch.num_msgs - 1
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!false,ch.num_msgs ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!false,ch.num_msgs
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
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
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    fi;
fi;
od
stop_process:
}

