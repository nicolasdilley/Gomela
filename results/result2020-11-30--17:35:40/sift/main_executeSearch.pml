#define executeSearch_options_Cores  3
#define executeSearch_targets  1

// /tmp/clone-example804467534/sift.go
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
	Chandef global_filesChan;
	int options_Cores = executeSearch_options_Cores;
	Chandef global_resultsChan;
	int i;
	Chandef global_directoryChan;
	Chandef global_resultsDoneChan;
	int targets = executeSearch_targets;
	bool state = false;
	
	if
	:: 256 > 0 -> 
		global_filesChan.size = 256;
		run AsyncChan(global_filesChan)
	:: else -> 
		run sync_monitor(global_filesChan)
	fi;
	
	if
	:: 128 > 0 -> 
		global_directoryChan.size = 128;
		run AsyncChan(global_directoryChan)
	:: else -> 
		run sync_monitor(global_directoryChan)
	fi;
	
	if
	:: 128 > 0 -> 
		global_resultsChan.size = 128;
		run AsyncChan(global_resultsChan)
	:: else -> 
		run sync_monitor(global_resultsChan)
	fi;
	run sync_monitor(global_resultsDoneChan);
for10_exit:	global_directoryChan.closing!true;
	global_filesChan.closing!true;
	global_resultsChan.closing!true;
	
	if
	:: global_resultsDoneChan.async_rcv?0;
	:: global_resultsDoneChan.sync?0;
	fi;
	goto stop_process
stop_process:}

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
