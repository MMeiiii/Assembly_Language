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
	
	MOV r9, #28	/* r9 store the size of array */
	ldr r10, =a	/* r10 store the address of array */
	
	BL NumSort	/* run numsort */
		
	nop	/* r10 is the address of sort --> answer */
	LDMEA fp,{fp,sp,pc}
	.end
