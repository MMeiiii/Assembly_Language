/* ========================= */
/*       DATA section        */
/* ========================= */
        .data
        .align 4
/* ------variable b-------- */
b:
	.space 400 /* the most size of array is 100 */
	
/*==========================*/
/*-------TEXT section------ */
/*==========================*/
	.section .text
	.global NumSort
	.type NumSort, %function

NumSort:
	STMFD sp!,{r0-r9,fp,ip,lr}
	ldr r0, =b
	mov r1, r10	/* old(moveable) */
	mov r2, r0	/* new(moveable) */
	mov r3, #0	/* count times */
	b copy

/*  copy the old element in new array*/
copy:
	cmp r3,r9
	beq break1
	ldr r4, [r1], #4	/* r4=[r1], r1=r1+4 */
	str r4, [r2], #4	/* [r2]=r4, r2=r2+4 */
	add r3, r3, #4		/* count++ --> r3=r3+4 */
	b copy
	
break1:
	mov r1, r0	/* new array --> pointer(moveable) */
	add r2, r9, #-4/* outside loop run size */
	mov r3, #0	/* outside loop count time */

/* sort */
outside_loop:
	cmp r3, r2	/* if r3>=r2 break */
	bge break2
	add r4, r1, #4	/* r4 inside loop location */
	add r5, r3, #4	/* r5 inside loop now size */

inside_loop:
	cmp r5, r9	/* if r5>= r9 break */
	addge r3, r3, #4	/* outside loop count++ */
	addge r1, r1, #4	/* outside loop now location++ */
	bge outside_loop	/* to outside loop */
	ldr r6, [r1]		/* load value in register */
	ldr r7, [r4]
	cmp r6, r7		/* if r6 > r7 */
	movgt r8, r6		/* swap */
	movgt r6, r7
	movgt r7, r8
	strgt r6, [r1]
	strgt r7, [r4]
	add r4, r4, #4		/* judge next location */
	add r5, r5, #4		/* inside loop size++ */
	b inside_loop		/* continue */
	
break2:
	mov r10, r0	/* store address in register 10 */
	
	LDMFD sp!,{r0-r9,fp,ip,pc}
	.end
