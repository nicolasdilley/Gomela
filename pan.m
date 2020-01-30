#define rand	pan_rand
#define pthread_equal(a,b)	((a)==(b))
#if defined(HAS_CODE) && defined(VERBOSE)
	#ifdef BFS_PAR
		bfs_printf("Pr: %d Tr: %d\n", II, t->forw);
	#else
		cpu_printf("Pr: %d Tr: %d\n", II, t->forw);
	#endif
#endif
	switch (t->forw) {
	default: Uerror("bad forward move");
	case 0:	/* if without executable clauses */
		continue;
	case 1: /* generic 'goto' or 'skip' */
		IfNotBlocked
		_m = 3; goto P999;
	case 2: /* generic 'else' */
		IfNotBlocked
		if (trpt->o_pm&1) continue;
		_m = 3; goto P999;

		 /* PROC mainworker3 */
	case 3: // STATE 1 - /Users/nicolasdilley/go/src/github.com/nicolasdilley/gomela/results/test/main_main0.pml:40 - [a.in!0] (0:0:0 - 1)
		IfNotBlocked
		reached[2][1] = 1;
		if (q_full(((P2 *)_this)->a.in))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P2 *)_this)->a.in);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P2 *)_this)->a.in, 0, 0, 1);
		if (q_zero(((P2 *)_this)->a.in)) { boq = ((P2 *)_this)->a.in; };
		_m = 2; goto P999; /* 0 */
	case 4: // STATE 2 - /Users/nicolasdilley/go/src/github.com/nicolasdilley/gomela/results/test/main_main0.pml:41 - [child!0] (0:0:0 - 1)
		IfNotBlocked
		reached[2][2] = 1;
		if (q_full(((P2 *)_this)->child))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P2 *)_this)->child);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P2 *)_this)->child, 0, 0, 1);
		if (q_zero(((P2 *)_this)->child)) { boq = ((P2 *)_this)->child; };
		_m = 2; goto P999; /* 0 */
	case 5: // STATE 4 - /Users/nicolasdilley/go/src/github.com/nicolasdilley/gomela/results/test/main_main0.pml:43 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[2][4] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC go_mainworker3 */
	case 6: // STATE 1 - /Users/nicolasdilley/go/src/github.com/nicolasdilley/gomela/results/test/main_main0.pml:34 - [a.in!0] (0:0:0 - 1)
		IfNotBlocked
		reached[1][1] = 1;
		if (q_full(((P1 *)_this)->a.in))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P1 *)_this)->a.in);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P1 *)_this)->a.in, 0, 0, 1);
		if (q_zero(((P1 *)_this)->a.in)) { boq = ((P1 *)_this)->a.in; };
		_m = 2; goto P999; /* 0 */
	case 7: // STATE 3 - /Users/nicolasdilley/go/src/github.com/nicolasdilley/gomela/results/test/main_main0.pml:36 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[1][3] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC :init: */
	case 8: // STATE 1 - /Users/nicolasdilley/go/src/github.com/nicolasdilley/gomela/results/test/main_main0.pml:17 - [ch0.in = ch0_in] (0:11:2 - 1)
		IfNotBlocked
		reached[0][1] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((P0 *)_this)->_ch0.in;
		((P0 *)_this)->_ch0.in = ((P0 *)_this)->_ch0_in;
#ifdef VAR_RANGES
		logval(":init::ch0.in", ((P0 *)_this)->_ch0.in);
#endif
		;
		/* merge: i = 1(11, 2, 11) */
		reached[0][2] = 1;
		(trpt+1)->bup.ovals[1] = ((P0 *)_this)->i;
		((P0 *)_this)->i = 1;
#ifdef VAR_RANGES
		logval(":init::i", ((P0 *)_this)->i);
#endif
		;
		/* merge: .(goto)(0, 12, 11) */
		reached[0][12] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 9: // STATE 3 - /Users/nicolasdilley/go/src/github.com/nicolasdilley/gomela/results/test/main_main0.pml:18 - [((i<=5))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][3] = 1;
		if (!((((P0 *)_this)->i<=5)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 10: // STATE 4 - /Users/nicolasdilley/go/src/github.com/nicolasdilley/gomela/results/test/main_main0.pml:19 - [(run go_mainworker3(ch0.in,ch0.sending,ch0.closing,ch0.is_closed))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][4] = 1;
		if (!(addproc(II, 1, 1, ((P0 *)_this)->_ch0.in, ((P0 *)_this)->_ch0.sending, ((P0 *)_this)->_ch0.closing, ((P0 *)_this)->_ch0.is_closed, 0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 11: // STATE 5 - /Users/nicolasdilley/go/src/github.com/nicolasdilley/gomela/results/test/main_main0.pml:20 - [(run go_mainworker3(ch0.in,ch0.sending,ch0.closing,ch0.is_closed))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][5] = 1;
		if (!(addproc(II, 1, 1, ((P0 *)_this)->_ch0.in, ((P0 *)_this)->_ch0.sending, ((P0 *)_this)->_ch0.closing, ((P0 *)_this)->_ch0.is_closed, 0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 12: // STATE 6 - /Users/nicolasdilley/go/src/github.com/nicolasdilley/gomela/results/test/main_main0.pml:22 - [(run mainworker3(ch0.in,ch0.sending,ch0.closing,ch0.is_closed,child_mainworker30))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][6] = 1;
		if (!(addproc(II, 1, 2, ((P0 *)_this)->_ch0.in, ((P0 *)_this)->_ch0.sending, ((P0 *)_this)->_ch0.closing, ((P0 *)_this)->_ch0.is_closed, ((P0 *)_this)->_2_6_child_mainworker30)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 13: // STATE 7 - /Users/nicolasdilley/go/src/github.com/nicolasdilley/gomela/results/test/main_main0.pml:23 - [child_mainworker30?0] (0:0:0 - 1)
		reached[0][7] = 1;
		if (q_zero(((P0 *)_this)->_2_6_child_mainworker30))
		{	if (boq != ((P0 *)_this)->_2_6_child_mainworker30) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(((P0 *)_this)->_2_6_child_mainworker30) == 0) continue;

		XX=1;
		if (0 != qrecv(((P0 *)_this)->_2_6_child_mainworker30, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(((P0 *)_this)->_2_6_child_mainworker30-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(((P0 *)_this)->_2_6_child_mainworker30, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P0 *)_this)->_2_6_child_mainworker30);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P0 *)_this)->_2_6_child_mainworker30))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		_m = 4; goto P999; /* 0 */
	case 14: // STATE 8 - /Users/nicolasdilley/go/src/github.com/nicolasdilley/gomela/results/test/main_main0.pml:18 - [i = (i+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[0][8] = 1;
		(trpt+1)->bup.oval = ((P0 *)_this)->i;
		((P0 *)_this)->i = (((P0 *)_this)->i+1);
#ifdef VAR_RANGES
		logval(":init::i", ((P0 *)_this)->i);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 15: // STATE 14 - /Users/nicolasdilley/go/src/github.com/nicolasdilley/gomela/results/test/main_main0.pml:25 - [i = 1] (0:20:1 - 3)
		IfNotBlocked
		reached[0][14] = 1;
		(trpt+1)->bup.oval = ((P0 *)_this)->i;
		((P0 *)_this)->i = 1;
#ifdef VAR_RANGES
		logval(":init::i", ((P0 *)_this)->i);
#endif
		;
		/* merge: .(goto)(0, 21, 20) */
		reached[0][21] = 1;
		;
		_m = 3; goto P999; /* 1 */
	case 16: // STATE 15 - /Users/nicolasdilley/go/src/github.com/nicolasdilley/gomela/results/test/main_main0.pml:25 - [((i<=5))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][15] = 1;
		if (!((((P0 *)_this)->i<=5)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 17: // STATE 16 - /Users/nicolasdilley/go/src/github.com/nicolasdilley/gomela/results/test/main_main0.pml:26 - [ch0.in?0] (0:0:0 - 1)
		reached[0][16] = 1;
		if (q_zero(((P0 *)_this)->_ch0.in))
		{	if (boq != ((P0 *)_this)->_ch0.in) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(((P0 *)_this)->_ch0.in) == 0) continue;

		XX=1;
		if (0 != qrecv(((P0 *)_this)->_ch0.in, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(((P0 *)_this)->_ch0.in-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(((P0 *)_this)->_ch0.in, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P0 *)_this)->_ch0.in);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P0 *)_this)->_ch0.in))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		_m = 4; goto P999; /* 0 */
	case 18: // STATE 17 - /Users/nicolasdilley/go/src/github.com/nicolasdilley/gomela/results/test/main_main0.pml:25 - [i = (i+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[0][17] = 1;
		(trpt+1)->bup.oval = ((P0 *)_this)->i;
		((P0 *)_this)->i = (((P0 *)_this)->i+1);
#ifdef VAR_RANGES
		logval(":init::i", ((P0 *)_this)->i);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 19: // STATE 24 - /Users/nicolasdilley/go/src/github.com/nicolasdilley/gomela/results/test/main_main0.pml:29 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[0][24] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */
	case  _T5:	/* np_ */
		if (!((!(trpt->o_pm&4) && !(trpt->tau&128))))
			continue;
		/* else fall through */
	case  _T2:	/* true */
		_m = 3; goto P999;
#undef rand
	}

