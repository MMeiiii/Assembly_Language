/*==========================*/
/*-------DATA section------ */
/*==========================*/	
	
	.data
	.align 4
	
/* ------variable a-------- */
	.type a, %object
	.size a, 32
a:
	.word 1
	.word 2
	.word 3
	.word 4
	.word 5
	.word 6
	.word 7
	.word 8

/* ------variable b-------- */	
	.type b, %object
	.size b, 32
b:
	.word 1
	.word 2
	.word 3
	.word 4
	.word 5
	.word 6
	.word 7
	.word 8

/* ------variable c-------- */
	.type c, %object
c:
	.space 16, 0
	
/*==========================*/
/*-------TEXT section------ */
/*==========================*/		
	
	.section .text
	.global main
	.type main, %function
	
main:

	ldr r0, =a /* catch the address of a matrix */
	ldr r1, =b /* catch the address of b matrix */
	ldr r2, =c /* catch the address of c matrix*/

/* calculate the value in c[1,1] */
	mov r6, #0 /* r6 count the time in the loop --> initialize r6=0 */
	ldr r3, =a /* find the address of first element in matrix a */
	ldr r4, =b /* find the address of first element in matrix b  */
	ldr r5, =c /* find the address of first element in matrix c */
	bl save_return_address /* save the return address */

/* calculate the value in c[1,2] */
	mov r6, #0	/* r6 count the time in the loop --> initialize r6=0 */
	ldr r3, =a	/* point the  matrix a's first element address */
	add r4, r1, #4	/* point the  matrix b's second element address, because now we want to calculate is the second col*/
	add r5, r2, #4	/* point the  matrix c's second element address */
	bl save_return_address /* save the return address */
	
/* calculate the value in c[2,1] */
	mov r6, #0	/* r6 count the time in the loop --> initialize r6=0 */
	add r3, r0, #16/* point the  matrix a's fifth element address, because we want is second row */	
	ldr r4, =b     /* find the address of first element in matrix b  */
	add r5, r2, #8 /* point the  matrix c's third element address */
	bl save_return_address /* save the return address */
	
/* calculate the value in c[2,2] */
	mov r6, #0	/* r6 count the time in the loop --> initialize r6=0 */
	add r3, r0, #16/* point the  matrix a's fifth element address, because we want is second row */	
	add r4, r1, #4 /* point the  matrix b's second element address, because now we want to calculate is the second col*/
	add r5, r2, #12/* point the  matrix c's forth element address */
	bl save_return_address /* save the return address */
	bl finally /* find the ans */

/* save the return address */	
save_return_address:
	stmfd r13!, {r14} /* save return address in r13 stack */
	bl cal_mul  	  /* calculate the multiple */
	ldmfd r13!, {pc} /* pop the address in r13 stack */
	
cal_mul:
	ldr r7, [r3], #4 /* r7 get the element in r3 address's element , and then r3=r3+4 , so after r7 will get the new element in r3*/
	ldr r8, [r4], #8 /* r8 get the element in r4 address's element , and then r4=r4+8(+8 is because I want the element is not row but col) , so after r8 will get the new element in r3*/
	mul r9, r7, r8	 /* multiple r7 * r8 and save in r9*/
	ldr r10,[r5]	 /* get the element in r5's and then load into r10  */
	add r10, r9	 /* add the value r10=r10+r9 (r10 is before the element add, r9 is now need to plus, so r9+r10 is now total value */
	str r10, [r5]   /* store r10 in r5's address */
	add r6, #1      /* r6 count time so ++ */
	cmp r6, #4	/* cmp if need to break the loop if r6==4, then break, not than do cal_mul  */
	blt cal_mul
	moveq pc, r14  /* move return address in pc */

finally:	
	mov r1, r2 /* move c matrix address from r2 to r1 */
	nop /* r1 is the ans */
	.end
