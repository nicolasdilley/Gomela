typedef Chandef {
	chan c = [0] of {int};
	bool is_closed = false
}

bool a_closed = false
bool b_closed = false

init { 
	Chandef a
	Chandef b

	run main0(a,b);
	run receive1(a)
}

proctype main0(Chandef a;Chandef b) {

	if
	:: !a_closed ->
		if
		:: !b_closed ->
			(true -> assert(true) : assert(false))
		:: else ->
			assert(false)
		fi
	:: else ->
		assert(false)
	fi

	

//
}
proctype receive1(Chandef a) {
	a.c?0	
}
