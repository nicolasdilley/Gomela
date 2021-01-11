#define runCopy_copy_concurrenctFiles  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example510331850/weed/command/filer_copy.go
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
	Chandef fileCopyTaskChan;
	bool state = false;
	int i;
	int copy_concurrenctFiles = runCopy_copy_concurrenctFiles;
	

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
			

			if
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
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
	

	if
	:: copy_concurrenctFiles > 0 -> 
		fileCopyTaskChan.size = copy_concurrenctFiles;
		run AsyncChan(fileCopyTaskChan)
	:: else -> 
		run sync_monitor(fileCopyTaskChan)
	fi;
	run go_Anonymous0(fileCopyTaskChan);
		for(i : 0.. copy_concurrenctFiles-1) {
		for20: skip;
		run go_Anonymous2(fileCopyTaskChan);
		for20_end: skip
	};
	for20_exit: skip;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef fileCopyTaskChan) {
	bool closed; 
	int i;
	bool state;
	chan child_commandgenFileCopyTask0 = [0] of {int};
	chan child_commandgenFileCopyTask0 = [0] of {int};
	int fileOrDirs = -2;
	

	if
	:: fileOrDirs-1 != -3 -> 
				for(i : 0.. fileOrDirs-1) {
			for10: skip;
			run commandgenFileCopyTask(fileCopyTaskChan,child_commandgenFileCopyTask0);
			child_commandgenFileCopyTask0?0;
			

			if
			:: true -> 
				break
			:: true;
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for10590: skip;
			run commandgenFileCopyTask(fileCopyTaskChan,child_commandgenFileCopyTask0);
			child_commandgenFileCopyTask0?0;
			

			if
			:: true -> 
				break
			:: true;
			fi;
			for10_end590: skip
		:: true -> 
			break
		od;
		for10_exit590: skip
	fi;
	stop_process: skip;
	fileCopyTaskChan.closing!true
}
proctype commandgenFileCopyTask(Chandef fileCopyTaskChan;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_commandgenFileCopyTask0 = [0] of {int};
	chan child_commandgenFileCopyTask0 = [0] of {int};
	int files = -2;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: files-1 != -3 -> 
						for(i : 0.. files-1) {
				for11: skip;
				run commandgenFileCopyTask(fileCopyTaskChan,child_commandgenFileCopyTask0);
				child_commandgenFileCopyTask0?0;
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				for11_end: skip
			};
			for11_exit: skip
		:: else -> 
			do
			:: true -> 
				for11589: skip;
				run commandgenFileCopyTask(fileCopyTaskChan,child_commandgenFileCopyTask0);
				child_commandgenFileCopyTask0?0;
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				for11_end589: skip
			:: true -> 
				break
			od;
			for11_exit589: skip
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: fileCopyTaskChan.async_send!0;
	:: fileCopyTaskChan.sync!0 -> 
		fileCopyTaskChan.sending?0
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype go_Anonymous2(Chandef fileCopyTaskChan) {
	bool closed; 
	int i;
	bool state;
	chan child_copyFiles0 = [0] of {int};
	run copyFiles(fileCopyTaskChan,child_copyFiles0);
	child_copyFiles0?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	stop_process: skip
}
proctype copyFiles(Chandef fileCopyTaskChan;chan child) {
	bool closed; 
	int i;
	bool state;
	do
	:: fileCopyTaskChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			

			if
			:: fileCopyTaskChan.async_rcv?0;
			:: fileCopyTaskChan.sync?0;
			fi;
			for21: skip;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for21_end: skip
		fi
	od;
	for21_exit: skip;
	goto stop_process;
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

