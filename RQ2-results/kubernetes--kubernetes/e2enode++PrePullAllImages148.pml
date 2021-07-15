#define PrePullAllImages_images  3
#define PrePullAllImages_parallelImagePullCount  0

// https://github.com/kubernetes/kubernetes/blob/master/test/e2e_node/image_list.go#L148
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
	chan child_PrePullAllImages1480 = [1] of {int};
	run PrePullAllImages148(child_PrePullAllImages1480)
stop_process:skip
}

proctype PrePullAllImages148(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousPrePullAllImages1781600 = [1] of {int};
	Wgdef wg;
	Chandef imageCh;
	int images = PrePullAllImages_images;
	int parallelImagePullCount = PrePullAllImages_parallelImagePullCount;
	

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
	:: images > 0 -> 
		imageCh.size = images;
		run AsyncChan(imageCh)
	:: else -> 
		run sync_monitor(imageCh)
	fi;
	

	if
	:: images-1 != -3 -> 
				for(i : 0.. images-1) {
			for10: skip;
			

			if
			:: imageCh.enq!0;
			:: imageCh.sync!false -> 
				imageCh.sending!false
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			

			if
			:: imageCh.enq!0;
			:: imageCh.sync!false -> 
				imageCh.sending!false
			fi;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	imageCh.closing!true;
	run wgMonitor(wg);
	wg.update!parallelImagePullCount;
		for(i : 0.. parallelImagePullCount-1) {
		for20: skip;
		run AnonymousPrePullAllImages178160(imageCh,wg,child_AnonymousPrePullAllImages1781600);
		for20_end: skip
	};
	for20_exit: skip;
	wg.wait?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousPrePullAllImages178160(Chandef imageCh;Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		

		if
		:: imageCh.deq?state,num_msgs;
		:: imageCh.sync?state -> 
			imageCh.rcving!false
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
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
	stop_process: skip;
		wg.update!-1;
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
  :: ch.enq?0-> // cannot send on closed channel
    assert(1 == 0)
  :: ch.closing?true -> // cannot close twice a channel
    assert(2 == 0)
  :: ch.rcving?false;
  :: ch.sending?false -> // sending state of channel (closed)
    assert(1 == 0)
  :: ch.sync!true -> 
		 ch.num_msgs = ch.num_msgs - 1
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

