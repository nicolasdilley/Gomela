
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example243985870/unmaintained/load_test/load_test_leveldb/load_test_leveldb.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int totalTenants = 5;
	int ch = 5;
	bool state = false;
	int dbCount = 5;
	int totalYears = 5;
	int i;
	
	if
	:: 0 != -1 && dbCount-1 != -1 -> 
				for(i : 0.. dbCount-1) {
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
		for(i : 0.. dbCount-1) {
for20:		wg.Add!1;
		run Anonymous0(wg)
	};
for20_exit:	
	if
	:: 0 != -1 && totalYears-1 != -1 -> 
				for(i : 0.. totalYears-1) {
for30:			
			if
			:: 0 != -1 && 12-1 != -1 -> 
								for(i : 0.. 12-1) {
for31:					
					if
					:: 0 != -1 && 31-1 != -1 -> 
												for(i : 0.. 31-1) {
for32:							
							if
							:: 0 != -1 && 24-1 != -1 -> 
																for(i : 0.. 24-1) {
for33:									
									if
									:: 0 != -1 && 60-1 != -1 -> 
																				for(i : 0.. 60-1) {
for34:											
											if
											:: 0 != -1 && totalTenants-1 != -1 -> 
																								for(i : 0.. totalTenants-1) {
for35:
												}
											:: else -> 
												do
												:: true -> 
for35:
												:: true -> 
													break
												od
											fi;
for35_exit:
										}
									:: else -> 
										do
										:: true -> 
for34:											
											if
											:: 0 != -1 && totalTenants-1 != -1 -> 
																								for(i : 0.. totalTenants-1) {
for35:
												}
											:: else -> 
												do
												:: true -> 
for35:
												:: true -> 
													break
												od
											fi;
for35_exit:
										:: true -> 
											break
										od
									fi;
for34_exit:
								}
							:: else -> 
								do
								:: true -> 
for33:									
									if
									:: 0 != -1 && 60-1 != -1 -> 
																				for(i : 0.. 60-1) {
for34:											
											if
											:: 0 != -1 && totalTenants-1 != -1 -> 
																								for(i : 0.. totalTenants-1) {
for35:
												}
											:: else -> 
												do
												:: true -> 
for35:
												:: true -> 
													break
												od
											fi;
for35_exit:
										}
									:: else -> 
										do
										:: true -> 
for34:											
											if
											:: 0 != -1 && totalTenants-1 != -1 -> 
																								for(i : 0.. totalTenants-1) {
for35:
												}
											:: else -> 
												do
												:: true -> 
for35:
												:: true -> 
													break
												od
											fi;
for35_exit:
										:: true -> 
											break
										od
									fi;
for34_exit:
								:: true -> 
									break
								od
							fi;
for33_exit:
						}
					:: else -> 
						do
						:: true -> 
for32:							
							if
							:: 0 != -1 && 24-1 != -1 -> 
																for(i : 0.. 24-1) {
for33:									
									if
									:: 0 != -1 && 60-1 != -1 -> 
																				for(i : 0.. 60-1) {
for34:											
											if
											:: 0 != -1 && totalTenants-1 != -1 -> 
																								for(i : 0.. totalTenants-1) {
for35:
												}
											:: else -> 
												do
												:: true -> 
for35:
												:: true -> 
													break
												od
											fi;
for35_exit:
										}
									:: else -> 
										do
										:: true -> 
for34:											
											if
											:: 0 != -1 && totalTenants-1 != -1 -> 
																								for(i : 0.. totalTenants-1) {
for35:
												}
											:: else -> 
												do
												:: true -> 
for35:
												:: true -> 
													break
												od
											fi;
for35_exit:
										:: true -> 
											break
										od
									fi;
for34_exit:
								}
							:: else -> 
								do
								:: true -> 
for33:									
									if
									:: 0 != -1 && 60-1 != -1 -> 
																				for(i : 0.. 60-1) {
for34:											
											if
											:: 0 != -1 && totalTenants-1 != -1 -> 
																								for(i : 0.. totalTenants-1) {
for35:
												}
											:: else -> 
												do
												:: true -> 
for35:
												:: true -> 
													break
												od
											fi;
for35_exit:
										}
									:: else -> 
										do
										:: true -> 
for34:											
											if
											:: 0 != -1 && totalTenants-1 != -1 -> 
																								for(i : 0.. totalTenants-1) {
for35:
												}
											:: else -> 
												do
												:: true -> 
for35:
												:: true -> 
													break
												od
											fi;
for35_exit:
										:: true -> 
											break
										od
									fi;
for34_exit:
								:: true -> 
									break
								od
							fi;
for33_exit:
						:: true -> 
							break
						od
					fi;
for32_exit:
				}
			:: else -> 
				do
				:: true -> 
for31:					
					if
					:: 0 != -1 && 31-1 != -1 -> 
												for(i : 0.. 31-1) {
for32:							
							if
							:: 0 != -1 && 24-1 != -1 -> 
																for(i : 0.. 24-1) {
for33:									
									if
									:: 0 != -1 && 60-1 != -1 -> 
																				for(i : 0.. 60-1) {
for34:											
											if
											:: 0 != -1 && totalTenants-1 != -1 -> 
																								for(i : 0.. totalTenants-1) {
for35:
												}
											:: else -> 
												do
												:: true -> 
for35:
												:: true -> 
													break
												od
											fi;
for35_exit:
										}
									:: else -> 
										do
										:: true -> 
for34:											
											if
											:: 0 != -1 && totalTenants-1 != -1 -> 
																								for(i : 0.. totalTenants-1) {
for35:
												}
											:: else -> 
												do
												:: true -> 
for35:
												:: true -> 
													break
												od
											fi;
for35_exit:
										:: true -> 
											break
										od
									fi;
for34_exit:
								}
							:: else -> 
								do
								:: true -> 
for33:									
									if
									:: 0 != -1 && 60-1 != -1 -> 
																				for(i : 0.. 60-1) {
for34:											
											if
											:: 0 != -1 && totalTenants-1 != -1 -> 
																								for(i : 0.. totalTenants-1) {
for35:
												}
											:: else -> 
												do
												:: true -> 
for35:
												:: true -> 
													break
												od
											fi;
for35_exit:
										}
									:: else -> 
										do
										:: true -> 
for34:											
											if
											:: 0 != -1 && totalTenants-1 != -1 -> 
																								for(i : 0.. totalTenants-1) {
for35:
												}
											:: else -> 
												do
												:: true -> 
for35:
												:: true -> 
													break
												od
											fi;
for35_exit:
										:: true -> 
											break
										od
									fi;
for34_exit:
								:: true -> 
									break
								od
							fi;
for33_exit:
						}
					:: else -> 
						do
						:: true -> 
for32:							
							if
							:: 0 != -1 && 24-1 != -1 -> 
																for(i : 0.. 24-1) {
for33:									
									if
									:: 0 != -1 && 60-1 != -1 -> 
																				for(i : 0.. 60-1) {
for34:											
											if
											:: 0 != -1 && totalTenants-1 != -1 -> 
																								for(i : 0.. totalTenants-1) {
for35:
												}
											:: else -> 
												do
												:: true -> 
for35:
												:: true -> 
													break
												od
											fi;
for35_exit:
										}
									:: else -> 
										do
										:: true -> 
for34:											
											if
											:: 0 != -1 && totalTenants-1 != -1 -> 
																								for(i : 0.. totalTenants-1) {
for35:
												}
											:: else -> 
												do
												:: true -> 
for35:
												:: true -> 
													break
												od
											fi;
for35_exit:
										:: true -> 
											break
										od
									fi;
for34_exit:
								}
							:: else -> 
								do
								:: true -> 
for33:									
									if
									:: 0 != -1 && 60-1 != -1 -> 
																				for(i : 0.. 60-1) {
for34:											
											if
											:: 0 != -1 && totalTenants-1 != -1 -> 
																								for(i : 0.. totalTenants-1) {
for35:
												}
											:: else -> 
												do
												:: true -> 
for35:
												:: true -> 
													break
												od
											fi;
for35_exit:
										}
									:: else -> 
										do
										:: true -> 
for34:											
											if
											:: 0 != -1 && totalTenants-1 != -1 -> 
																								for(i : 0.. totalTenants-1) {
for35:
												}
											:: else -> 
												do
												:: true -> 
for35:
												:: true -> 
													break
												od
											fi;
for35_exit:
										:: true -> 
											break
										od
									fi;
for34_exit:
								:: true -> 
									break
								od
							fi;
for33_exit:
						:: true -> 
							break
						od
					fi;
for32_exit:
				:: true -> 
					break
				od
			fi;
for31_exit:
		}
	:: else -> 
		do
		:: true -> 
for30:			
			if
			:: 0 != -1 && 12-1 != -1 -> 
								for(i : 0.. 12-1) {
for31:					
					if
					:: 0 != -1 && 31-1 != -1 -> 
												for(i : 0.. 31-1) {
for32:							
							if
							:: 0 != -1 && 24-1 != -1 -> 
																for(i : 0.. 24-1) {
for33:									
									if
									:: 0 != -1 && 60-1 != -1 -> 
																				for(i : 0.. 60-1) {
for34:											
											if
											:: 0 != -1 && totalTenants-1 != -1 -> 
																								for(i : 0.. totalTenants-1) {
for35:
												}
											:: else -> 
												do
												:: true -> 
for35:
												:: true -> 
													break
												od
											fi;
for35_exit:
										}
									:: else -> 
										do
										:: true -> 
for34:											
											if
											:: 0 != -1 && totalTenants-1 != -1 -> 
																								for(i : 0.. totalTenants-1) {
for35:
												}
											:: else -> 
												do
												:: true -> 
for35:
												:: true -> 
													break
												od
											fi;
for35_exit:
										:: true -> 
											break
										od
									fi;
for34_exit:
								}
							:: else -> 
								do
								:: true -> 
for33:									
									if
									:: 0 != -1 && 60-1 != -1 -> 
																				for(i : 0.. 60-1) {
for34:											
											if
											:: 0 != -1 && totalTenants-1 != -1 -> 
																								for(i : 0.. totalTenants-1) {
for35:
												}
											:: else -> 
												do
												:: true -> 
for35:
												:: true -> 
													break
												od
											fi;
for35_exit:
										}
									:: else -> 
										do
										:: true -> 
for34:											
											if
											:: 0 != -1 && totalTenants-1 != -1 -> 
																								for(i : 0.. totalTenants-1) {
for35:
												}
											:: else -> 
												do
												:: true -> 
for35:
												:: true -> 
													break
												od
											fi;
for35_exit:
										:: true -> 
											break
										od
									fi;
for34_exit:
								:: true -> 
									break
								od
							fi;
for33_exit:
						}
					:: else -> 
						do
						:: true -> 
for32:							
							if
							:: 0 != -1 && 24-1 != -1 -> 
																for(i : 0.. 24-1) {
for33:									
									if
									:: 0 != -1 && 60-1 != -1 -> 
																				for(i : 0.. 60-1) {
for34:											
											if
											:: 0 != -1 && totalTenants-1 != -1 -> 
																								for(i : 0.. totalTenants-1) {
for35:
												}
											:: else -> 
												do
												:: true -> 
for35:
												:: true -> 
													break
												od
											fi;
for35_exit:
										}
									:: else -> 
										do
										:: true -> 
for34:											
											if
											:: 0 != -1 && totalTenants-1 != -1 -> 
																								for(i : 0.. totalTenants-1) {
for35:
												}
											:: else -> 
												do
												:: true -> 
for35:
												:: true -> 
													break
												od
											fi;
for35_exit:
										:: true -> 
											break
										od
									fi;
for34_exit:
								}
							:: else -> 
								do
								:: true -> 
for33:									
									if
									:: 0 != -1 && 60-1 != -1 -> 
																				for(i : 0.. 60-1) {
for34:											
											if
											:: 0 != -1 && totalTenants-1 != -1 -> 
																								for(i : 0.. totalTenants-1) {
for35:
												}
											:: else -> 
												do
												:: true -> 
for35:
												:: true -> 
													break
												od
											fi;
for35_exit:
										}
									:: else -> 
										do
										:: true -> 
for34:											
											if
											:: 0 != -1 && totalTenants-1 != -1 -> 
																								for(i : 0.. totalTenants-1) {
for35:
												}
											:: else -> 
												do
												:: true -> 
for35:
												:: true -> 
													break
												od
											fi;
for35_exit:
										:: true -> 
											break
										od
									fi;
for34_exit:
								:: true -> 
									break
								od
							fi;
for33_exit:
						:: true -> 
							break
						od
					fi;
for32_exit:
				}
			:: else -> 
				do
				:: true -> 
for31:					
					if
					:: 0 != -1 && 31-1 != -1 -> 
												for(i : 0.. 31-1) {
for32:							
							if
							:: 0 != -1 && 24-1 != -1 -> 
																for(i : 0.. 24-1) {
for33:									
									if
									:: 0 != -1 && 60-1 != -1 -> 
																				for(i : 0.. 60-1) {
for34:											
											if
											:: 0 != -1 && totalTenants-1 != -1 -> 
																								for(i : 0.. totalTenants-1) {
for35:
												}
											:: else -> 
												do
												:: true -> 
for35:
												:: true -> 
													break
												od
											fi;
for35_exit:
										}
									:: else -> 
										do
										:: true -> 
for34:											
											if
											:: 0 != -1 && totalTenants-1 != -1 -> 
																								for(i : 0.. totalTenants-1) {
for35:
												}
											:: else -> 
												do
												:: true -> 
for35:
												:: true -> 
													break
												od
											fi;
for35_exit:
										:: true -> 
											break
										od
									fi;
for34_exit:
								}
							:: else -> 
								do
								:: true -> 
for33:									
									if
									:: 0 != -1 && 60-1 != -1 -> 
																				for(i : 0.. 60-1) {
for34:											
											if
											:: 0 != -1 && totalTenants-1 != -1 -> 
																								for(i : 0.. totalTenants-1) {
for35:
												}
											:: else -> 
												do
												:: true -> 
for35:
												:: true -> 
													break
												od
											fi;
for35_exit:
										}
									:: else -> 
										do
										:: true -> 
for34:											
											if
											:: 0 != -1 && totalTenants-1 != -1 -> 
																								for(i : 0.. totalTenants-1) {
for35:
												}
											:: else -> 
												do
												:: true -> 
for35:
												:: true -> 
													break
												od
											fi;
for35_exit:
										:: true -> 
											break
										od
									fi;
for34_exit:
								:: true -> 
									break
								od
							fi;
for33_exit:
						}
					:: else -> 
						do
						:: true -> 
for32:							
							if
							:: 0 != -1 && 24-1 != -1 -> 
																for(i : 0.. 24-1) {
for33:									
									if
									:: 0 != -1 && 60-1 != -1 -> 
																				for(i : 0.. 60-1) {
for34:											
											if
											:: 0 != -1 && totalTenants-1 != -1 -> 
																								for(i : 0.. totalTenants-1) {
for35:
												}
											:: else -> 
												do
												:: true -> 
for35:
												:: true -> 
													break
												od
											fi;
for35_exit:
										}
									:: else -> 
										do
										:: true -> 
for34:											
											if
											:: 0 != -1 && totalTenants-1 != -1 -> 
																								for(i : 0.. totalTenants-1) {
for35:
												}
											:: else -> 
												do
												:: true -> 
for35:
												:: true -> 
													break
												od
											fi;
for35_exit:
										:: true -> 
											break
										od
									fi;
for34_exit:
								}
							:: else -> 
								do
								:: true -> 
for33:									
									if
									:: 0 != -1 && 60-1 != -1 -> 
																				for(i : 0.. 60-1) {
for34:											
											if
											:: 0 != -1 && totalTenants-1 != -1 -> 
																								for(i : 0.. totalTenants-1) {
for35:
												}
											:: else -> 
												do
												:: true -> 
for35:
												:: true -> 
													break
												od
											fi;
for35_exit:
										}
									:: else -> 
										do
										:: true -> 
for34:											
											if
											:: 0 != -1 && totalTenants-1 != -1 -> 
																								for(i : 0.. totalTenants-1) {
for35:
												}
											:: else -> 
												do
												:: true -> 
for35:
												:: true -> 
													break
												od
											fi;
for35_exit:
										:: true -> 
											break
										od
									fi;
for34_exit:
								:: true -> 
									break
								od
							fi;
for33_exit:
						:: true -> 
							break
						od
					fi;
for32_exit:
				:: true -> 
					break
				od
			fi;
for31_exit:
		:: true -> 
			break
		od
	fi;
for30_exit:	
	if
	:: 0 != -1 && dbCount-1 != -1 -> 
				for(i : 0.. dbCount-1) {
for40:
		}
	:: else -> 
		do
		:: true -> 
for40:
		:: true -> 
			break
		od
	fi;
for40_exit:	wg.Wait?0
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	do
	:: true -> 
for21:
	:: true -> 
		break
	od;
	wg.Add!-1;
stop_process:
}
proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
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
