#define download_sizeDld  60
#define download_st_cfg_Download_ThreadsPerURL  60
#define download_urls  60
#define lb_for224_3  -1
#define ub_for224_4  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example263572852/speedtest/speedtest.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int st_cfg_Download_ThreadsPerURL = download_st_cfg_Download_ThreadsPerURL;
	Wgdef wg;
	int i;
	int sizeDld = download_sizeDld;
	int urls = download_urls;
	bool state = false;
	run wgMonitor(wg);
		for(i : 1.. sizeDld) {
for10:		
		if
		:: 0 != -1 && st_cfg_Download_ThreadsPerURL-1 != -1 -> 
						for(i : 0.. st_cfg_Download_ThreadsPerURL-1) {
for11:
			}
		:: else -> 
			do
			:: true -> 
for11:
			:: true -> 
				break
			od
		fi;
for11_exit:
	};
		for(i : 1.. urls) {
for20:		wg.Add!1;
		run Anonymous0(wg)
	};
	wg.Wait?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for21:		
		if
		:: true -> 
			break
		:: true;
		fi;
		
		if
		:: true -> 
			break
		:: true;
		fi
	od;
for21_exit:	wg.Add!-1;
stop_process:
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
end:		
		if
		:: wg.Add?i -> 
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
		fi
	od;
stop_process:
}
