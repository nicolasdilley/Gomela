#define lb_for407_0  -1
#define ub_for407_1  -1
#define lb_for416_2  -1
#define ub_for416_3  -1
#define lb_for431_4  -1
#define ub_for431_5  -1
#define lb_for441_6  -1
#define ub_for441_7  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example667255095/nes/azul3d_video.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
}



init { 
	Chandef texUpdate;
	int i;
	int Azul3DPalette = 5;
	Chandef done;
	Chandef events;
	int colors = 5;
	bool state = false;
	run sync_monitor(done);
	do
	:: true -> 
for10:
	:: true -> 
		break
	od;
	run sync_monitor(texUpdate);
	
	if
	:: 256 > 0 -> 
		events.size = 256;
		run emptyChan(events)
	:: else -> 
		run sync_monitor(events)
	fi;
	run Anonymous0(done,texUpdate,onLoad,events);
	run Anonymous1(done,texUpdate,onLoad,events);
	do
	:: true -> 
for40:		do
		:: done.async_rcv?0 -> 
			goto stop_process
		:: done.sync?0 -> 
			goto stop_process
		od
	od;
for40_exit:
stop_process:}

proctype Anonymous0(Chandef done;Chandef texUpdate;Chandef onLoad;Chandef events) {
	bool closed; 
	int i;
	do
	:: true -> 
for20:		do
		:: done.async_rcv?0 -> 
			goto stop_process
		:: done.sync?0 -> 
			goto stop_process
		od
	od;
for20_exit:stop_process:
}
proctype videohandleInput(Chandef done;chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		

		if
		:: true;
		:: true;
		:: true;
		:: true;
		:: true;
		:: true;
		:: true;
		:: true -> 
			done.closing!true
		:: true;
		:: true;
		:: true;
		:: true;
		:: true;
		:: true;
		:: true;
		:: true;
		:: true;
		:: true;
		:: true;
		:: true;
		:: true;
		:: true;
		:: true;
		:: true;
		:: true;
		:: true;
		:: true;
		:: true;
		:: true;
		:: true;
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		

		if
		:: true;
		:: true;
		:: true;
		:: true;
		:: true;
		:: true;
		:: true;
		:: true;
		fi
	:: true;
	fi;
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous1(Chandef done;Chandef texUpdate;Chandef onLoad;Chandef events) {
	bool closed; 
	int i;
	do
	:: true -> 
for30:		
		if
		:: events.async_rcv?0;
		:: events.sync?0;
		fi;
		
		if
		:: true -> 
			chan child_videohandleInput0 = [0] of {int};
			run videohandleInput(done,child_videohandleInput0);
			child_videohandleInput0?0
		:: true;
		fi
	od;
for30_exit:stop_process:
}
proctype sync_monitor(Chandef ch) {
end: if
    :: ch.sending!false;
      run sync_monitor(ch)
    :: ch.closing?true ->
      run closedChan(ch)
    :: ch.is_closed!false ->
      run sync_monitor(ch)
    fi
stop_process:
}

proctype emptyChan(Chandef ch) {
end: if
	 :: ch.async_send?0 -> // a message has been received
    ch.num_msgs = ch.num_msgs + 1
    if
    :: ch.num_msgs == ch.size ->
      run fullChan(ch)
    :: else ->
      run neitherChan(ch)
    fi;
  :: ch.closing?true -> // closing the channel
    run closedChan(ch)
  :: ch.is_closed!false ->
    run emptyChan(ch) // sending channel is open 
  :: ch.sending!false ->
    run emptyChan(ch) // sending channel is open 
fi;
}

proctype fullChan(Chandef ch) {
end: if
  :: ch.async_rcv!0 ->
    ch.num_msgs = ch.num_msgs - 1
    if
    :: ch.num_msgs == 0 ->
      run emptyChan(ch)
    :: else ->
      run neitherChan(ch)
    fi;
  :: ch.closing?true -> // closing the channel
      run closedChan(ch)
  :: ch.is_closed!false -> // sending channel is open 
      run fullChan(ch)
  :: ch.sending!false ->
      run fullChan(ch)
fi;
}

proctype neitherChan(Chandef ch) {
end: if
  :: ch.async_send?0->
     ch.num_msgs = ch.num_msgs + 1
     if
     :: ch.num_msgs == ch.size ->
        run fullChan(ch)
     :: else ->
        run neitherChan(ch)
    fi;
  :: ch.async_rcv!0
     ch.num_msgs = ch.num_msgs - 1
     if
     :: ch.num_msgs == 0 ->
      run emptyChan(ch)
     :: else ->
      run neitherChan(ch)
     fi;
  :: ch.closing?true -> // closing the channel
      run closedChan(ch)
  :: ch.is_closed!false ->  // sending channel is open
     run neitherChan(ch)
  :: ch.sending!false ->  // sending channel is open
     run neitherChan(ch)
fi;
}

proctype closedChan(Chandef ch) {
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true -> // sending state of channel (closed)
    run closedChan(ch)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0 -> // can always receive on a closed chan
    run closedChan(ch)
  fi;
}

