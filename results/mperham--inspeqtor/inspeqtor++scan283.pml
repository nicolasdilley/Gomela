#define scan_i_Services  3

// https://github.com/mperham/inspeqtor/blob/ea4f56394811af5171c0746ab805a97946d82a38/inspeqtor.go#L283
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef barrier;
	int num_msgs = 0;
	bool state = false;
	int i;
	int i_Services = scan_i_Services;
	run wgMonitor(barrier);
	barrier.Add!1;
	barrier.Add!i_Services;
	barrier.Wait?0
stop_process:skip
}


 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
bool closed;
int i;
bool state;
do
	:: wg.Add?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}

