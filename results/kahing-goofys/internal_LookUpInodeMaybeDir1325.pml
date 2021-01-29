#define ub_for1350_0  0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example327246016/internal/dir.go
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
	Chandef dirChan;
	Chandef errDirChan;
	Chandef errDirBlobChan;
	Chandef objectChan;
	Chandef errObjectChan;
	int num_msgs = 0;
	bool state = false;
	int i;
	

	if
	:: 1 > 0 -> 
		errObjectChan.size = 1;
		run AsyncChan(errObjectChan)
	:: else -> 
		run sync_monitor(errObjectChan)
	fi;
	

	if
	:: 2 > 0 -> 
		objectChan.size = 2;
		run AsyncChan(objectChan)
	:: else -> 
		run sync_monitor(objectChan)
	fi;
	

	if
	:: 1 > 0 -> 
		errDirBlobChan.size = 1;
		run AsyncChan(errDirBlobChan)
	:: else -> 
		run sync_monitor(errDirBlobChan)
	fi;
	run go_LookUpInodeNotDir(objectChan,errObjectChan);
	

	if
	:: true -> 
		run go_LookUpInodeNotDir(objectChan,errDirBlobChan);
		

		if
		:: true -> 
			

			if
			:: 1 > 0 -> 
				errDirChan.size = 1;
				run AsyncChan(errDirChan)
			:: else -> 
				run sync_monitor(errDirChan)
			fi;
			

			if
			:: 1 > 0 -> 
				dirChan.size = 1;
				run AsyncChan(dirChan)
			:: else -> 
				run sync_monitor(dirChan)
			fi;
			run go_LookUpInodeDir(dirChan,errDirChan)
		:: true;
		fi
	:: true;
	fi;
		for(i : 0.. ub_for1350_0) {
		for10: skip;
		do
		:: objectChan.async_rcv?state,num_msgs -> 
			goto stop_process
		:: objectChan.sync?state,num_msgs -> 
			goto stop_process
		:: errObjectChan.async_rcv?state,num_msgs -> 
			break
		:: errObjectChan.sync?state,num_msgs -> 
			break
		:: dirChan.async_rcv?state,num_msgs -> 
			

			if
			:: true -> 
				goto stop_process
			fi;
			break
		:: dirChan.sync?state,num_msgs -> 
			

			if
			:: true -> 
				goto stop_process
			fi;
			break
		:: errDirChan.async_rcv?state,num_msgs -> 
			break
		:: errDirChan.sync?state,num_msgs -> 
			break
		:: errDirBlobChan.async_rcv?state,num_msgs -> 
			break
		:: errDirBlobChan.sync?state,num_msgs -> 
			break
		od;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		for10_end: skip
	};
	for10_exit: skip
stop_process:skip
}

proctype go_LookUpInodeNotDir(Chandef c;Chandef errc) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!false,0 -> 
			errc.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: c.async_send!0;
	:: c.sync!false,0 -> 
		c.sending?state
	fi;
	stop_process: skip
}
proctype go_LookUpInodeDir(Chandef c;Chandef errc) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!false,0 -> 
			errc.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: c.async_send!0;
	:: c.sync!false,0 -> 
		c.sending?state
	fi;
	stop_process: skip
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

