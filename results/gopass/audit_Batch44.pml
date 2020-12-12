#define Batch_maxJobs  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example088775668/internal/audit/audit.go
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
	Chandef checked;
	int i;
	int maxJobs = Batch_maxJobs;
	Chandef pending;
	Chandef done;
	int secret_messages = -2;
	bool state = false;
	
	if
	:: 100 > 0 -> 
		pending.size = 100;
		run AsyncChan(pending)
	:: else -> 
		run sync_monitor(pending)
	fi;
	
	if
	:: 100 > 0 -> 
		checked.size = 100;
		run AsyncChan(checked)
	:: else -> 
		run sync_monitor(checked)
	fi;
	
	if
	:: maxJobs > 0 -> 
		done.size = maxJobs;
		run AsyncChan(done)
	:: else -> 
		run sync_monitor(done)
	fi;
for10_exit:	run Anonymous1(pending,checked,done);
	run Anonymous2(pending,checked,done);
	do
	:: checked.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: checked.async_rcv?0;
			:: checked.sync?0;
			fi;
						for(i : 0.. secret_messages-1) {
for41:
			};
			
			if
			:: true -> 
				break
			:: true;
			fi
		fi
	od;
	goto stop_process
stop_process:}

proctype go_auditaudit(Chandef secrets;Chandef checked;Chandef done) {
	bool closed; 
	int i;
	bool state;
	int errs = -2;
	do
	:: secrets.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: secrets.async_rcv?0;
			:: secrets.sync?0;
			fi;
			do
			:: true -> 
				break
			od;
			
			if
			:: true -> 
				
				if
				:: checked.async_send!0;
				:: checked.sync!0 -> 
					checked.sending?0
				fi
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: checked.async_send!0;
				:: checked.sync!0 -> 
					checked.sending?0
				fi
			:: true;
			fi;
			
			if
			:: true -> 
								for(i : 0.. errs-1) {
for12:
				};
				
				if
				:: checked.async_send!0;
				:: checked.sync!0 -> 
					checked.sending?0
				fi
			:: true;
			fi;
			
			if
			:: checked.async_send!0;
			:: checked.sync!0 -> 
				checked.sending?0
			fi
		fi
	od;
	
	if
	:: done.async_send!0;
	:: done.sync!0 -> 
		done.sending?0
	fi;
stop_process:
}
proctype Anonymous1(Chandef pending;Chandef checked;Chandef done) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for20:		
		if
		:: pending.async_send!0;
		:: pending.sync!0 -> 
			pending.sending?0
		fi
	:: true -> 
		break
	od;
	pending.closing!true;
stop_process:
}
proctype Anonymous2(Chandef pending;Chandef checked;Chandef done) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: 0 != -2 && maxJobs-1 != -3 -> 
				for(i : 0.. maxJobs-1) {
for30:			
			if
			:: done.async_rcv?0;
			:: done.sync?0;
			fi
		}
	:: else -> 
		do
		:: true -> 
for30:			
			if
			:: done.async_rcv?0;
			:: done.sync?0;
			fi
		:: true -> 
			break
		od
	fi;
for30_exit:	checked.closing!true;
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

