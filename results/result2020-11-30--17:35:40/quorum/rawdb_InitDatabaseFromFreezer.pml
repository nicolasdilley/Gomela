#define InitDatabaseFromFreezer_runtime_NumCPU4539  3
#define InitDatabaseFromFreezer_runtime_NumCPU5018  1
#define lb_for52_2  -1
#define ub_for52_3  -1
#define lb_for94_4  -1
#define ub_for94_5  -1

// /tmp/clone-example903492413/core/rawdb/freezer_reinit.go
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
	bool state = false;
	int runtime_NumCPU5018 = InitDatabaseFromFreezer_runtime_NumCPU5018;
	Chandef abort;
	int uint648611 = -2;
	Chandef results;
	int runtime_NumCPU4539 = InitDatabaseFromFreezer_runtime_NumCPU4539;
	int frozen = -2;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: 4 * runtime_NumCPU4539 > 0 -> 
		results.size = 4 * runtime_NumCPU4539;
		run AsyncChan(results)
	:: else -> 
		run sync_monitor(results)
	fi;
	run sync_monitor(abort);
for10_exit:	
	if
	:: uint648611 != -2 && frozen-1 != -3 -> 
				for(i : uint648611.. frozen-1) {
for20:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: lb_for94_4 != -2 && ub_for94_5 != -2 -> 
								for(i : lb_for94_4.. ub_for94_5) {
for21:					
					if
					:: true -> 
						break
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
					fi
				}
			:: else -> 
				do
				:: true -> 
for21:					
					if
					:: true -> 
						break
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
					fi
				:: true -> 
					break
				od
			fi;
for21_exit:
		}
	:: else -> 
		do
		:: true -> 
for20:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: lb_for94_4 != -2 && ub_for94_5 != -2 -> 
								for(i : lb_for94_4.. ub_for94_5) {
for21:					
					if
					:: true -> 
						break
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
					fi
				}
			:: else -> 
				do
				:: true -> 
for21:					
					if
					:: true -> 
						break
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
					fi
				:: true -> 
					break
				od
			fi;
for21_exit:
		:: true -> 
			break
		od
	fi;
for20_exit:	goto stop_process;
	abort.closing!true
stop_process:}

proctype Anonymous0(Chandef results;Chandef abort) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for11:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
						for(i : 0.. block_Transactions6425-1) {
for12:
			}
		:: true;
		fi;
		do
		:: results.async_send!0 -> 
			break
		:: results.sync!0 -> 
			results.sending?0;
			break
		:: abort.async_rcv?0 -> 
			goto stop_process
		:: abort.sync?0 -> 
			goto stop_process
		od
	od;
for11_exit:stop_process:
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

