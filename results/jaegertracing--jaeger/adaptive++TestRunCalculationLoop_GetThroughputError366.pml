#define not_found_327  -2
#define not_found_246  -2
#define not_found_400  -2

// https://github.com/jaegertracing/jaeger/blob/master/plugin/sampling/strategystore/adaptive/processor_test.go#L366
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



init { 
	chan child_TestRunCalculationLoop_GetThroughputError3660 = [1] of {int};
	run TestRunCalculationLoop_GetThroughputError366(child_TestRunCalculationLoop_GetThroughputError3660)
stop_process:skip
}

proctype TestRunCalculationLoop_GetThroughputError366(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_runCalculationLoop2300 = [1] of {int};
	Chandef p_shutdown;
	run sync_monitor(p_shutdown);
	run runCalculationLoop230(p_shutdown,child_runCalculationLoop2300);
	stop_process: skip;
		p_shutdown.closing!true;
	child!0
}
proctype runCalculationLoop230(Chandef p_shutdown;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_saveProbabilitiesAndQPS2806 = [1] of {int};
	chan child_generateStrategyResponses4855 = [1] of {int};
	chan child_calculateProbabilitiesAndQPS3854 = [1] of {int};
	chan child_isLeader2173 = [1] of {int};
	chan child_prependThroughputBucket2882 = [1] of {int};
	chan child_aggregateThroughput2981 = [1] of {int};
	chan child_initializeThroughput3160 = [1] of {int};
	run initializeThroughput316(p_shutdown,child_initializeThroughput3160);
	child_initializeThroughput3160?0;
	do
	:: true -> 
		for20: skip;
		do
		:: true -> 
			

			if
			:: true -> 
				goto for20_exit
			:: true;
			fi;
			run aggregateThroughput298(p_shutdown,not_found_246,child_aggregateThroughput2981);
			child_aggregateThroughput2981?0;
			run prependThroughputBucket288(p_shutdown,child_prependThroughputBucket2882);
			child_prependThroughputBucket2882?0;
			run isLeader217(p_shutdown,child_isLeader2173);
			child_isLeader2173?0;
			

			if
			:: true -> 
				run calculateProbabilitiesAndQPS385(p_shutdown,child_calculateProbabilitiesAndQPS3854);
				child_calculateProbabilitiesAndQPS3854?0;
				run generateStrategyResponses485(p_shutdown,child_generateStrategyResponses4855);
				child_generateStrategyResponses4855?0;
				run saveProbabilitiesAndQPS280(p_shutdown,child_saveProbabilitiesAndQPS2806)
			:: true;
			fi
		:: p_shutdown.deq?state,num_msgs -> 
			goto stop_process
		:: p_shutdown.sync?state -> 
			p_shutdown.rcving!false;
			goto stop_process
		od;
		for20_end: skip
	od;
	for20_exit: skip;
	stop_process: skip;
	child!0
}
proctype initializeThroughput316(Chandef p_shutdown;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_aggregateThroughput2981 = [1] of {int};
	chan child_aggregateThroughput2980 = [1] of {int};
	int p_AggregationBuckets = -2;
	

	if
	:: 0 != -2 && p_AggregationBuckets-1 != -3 -> 
				for(i : 0.. p_AggregationBuckets-1) {
			for13: skip;
			

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
			run aggregateThroughput298(p_shutdown,not_found_327,child_aggregateThroughput2981);
			child_aggregateThroughput2981?0;
			for13_end: skip
		};
		for13_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			

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
			run aggregateThroughput298(p_shutdown,not_found_327,child_aggregateThroughput2980);
			child_aggregateThroughput2980?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype aggregateThroughput298(Chandef p_shutdown;int throughputs;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype prependThroughputBucket288(Chandef p_shutdown;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype isLeader217(Chandef p_shutdown;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype calculateProbabilitiesAndQPS385(Chandef p_shutdown;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_calculateProbability4097 = [1] of {int};
	chan child_calculateWeightedQPS3666 = [1] of {int};
	chan child_calculateProbability4099 = [1] of {int};
	chan child_calculateWeightedQPS3668 = [1] of {int};
	chan child_calculateProbability40911 = [1] of {int};
	chan child_calculateWeightedQPS36610 = [1] of {int};
	chan child_calculateProbability40913 = [1] of {int};
	chan child_calculateWeightedQPS36612 = [1] of {int};
	chan child_throughputToQPS3385 = [1] of {int};
	chan child_prependServiceCache3784 = [1] of {int};
	int svcOpQPS = -2;
	int opQPS = -2;
	run prependServiceCache378(p_shutdown,child_prependServiceCache3784);
	child_prependServiceCache3784?0;
	run throughputToQPS338(p_shutdown,child_throughputToQPS3385);
	child_throughputToQPS3385?0;
	

	if
	:: svcOpQPS-1 != -3 -> 
				for(i : 0.. svcOpQPS-1) {
			for215: skip;
			

			if
			:: opQPS-1 != -3 -> 
								for(i : 0.. opQPS-1) {
					for216: skip;
					run calculateWeightedQPS366(p_shutdown,not_found_400,child_calculateWeightedQPS3666);
					child_calculateWeightedQPS3666?0;
					run calculateProbability409(p_shutdown,child_calculateProbability4097);
					child_calculateProbability4097?0;
					for216_end: skip
				};
				for216_exit: skip
			:: else -> 
				do
				:: true -> 
					for219: skip;
					run calculateWeightedQPS366(p_shutdown,not_found_400,child_calculateWeightedQPS3668);
					child_calculateWeightedQPS3668?0;
					run calculateProbability409(p_shutdown,child_calculateProbability4099);
					child_calculateProbability4099?0;
					for219_end: skip
				:: true -> 
					break
				od;
				for219_exit: skip
			fi;
			for215_end: skip
		};
		for215_exit: skip
	:: else -> 
		do
		:: true -> 
			for220: skip;
			

			if
			:: opQPS-1 != -3 -> 
								for(i : 0.. opQPS-1) {
					for221: skip;
					run calculateWeightedQPS366(p_shutdown,not_found_400,child_calculateWeightedQPS36610);
					child_calculateWeightedQPS36610?0;
					run calculateProbability409(p_shutdown,child_calculateProbability40911);
					child_calculateProbability40911?0;
					for221_end: skip
				};
				for221_exit: skip
			:: else -> 
				do
				:: true -> 
					for222: skip;
					run calculateWeightedQPS366(p_shutdown,not_found_400,child_calculateWeightedQPS36612);
					child_calculateWeightedQPS36612?0;
					run calculateProbability409(p_shutdown,child_calculateProbability40913);
					child_calculateProbability40913?0;
					for222_end: skip
				:: true -> 
					break
				od;
				for222_exit: skip
			fi;
			for220_end: skip
		:: true -> 
			break
		od;
		for220_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype prependServiceCache378(Chandef p_shutdown;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype throughputToQPS338(Chandef p_shutdown;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype calculateWeightedQPS366(Chandef p_shutdown;int allQPS;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype calculateProbability409(Chandef p_shutdown;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_withinTolerance4448 = [1] of {int};
	chan child_isUsingAdaptiveSampling4567 = [1] of {int};
	run isUsingAdaptiveSampling456(p_shutdown,child_isUsingAdaptiveSampling4567);
	child_isUsingAdaptiveSampling4567?0;
	run withinTolerance444(p_shutdown,child_withinTolerance4448);
	child_withinTolerance4448?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype isUsingAdaptiveSampling456(Chandef p_shutdown;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype withinTolerance444(Chandef p_shutdown;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype generateStrategyResponses485(Chandef p_shutdown;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_generateDefaultSamplingStrategyResponse5115 = [1] of {int};
	chan child_generateDefaultSamplingStrategyResponse5116 = [1] of {int};
	int p_probabilities = -2;
	

	if
	:: p_probabilities-1 != -3 -> 
				for(i : 0.. p_probabilities-1) {
			for223: skip;
			run generateDefaultSamplingStrategyResponse511(p_shutdown,child_generateDefaultSamplingStrategyResponse5115);
			child_generateDefaultSamplingStrategyResponse5115?0;
			for223_end: skip
		};
		for223_exit: skip
	:: else -> 
		do
		:: true -> 
			for226: skip;
			run generateDefaultSamplingStrategyResponse511(p_shutdown,child_generateDefaultSamplingStrategyResponse5116);
			child_generateDefaultSamplingStrategyResponse5116?0;
			for226_end: skip
		:: true -> 
			break
		od;
		for226_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype generateDefaultSamplingStrategyResponse511(Chandef p_shutdown;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype saveProbabilitiesAndQPS280(Chandef p_shutdown;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

