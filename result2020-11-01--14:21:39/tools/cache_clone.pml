#define clone_s_files  ??
#define clone_s_unloadableFiles  ??
#define clone_s_parseModHandles  ??
#define clone_s_goFiles  ??
#define clone_s_modTidyHandles  ??
#define clone_s_modUpgradeHandles  ??
#define clone_s_modWhyHandles  ??
#define clone_s_metadata  ??
#define clone_changes  ??
#define clone_filePackages  ??
#define clone_id  ??
#define clone_directIDs  ??
#define clone_s_packages  ??
#define clone_s_actions  ??
#define clone_s_ids  ??
#define clone_ids  ??
#define clone_s_workspacePackages  ??
#define clone_s_metadata[id]_goFiles  ??
#define clone_result_modTidyHandles  ??
#define clone_result_modUpgradeHandles  ??
#define clone_result_modWhyHandles  ??
#define clone_result_parseModHandles  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example131702815/internal/lsp/cache/snapshot.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int s_modWhyHandles = clone_s_modWhyHandles;
	int i;
	int s_ids = clone_s_ids;
	int s_parseModHandles = clone_s_parseModHandles;
	int id = clone_id;
	int result_modTidyHandles = clone_result_modTidyHandles;
	int s_files = clone_s_files;
	int s_modTidyHandles = clone_s_modTidyHandles;
	int changes = clone_changes;
	int s_packages = clone_s_packages;
	int s_workspacePackages = clone_s_workspacePackages;
	int result_modWhyHandles = clone_result_modWhyHandles;
	Wgdef newGen_wg;
	int s_unloadableFiles = clone_s_unloadableFiles;
	int s_goFiles = clone_s_goFiles;
	int s_modUpgradeHandles = clone_s_modUpgradeHandles;
	int s_metadata = clone_s_metadata;
	int filePackages = clone_filePackages;
	int directIDs = clone_directIDs;
	int s_actions = clone_s_actions;
	int ids = clone_ids;
	int s_metadata[id]_goFiles = clone_s_metadata[id]_goFiles;
	int result_modUpgradeHandles = clone_result_modUpgradeHandles;
	int result_parseModHandles = clone_result_parseModHandles;
	bool state = false;
	run wgMonitor(newGen_wg);
		for(i : 0.. s_files-1) {
for10:
	};
		for(i : 0.. s_unloadableFiles-1) {
for20:
	};
		for(i : 0.. s_parseModHandles-1) {
for30:
	};
		for(i : 0.. s_goFiles-1) {
for40:
	};
		for(i : 0.. s_modTidyHandles-1) {
for50:
	};
		for(i : 0.. s_modUpgradeHandles-1) {
for60:
	};
		for(i : 0.. s_modWhyHandles-1) {
for70:
	};
	
	if
	:: true -> 
				for(i : 0.. s_metadata-1) {
for80:
		}
	:: true;
	fi;
		for(i : 0.. changes-1) {
for90:				for(i : 0.. filePackages-1) {
for91:
		};
		
		if
		:: true -> 
						for(i : 0.. s_modTidyHandles-1) {
for92:
			};
						for(i : 0.. s_modUpgradeHandles-1) {
for93:
			};
						for(i : 0.. s_modWhyHandles-1) {
for94:
			}
		:: true;
		fi
	};
		for(i : 0.. directIDs-1) {
for100:
	};
		for(i : 0.. s_packages-1) {
for110:
	};
		for(i : 0.. s_actions-1) {
for120:
	};
		for(i : 0.. s_metadata-1) {
for130:
	};
copyIDs:			for(i : 0.. s_ids-1) {
for140:				for(i : 0.. ids-1) {
for141:
		}
	};
		for(i : 0.. s_workspacePackages-1) {
for150:		
		if
		:: true -> 
						for(i : 0.. s_metadata[id]_goFiles-1) {
for151:				
				if
				:: true -> 
					break
				:: true;
				fi
			}
		:: true;
		fi
	};
		for(i : 0.. result_modTidyHandles-1) {
for160:
	};
		for(i : 0.. result_modUpgradeHandles-1) {
for170:
	};
		for(i : 0.. result_modWhyHandles-1) {
for180:
	};
		for(i : 0.. result_parseModHandles-1) {
for190:
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
	od
}
