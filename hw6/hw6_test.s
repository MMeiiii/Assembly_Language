.set SWI_Write, 0x5
.set SWI_Open, 0x1
.set SWI_Close, 0x2
.set AngelSWI, 0x123456

/* ========================= */
/*       DATA section        */
/* ========================= */
	.data
	.align 4
	
/* sprintf("str", %d, 12) */
/* ------sprintf function-------- */
str_addr:	/* str */
        .space 52, 0
        .align 4	
	
format_1:	/* %d */
	.ascii "%d,  \000"
	.align 4
	
format_2:	/* %d */
	.ascii "%d   \000"
	.align 4

/* ------file function-------- */
filename:
	.ascii "result.txt\000"
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
	
/* ========================= */
/*       TEXT section        */
/* ========================= */
	.section .text
	.global main
	.type main,%function

.open_param:
	.word filename /* the address of filename */
	.word 0x4	/* arguement */
	.word 0x8	/* lenth of file name */
.write_param:
	.space 4   /* file descriptor */
	.space 4   /* address of the string */
	.space 4   /* length of the string */
.close_param:
	.space 4
	
main:
	mov ip, sp
	stmfd sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	
	MOV r0, #28	/* r9 store the size of array */
	ldr r1, =a	/* r10 store the address of array */
	
	BL NumSort	/* run numsort */	

	mov r8, r0 /* r8 --> result address */
	ldr r5, =str_addr
	
	mov r7, #0 /* count */
	mov r6, #16	/* one number */
	b change_string

/* one number */	
change_string:
	cmp r7,r6	/* r7==r6 break1 */
	beq break1
	mov r0, r5	/* sprintf */
	ldr r1, =format_1
        ldr r2, [r8], #4
	bl  sprintf
	add r5, r5, #2	/* align */
	add r7, r7, #4	/* count ++ */
	b change_string
/* two number */
break1:	
	mov r7, #0 /* count */	
	mov r6, #8	/* two number */
	b change_string1
	
change_string1:
	cmp r7,r6 /* r7==r6 break1 */
	beq break2
	mov r0, r5	/* sprintf */
	ldr r1, =format_1
        ldr r2, [r8], #4
	bl  sprintf
	add r5, r5, #3	/* align */
	add r7, r7, #4	/* count ++ */
	b change_string1
break2:

	mov r0, r5
	ldr r1, =format_2	/* last one no common change format */
        ldr r2, [r8], #4
	bl  sprintf

/* file */
        /* open a file */
	mov r0, #SWI_Open
	adr r1, .open_param
	swi AngelSWI
	mov r2, r0                /* r2 is file descriptor */
      
        /* write to a file */
	adr r1, .write_param
	str r2, [r1, #0]          /* store file descriptor */
	
	ldr r3, =str_addr
	str r3, [r1, #4]          /* address of the string */

	mov r3, #17
	str r3, [r1, #8]          /* store the length of the string */
	
	
	mov r0, #SWI_Write
	swi AngelSWI


	/* close a file */
	adr r1, .close_param
	str r2, [r1, #0]
	
	mov r0, #SWI_Close
	swi AngelSWI
	
	ldmea fp, {fp, sp, pc}

