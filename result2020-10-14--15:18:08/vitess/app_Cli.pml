#define Cli_errs  60
#define Cli_replicas  60
#define Cli_movedReplicas  60
#define Cli_repointedReplicas  60
#define Cli_matchedReplicas  60
#define Cli_statements  60
#define Cli_errantBinlogs  60
#define Cli_clusterPoolInstances  60
#define Cli_instances  60
#define Cli_clusters  60
#define Cli_kvPairs  60
#define Cli_tags  60
#define Cli_keysDisplayStrings  60
#define Cli_analysis  60
#define Cli_nodes  60
#define Cli_resolves  60
#define Cli_unresolves  60
#define Cli_promotionRules  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example994420206/go/vt/orchestrator/app/cli.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int clusters = Cli_clusters;
	int replicas = Cli_replicas;
	int promotionRules = Cli_promotionRules;
	int statements = Cli_statements;
	int analysis = Cli_analysis;
	Wgdef postponedFunctionsContainer_waitGroup;
	int repointedReplicas = Cli_repointedReplicas;
	int clusterPoolInstances = Cli_clusterPoolInstances;
	int tags = Cli_tags;
	int resolves = Cli_resolves;
	bool state = false;
	int errs = Cli_errs;
	int movedReplicas = Cli_movedReplicas;
	int matchedReplicas = Cli_matchedReplicas;
	int errantBinlogs = Cli_errantBinlogs;
	int instances = Cli_instances;
	int kvPairs = Cli_kvPairs;
	int keysDisplayStrings = Cli_keysDisplayStrings;
	int nodes = Cli_nodes;
	int unresolves = Cli_unresolves;
	int i;
	

	if
	:: true;
	:: true;
	:: true;
	fi;
	run wgMonitor(postponedFunctionsContainer_waitGroup);
	

	if
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	fi
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
