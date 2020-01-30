	switch (t->back) {
	default: Uerror("bad return move");
	case  0: goto R999; /* nothing to undo */

		 /* PROC mainworker3 */

	case 3: // STATE 1
		;
		_m = unsend(((P2 *)_this)->a.in);
		;
		goto R999;

	case 4: // STATE 2
		;
		_m = unsend(((P2 *)_this)->child);
		;
		goto R999;

	case 5: // STATE 4
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC go_mainworker3 */

	case 6: // STATE 1
		;
		_m = unsend(((P1 *)_this)->a.in);
		;
		goto R999;

	case 7: // STATE 3
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC :init: */

	case 8: // STATE 2
		;
		((P0 *)_this)->i = trpt->bup.ovals[1];
		((P0 *)_this)->_ch0.in = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;
;
		;
		
	case 10: // STATE 4
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 11: // STATE 5
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 12: // STATE 6
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 13: // STATE 7
		;
		XX = 1;
		unrecv(((P0 *)_this)->_2_6_child_mainworker30, XX-1, 0, 0, 1);
		;
		;
		goto R999;

	case 14: // STATE 8
		;
		((P0 *)_this)->i = trpt->bup.oval;
		;
		goto R999;

	case 15: // STATE 14
		;
		((P0 *)_this)->i = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 17: // STATE 16
		;
		XX = 1;
		unrecv(((P0 *)_this)->_ch0.in, XX-1, 0, 0, 1);
		;
		;
		goto R999;

	case 18: // STATE 17
		;
		((P0 *)_this)->i = trpt->bup.oval;
		;
		goto R999;

	case 19: // STATE 24
		;
		p_restor(II);
		;
		;
		goto R999;
	}

