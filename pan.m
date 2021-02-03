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

		 /* PROC sync_monitor */
	case 3: // STATE 2 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:118 - [(ch.closed)] (0:0:0 - 1)
		IfNotBlocked
		reached[2][2] = 1;
		if (!(((int)((P2 *)this)->ch.closed)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 4: // STATE 3 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:120 - [ch.async_send?0] (0:0:0 - 1)
		reached[2][3] = 1;
		if (boq != ((P2 *)this)->ch.async_send) continue;
		if (q_len(((P2 *)this)->ch.async_send) == 0) continue;

		XX=1;
		if (0 != qrecv(((P2 *)this)->ch.async_send, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(((P2 *)this)->ch.async_send-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(((P2 *)this)->ch.async_send, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P2 *)this)->ch.async_send);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P2 *)this)->ch.async_send))
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
	case 5: // STATE 4 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:121 - [assert(0)] (0:0:0 - 1)
		IfNotBlocked
		reached[2][4] = 1;
		spin_assert(0, "0", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 6: // STATE 5 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:122 - [ch.closing?1] (0:0:0 - 1)
		reached[2][5] = 1;
		if (boq != ((P2 *)this)->ch.closing) continue;
		if (q_len(((P2 *)this)->ch.closing) == 0) continue;

		XX=1;
		if (1 != qrecv(((P2 *)this)->ch.closing, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(((P2 *)this)->ch.closing-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(((P2 *)this)->ch.closing, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P2 *)this)->ch.closing);
		sprintf(simtmp, "%d", 1); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P2 *)this)->ch.closing))
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
	case 7: // STATE 6 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:123 - [assert(0)] (0:0:0 - 1)
		IfNotBlocked
		reached[2][6] = 1;
		spin_assert(0, "0", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 8: // STATE 7 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:124 - [ch.sending!1] (0:0:0 - 1)
		IfNotBlocked
		reached[2][7] = 1;
		if (q_len(((P2 *)this)->ch.sending))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P2 *)this)->ch.sending);
		sprintf(simtmp, "%d", 1); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P2 *)this)->ch.sending, 0, 1, 0, 1);
		{ boq = ((P2 *)this)->ch.sending; };
		_m = 2; goto P999; /* 0 */
	case 9: // STATE 8 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:125 - [assert(0)] (0:0:0 - 1)
		IfNotBlocked
		reached[2][8] = 1;
		spin_assert(0, "0", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 10: // STATE 9 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:126 - [ch.sync!1,0] (0:0:0 - 1)
		IfNotBlocked
		reached[2][9] = 1;
		if (q_len(((P2 *)this)->ch.sync))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P2 *)this)->ch.sync);
		sprintf(simtmp, "%d", 1); strcat(simvals, simtmp);		strcat(simvals, ",");
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P2 *)this)->ch.sync, 0, 1, 0, 2);
		{ boq = ((P2 *)this)->ch.sync; };
		_m = 2; goto P999; /* 0 */
	case 11: // STATE 13 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:130 - [ch.sending!0] (0:0:0 - 1)
		IfNotBlocked
		reached[2][13] = 1;
		if (q_len(((P2 *)this)->ch.sending))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P2 *)this)->ch.sending);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P2 *)this)->ch.sending, 0, 0, 0, 1);
		{ boq = ((P2 *)this)->ch.sending; };
		_m = 2; goto P999; /* 0 */
	case 12: // STATE 14 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:131 - [ch.closing?1] (0:0:0 - 1)
		reached[2][14] = 1;
		if (boq != ((P2 *)this)->ch.closing) continue;
		if (q_len(((P2 *)this)->ch.closing) == 0) continue;

		XX=1;
		if (1 != qrecv(((P2 *)this)->ch.closing, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(((P2 *)this)->ch.closing-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(((P2 *)this)->ch.closing, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P2 *)this)->ch.closing);
		sprintf(simtmp, "%d", 1); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P2 *)this)->ch.closing))
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
	case 13: // STATE 15 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:132 - [ch.closed = 1] (0:0:1 - 1)
		IfNotBlocked
		reached[2][15] = 1;
		(trpt+1)->bup.oval = ((int)((P2 *)this)->ch.closed);
		((P2 *)this)->ch.closed = 1;
#ifdef VAR_RANGES
		logval("sync_monitor:ch.closed", ((int)((P2 *)this)->ch.closed));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 14: // STATE 24 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:137 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[2][24] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC AsyncChan */
	case 15: // STATE 2 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:70 - [(ch.closed)] (0:0:0 - 1)
		IfNotBlocked
		reached[1][2] = 1;
		if (!(((int)((P1 *)this)->ch.closed)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 16: // STATE 3 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:72 - [ch.async_send?0] (0:0:0 - 1)
		reached[1][3] = 1;
		if (boq != ((P1 *)this)->ch.async_send) continue;
		if (q_len(((P1 *)this)->ch.async_send) == 0) continue;

		XX=1;
		if (0 != qrecv(((P1 *)this)->ch.async_send, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(((P1 *)this)->ch.async_send-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(((P1 *)this)->ch.async_send, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P1 *)this)->ch.async_send);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P1 *)this)->ch.async_send))
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
	case 17: // STATE 4 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:73 - [assert(0)] (0:0:0 - 1)
		IfNotBlocked
		reached[1][4] = 1;
		spin_assert(0, "0", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 18: // STATE 5 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:74 - [ch.closing?1] (0:0:0 - 1)
		reached[1][5] = 1;
		if (boq != ((P1 *)this)->ch.closing) continue;
		if (q_len(((P1 *)this)->ch.closing) == 0) continue;

		XX=1;
		if (1 != qrecv(((P1 *)this)->ch.closing, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(((P1 *)this)->ch.closing-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(((P1 *)this)->ch.closing, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P1 *)this)->ch.closing);
		sprintf(simtmp, "%d", 1); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P1 *)this)->ch.closing))
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
	case 19: // STATE 6 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:75 - [assert(0)] (0:0:0 - 1)
		IfNotBlocked
		reached[1][6] = 1;
		spin_assert(0, "0", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 20: // STATE 7 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:76 - [ch.sending!1] (0:0:0 - 1)
		IfNotBlocked
		reached[1][7] = 1;
		if (q_len(((P1 *)this)->ch.sending))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P1 *)this)->ch.sending);
		sprintf(simtmp, "%d", 1); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P1 *)this)->ch.sending, 0, 1, 0, 1);
		{ boq = ((P1 *)this)->ch.sending; };
		_m = 2; goto P999; /* 0 */
	case 21: // STATE 8 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:77 - [assert(0)] (0:0:0 - 1)
		IfNotBlocked
		reached[1][8] = 1;
		spin_assert(0, "0", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 22: // STATE 9 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:78 - [ch.sync!1,ch.num_msgs] (0:0:0 - 1)
		IfNotBlocked
		reached[1][9] = 1;
		if (q_len(((P1 *)this)->ch.sync))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P1 *)this)->ch.sync);
		sprintf(simtmp, "%d", 1); strcat(simvals, simtmp);		strcat(simvals, ",");
		sprintf(simtmp, "%d", ((P1 *)this)->ch.num_msgs); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P1 *)this)->ch.sync, 0, 1, ((P1 *)this)->ch.num_msgs, 2);
		{ boq = ((P1 *)this)->ch.sync; };
		_m = 2; goto P999; /* 0 */
	case 23: // STATE 10 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:79 - [ch.num_msgs = (ch.num_msgs-1)] (0:0:1 - 1)
		IfNotBlocked
		reached[1][10] = 1;
		(trpt+1)->bup.oval = ((P1 *)this)->ch.num_msgs;
		((P1 *)this)->ch.num_msgs = (((P1 *)this)->ch.num_msgs-1);
#ifdef VAR_RANGES
		logval("AsyncChan:ch.num_msgs", ((P1 *)this)->ch.num_msgs);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 24: // STATE 14 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:83 - [((ch.num_msgs==ch.size))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][14] = 1;
		if (!((((P1 *)this)->ch.num_msgs==((P1 *)this)->ch.size)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 25: // STATE 15 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:85 - [ch.async_rcv!0,ch.num_msgs] (0:0:0 - 1)
		IfNotBlocked
		reached[1][15] = 1;
		if (q_len(((P1 *)this)->ch.async_rcv))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P1 *)this)->ch.async_rcv);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		strcat(simvals, ",");
		sprintf(simtmp, "%d", ((P1 *)this)->ch.num_msgs); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P1 *)this)->ch.async_rcv, 0, 0, ((P1 *)this)->ch.num_msgs, 2);
		{ boq = ((P1 *)this)->ch.async_rcv; };
		_m = 2; goto P999; /* 0 */
	case 26: // STATE 16 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:86 - [ch.num_msgs = (ch.num_msgs-1)] (0:0:1 - 1)
		IfNotBlocked
		reached[1][16] = 1;
		(trpt+1)->bup.oval = ((P1 *)this)->ch.num_msgs;
		((P1 *)this)->ch.num_msgs = (((P1 *)this)->ch.num_msgs-1);
#ifdef VAR_RANGES
		logval("AsyncChan:ch.num_msgs", ((P1 *)this)->ch.num_msgs);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 27: // STATE 17 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:87 - [ch.closing?1] (0:0:0 - 1)
		reached[1][17] = 1;
		if (boq != ((P1 *)this)->ch.closing) continue;
		if (q_len(((P1 *)this)->ch.closing) == 0) continue;

		XX=1;
		if (1 != qrecv(((P1 *)this)->ch.closing, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(((P1 *)this)->ch.closing-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(((P1 *)this)->ch.closing, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P1 *)this)->ch.closing);
		sprintf(simtmp, "%d", 1); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P1 *)this)->ch.closing))
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
	case 28: // STATE 18 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:88 - [ch.closed = 1] (0:0:1 - 1)
		IfNotBlocked
		reached[1][18] = 1;
		(trpt+1)->bup.oval = ((int)((P1 *)this)->ch.closed);
		((P1 *)this)->ch.closed = 1;
#ifdef VAR_RANGES
		logval("AsyncChan:ch.closed", ((int)((P1 *)this)->ch.closed));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 29: // STATE 19 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:89 - [ch.sending!0] (0:0:0 - 1)
		IfNotBlocked
		reached[1][19] = 1;
		if (q_len(((P1 *)this)->ch.sending))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P1 *)this)->ch.sending);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P1 *)this)->ch.sending, 0, 0, 0, 1);
		{ boq = ((P1 *)this)->ch.sending; };
		_m = 2; goto P999; /* 0 */
	case 30: // STATE 22 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:91 - [((ch.num_msgs==0))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][22] = 1;
		if (!((((P1 *)this)->ch.num_msgs==0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 31: // STATE 23 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:93 - [ch.async_send?0] (0:0:0 - 1)
		reached[1][23] = 1;
		if (boq != ((P1 *)this)->ch.async_send) continue;
		if (q_len(((P1 *)this)->ch.async_send) == 0) continue;

		XX=1;
		if (0 != qrecv(((P1 *)this)->ch.async_send, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(((P1 *)this)->ch.async_send-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(((P1 *)this)->ch.async_send, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P1 *)this)->ch.async_send);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P1 *)this)->ch.async_send))
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
	case 32: // STATE 24 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:94 - [ch.num_msgs = (ch.num_msgs+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[1][24] = 1;
		(trpt+1)->bup.oval = ((P1 *)this)->ch.num_msgs;
		((P1 *)this)->ch.num_msgs = (((P1 *)this)->ch.num_msgs+1);
#ifdef VAR_RANGES
		logval("AsyncChan:ch.num_msgs", ((P1 *)this)->ch.num_msgs);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 33: // STATE 25 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:95 - [ch.closing?1] (0:0:0 - 1)
		reached[1][25] = 1;
		if (boq != ((P1 *)this)->ch.closing) continue;
		if (q_len(((P1 *)this)->ch.closing) == 0) continue;

		XX=1;
		if (1 != qrecv(((P1 *)this)->ch.closing, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(((P1 *)this)->ch.closing-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(((P1 *)this)->ch.closing, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P1 *)this)->ch.closing);
		sprintf(simtmp, "%d", 1); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P1 *)this)->ch.closing))
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
	case 34: // STATE 26 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:96 - [ch.closed = 1] (0:0:1 - 1)
		IfNotBlocked
		reached[1][26] = 1;
		(trpt+1)->bup.oval = ((int)((P1 *)this)->ch.closed);
		((P1 *)this)->ch.closed = 1;
#ifdef VAR_RANGES
		logval("AsyncChan:ch.closed", ((int)((P1 *)this)->ch.closed));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 35: // STATE 27 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:97 - [ch.sending!0] (0:0:0 - 1)
		IfNotBlocked
		reached[1][27] = 1;
		if (q_len(((P1 *)this)->ch.sending))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P1 *)this)->ch.sending);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P1 *)this)->ch.sending, 0, 0, 0, 1);
		{ boq = ((P1 *)this)->ch.sending; };
		_m = 2; goto P999; /* 0 */
	case 36: // STATE 31 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:101 - [ch.async_send?0] (0:0:0 - 1)
		reached[1][31] = 1;
		if (boq != ((P1 *)this)->ch.async_send) continue;
		if (q_len(((P1 *)this)->ch.async_send) == 0) continue;

		XX=1;
		if (0 != qrecv(((P1 *)this)->ch.async_send, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(((P1 *)this)->ch.async_send-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(((P1 *)this)->ch.async_send, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P1 *)this)->ch.async_send);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P1 *)this)->ch.async_send))
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
	case 37: // STATE 32 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:102 - [ch.num_msgs = (ch.num_msgs+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[1][32] = 1;
		(trpt+1)->bup.oval = ((P1 *)this)->ch.num_msgs;
		((P1 *)this)->ch.num_msgs = (((P1 *)this)->ch.num_msgs+1);
#ifdef VAR_RANGES
		logval("AsyncChan:ch.num_msgs", ((P1 *)this)->ch.num_msgs);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 38: // STATE 33 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:103 - [ch.async_rcv!0,ch.num_msgs] (0:0:0 - 1)
		IfNotBlocked
		reached[1][33] = 1;
		if (q_len(((P1 *)this)->ch.async_rcv))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P1 *)this)->ch.async_rcv);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		strcat(simvals, ",");
		sprintf(simtmp, "%d", ((P1 *)this)->ch.num_msgs); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P1 *)this)->ch.async_rcv, 0, 0, ((P1 *)this)->ch.num_msgs, 2);
		{ boq = ((P1 *)this)->ch.async_rcv; };
		_m = 2; goto P999; /* 0 */
	case 39: // STATE 34 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:104 - [ch.num_msgs = (ch.num_msgs-1)] (0:0:1 - 1)
		IfNotBlocked
		reached[1][34] = 1;
		(trpt+1)->bup.oval = ((P1 *)this)->ch.num_msgs;
		((P1 *)this)->ch.num_msgs = (((P1 *)this)->ch.num_msgs-1);
#ifdef VAR_RANGES
		logval("AsyncChan:ch.num_msgs", ((P1 *)this)->ch.num_msgs);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 40: // STATE 35 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:105 - [ch.closing?1] (0:0:0 - 1)
		reached[1][35] = 1;
		if (boq != ((P1 *)this)->ch.closing) continue;
		if (q_len(((P1 *)this)->ch.closing) == 0) continue;

		XX=1;
		if (1 != qrecv(((P1 *)this)->ch.closing, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(((P1 *)this)->ch.closing-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(((P1 *)this)->ch.closing, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P1 *)this)->ch.closing);
		sprintf(simtmp, "%d", 1); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P1 *)this)->ch.closing))
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
	case 41: // STATE 36 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:106 - [ch.closed = 1] (0:0:1 - 1)
		IfNotBlocked
		reached[1][36] = 1;
		(trpt+1)->bup.oval = ((int)((P1 *)this)->ch.closed);
		((P1 *)this)->ch.closed = 1;
#ifdef VAR_RANGES
		logval("AsyncChan:ch.closed", ((int)((P1 *)this)->ch.closed));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 42: // STATE 37 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:107 - [ch.sending!0] (0:0:0 - 1)
		IfNotBlocked
		reached[1][37] = 1;
		if (q_len(((P1 *)this)->ch.sending))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P1 *)this)->ch.sending);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P1 *)this)->ch.sending, 0, 0, 0, 1);
		{ boq = ((P1 *)this)->ch.sending; };
		_m = 2; goto P999; /* 0 */
	case 43: // STATE 47 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:112 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[1][47] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC :init: */
	case 44: // STATE 1 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:29 - [((n>0))] (3:0:1 - 1)
		IfNotBlocked
		reached[0][1] = 1;
		if (!((((P0 *)this)->n>0)))
			continue;
		/* merge: errCh.size = n(0, 2, 3) */
		reached[0][2] = 1;
		(trpt+1)->bup.oval = ((P0 *)this)->errCh.size;
		((P0 *)this)->errCh.size = ((P0 *)this)->n;
#ifdef VAR_RANGES
		logval(":init::errCh.size", ((P0 *)this)->errCh.size);
#endif
		;
		_m = 3; goto P999; /* 1 */
	case 45: // STATE 3 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:31 - [(run AsyncChan(errCh.sync,errCh.async_send,errCh.async_rcv,errCh.sending,errCh.closing,errCh.size,errCh.num_msgs,errCh.closed))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][3] = 1;
		if (!(addproc(II, 1, 1, ((P0 *)this)->errCh.sync, ((P0 *)this)->errCh.async_send, ((P0 *)this)->errCh.async_rcv, ((P0 *)this)->errCh.sending, ((P0 *)this)->errCh.closing, ((P0 *)this)->errCh.size, ((P0 *)this)->errCh.num_msgs, ((int)((P0 *)this)->errCh.closed))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 46: // STATE 5 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:33 - [(run sync_monitor(errCh.sync,errCh.async_send,errCh.async_rcv,errCh.sending,errCh.closing,errCh.size,errCh.num_msgs,errCh.closed))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][5] = 1;
		if (!(addproc(II, 1, 2, ((P0 *)this)->errCh.sync, ((P0 *)this)->errCh.async_send, ((P0 *)this)->errCh.async_rcv, ((P0 *)this)->errCh.sending, ((P0 *)this)->errCh.closing, ((P0 *)this)->errCh.size, ((P0 *)this)->errCh.num_msgs, ((int)((P0 *)this)->errCh.closed))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 47: // STATE 9 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:42 - [((limit>0))] (11:0:1 - 1)
		IfNotBlocked
		reached[0][9] = 1;
		if (!((((P0 *)this)->limit>0)))
			continue;
		/* merge: limiter.size = limit(0, 10, 11) */
		reached[0][10] = 1;
		(trpt+1)->bup.oval = ((P0 *)this)->limiter.size;
		((P0 *)this)->limiter.size = ((P0 *)this)->limit;
#ifdef VAR_RANGES
		logval(":init::limiter.size", ((P0 *)this)->limiter.size);
#endif
		;
		_m = 3; goto P999; /* 1 */
	case 48: // STATE 11 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:44 - [(run AsyncChan(limiter.sync,limiter.async_send,limiter.async_rcv,limiter.sending,limiter.closing,limiter.size,limiter.num_msgs,limiter.closed))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][11] = 1;
		if (!(addproc(II, 1, 1, ((P0 *)this)->limiter.sync, ((P0 *)this)->limiter.async_send, ((P0 *)this)->limiter.async_rcv, ((P0 *)this)->limiter.sending, ((P0 *)this)->limiter.closing, ((P0 *)this)->limiter.size, ((P0 *)this)->limiter.num_msgs, ((int)((P0 *)this)->limiter.closed))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 49: // STATE 13 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:46 - [(run sync_monitor(limiter.sync,limiter.async_send,limiter.async_rcv,limiter.sending,limiter.closing,limiter.size,limiter.num_msgs,limiter.closed))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][13] = 1;
		if (!(addproc(II, 1, 2, ((P0 *)this)->limiter.sync, ((P0 *)this)->limiter.async_send, ((P0 *)this)->limiter.async_rcv, ((P0 *)this)->limiter.sending, ((P0 *)this)->limiter.closing, ((P0 *)this)->limiter.size, ((P0 *)this)->limiter.num_msgs, ((int)((P0 *)this)->limiter.closed))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 50: // STATE 20 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:51 - [errCh.closing!1] (0:0:0 - 1)
		IfNotBlocked
		reached[0][20] = 1;
		if (q_len(((P0 *)this)->errCh.closing))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P0 *)this)->errCh.closing);
		sprintf(simtmp, "%d", 1); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P0 *)this)->errCh.closing, 0, 1, 0, 1);
		{ boq = ((P0 *)this)->errCh.closing; };
		_m = 2; goto P999; /* 0 */
	case 51: // STATE 21 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:55 - [errCh.async_rcv?state,num_msgs] (0:0:4 - 1)
		reached[0][21] = 1;
		if (boq != ((P0 *)this)->errCh.async_rcv) continue;
		if (q_len(((P0 *)this)->errCh.async_rcv) == 0) continue;

		XX=1;
		(trpt+1)->bup.ovals = grab_ints(4);
		(trpt+1)->bup.ovals[0] = ((int)((P0 *)this)->state);
		(trpt+1)->bup.ovals[1] = ((P0 *)this)->num_msgs;
		;
		((P0 *)this)->state = qrecv(((P0 *)this)->errCh.async_rcv, XX-1, 0, 0);
#ifdef VAR_RANGES
		logval(":init::state", ((int)((P0 *)this)->state));
#endif
		;
		((P0 *)this)->num_msgs = qrecv(((P0 *)this)->errCh.async_rcv, XX-1, 1, 1);
#ifdef VAR_RANGES
		logval(":init::num_msgs", ((P0 *)this)->num_msgs);
#endif
		;
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P0 *)this)->errCh.async_rcv);
		sprintf(simtmp, "%d", ((int)((P0 *)this)->state)); strcat(simvals, simtmp);		strcat(simvals, ",");
		sprintf(simtmp, "%d", ((P0 *)this)->num_msgs); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P0 *)this)->errCh.async_rcv))
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
		if (TstOnly) return 1; /* TT */
		/* dead 2: state */  (trpt+1)->bup.ovals[2] = ((P0 *)this)->state;
#ifdef HAS_CODE
		if (!readtrail)
#endif
			((P0 *)this)->state = 0;
		if (TstOnly) return 1; /* TT */
		/* dead 2: num_msgs */  (trpt+1)->bup.ovals[3] = ((P0 *)this)->num_msgs;
#ifdef HAS_CODE
		if (!readtrail)
#endif
			((P0 *)this)->num_msgs = 0;
		_m = 4; goto P999; /* 0 */
	case 52: // STATE 22 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:56 - [errCh.sync?state,num_msgs] (0:0:4 - 1)
		reached[0][22] = 1;
		if (boq != ((P0 *)this)->errCh.sync) continue;
		if (q_len(((P0 *)this)->errCh.sync) == 0) continue;

		XX=1;
		(trpt+1)->bup.ovals = grab_ints(4);
		(trpt+1)->bup.ovals[0] = ((int)((P0 *)this)->state);
		(trpt+1)->bup.ovals[1] = ((P0 *)this)->num_msgs;
		;
		((P0 *)this)->state = qrecv(((P0 *)this)->errCh.sync, XX-1, 0, 0);
#ifdef VAR_RANGES
		logval(":init::state", ((int)((P0 *)this)->state));
#endif
		;
		((P0 *)this)->num_msgs = qrecv(((P0 *)this)->errCh.sync, XX-1, 1, 1);
#ifdef VAR_RANGES
		logval(":init::num_msgs", ((P0 *)this)->num_msgs);
#endif
		;
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P0 *)this)->errCh.sync);
		sprintf(simtmp, "%d", ((int)((P0 *)this)->state)); strcat(simvals, simtmp);		strcat(simvals, ",");
		sprintf(simtmp, "%d", ((P0 *)this)->num_msgs); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P0 *)this)->errCh.sync))
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
		if (TstOnly) return 1; /* TT */
		/* dead 2: state */  (trpt+1)->bup.ovals[2] = ((P0 *)this)->state;
#ifdef HAS_CODE
		if (!readtrail)
#endif
			((P0 *)this)->state = 0;
		if (TstOnly) return 1; /* TT */
		/* dead 2: num_msgs */  (trpt+1)->bup.ovals[3] = ((P0 *)this)->num_msgs;
#ifdef HAS_CODE
		if (!readtrail)
#endif
			((P0 *)this)->num_msgs = 0;
		_m = 4; goto P999; /* 0 */
	case 53: // STATE 27 - /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/result2021-02-03--12:48:56/tsuru--tsuru/client++DoLimited780.pml:60 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[0][27] = 1;
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

