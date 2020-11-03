#define Cli_errs  ??
#define Cli_replicas  ??
#define Cli_movedReplicas  ??
#define Cli_repointedReplicas  ??
#define Cli_matchedReplicas  ??
#define Cli_statements  ??
#define Cli_errantBinlogs  ??
#define Cli_clusterPoolInstances  ??
#define Cli_instances  ??
#define Cli_clusters  ??
#define Cli_kvPairs  ??
#define Cli_tags  ??
#define Cli_keysDisplayStrings  ??
#define Cli_analysis  ??
#define Cli_nodes  ??
#define Cli_resolves  ??
#define Cli_unresolves  ??
#define Cli_promotionRules  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example345111863/go/vt/orchestrator/app/cli.go
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
	od
}
