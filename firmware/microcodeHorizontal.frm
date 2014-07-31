00 | str r4, [#0]                | str r5, [#4]                    @ Preserve Register Values
01 | str r6, [#8]                | str r7, [#12]
02 | str r8, [#16]               | str r9, [#20]
03 | mov r3, r0, asr #16         | NOP                             @ Unpack R
04 | mul r4, r3, #2498396        | NOP                             @ Calculate R components (Note that mul instructions cannot be executed in parallel)
05 | mul r5, r3, #2498407        | NOP
06 | mul r6, r3, #5857443        | NOP	
07 | mov r3, r0, asl #16         | NOP				                     @ Unpack G		
08 | mov r3, r3, asr #24         | NOP
09 | mul r7, r3, #4904878        | NOP                             @ Calculate G components 
0A | mul r8, r3, #4904867        | NOP
0B | add r4, r4, r7              | add r5, r5, r8
0C | mul r7, r3, #4904877        | NOP
0D | add r6, r6, r7              | mov r3, r0 asl #24              @ Unpack B
0E | mov r3, r3 asr #24          | NOP
0F | mul r7, r3, #952566         | NOP                             @ Calculate G components
10 | mul r8, r3, #7403274        | NOP
11 | add r4, r4, r7		           | add r5, r5, r8
12 | mul r7, r3, #952567         | NOP               		                         
13 | add r6, r6, r7              | mov r4, r4, asr #23             @ Calculate Final Y / Cb    
14 | add r4, r4, #16             | mov r5, r5, asr #24		         @ Calculate Final Cb /Cr	
15 | mov r6, r6, asr #24         | mov r1, r4, asl #16             @ Calculate Final Cr, Pack Y
16 | mov r5, r5, asl #8          | ldr r4, [#0]                    @ Pack Cb, Restore Register
17 | add r1, r1 r5               | NOP                             @ Pack Cb
18 | add r1, r1, r6              | ldr r5, [#4]			               @ Pack Cr, Restore Register
19 | ldr r6, [#8]                | ldr r7, [#12]		               @ Restore Registers
1A | ldr r8, [#16]               | ldr r9, [#20]

