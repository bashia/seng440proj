00 | str r4, [#0]		@ Preserve Register Values
01 | str r5, [#4]
02 | str r6, [#8]
03 | str r7, [#12]
04 | mov r3, r0, asr #16        @ Unpack R
05 | mul r4, r3, #2498396       @ Calculate R components
06 | mul r5, r3, #2498407
07 | mul r6, r3, #5857443
08 | mov r3, r0, asl #16        @ Unpack G
09 | mov r3, r3, asr #24
0A | mul r7, r3, #4904878       @ Calculate G components
0B | add r4, r4, r7
0C | mul r7, r3, #4904867
0D | add r5, r5, r7
0E | mul r7, r3, #4904877
0F | add r6, r6, r7
10 | mov r3, r0 asl #24         @ Unpack B
11 | mov r3, r3 asr #24
12 | mul r7, r3, #952566        @ Calculate B Components
13 | add r4, r4, r7
14 | mul r7, r3, #7403274
15 | add r5, r5, r7
16 | mul r7, r3, #952567
17 | add r6, r6, r7
18 | mov r4, r4, asr #23        @ Calculate Final Y
19 | add r4, r4, #16
1A | mov r5, r5, asr #24	@ Calculate Final Cb
1B | mov r6, r6, asr #24        @ Calculate Final Cr
1C | mov r1, r4, asl #16        @ Pack YCC values
1D | mov r5, r5, asl #8
1E | add r1, r1 r5
1F | add r1, r1, r6
20 | ldr r4, [#0]		@ Preserve Register Values
21 | ldr r5, [#4]
22 | ldr r6, [#8]
23 | ldr r7, [#12]

