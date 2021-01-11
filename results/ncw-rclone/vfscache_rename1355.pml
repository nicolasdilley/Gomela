
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example110380261/vfs/vfscache/item.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef item_downloaders_wg;
	Wgdef downloaders_wg;
	bool state = false;
	int i;
	run wgMonitor(downloaders_wg);
	run wgMonitor(item_downloaders_wg);
	goto stop_process
stop_process:skip
}

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

