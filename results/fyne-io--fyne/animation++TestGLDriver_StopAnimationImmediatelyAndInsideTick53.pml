#define ub_for68_3  -2

// https://github.com/fyne-io/fyne/blob/master/internal/animation/animation_test.go#L53
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGLDriver_StopAnimationImmediatelyAndInsideTick530 = [1] of {int};
	run TestGLDriver_StopAnimationImmediatelyAndInsideTick53(child_TestGLDriver_StopAnimationImmediatelyAndInsideTick530)
stop_process:skip
}

proctype TestGLDriver_StopAnimationImmediatelyAndInsideTick53(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Stop345 = [1] of {int};
	chan child_Start204 = [1] of {int};
	chan child_Start202 = [1] of {int};
	chan child_Stop341 = [1] of {int};
	chan child_Start200 = [1] of {int};
	Mutexdef run_animationMutex;
	Wgdef wg;
	run wgMonitor(wg);
	run mutexMonitor(run_animationMutex);
	run Start20(run_animationMutex,child_Start200);
	child_Start200?0;
	run Stop34(run_animationMutex,child_Stop341);
	child_Stop341?0;
		for(i : 0.. 10-1) {
		for40: skip;
		wg.update!1;
		run Start20(run_animationMutex,child_Start202);
		child_Start202?0;
		for40_end: skip
	};
	for40_exit: skip;
	run Start20(run_animationMutex,child_Start204);
	child_Start204?0;
	run Stop34(run_animationMutex,child_Stop345);
	child_Stop345?0;
	wg.wait?0;
	run_animationMutex.RLock!false;
	run_animationMutex.RUnlock!false;
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
	stop_process: skip;
		r_animationMutex.Unlock!false;
	child!0
}
proctype runAnimations64(Mutexdef r_animationMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousrunAnimations6700 = [1] of {int};
	run AnonymousrunAnimations670(r_animationMutex,child_AnonymousrunAnimations6700);
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
	int oldList = -2;
	

	if
	:: 0 != -2 && ub_for68_3 != -2 -> 
				for(i : 0.. ub_for68_3) {
			for13: skip;
			r_animationMutex.Lock!false;
			r_animationMutex.Unlock!false;
			

			if
			:: oldList-1 != -3 -> 
								for(i : 0.. oldList-1) {
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
			:: oldList-1 != -3 -> 
								for(i : 0.. oldList-1) {
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
	r_animationMutex.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
		r_animationMutex.Unlock!false;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
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

