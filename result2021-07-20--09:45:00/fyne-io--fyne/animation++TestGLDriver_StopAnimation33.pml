// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/fyne-io/fyne/blob/9b5a176fe1dc80beae72a3074d0d5cd2b409637c/internal/animation/animation_test.go#L33
#define ub_for68_3  -2
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
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGLDriver_StopAnimation330 = [1] of {int};
	run TestGLDriver_StopAnimation33(child_TestGLDriver_StopAnimation330);
	run receiver(child_TestGLDriver_StopAnimation330)
stop_process:skip
}

proctype TestGLDriver_StopAnimation33(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Stop341 = [1] of {int};
	chan child_Start200 = [1] of {int};
	Mutexdef run_animationMutex;
	Chandef done_ch;
	run sync_monitor(done_ch);
	run mutexMonitor(run_animationMutex);
	run Start20(run_animationMutex,child_Start200);
	child_Start200?0;
	do
	:: done_ch.deq?state,num_msgs -> 
		break
	:: done_ch.sync?state -> 
		done_ch.rcving!false;
		break
	:: true -> 
		break
	od;
	for20_exit: skip;
	for20_end: skip;
	run Stop34(run_animationMutex,child_Stop341);
	child_Stop341?0;
	stop_process: skip;
	child!0
}
proctype Start20(Mutexdef r_animationMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_runAnimations640 = [1] of {int};
	r_animationMutex.Lock!false;
	

	if
	:: true -> 
		run runAnimations64(r_animationMutex,child_runAnimations640);
		child_runAnimations640?0
	fi;
		defer1: skip;
	r_animationMutex.Unlock!false;
	stop_process: skip;
	child!0
}
proctype runAnimations64(Mutexdef r_animationMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousrunAnimations6700 = [1] of {int};
	run AnonymousrunAnimations670(r_animationMutex,child_AnonymousrunAnimations6700);
	run receiver(child_AnonymousrunAnimations6700);
	stop_process: skip;
	child!0
}
proctype AnonymousrunAnimations670(Mutexdef r_animationMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_tickAnimation932 = [1] of {int};
	chan child_tickAnimation933 = [1] of {int};
	chan child_tickAnimation930 = [1] of {int};
	chan child_tickAnimation931 = [1] of {int};
	int var_oldListoldList = -2; // opt var_oldListoldList
	

	if
	:: 0 != -2 && ub_for68_3 != -2 -> 
				for(i : 0.. ub_for68_3) {
			for13: skip;
			r_animationMutex.Lock!false;
			r_animationMutex.Unlock!false;
			

			if
			:: var_oldList-1 != -3 -> 
								for(i : 0.. var_oldList-1) {
					for14: skip;
					run tickAnimation93(r_animationMutex,child_tickAnimation932);
					child_tickAnimation932?0;
					for14_end: skip
				};
				for14_exit: skip
			:: else -> 
				do
				:: true -> 
					for15: skip;
					run tickAnimation93(r_animationMutex,child_tickAnimation933);
					child_tickAnimation933?0;
					for15_end: skip
				:: true -> 
					break
				od;
				for15_exit: skip
			fi;
			r_animationMutex.Lock!false;
			r_animationMutex.Unlock!false;
			for13_end: skip
		};
		for13_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			r_animationMutex.Lock!false;
			r_animationMutex.Unlock!false;
			

			if
			:: var_oldList-1 != -3 -> 
								for(i : 0.. var_oldList-1) {
					for11: skip;
					run tickAnimation93(r_animationMutex,child_tickAnimation930);
					child_tickAnimation930?0;
					for11_end: skip
				};
				for11_exit: skip
			:: else -> 
				do
				:: true -> 
					for12: skip;
					run tickAnimation93(r_animationMutex,child_tickAnimation931);
					child_tickAnimation931?0;
					for12_end: skip
				:: true -> 
					break
				od;
				for12_exit: skip
			fi;
			r_animationMutex.Lock!false;
			r_animationMutex.Unlock!false;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	r_animationMutex.Lock!false;
	r_animationMutex.Unlock!false;
	stop_process: skip;
	child!0
}
proctype tickAnimation93(Mutexdef r_animationMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

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
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Stop34(Mutexdef r_animationMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_r_pendingAnimationsr_pendingAnimations = -2; // opt var_r_pendingAnimationsr_pendingAnimations
	int var_r_animationsr_animations = -2; // opt var_r_animationsr_animations
	r_animationMutex.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
		defer1: skip;
	r_animationMutex.Unlock!false;
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

proctype mutexMonitor(Mutexdef m) {
bool locked = false;
do
:: true ->
	if
	:: m.Counter > 0 ->
		if 
		:: m.RUnlock?false -> 
			m.Counter = m.Counter - 1;
		:: m.RLock?false -> 
			m.Counter = m.Counter + 1;
		fi;
	:: locked ->
		m.Unlock?false;
		locked = false;
	:: else ->	 end:	if
		:: m.Unlock?false ->
			assert(0==32);		:: m.Lock?false ->
			locked =true;
		:: m.RUnlock?false ->
			assert(0==32);		:: m.RLock?false ->
			m.Counter = m.Counter + 1;
		fi;
	fi;
od
}

proctype receiver(chan c) {
c?0
}

