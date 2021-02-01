#define init_hostCount  0
#define init_c_Options_HostBufferFactor  3
#define init_c_Options_EnqueueChanBuffer  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example137876708/crawler.go
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
	Chandef c_enqueue;
	Chandef c_push;
	Chandef c_push;
	Chandef c_stop;
	Wgdef c_wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int c_Options_EnqueueChanBuffer = init_c_Options_EnqueueChanBuffer;
	int c_Options_HostBufferFactor = init_c_Options_HostBufferFactor;
	int hostCount = init_hostCount;
	run wgMonitor(c_wg);
	run sync_monitor(c_stop);
	

	if
	:: true -> 
		

		if
		:: hostCount > 0 -> 
			c_push.size = hostCount;
			run AsyncChan(c_push)
		:: else -> 
			run sync_monitor(c_push)
		fi
	:: true -> 
		

		if
		:: c_Options_HostBufferFactor * hostCount > 0 -> 
			c_push.size = c_Options_HostBufferFactor * hostCount;
			run AsyncChan(c_push)
		:: else -> 
			run sync_monitor(c_push)
		fi
	fi;
	

	if
	:: c_Options_EnqueueChanBuffer > 0 -> 
		c_enqueue.size = c_Options_EnqueueChanBuffer;
		run AsyncChan(c_enqueue)
	:: else -> 
		run sync_monitor(c_enqueue)
	fi
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
