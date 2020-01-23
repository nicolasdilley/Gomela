
chan fork2 = [0] of {bool};
chan fork3 = [0] of {bool};
chan fork1 = [0] of {bool};

init {
	run philo(fork1,fork2)
	run philo(fork3,fork1)
	run philo(fork2,fork3)
	run aFork(fork1)
	run aFork(fork2)
	run aFork(fork3)
}

proctype philo(chan left,right) {

	bool val

	do
	:: right?val ->
		if 
		:: left?val ->
			left!true;
			right!true;
			printf("Eat")
		/* :: right!true */
			
		fi
	:: left?val ->
		if
		::	right?val ->
			left!true
			right!true
			printf("Eat")
		/*:: left!true*/
		fi
	od
}


proctype aFork(chan c1) 
{
	bool data
	do
	:: c1!true ->
		c1?data
	od;
}