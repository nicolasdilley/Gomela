// num_comm_params=2
// num_mand_comm_params=1
// num_opt_comm_params=1

// git_link=https://github.com/chrislusf/seaweedfs/blob//weed/operation/delete_content.go#L50
#define def_var_fileIds  -2 // opt fileIds line 50
#define def_var_server_to_fileIds98  3 // mand server_to_fileIds line 98
typedef Chandef {
	chan sync = [0] of {bool};
	chan enq = [0] of {int};
	chan deq = [0] of {bool,int};
	chan sending = [0] of {bool};
	chan rcving = [0] of {bool};
	chan closing = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_DeleteFilesWithLookupVolumeId500 = [1] of {int};
	run DeleteFilesWithLookupVolumeId50(def_var_fileIds,child_DeleteFilesWithLookupVolumeId500);
	run receiver(child_DeleteFilesWithLookupVolumeId500)
stop_process:skip
}

proctype DeleteFilesWithLookupVolumeId50(int var_fileIds;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousDeleteFilesWithLookupVolumeId1021020 = [1] of {int};
	Wgdef wg;
	Chandef resultChan_ch;
	int var_server_to_fileIds = def_var_server_to_fileIds98; // mand var_server_to_fileIds
	int var_result_Locations = -2; // opt var_result_Locations
	int var_lookupResults = -2; // opt var_lookupResults
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: var_server_to_fileIds > 0 -> 
		resultChan_ch.size = var_server_to_fileIds;
		run AsyncChan(resultChan_ch)
	:: else -> 
		run sync_monitor(resultChan_ch)
	fi;
	run wgMonitor(wg);
		for(i : 0.. var_server_to_fileIds-1) {
		for30: skip;
		wg.update!1;
		run AnonymousDeleteFilesWithLookupVolumeId102102(resultChan_ch,wg,child_AnonymousDeleteFilesWithLookupVolumeId1021020);
		run receiver(child_AnonymousDeleteFilesWithLookupVolumeId1021020);
		for30_end: skip
	};
	for30_exit: skip;
	wg.wait?0;
	resultChan_ch.closing!true;
	do
	:: true -> 
		num_msgs = 0;
		

		if
		:: resultChan_ch.deq?state,num_msgs;
		:: resultChan_ch.sync?state -> 
			resultChan_ch.rcving!false
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for40: skip;
			for40_end: skip
		fi
	od;
	for40_exit: skip;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousDeleteFilesWithLookupVolumeId102102(Chandef resultChan_ch;Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: resultChan_ch.enq!0;
			:: resultChan_ch.sync!false -> 
				resultChan_ch.sending!false
			fi
		:: true;
		fi
	fi;
		defer1: skip;
	wg.update!-1;
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
  :: ch.num_msgs > 0 -> // cannot send on closed channel
    end4: if
    :: ch.enq?0-> // cannot send on closed channel
      assert(1 == 0)
    :: ch.closing?true -> // cannot close twice a channel
      assert(2 == 0)
    :: ch.rcving?false;
    :: ch.sending?false -> // sending state of channel (closed)
      assert(1 == 0)
    :: ch.deq!true,ch.num_msgs -> 
  		 ch.num_msgs = ch.num_msgs - 1
    fi;
  :: else ->    end5: if
    :: ch.enq?0-> // cannot send on closed channel
      assert(1 == 0)
    :: ch.closing?true -> // cannot close twice a channel
      assert(2 == 0)
    :: ch.rcving?false;
    :: ch.sending?false -> // sending state of channel (closed)
      assert(1 == 0)
    :: ch.sync!true; 
    fi;
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.deq!false,ch.num_msgs ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		    ch.closed = true
		   :: ch.rcving?false ->
 		    ch.sending?false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.enq?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.rcving?false ->
 		    ch.sending?false;
		fi;
		:: else -> 
		end3: if
		  :: ch.enq?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.deq!false,ch.num_msgs
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		     ch.closed = true
		  :: ch.rcving?false ->
 		    ch.sending?false;
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
  :: ch.enq?0-> // cannot send on closed channel
    assert(1 == 0)
  :: ch.closing?true -> // cannot close twice a channel
    assert(2 == 0)
  :: ch.sending?false -> // sending state of channel (closed)
    assert(1 == 0)
  :: ch.rcving?false;
  :: ch.sync!true; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.rcving?false ->
       ch.sending?false;
    :: ch.closing?true ->
      ch.closed = true
    fi;
fi;
od
stop_process:
}

proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

proctype receiver(chan c) {
c?0
}

