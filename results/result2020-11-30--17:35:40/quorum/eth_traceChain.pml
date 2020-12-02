#define traceChain_threads  3
#define lb_for355_1  -1
#define ub_for355_2  -1

// /tmp/clone-example903492413/eth/api_tracer.go
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
	Chandef tasks;
	int threads = traceChain_threads;
	int reexec = -2;
	bool state = false;
	Chandef results;
	int uint6416812 = -2;
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
		
		if
		:: uint6416812 != -2 && reexec-1 != -3 -> 
						for(i : uint6416812.. reexec-1) {
for10:				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: true -> 
					break
				:: true;
				fi
			}
		:: else -> 
			do
			:: true -> 
for10:				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: true -> 
					break
				:: true;
				fi
			:: true -> 
				break
			od
		fi;
for10_exit:
	:: true;
	fi;
	
	if
	:: threads > 0 -> 
		tasks.size = threads;
		run AsyncChan(tasks)
	:: else -> 
		run sync_monitor(tasks)
	fi;
	
	if
	:: threads > 0 -> 
		results.size = threads;
		run AsyncChan(results)
	:: else -> 
		run sync_monitor(results)
	fi;
for20_exit:	run Anonymous1(tasks,results);
	run Anonymous2(tasks,results);
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef tasks;Chandef results) {
	bool closed; 
	int i;
	bool state;
	do
	:: tasks.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: tasks.async_rcv?0;
			:: tasks.sync?0;
			fi;
						for(i : 0.. task_block_Transactions21024-1) {
for22:				
				if
				:: true -> 
					break
				:: true;
				fi
			};
			do
			:: results.async_send!0 -> 
				break
			:: results.sync!0 -> 
				results.sending?0;
				break
			od
		fi
	od;
stop_process:
}
proctype Anonymous1(Chandef tasks;Chandef results) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: start_NumberU6426116 + 1 != -2 && end_NumberU6426149 != -2 -> 
				for(i : start_NumberU6426116 + 1.. end_NumberU6426149) {
for30:			do
			:: true -> 
				break
			od;
			
			if
			:: true -> 
				break
			:: true;
			fi;
			
			if
			:: true -> 
				do
				:: tasks.async_send!0 -> 
					break
				:: tasks.sync!0 -> 
					tasks.sending?0;
					break
				od
			:: true;
			fi;
			
			if
			:: true -> 
				break
			:: true;
			fi;
			
			if
			:: true -> 
				break
			:: true;
			fi;
			
			if
			:: true -> 
				break
			:: true;
			fi;
			
			if
			:: true -> 
				break
			:: true;
			fi;
			
			if
			:: true -> 
				break
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for30:			do
			:: true -> 
				break
			od;
			
			if
			:: true -> 
				break
			:: true;
			fi;
			
			if
			:: true -> 
				do
				:: tasks.async_send!0 -> 
					break
				:: tasks.sync!0 -> 
					tasks.sending?0;
					break
				od
			:: true;
			fi;
			
			if
			:: true -> 
				break
			:: true;
			fi;
			
			if
			:: true -> 
				break
			:: true;
			fi;
			
			if
			:: true -> 
				break
			:: true;
			fi;
			
			if
			:: true -> 
				break
			:: true;
			fi;
			
			if
			:: true -> 
				break
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for30_exit:stop_process:	tasks.closing!true;
	

	if
	:: true -> 
		break
	fi;
	results.closing!true
}
proctype Anonymous2(Chandef tasks;Chandef results) {
	bool closed; 
	int i;
	bool state;
	do
	:: results.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: results.async_rcv?0;
			:: results.sync?0;
			fi;
			
			if
			:: lb_for355_1 != -2 && ub_for355_2 != -2 -> 
								for(i : lb_for355_1.. ub_for355_2) {
for41:
				}
			:: else -> 
				do
				:: true -> 
for41:
				:: true -> 
					break
				od
			fi;
for41_exit:
		fi
	od;
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

