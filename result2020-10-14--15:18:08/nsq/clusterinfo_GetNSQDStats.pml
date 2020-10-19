#define GetNSQDStats_producers  60
#define GetNSQDStats_resp_Topics  60
#define GetNSQDStats_topic_Channels  60
#define GetNSQDStats_channel_Clients  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example009752769/internal/clusterinfo/data.go
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
		for(i : 1.. producers) {
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
		for(i : 1.. resp_Topics) {
for11:				for(i : 1.. topic_Channels) {
for12:						for(i : 1.. channel_Clients) {
for13:
			}
		}
	};
	wg.Add!-1;
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
