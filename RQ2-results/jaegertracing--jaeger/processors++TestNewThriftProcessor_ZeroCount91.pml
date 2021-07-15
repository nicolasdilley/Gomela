
// https://github.com/jaegertracing/jaeger/blob/master/cmd/agent/app/processors/thrift_processor_test.go#L91
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestNewThriftProcessor_ZeroCount910 = [1] of {int};
	run TestNewThriftProcessor_ZeroCount91(child_TestNewThriftProcessor_ZeroCount910)
stop_process:skip
}

proctype TestNewThriftProcessor_ZeroCount91(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Wgdef __processing;
	run wgMonitor(__processing);
	stop_process: skip;
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

