
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example810706838/host/cli/download.go
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
	chan child_DownloadImages0 = [0] of {int};
	Chandef ch;
	int num_msgs = 0;
	bool state = false;
	int i;
	

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
	run sync_monitor(ch);
	run go_Anonymous0(ch);
	run DownloadImages(ch,child_DownloadImages0);
	child_DownloadImages0?0;
	

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
stop_process:skip
}

proctype go_Anonymous0(Chandef ch) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		

		if
		:: ch.async_rcv?state,num_msgs;
		:: ch.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for10: skip;
			for10_end: skip
		fi
	od;
	for10_exit: skip;
	stop_process: skip
}
proctype DownloadImages(Chandef info;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_downloadImage0 = [0] of {int};
	chan child_downloadImage0 = [0] of {int};
	int images = -2;
	

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
	:: images-1 != -3 -> 
				for(i : 0.. images-1) {
			for20: skip;
			run downloadImage(info,child_downloadImage0);
			child_downloadImage0?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for20388: skip;
			run downloadImage(info,child_downloadImage0);
			child_downloadImage0?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for20_end388: skip
		:: true -> 
			break
		od;
		for20_exit388: skip
	fi;
	goto stop_process;
	stop_process: skip;
	info.closing!true;
	child!0
}
proctype downloadImage(Chandef info;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int rootfs_Layers = -2;
	int artifact_Manifest_Rootfs = -2;
	

	if
	:: info.async_send!0;
	:: info.sync!false,0 -> 
		info.sending?state
	fi;
	

	if
	:: artifact_Manifest_Rootfs-1 != -3 -> 
				for(i : 0.. artifact_Manifest_Rootfs-1) {
			for21: skip;
			

			if
			:: rootfs_Layers-1 != -3 -> 
								for(i : 0.. rootfs_Layers-1) {
					for22: skip;
					

					if
					:: true -> 
						goto for22_end
					:: true;
					fi;
					

					if
					:: info.async_send!0;
					:: info.sync!false,0 -> 
						info.sending?state
					fi;
					

					if
					:: true -> 
						goto stop_process
					:: true;
					fi;
					for22_end: skip
				};
				for22_exit: skip
			:: else -> 
				do
				:: true -> 
					for22386: skip;
					

					if
					:: true -> 
						goto for22_end386
					:: true;
					fi;
					

					if
					:: info.async_send!0;
					:: info.sync!false,0 -> 
						info.sending?state
					fi;
					

					if
					:: true -> 
						goto stop_process
					:: true;
					fi;
					for22_end386: skip
				:: true -> 
					break
				od;
				for22_exit386: skip
			fi;
			for21_end: skip
		};
		for21_exit: skip
	:: else -> 
		do
		:: true -> 
			for21387: skip;
			

			if
			:: rootfs_Layers-1 != -3 -> 
								for(i : 0.. rootfs_Layers-1) {
					for22387: skip;
					

					if
					:: true -> 
						goto for22_end387
					:: true;
					fi;
					

					if
					:: info.async_send!0;
					:: info.sync!false,0 -> 
						info.sending?state
					fi;
					

					if
					:: true -> 
						goto stop_process
					:: true;
					fi;
					for22_end387: skip
				};
				for22_exit387: skip
			:: else -> 
				do
				:: true -> 
					for22386387: skip;
					

					if
					:: true -> 
						goto for22_end386387
					:: true;
					fi;
					

					if
					:: info.async_send!0;
					:: info.sync!false,0 -> 
						info.sending?state
					fi;
					

					if
					:: true -> 
						goto stop_process
					:: true;
					fi;
					for22_end386387: skip
				:: true -> 
					break
				od;
				for22_exit386387: skip
			fi;
			for21_end387: skip
		:: true -> 
			break
		od;
		for21_exit387: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
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

