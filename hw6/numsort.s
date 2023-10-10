/* ========================= */
/*       DATA section        */
/* ========================= */
        .data
        .align 4

/*==========================*/
/*-------TEXT section------ */
/*==========================*/
	.section .text
	.global NumSort
	.type NumSort, %function

NumSort:
	STMFD sp!,{r4-r9,fp,ip,lr}
	mov r7, r0
	mov r8, r1
	bl malloc
	
	mov r1, r8
	
	mov r9, r1	/* old(moveable) */
	mov r10, r0	/* new(moveable) */
	mov r3, #0	/* count times */
	b copy

/*  copy the old element in new array*/
copy:
	cmp r3,r7
	beq break1
	ldr r4, [r9], #4	/* r4=[r9], r9=r9+4 */
	str r4, [r10], #4	/* [r10]=r4, r10=r10+4 */
	add r3, r3, #4		/* count++ --> r3=r3+4 */
	b copy
	
break1:
	mov r10, r0	/* new array --> pointer(moveable) */
	add r1, r7, #-4/* outside loop run size */
	mov r3, #0	/* outside loop count time */

/* sort */
outside_loop:
	cmp r3, r1	/* if r3>=r1 break */
	bge break2
	add r4, r10, #4	/* r4 inside loop location */
	add r5, r3, #4	/* r5 inside loop now size */

inside_loop:
	cmp r5, r7	/* if r5>= r7 break */
	addge r3, r3, #4	/* outside loop count++ */
	addge r10, r10, #4	/* outside loop now location++ */
	bge outside_loop	/* to outside loop */
	ldr r6, [r10]		/* load value in register */
	ldr r2, [r4]
	cmp r6, r2		/* if r6 > r2 */
	movgt r8, r6		/* swap */
	movgt r6, r2
	movgt r2, r8
	strgt r6, [r10]
	strgt r2, [r4]
	add r4, r4, #4		/* judge next location */
	add r5, r5, #4		/* inside loop size++ */
	b inside_loop		/* continue */
	
break2:
	LDMFD sp!,{r4-r9,fp,ip,pc}
	.end
