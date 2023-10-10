	.section .text
	.global main
	.type main, %function
main:
	MOV r1, #10	/* r1 = 10 */
	MOV r2, #10	/* r2 = 10 */
	MOV r3, #10	/* r3 = 10 */
	MOV r0, r1, LSL #1	/* r0 = r1 * 2 */
	ADD r0, r0, r2, LSL #2	/* r0 = r0 + r2 * 4 */
	ADD r0, r0, r3, LSL #3	/* r0 = r0 + r3 * 8 */
	NOP	/* r0 is answer */
	.end
