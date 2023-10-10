/*==========================*/
/*-------DATA section------ */
/*==========================*/	
	
	.data
	.align 4
	
/* ------variable a-------- */
	.type a, %object
	.size a, 28
a:
	.word 1
	.word 10
	.word 6
	.word 3
	.word 20
	.word 40
	.word 9
	
/* ------printf function-------- */

format:
	.ascii "Input array: \000"
format1:
	.ascii "%d \000"
format2:
	.ascii "\n\000"
format3:
	.ascii "Result array: \000"
	
/*==========================*/
/*-------TEXT section------ */
/*==========================*/	

	.section .text
	.global main
	.type main, %function
	
main:
	MOV ip,sp	
	STMFD sp!,{fp,ip,lr,pc}
	SUB fp,ip,#4
	
	MOV r9, #28	/* r0 store the size of array */
	ldr r8, =a	/* r1 store the address of array */
	mov r7, #0	/* count */
	mov r6, r8	/* moveable */
	
/* input array: */	
	ldr r0, =format
	bl printf
	
/* number */
print1:
	cmp r7, r9
	beq break2
	ldr r0, =format1
	ldr r1, [r6], #4
	bl printf
	add r7, r7, #4
	b print1
	
break2:
	
/* print \n */
	ldr r0, =format2	
	bl printf
	
	mov r0, r9
	mov r1, r8
	BL NumSort	/* run numsort */
	
	mov r8, r0	/* resuult address(moveable) */ 
/* print result */
	ldr r0, =format3
	bl printf
	
	mov r7, #28	/* size */
	mov r6, #0	/*count */
	b print
	
print:
	cmp r6, r7
	beq break1	
	ldr r0, =format1	/* get format address and save in r0 */
	ldr r1, [r8], #4	/* get result address's value and save in r1 */
	bl printf		
	add r6, r6, #4
	b print

break1:	
	nop	
	LDMEA fp,{fp,sp,pc}
	.end
