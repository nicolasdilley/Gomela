#define GetNSQDStats_producers 3
#define GetNSQDStats_resp_Topics 1
#define GetNSQDStats_topic_Channels 0
#define GetNSQDStats_channel_Clients 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example519737571/internal/clusterinfo/data.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int producers = GetNSQDStats_producers;
	int i;
	int topic_Channels = GetNSQDStats_topic_Channels;
	Wgdef wg;
	int resp_Topics = GetNSQDStats_resp_Topics;
	int channel_Clients = GetNSQDStats_channel_Clients;
	bool state = false;
	run wgMonitor(wg);
		for(i : 0.. producers-1) {
for10:		wg.Add!1;
		run Anonymous0(wg)
	};
	wg.Wait?0;
	
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
		for(i : 0.. resp_Topics-1) {
for11:				for(i : 0.. topic_Channels-1) {
for12:						for(i : 0.. channel_Clients-1) {
for13:
			}
		}
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

