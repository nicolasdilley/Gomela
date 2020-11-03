#define determinePaths_chunks 0
#define determinePaths_keys 0
#define determinePaths_chunkPaths 1
#define determinePaths_chunk 0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example401606570/btree/immutable/add.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int chunks = determinePaths_chunks;
	int i;
	int chunkPaths = determinePaths_chunkPaths;
	Wgdef wg;
	int keys = determinePaths_keys;
	int chunk = determinePaths_chunk;
	bool state = false;
	run wgMonitor(wg);
	wg.Add!chunks;
		for(i : 0.. chunks-1) {
for10:		run Anonymous0(wg)
	};
	wg.Wait?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 0.. chunkPaths-1) {
for20:				for(i : 0.. chunk-1) {
for21:
		}
	};
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 0.. keys-1) {
for11:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
stop_process:	wg.Add!-1
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

