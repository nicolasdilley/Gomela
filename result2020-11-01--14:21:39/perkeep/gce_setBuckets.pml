#define setBuckets_buckets_Items 3
#define setBuckets_needBucket 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example826291225/pkg/deploy/gce/deploy.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int needBucket = setBuckets_needBucket;
	int buckets_Items = setBuckets_buckets_Items;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 0.. buckets_Items-1) {
for10:
	};
	
	if
	:: true -> 
		Wgdef waitBucket;
		run wgMonitor(waitBucket);
				for(i : 0.. needBucket-1) {
for20:			do
			:: true -> 
				break
			od;
			waitBucket.Add!1;
			run Anonymous0(waitBucket)
		};
		waitBucket.Wait?0;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef waitBucket) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
stop_process:	waitBucket.Add!-1
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
	od
}

