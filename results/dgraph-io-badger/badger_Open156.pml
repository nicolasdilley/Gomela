#define Open_opt_NumMemtables  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example363257061/db.go
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
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef db_closers_pub_waiting;
	Wgdef db_closers_valueGC_waiting;
	Wgdef db_closers_writes_waiting;
	Wgdef db_closers_memtable_waiting;
	Wgdef db_closers_compactors_waiting;
	Wgdef db_closers_updateSize_waiting;
	Wgdef db_closers_cacheHealth_waiting;
	Chandef db_writeCh;
	Chandef db_flushChan;
	int num_msgs = 0;
	bool state = false;
	int i;
	int db_imm=0;
	int opt_NumMemtables = Open_opt_NumMemtables;
	

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
		fi;
		

		if
		:: true -> 
			

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
			fi
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
	:: opt_NumMemtables > 0 -> 
		db_flushChan.size = opt_NumMemtables;
		run AsyncChan(db_flushChan)
	:: else -> 
		run sync_monitor(db_flushChan)
	fi;
	

	if
	:: 1000 > 0 -> 
		db_writeCh.size = 1000;
		run AsyncChan(db_writeCh)
	:: else -> 
		run sync_monitor(db_writeCh)
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
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	run wgMonitor(db_closers_cacheHealth_waiting);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(db_closers_updateSize_waiting);
	

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
		run wgMonitor(db_closers_compactors_waiting);
		run wgMonitor(db_closers_memtable_waiting);
		

		if
		:: db_imm-1 != -3 -> 
						for(i : 0.. db_imm-1) {
				for10: skip;
				

				if
				:: db_flushChan.async_send!0;
				:: db_flushChan.sync!false,0 -> 
					db_flushChan.sending?state
				fi;
				for10_end: skip
			};
			for10_exit: skip
		:: else -> 
			do
			:: true -> 
				for10766: skip;
				

				if
				:: db_flushChan.async_send!0;
				:: db_flushChan.sync!false,0 -> 
					db_flushChan.sending?state
				fi;
				for10_end766: skip
			:: true -> 
				break
			od;
			for10_exit766: skip
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(db_closers_writes_waiting);
	

	if
	:: true -> 
		run wgMonitor(db_closers_valueGC_waiting)
	:: true;
	fi;
	run wgMonitor(db_closers_pub_waiting);
	goto stop_process
stop_process:skip
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

proctype wgMonitor(Wgdef wg) {
bool closed;
int i;
bool state;
do
	:: wg.Add?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}


