#define lb_for174_0  -1
#define ub_for174_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example792433737/pkg/operator/ceph/operator.go
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
	Chandef stopChan;
	bool state = false;
	int provisionerConfigs = -2;
	Chandef signalChan;
	Chandef mgrErrorChan;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: 1 > 0 -> 
		signalChan.size = 1;
		run AsyncChan(signalChan)
	:: else -> 
		run sync_monitor(signalChan)
	fi;
	run sync_monitor(stopChan);
	do
	:: signalChan!0 -> 
		break
	:: true -> 
		break
	od;
	
	if
	:: true -> 
				for(i : 0.. provisionerConfigs-1) {
for10:
		}
	:: true;
	fi;
	run sync_monitor(mgrErrorChan);
	run go_startManager(stopChan,mgrErrorChan);
	do
	:: true -> 
for20:		do
		:: signalChan.async_rcv?0 -> 
			chan child_cleanup0 = [0] of {int};
			run cleanup(stopChan,child_cleanup0);
			child_cleanup0?0;
			goto stop_process
		:: signalChan.sync?0 -> 
			chan child_cleanup0 = [0] of {int};
			run cleanup(stopChan,child_cleanup0);
			child_cleanup0?0;
			goto stop_process
		:: mgrErrorChan.async_rcv?0 -> 
			chan child_cleanup1 = [0] of {int};
			run cleanup(stopChan,child_cleanup1);
			child_cleanup1?0;
			goto stop_process
		:: mgrErrorChan.sync?0 -> 
			chan child_cleanup1 = [0] of {int};
			run cleanup(stopChan,child_cleanup1);
			child_cleanup1?0;
			goto stop_process
		od
	od;
for20_exit:
stop_process:}

proctype go_startManager(Chandef stopCh;Chandef mgrErrorCh) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: mgrErrorCh.async_send!0;
		:: mgrErrorCh.sync!0 -> 
			mgrErrorCh.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: mgrErrorCh.async_send!0;
		:: mgrErrorCh.sync!0 -> 
			mgrErrorCh.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: mgrErrorCh.async_send!0;
		:: mgrErrorCh.sync!0 -> 
			mgrErrorCh.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: mgrErrorCh.async_send!0;
		:: mgrErrorCh.sync!0 -> 
			mgrErrorCh.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
stop_process:
}
proctype cleanup(Chandef stopCh;chan child) {
	bool closed; 
	int i;
	bool state;
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

