#define GetChannels_slackChans  60
#define GetChannels_buckets  60
#define GetChannels_keys  60
#define GetChannels_bucket  60
#define GetChannels_tcArr  60
#define lb_for101_5  -1
#define ub_for101_6  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example596742657/service/slack.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int keys = GetChannels_keys;
	int slackChans = GetChannels_slackChans;
	int tcArr = GetChannels_tcArr;
	Wgdef wg;
	int buckets = GetChannels_buckets;
	int bucket = GetChannels_bucket;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: lb_for101_5 != -1 && ub_for101_6 != -1 -> 
				for(i : lb_for101_5.. ub_for101_6) {
for10:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	run wgMonitor(wg);
		for(i : 1.. slackChans) {
for20:
	};
	wg.Wait?0;
		for(i : 1.. buckets) {
for30:
	};
		for(i : 1.. keys) {
for40:				for(i : 1.. bucket) {
for41:
		};
				for(i : 1.. tcArr) {
for42:
		}
	};
	goto stop_process
stop_process:}

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
