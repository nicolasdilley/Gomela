
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example440247525/eth/filters/filter_system.go
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
	Chandef m_install;
	Chandef m_rmLogsCh;
	Chandef m_txsCh;
	int i;
	Chandef m_uninstall;
	Chandef m_logsCh;
	Chandef m_chainCh;
	bool state = false;
	run sync_monitor(m_install);
	run sync_monitor(m_uninstall);
	
	if
	:: 4096 > 0 -> 
		m_txsCh.size = 4096;
		run AsyncChan(m_txsCh)
	:: else -> 
		run sync_monitor(m_txsCh)
	fi;
	
	if
	:: 10 > 0 -> 
		m_logsCh.size = 10;
		run AsyncChan(m_logsCh)
	:: else -> 
		run sync_monitor(m_logsCh)
	fi;
	
	if
	:: 10 > 0 -> 
		m_rmLogsCh.size = 10;
		run AsyncChan(m_rmLogsCh)
	:: else -> 
		run sync_monitor(m_rmLogsCh)
	fi;
	
	if
	:: 10 > 0 -> 
		m_chainCh.size = 10;
		run AsyncChan(m_chainCh)
	:: else -> 
		run sync_monitor(m_chainCh)
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

