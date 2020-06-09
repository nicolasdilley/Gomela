



init { 
	bool state = false;
	int i;
	do
	:: true -> 
for10:
	od;
	do
	:: true -> 
for20:
	od;
	do
	:: true -> 
for30:
	od;
	do
	:: true -> 
for40:		run Anonymous0()
	od;
	do
	:: true -> 
for50:
	od
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
stop_process:
}
