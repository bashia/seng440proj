00 | str r4, [#0]                | str r5, [#4]                    @ Preserve Register Values
01 | str r6, [#8]                | str r7, [#12]
02 | str r8, [#16]               | str r9, [#20]
03 | mov r3, r0, asr #16         | NOP                             @ Unpack R
04 | mul r4, r3, #2498396        | mul r5, r3, #2498407            @ Calculate R components 
05 | mul r6, r3, #5857443        | NOP		
06 | mov r3, r0, asl #16         | NOP				   @ Unpack G		
07 | mov r3, r3, asr #24         | NOP
08 | mul r7, r3, #4904878        | mul r8, r3, #4904867            @ Calculate G components 
09 | add r4, r4, r7              | add r5, r5, r8
0A | mul r7, r3, #4904877        | NOP
0B | add r6, r6, r7              | mov r3, r0 asl #24              @ Unpack B
0C | mov r3, r3 asr #24          | NOP
0D | mul r7, r3, #952566         | mul r8, r3, #7403274    
0E | add r4, r4, r7		 | add r5, r5, r8
10 | mul r7, r3, #952567         | NOP               		   @ Calculate G components              
12 | add r6, r6, r7              | mov r4, r4, asr #23             @ Calculate Final Y / Cb    
13 | add r4, r4, #16             | mov r5, r5, asr #24		   @ Calculate Final Cb /Cr	
14 | mov r6, r6, asr #24         | mov r1, r4, asl #16             @ Calculate Final Cr, Pack Y
15 | mov r5, r5, asl #8          | ldr r4, [#0]                    @ Pack Cb, Restore Register
16 | add r1, r1 r5               | NOP                             @ Pack Cb
17 | add r1, r1, r6              | ldr r5, [#4]			   @ Pack Cr, Restore Register
18 | ldr r6, [#8]                | ldr r7, [#12]		   @ Restore Registers
19 | ldr r8, [#16]               | ldr r9, [#20]

