
// https://github.com/ethereum/go-ethereum/blob/master/eth/downloader/testchain_test.go#L47
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_init470 = [1] of {int};
	run init47(child_init470)
stop_process:skip
}

proctype init47(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Anonymousinit53492 = [1] of {int};
	chan child_Anonymousinit52491 = [1] of {int};
	chan child_Anonymousinit51490 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
	wg.update!3;
	run Anonymousinit5149(wg,child_Anonymousinit51490);
	run Anonymousinit5249(wg,child_Anonymousinit52491);
	run Anonymousinit5349(wg,child_Anonymousinit53492);
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype Anonymousinit5149(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype Anonymousinit5249(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype Anonymousinit5349(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.update!-1;
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

