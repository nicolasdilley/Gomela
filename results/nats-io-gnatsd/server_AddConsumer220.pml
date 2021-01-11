#define AddConsumer_msetSendQSize  0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example111195339/server/consumer.go
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
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Chandef o_sendq;
	chan child_RegisterNotification0 = [0] of {int};
	Chandef o_inch;
	Chandef o_mch;
	Chandef o_qch;
	Wgdef s_grWG;
	bool state = false;
	int i;
	int msetSendQSize = AddConsumer_msetSendQSize;
	

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
			goto stop_process
		:: true;
		fi
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
			goto stop_process
		:: true;
		fi
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
			goto stop_process
		:: true;
		fi
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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(s_grWG);
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true -> 
					goto stop_process
				:: true -> 
					goto stop_process
				fi
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true -> 
					goto stop_process
				:: true -> 
					goto stop_process
				fi
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
	run sync_monitor(o_qch);
	

	if
	:: 1 > 0 -> 
		o_mch.size = 1;
		run AsyncChan(o_mch)
	:: else -> 
		run sync_monitor(o_mch)
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: 8 > 0 -> 
			o_inch.size = 8;
			run AsyncChan(o_inch)
		:: else -> 
			run sync_monitor(o_inch)
		fi;
		run RegisterNotification(o_inch,child_RegisterNotification0);
		child_RegisterNotification0?0;
		

		if
		:: o_inch.async_rcv?0;
		:: o_inch.sync?0;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: msetSendQSize > 0 -> 
		o_sendq.size = msetSendQSize;
		run AsyncChan(o_sendq)
	:: else -> 
		run sync_monitor(o_sendq)
	fi;
	goto stop_process
stop_process:skip
}

proctype RegisterNotification(Chandef notify;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_serversendNotification2 = [0] of {int};
	chan child_addRemoveNotify0 = [0] of {int};
	chan child_addInsertNotify1 = [0] of {int};
	

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
		run addRemoveNotify(notify,child_addRemoveNotify0);
		child_addRemoveNotify0?0
	:: true -> 
		run addInsertNotify(notify,child_addInsertNotify1);
		child_addInsertNotify1?0
	:: true -> 
		run addInsertNotify(notify,child_addInsertNotify1);
		child_addInsertNotify1?0
	fi;
	

	if
	:: true -> 
		run serversendNotification(notify,child_serversendNotification2);
		child_serversendNotification2?0
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype addRemoveNotify(Chandef notify;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_addNotify0 = [0] of {int};
	run addNotify(notify,child_addNotify0);
	child_addNotify0?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype addNotify(Chandef notify;chan child) {
	bool closed; 
	int i;
	bool state;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype addInsertNotify(Chandef notify;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_addNotify1 = [0] of {int};
	run addNotify(notify,child_addNotify1);
	child_addNotify1?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype serversendNotification(Chandef ch;chan child) {
	bool closed; 
	int i;
	bool state;
	do
	:: ch.async_send!0 -> 
		break
	:: ch.sync!0 -> 
		ch.sending?0;
		break
	:: true;
	od;
	stop_process: skip;
	child!0
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

