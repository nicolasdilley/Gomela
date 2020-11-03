#define refine_roots  ??
#define refine_list  ??
#define refine_stubs  ??
#define refine_initial  ??
#define refine_srcPkgs  ??
#define refine_lpkg_Imports  ??
#define refine_ld_pkgs  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example131702815/go/packages/packages.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int ld_pkgs = refine_ld_pkgs;
	int stubs = refine_stubs;
	int roots = refine_roots;
	int srcPkgs = refine_srcPkgs;
	bool state = false;
	int list = refine_list;
	int initial = refine_initial;
	int lpkg_Imports = refine_lpkg_Imports;
	int i;
		for(i : 0.. roots-1) {
for10:
	};
		for(i : 0.. list-1) {
for20:
	};
		for(i : 0.. roots-1) {
for30:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
	
	if
	:: true -> 
				for(i : 0.. initial-1) {
for40:
		}
	:: true -> 
				for(i : 0.. initial-1) {
for50:
		}
	:: true -> 
				for(i : 0.. initial-1) {
for50:
		}
	fi;
	
	if
	:: true -> 
				for(i : 0.. srcPkgs-1) {
for60:						for(i : 0.. lpkg_Imports-1) {
for61:
			}
		}
	:: true;
	fi;
	
	if
	:: true -> 
		Wgdef wg;
		run wgMonitor(wg);
				for(i : 0.. initial-1) {
for70:			wg.Add!1;
			run Anonymous0(wg)
		};
		wg.Wait?0
	:: true;
	fi;
		for(i : 0.. initial-1) {
for80:
	};
		for(i : 0.. ld_pkgs-1) {
for90:
	};
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
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
	od
}
