// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/hashicorp/vault/blob/f8f289712a3d37115090591602a2b92503fb3a13/builtin/credential/cert/backend_test.go#L1806
#define not_found_247  -2 // opt chain line 467
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Test_Renew18060 = [1] of {int};
	run Test_Renew1806(child_Test_Renew18060);
	run receiver(child_Test_Renew18060)
stop_process:skip
}

proctype Test_Renew1806(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_pathLoginRenew11610 = [1] of {int};
	chan child_pathCertDelete2119 = [1] of {int};
	chan child_pathLoginRenew1168 = [1] of {int};
	chan child_pathCertWrite2707 = [1] of {int};
	chan child_pathLoginRenew1166 = [1] of {int};
	chan child_pathCertWrite2705 = [1] of {int};
	chan child_pathLoginRenew1164 = [1] of {int};
	chan child_pathCertWrite2703 = [1] of {int};
	chan child_pathLoginRenew1162 = [1] of {int};
	chan child_pathLogin611 = [1] of {int};
	chan child_pathCertWrite2700 = [1] of {int};
	Mutexdef b_crlUpdateMutex;
	Mutexdef storage_once_m;
	run mutexMonitor(storage_once_m);
	run mutexMonitor(b_crlUpdateMutex);
	run pathCertWrite270(b_crlUpdateMutex,child_pathCertWrite2700);
	child_pathCertWrite2700?0;
	run pathLogin61(b_crlUpdateMutex,child_pathLogin611);
	child_pathLogin611?0;
	run pathLoginRenew116(b_crlUpdateMutex,child_pathLoginRenew1162);
	child_pathLoginRenew1162?0;
	run pathCertWrite270(b_crlUpdateMutex,child_pathCertWrite2703);
	child_pathCertWrite2703?0;
	run pathLoginRenew116(b_crlUpdateMutex,child_pathLoginRenew1164);
	child_pathLoginRenew1164?0;
	run pathCertWrite270(b_crlUpdateMutex,child_pathCertWrite2705);
	child_pathCertWrite2705?0;
	run pathLoginRenew116(b_crlUpdateMutex,child_pathLoginRenew1166);
	child_pathLoginRenew1166?0;
	run pathCertWrite270(b_crlUpdateMutex,child_pathCertWrite2707);
	child_pathCertWrite2707?0;
	run pathLoginRenew116(b_crlUpdateMutex,child_pathLoginRenew1168);
	child_pathLoginRenew1168?0;
	run pathCertDelete211(b_crlUpdateMutex,child_pathCertDelete2119);
	child_pathCertDelete2119?0;
	run pathLoginRenew116(b_crlUpdateMutex,child_pathLoginRenew11610);
	child_pathLoginRenew11610?0;
	stop_process: skip;
	child!0
}
proctype pathCertWrite270(Mutexdef b_crlUpdateMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Cert1780 = [1] of {int};
	int var_parsedL0L_ExtKeyUsage = -2; // opt var_parsedL0L_ExtKeyUsage
	run Cert178(b_crlUpdateMutex,child_Cert1780);
	child_Cert1780?0;
	

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
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Cert178(Mutexdef b_crlUpdateMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype pathLogin61(Mutexdef b_crlUpdateMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_verifyCredentials1711 = [1] of {int};
	run verifyCredentials171(b_crlUpdateMutex,child_verifyCredentials1711);
	child_verifyCredentials1711?0;
	

	if
	:: true -> 
		goto stop_process
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		fi
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype verifyCredentials171(Mutexdef b_crlUpdateMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_matchesConstraints2464 = [1] of {int};
	chan child_matchesConstraints2465 = [1] of {int};
	chan child_matchesConstraints2466 = [1] of {int};
	chan child_matchesConstraints2467 = [1] of {int};
	chan child_matchesConstraints2468 = [1] of {int};
	chan child_matchesConstraints2469 = [1] of {int};
	chan child_matchesConstraints24610 = [1] of {int};
	chan child_matchesConstraints24611 = [1] of {int};
	chan child_matchesConstraints24612 = [1] of {int};
	chan child_matchesConstraints24613 = [1] of {int};
	chan child_matchesConstraints24614 = [1] of {int};
	chan child_matchesConstraints24615 = [1] of {int};
	chan child_matchesConstraints24616 = [1] of {int};
	chan child_matchesConstraints24617 = [1] of {int};
	chan child_matchesConstraints24618 = [1] of {int};
	chan child_matchesConstraints24619 = [1] of {int};
	chan child_matchesConstraints2462 = [1] of {int};
	chan child_matchesConstraints2463 = [1] of {int};
	chan child_loadTrustedCerts4131 = [1] of {int};
	int var_chain = -2; // opt var_chain
	int var_trustedChains = -2; // opt var_trustedChains
	int var_trust_Certificates = -2; // opt var_trust_Certificates
	int var_trusted = -2; // opt var_trusted
	int var_trustedNonCAs = -2; // opt var_trustedNonCAs
	

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
	run loadTrustedCerts413(b_crlUpdateMutex,child_loadTrustedCerts4131);
	child_loadTrustedCerts4131?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: var_trustedNonCAs-1 != -3 -> 
						for(i : 0.. var_trustedNonCAs-1) {
				for30: skip;
				run matchesConstraints246(b_crlUpdateMutex,child_matchesConstraints2462);
				child_matchesConstraints2462?0;
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				for30_end: skip
			};
			for30_exit: skip
		:: else -> 
			do
			:: true -> 
				for345: skip;
				run matchesConstraints246(b_crlUpdateMutex,child_matchesConstraints2463);
				child_matchesConstraints2463?0;
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				for345_end: skip
			:: true -> 
				break
			od;
			for345_exit: skip
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: var_trusted-1 != -3 -> 
				for(i : 0.. var_trusted-1) {
			for40: skip;
			

			if
			:: var_trust_Certificates-1 != -3 -> 
								for(i : 0.. var_trust_Certificates-1) {
					for41: skip;
					

					if
					:: var_trustedChains-1 != -3 -> 
												for(i : 0.. var_trustedChains-1) {
							for42: skip;
							

							if
							:: var_chain-1 != -3 -> 
																for(i : 0.. var_chain-1) {
									for43: skip;
									run matchesConstraints246(b_crlUpdateMutex,child_matchesConstraints2464);
									child_matchesConstraints2464?0;
									for43_end: skip
								};
								for43_exit: skip
							:: else -> 
								do
								:: true -> 
									for44: skip;
									run matchesConstraints246(b_crlUpdateMutex,child_matchesConstraints2465);
									child_matchesConstraints2465?0;
									for44_end: skip
								:: true -> 
									break
								od;
								for44_exit: skip
							fi;
							for42_end: skip
						};
						for42_exit: skip
					:: else -> 
						do
						:: true -> 
							for45: skip;
							

							if
							:: var_chain-1 != -3 -> 
																for(i : 0.. var_chain-1) {
									for46: skip;
									run matchesConstraints246(b_crlUpdateMutex,child_matchesConstraints2466);
									child_matchesConstraints2466?0;
									for46_end: skip
								};
								for46_exit: skip
							:: else -> 
								do
								:: true -> 
									for47: skip;
									run matchesConstraints246(b_crlUpdateMutex,child_matchesConstraints2467);
									child_matchesConstraints2467?0;
									for47_end: skip
								:: true -> 
									break
								od;
								for47_exit: skip
							fi;
							for45_end: skip
						:: true -> 
							break
						od;
						for45_exit: skip
					fi;
					for41_end: skip
				};
				for41_exit: skip
			:: else -> 
				do
				:: true -> 
					for48: skip;
					

					if
					:: var_trustedChains-1 != -3 -> 
												for(i : 0.. var_trustedChains-1) {
							for49: skip;
							

							if
							:: var_chain-1 != -3 -> 
																for(i : 0.. var_chain-1) {
									for410: skip;
									run matchesConstraints246(b_crlUpdateMutex,child_matchesConstraints2468);
									child_matchesConstraints2468?0;
									for410_end: skip
								};
								for410_exit: skip
							:: else -> 
								do
								:: true -> 
									for411: skip;
									run matchesConstraints246(b_crlUpdateMutex,child_matchesConstraints2469);
									child_matchesConstraints2469?0;
									for411_end: skip
								:: true -> 
									break
								od;
								for411_exit: skip
							fi;
							for49_end: skip
						};
						for49_exit: skip
					:: else -> 
						do
						:: true -> 
							for412: skip;
							

							if
							:: var_chain-1 != -3 -> 
																for(i : 0.. var_chain-1) {
									for413: skip;
									run matchesConstraints246(b_crlUpdateMutex,child_matchesConstraints24610);
									child_matchesConstraints24610?0;
									for413_end: skip
								};
								for413_exit: skip
							:: else -> 
								do
								:: true -> 
									for414: skip;
									run matchesConstraints246(b_crlUpdateMutex,child_matchesConstraints24611);
									child_matchesConstraints24611?0;
									for414_end: skip
								:: true -> 
									break
								od;
								for414_exit: skip
							fi;
							for412_end: skip
						:: true -> 
							break
						od;
						for412_exit: skip
					fi;
					for48_end: skip
				:: true -> 
					break
				od;
				for48_exit: skip
			fi;
			for40_end: skip
		};
		for40_exit: skip
	:: else -> 
		do
		:: true -> 
			for415: skip;
			

			if
			:: var_trust_Certificates-1 != -3 -> 
								for(i : 0.. var_trust_Certificates-1) {
					for416: skip;
					

					if
					:: var_trustedChains-1 != -3 -> 
												for(i : 0.. var_trustedChains-1) {
							for417: skip;
							

							if
							:: var_chain-1 != -3 -> 
																for(i : 0.. var_chain-1) {
									for418: skip;
									run matchesConstraints246(b_crlUpdateMutex,child_matchesConstraints24612);
									child_matchesConstraints24612?0;
									for418_end: skip
								};
								for418_exit: skip
							:: else -> 
								do
								:: true -> 
									for419: skip;
									run matchesConstraints246(b_crlUpdateMutex,child_matchesConstraints24613);
									child_matchesConstraints24613?0;
									for419_end: skip
								:: true -> 
									break
								od;
								for419_exit: skip
							fi;
							for417_end: skip
						};
						for417_exit: skip
					:: else -> 
						do
						:: true -> 
							for420: skip;
							

							if
							:: var_chain-1 != -3 -> 
																for(i : 0.. var_chain-1) {
									for421: skip;
									run matchesConstraints246(b_crlUpdateMutex,child_matchesConstraints24614);
									child_matchesConstraints24614?0;
									for421_end: skip
								};
								for421_exit: skip
							:: else -> 
								do
								:: true -> 
									for422: skip;
									run matchesConstraints246(b_crlUpdateMutex,child_matchesConstraints24615);
									child_matchesConstraints24615?0;
									for422_end: skip
								:: true -> 
									break
								od;
								for422_exit: skip
							fi;
							for420_end: skip
						:: true -> 
							break
						od;
						for420_exit: skip
					fi;
					for416_end: skip
				};
				for416_exit: skip
			:: else -> 
				do
				:: true -> 
					for423: skip;
					

					if
					:: var_trustedChains-1 != -3 -> 
												for(i : 0.. var_trustedChains-1) {
							for424: skip;
							

							if
							:: var_chain-1 != -3 -> 
																for(i : 0.. var_chain-1) {
									for425: skip;
									run matchesConstraints246(b_crlUpdateMutex,child_matchesConstraints24616);
									child_matchesConstraints24616?0;
									for425_end: skip
								};
								for425_exit: skip
							:: else -> 
								do
								:: true -> 
									for426: skip;
									run matchesConstraints246(b_crlUpdateMutex,child_matchesConstraints24617);
									child_matchesConstraints24617?0;
									for426_end: skip
								:: true -> 
									break
								od;
								for426_exit: skip
							fi;
							for424_end: skip
						};
						for424_exit: skip
					:: else -> 
						do
						:: true -> 
							for427: skip;
							

							if
							:: var_chain-1 != -3 -> 
																for(i : 0.. var_chain-1) {
									for428: skip;
									run matchesConstraints246(b_crlUpdateMutex,child_matchesConstraints24618);
									child_matchesConstraints24618?0;
									for428_end: skip
								};
								for428_exit: skip
							:: else -> 
								do
								:: true -> 
									for429: skip;
									run matchesConstraints246(b_crlUpdateMutex,child_matchesConstraints24619);
									child_matchesConstraints24619?0;
									for429_end: skip
								:: true -> 
									break
								od;
								for429_exit: skip
							fi;
							for427_end: skip
						:: true -> 
							break
						od;
						for427_exit: skip
					fi;
					for423_end: skip
				:: true -> 
					break
				od;
				for423_exit: skip
			fi;
			for415_end: skip
		:: true -> 
			break
		od;
		for415_exit: skip
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype loadTrustedCerts413(Mutexdef b_crlUpdateMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Cert1781 = [1] of {int};
	chan child_Cert1782 = [1] of {int};
	int var_parsed = -2; // opt var_parsed
	int var_names = -2; // opt var_names
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	

	if
	:: var_names-1 != -3 -> 
				for(i : 0.. var_names-1) {
			for20: skip;
			run Cert178(b_crlUpdateMutex,child_Cert1781);
			child_Cert1781?0;
			

			if
			:: true -> 
				goto for20_end
			:: true;
			fi;
			

			if
			:: true -> 
				goto for20_end
			:: true;
			fi;
			

			if
			:: true -> 
				goto for20_end
			:: true;
			fi;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for23: skip;
			run Cert178(b_crlUpdateMutex,child_Cert1782);
			child_Cert1782?0;
			

			if
			:: true -> 
				goto for23_end
			:: true;
			fi;
			

			if
			:: true -> 
				goto for23_end
			:: true;
			fi;
			

			if
			:: true -> 
				goto for23_end
			:: true;
			fi;
			for23_end: skip
		:: true -> 
			break
		od;
		for23_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype matchesConstraints246(Mutexdef b_crlUpdateMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_matchesCertificateExtensions3819 = [1] of {int};
	chan child_matchesOrganizationalUnits3618 = [1] of {int};
	chan child_matchesURISANs3437 = [1] of {int};
	chan child_matchesEmailSANs3246 = [1] of {int};
	chan child_matchesDNSSANs3055 = [1] of {int};
	chan child_matchesCommonName2884 = [1] of {int};
	chan child_matchesNames2593 = [1] of {int};
	chan child_checkForChainInCRLs4672 = [1] of {int};
	run checkForChainInCRLs467(b_crlUpdateMutex,not_found_247,child_checkForChainInCRLs4672);
	child_checkForChainInCRLs4672?0;
	run matchesNames259(b_crlUpdateMutex,child_matchesNames2593);
	child_matchesNames2593?0;
	run matchesCommonName288(b_crlUpdateMutex,child_matchesCommonName2884);
	child_matchesCommonName2884?0;
	run matchesDNSSANs305(b_crlUpdateMutex,child_matchesDNSSANs3055);
	child_matchesDNSSANs3055?0;
	run matchesEmailSANs324(b_crlUpdateMutex,child_matchesEmailSANs3246);
	child_matchesEmailSANs3246?0;
	run matchesURISANs343(b_crlUpdateMutex,child_matchesURISANs3437);
	child_matchesURISANs3437?0;
	run matchesOrganizationalUnits361(b_crlUpdateMutex,child_matchesOrganizationalUnits3618);
	child_matchesOrganizationalUnits3618?0;
	run matchesCertificateExtensions381(b_crlUpdateMutex,child_matchesCertificateExtensions3819);
	child_matchesCertificateExtensions3819?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype checkForChainInCRLs467(Mutexdef b_crlUpdateMutex;int var_chain;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_findSerialInCRLs852 = [1] of {int};
	chan child_findSerialInCRLs853 = [1] of {int};
	

	if
	:: var_chain-1 != -3 -> 
				for(i : 0.. var_chain-1) {
			for31: skip;
			run findSerialInCRLs85(b_crlUpdateMutex,child_findSerialInCRLs852);
			child_findSerialInCRLs852?0;
			

			if
			:: true -> 
				break
			:: true;
			fi;
			for31_end: skip
		};
		for31_exit: skip
	:: else -> 
		do
		:: true -> 
			for34: skip;
			run findSerialInCRLs85(b_crlUpdateMutex,child_findSerialInCRLs853);
			child_findSerialInCRLs853?0;
			

			if
			:: true -> 
				break
			:: true;
			fi;
			for34_end: skip
		:: true -> 
			break
		od;
		for34_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype findSerialInCRLs85(Mutexdef b_crlUpdateMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_b_crls = -2; // opt var_b_crls
	b_crlUpdateMutex.RLock!false;
	goto defer1;
		defer1: skip;
	b_crlUpdateMutex.RUnlock!false;
	stop_process: skip;
	child!0
}
proctype matchesNames259(Mutexdef b_crlUpdateMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_clientCert_EmailAddresses = -2; // opt var_clientCert_EmailAddresses
	int var_clientCert_DNSNames = -2; // opt var_clientCert_DNSNames
	int var_config_Entry_AllowedNames = -2; // opt var_config_Entry_AllowedNames
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype matchesCommonName288(Mutexdef b_crlUpdateMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_config_Entry_AllowedCommonNames = -2; // opt var_config_Entry_AllowedCommonNames
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype matchesDNSSANs305(Mutexdef b_crlUpdateMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_clientCert_DNSNames = -2; // opt var_clientCert_DNSNames
	int var_config_Entry_AllowedDNSSANs = -2; // opt var_config_Entry_AllowedDNSSANs
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype matchesEmailSANs324(Mutexdef b_crlUpdateMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_clientCert_EmailAddresses = -2; // opt var_clientCert_EmailAddresses
	int var_config_Entry_AllowedEmailSANs = -2; // opt var_config_Entry_AllowedEmailSANs
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype matchesURISANs343(Mutexdef b_crlUpdateMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_clientCert_URIs = -2; // opt var_clientCert_URIs
	int var_config_Entry_AllowedURISANs = -2; // opt var_config_Entry_AllowedURISANs
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype matchesOrganizationalUnits361(Mutexdef b_crlUpdateMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_clientCert_Subject_OrganizationalUnit = -2; // opt var_clientCert_Subject_OrganizationalUnit
	int var_config_Entry_AllowedOrganizationalUnits = -2; // opt var_config_Entry_AllowedOrganizationalUnits
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype matchesCertificateExtensions381(Mutexdef b_crlUpdateMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_config_Entry_RequiredExtensions = -2; // opt var_config_Entry_RequiredExtensions
	int var_clientCert_Extensions = -2; // opt var_clientCert_Extensions
	

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
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype pathLoginRenew116(Mutexdef b_crlUpdateMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Cert1784 = [1] of {int};
	chan child_verifyCredentials1713 = [1] of {int};
	chan child_Config452 = [1] of {int};
	run Config45(b_crlUpdateMutex,child_Config452);
	child_Config452?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run verifyCredentials171(b_crlUpdateMutex,child_verifyCredentials1713);
		child_verifyCredentials1713?0;
		

		if
		:: true -> 
			goto stop_process
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			fi
		fi;
		

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
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	run Cert178(b_crlUpdateMutex,child_Cert1784);
	child_Cert1784?0;
	

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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Config45(Mutexdef b_crlUpdateMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype pathCertDelete211(Mutexdef b_crlUpdateMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype mutexMonitor(Mutexdef m) {
bool locked = false;
do
:: true ->
	if
	:: m.Counter > 0 ->
		if 
		:: m.RUnlock?false -> 
			m.Counter = m.Counter - 1;
		:: m.RLock?false -> 
			m.Counter = m.Counter + 1;
		fi;
	:: locked ->
		m.Unlock?false;
		locked = false;
	:: else ->	 end:	if
		:: m.Unlock?false ->
			assert(0==32);		:: m.Lock?false ->
			locked =true;
		:: m.RUnlock?false ->
			assert(0==32);		:: m.RLock?false ->
			m.Counter = m.Counter + 1;
		fi;
	fi;
od
}

proctype receiver(chan c) {
c?0
}

