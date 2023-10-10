1.程式目標：排序-->(使用printf和malloc)

2.程式內容：
排序跟hw4的方法一樣，那主要是在練習在arm assembly program calls c functions，那主要練習的是-->printf(),malloc()

printf() 是放在hw5_test.s裡
程式碼：

/* ------printf function-------- */
format:
	.ascii "Input array: \000"
format1:
	.ascii "%d \000"
format2:
	.ascii "\n\000"
format3:
	.ascii "Result array: \000"

print:
	cmp r6, r7
	beq break1
	ldr r0, =format 	/* get format address and save in r0 */
	ldr r1, [r8], #4	/* get result address's value and save in r1 */
	bl printf
	add r6, r6, #4
	b print
	
在printf裡會用r0存-->format的記憶體位置

	      r1存-->%d的值
	      
	   
malloc() 是放在numsort.s裡
程式碼：

mov r7, r0
bl malloc

在malloc裡會用r0存-->傳入要創記憶體的大小並回傳新創的記憶體的地址存在r0裡，所以意開始要記的把r0的size先用一個register存起來

3.如何編譯程式：
arm-none-eabi-gcc –g hw5_test.s numsort.s –o hw5.exe

4.如何執行程式：

# sample makefile
all:hw5_test.s
	arm-none-eabi-gcc -g hw5_test.s numsort.s -o hw5.exe
clean:
	rm -f hw5.exe
	
心得：
學到新技能，在assembly裡用printf()和malloc()，而且還有特定的暫存器溝通，所以用的時候要很小心，不然原本的值很容易被覆蓋過去！不過很好玩，超酷：）
還有他不像前幾支程式在nop時可以在register看到結果，因為是印出來所以要等整支程式跑完，才會從buffer裡出來

