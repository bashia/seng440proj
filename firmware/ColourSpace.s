	.arch armv6
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 18, 4
	.file	"ColourSpace.c"
	.section	.rodata
	.align	2
.LC0:
	.ascii	"outY.bmp\000"
	.align	2
.LC1:
	.ascii	"outCb.bmp\000"
	.align	2
.LC2:
	.ascii	"outCr.bmp\000"
	.text
	.align	2
	.global	RGBtoYCC
	.type	RGBtoYCC, %function
RGBtoYCC:
	@ args = 0, pretend = 0, frame = 176
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #184
	str	r0, [fp, #-176]
	sub	r3, fp, #120
	mov	r0, r3
	ldr	r1, [fp, #-176]
	bl	readImage
	ldr	r3, [fp, #-112]
	mov	r3, r3, asr #1
	str	r3, [fp, #-12]
	ldr	r3, [fp, #-120]
	mov	r3, r3, asr #1
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-112]
	mov	r2, r3
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r0, r3
	bl	malloc
	mov	r3, r0
	str	r3, [fp, #-124]
	ldr	r3, [fp, #-112]
	str	r3, [fp, #-128]
	ldr	r3, [fp, #-120]
	str	r3, [fp, #-136]
	ldr	r3, [fp, #-116]
	str	r3, [fp, #-132]
	ldr	r3, [fp, #-112]
	mov	r2, r3
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r0, r3
	bl	malloc
	mov	r3, r0
	str	r3, [fp, #-140]
	ldr	r3, [fp, #-12]
	str	r3, [fp, #-144]
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-152]
	ldr	r3, [fp, #-116]
	str	r3, [fp, #-148]
	ldr	r3, [fp, #-112]
	mov	r2, r3
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r0, r3
	bl	malloc
	mov	r3, r0
	str	r3, [fp, #-156]
	ldr	r3, [fp, #-12]
	str	r3, [fp, #-160]
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-168]
	ldr	r3, [fp, #-116]
	str	r3, [fp, #-164]
	mov	r3, #1
	str	r3, [fp, #-104]
	b	.L2
.L3:
	ldr	r3, [fp, #-104]
	add	r3, r3, #1
	str	r3, [fp, #-100]
	ldr	r3, [fp, #-104]
	mov	r3, r3, asr #1
	str	r3, [fp, #-96]
	ldr	r1, [fp, #-108]
	ldr	r2, [fp, #-104]
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	add	r3, r1, r3
	mov     r2, r3
	ldrb	r3, [r2, #2]
	str	r3, [fp, #-92]
	ldrb	r3, [r2, #1]
	str	r3, [fp, #-88]
	ldrb	r3, [r2, #0]
	str	r3, [fp, #-84]
	ldr	r1, [fp, #-108]
	ldr	r2, [fp, #-100]
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	add	r3, r1, r3
	mov     r2, r3
	ldrb	r3, [r2, #2]
	str	r3, [fp, #-80]
	ldrb	r3, [r2, #1]
	str	r3, [fp, #-76]
	ldrb	r3, [r2, #0]
	str	r3, [fp, #-72]

	@ Pack First RGB to one integer
	ldr	r3, [fp, #-84]
	ldr	r3, [fp, #-88]
	mov	r3, r3, asl #8
	add	r2, r2, r3
	ldr	r2, [fp, #-92]
	mov	r3, r3, asl #16
	add	r2, r2, r3

	@ New Instruction
	ycc	r2, r2   

	@ Unpack and store first Y value to location [fp, #-172] (Assume this is available memory space)
	mov r3, r2, asr #16
	str r3, [fp, #-172] 
	
	@ Unpack and store first Cb value to location [fp, #-176] (Assume this is available memory space)
	mov r3, r2, asl #16
	mov r3, r2, asr #24
	str r3, [fp, #-176] 	
	
	@ Unpack and store first Cr value to location [fp, #-180] (Assume this is available memory space)
	mov r3, r2, asl #24
	mov r3, r2, asr #24
	str r3, [fp, #-180] 

	@ Pack Second RGB to one integer
	ldr	r2, [fp, #-72]
	ldr	r3, [fp, #-76]
	mov	r3, r3, asl #8
	add	r2, r2, r3
	ldr	r3, [fp, #-80]
	mov	r3, r3, asl #16
	add	r2, r2, r3

	@ New Instruction
	ycc	r2, r2   

	@ Unpack and store second Y value to location [fp, #-184] (Assume this is available memory space)
	mov r3, r2, asr #16
	str r3, [fp, #-184] 
	
	@ Unpack and store second Cb value to location [fp, #-188] (Assume this is available memory space)
	mov r3, r2, asl #16
	mov r3, r2, asr #24
	str r3, [fp, #-188] 	
	
	@ Unpack and store second Cr value to location [fp, #-192] (Assume this is available memory space)
	mov r3, r2, asl #24
	mov r3, r2, asr #24
	str r3, [fp, #-192] 

	@ Removed ldr	r2, [fp, #-92]
	@ Removed ldr	r3, .L5
	@ Removed mul	r1, r3, r2
	@ Removed ldr	r2, [fp, #-88]
	@ Removed ldr	r3, .L5+4
	@ Removed mul	r3, r3, r2
	@ Removed add	r1, r1, r3
	@ Removed ldr	r2, [fp, #-84]
	@ Removed ldr	r3, .L5+8
	@ Removed mul	r3, r3, r2
	@ Removed add	r3, r1, r3
	@ Removed mov	r3, r3, asr #23
	@ Removed add	r3, r3, #16
	@ Removed str	r3, [fp, #-68]
	@ Removed ldr	r2, [fp, #-80]
	@ Removed ldr	r3, .L5
	@ Removed mul	r1, r3, r2
	@ Removed ldr	r2, [fp, #-76]
	@ Removed ldr	r3, .L5+4
	@ Removed mul	r3, r3, r2
	@ Removed add	r1, r1, r3
	@ Removed ldr	r2, [fp, #-72]
	@ Removed ldr	r3, .L5+8
	@ Removed mul	r3, r3, r2
	@ Removed add	r3, r1, r3
	@ Removed mov	r3, r3, asr #23
	@ Removed add	r3, r3, #16

	@ Added instruction to load correct Y value
	ldr r3, [fp, #-172]

#APP
@ 113 "src/ColourSpace.c" 1
	USAT r3, #8, r3
@ 0 "" 2

	@ Changed instructions to store/load from correct locations
	str	r3, [fp, #-172]
	ldr	r3, [fp, #-184]

#APP
@ 112 "src/ColourSpace.c" 1
	USAT r3, #8, r3
@ 0 "" 2
	
	@ Changed instruction to store/load from correct location
	str	r3, [fp, #-184]

	ldr	r1, [fp, #-124]
	ldr	r2, [fp, #-104]
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	add	r2, r1, r3
	
	@ Changed instruction to store/load from correct location
	ldr	r3, [fp, #-172]

	uxtb	r3, r3
	strb	r3, [r2, #2]
	strb	r3, [r2, #1]
	strb	r3, [r2, #0]

	ldr	r1, [fp, #-124]
	ldr	r2, [fp, #-100]
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	add	r2, r1, r3
	
	@ Changed instruction to store/load from correct location
	ldr	r3, [fp, #-184]

	uxtb	r3, r3
	strb	r3, [r2, #2]
	strb	r3, [r2, #1]
	strb	r3, [r2, #0]

	@ Removed ldr	r2, [fp, #-84]
	@ Removed ldr	r3, .L5+12
	@ Removed mul	r1, r3, r2
	@ Removed ldr	r2, [fp, #-92]
	@ Removed ldr	r3, .L5+16
	@ Removed mul	r3, r3, r2
	@ Removed add	r1, r1, r3
	@ Removed ldr	r2, [fp, #-88]
	@ Removed ldr	r3, .L5+20
	@ Removed mul	r3, r3, r2
	@ Removed add	r3, r1, r3
	@ Removed mov	r3, r3, asr #24
	@ Removed str	r3, [fp, #-60]
	@ Removed ldr	r2, [fp, #-72]
	@ Removed ldr	r3, .L5+12
	@ Removed mul	r1, r3, r2
	@ Removed ldr	r2, [fp, #-80]
	@ Removed ldr	r3, .L5+16
	@ Removed mul	r3, r3, r2
	@ Removed add	r1, r1, r3
	@ Removed ldr	r2, [fp, #-76]
	@ Removed ldr	r3, .L5+20
	@ Removed mul	r3, r3, r2
	@ Removed add	r3, r1, r3
	@ Removed mov	r3, r3, asr #24
	@ Removed str	r3, [fp, #-52]

	@ Changed instruction to store/load from correct location
	ldr	r2, [fp, #-176]

	ldr	r3, .L5+24
	mul	r3, r3, r2
	mov 	r3, r3, asr #23
	str	r3, [fp, #-56]

	@ Changed instruction to store/load from correct location
	ldr	r2, [fp, #-188]

	ldr	r3, .L5+24
	mul	r3, r3, r2
	mov	r3, r3, asr #23
	str	r3, [fp, #-48]
	ldr	r2, [fp, #-56]
	ldr	r3, [fp, #-48]
	add	r3, r2, r3
	add	r3, r3, #128
	str	r3, [fp, #-44]
	ldr	r2, [fp, #-60]
	ldr	r3, [fp, #-52]
	add	r3, r2, r3
	add	r3, r3, #128
#APP
@ 140 "src/ColourSpace.c" 1
	USAT r3, #8, r3
@ 0 "" 2

	str	r3, [fp, #-40]
	ldr	r3, [fp, #-44]
#APP
@ 139 "src/ColourSpace.c" 1
	USAT r3, #8, r3
@ 0 "" 2
	str	r3, [fp, #-44]
	ldr	r1, [fp, #-140]
	ldr	r2, [fp, #-96]
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	add	r2, r1, r3
	mov r1, r2
	mov	r3, #0
	strb	r3, [r1, #2]
	ldr	r3, [fp, #-44]
	uxtb	r3, r3
	strb	r3, [r1, #1]
	ldr	r3, [fp, #-40]
	uxtb	r3, r3
	strb	r3, [r1, #0]

	@ Removed ldr	r2, [fp, #-92]
	@ Removed ldr	r3, .L5+28
	@ Removed mul	r1, r3, r2
	@ Removed ldr	r2, [fp, #-88]
	@ Removed ldr	r3, .L5+32
	@ Removed mul	r3, r3, r2
	@ Removed add	r1, r1, r3
	@ Removed ldr	r2, [fp, #-84]
	@ Removed ldr	r3, .L5+36
	@ Removed mul	r3, r3, r2
	@ Removed add	r3, r1, r3
	@ Removed mov	r3, r3, asr #24
	@ Removed str	r3, [fp, #-36]
	@ Removed ldr	r2, [fp, #-80]
	@ Removed ldr	r3, .L5+28
	@ Removed mul	r1, r3, r2
	@ Removed ldr	r2, [fp, #-76]
	@ Removed ldr	r3, .L5+32
	@ Removed mul	r3, r3, r2
	@ Removed add	r1, r1, r3
	@ Removed ldr	r2, [fp, #-72]
	@ Removed ldr	r3, .L5+36
	@ Removed mul	r3, r3, r2
	@ Removed add	r3, r1, r3
	@ Removed mov	r3, r3, asr #24
	@ Removed str	r3, [fp, #-28]

	@ Changed instruction to store/load from correct location
	ldr	r2, [fp, #-180]
	
	ldr	r3, .L5+40
	mul	r3, r3, r2
	mov	r3, r3, asr #23
	str	r3, [fp, #-32]

	@ Changed instruction to store/load from correct location
	ldr	r2, [fp, #-192]
	ldr	r3, .L5+40
	mul	r3, r3, r2
	mov	r3, r3, asr #23
	str	r3, [fp, #-24]
	ldr	r2, [fp, #-36]
	ldr	r3, [fp, #-28]
	add	r3, r2, r3
	add	r3, r3, #128
	str	r3, [fp, #-20]
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-24]
	add	r3, r2, r3
	add	r3, r3, #128
#APP
@ 163 "src/ColourSpace.c" 1
	USAT r3, #8, r3
@ 0 "" 2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-20]
#APP
@ 162 "src/ColourSpace.c" 1
	USAT r3, #8, r3
@ 0 "" 2
	str	r3, [fp, #-20]
	ldr	r1, [fp, #-156]
	ldr	r2, [fp, #-96]
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	add	r2, r1, r3
	mov r1, r2
	ldr	r3, [fp, #-20]
	uxtb	r3, r3
	strb	r3, [r2, #2]
	ldr	r3, [fp, #-16]
	uxtb	r3, r3
	strb	r3, [r2, #1]
	mov	r3, #0
	strb	r3, [r2, #0]
	ldr	r3, [fp, #-104]
	add	r3, r3, #2
	str	r3, [fp, #-104]
.L2:
	ldr	r2, [fp, #-112]
	ldr	r3, [fp, #-104]
	cmp	r2, r3
	bgt	.L3
	ldr	r3, [fp, #-124]
	str	r3, [sp, #0]
	sub	r3, fp, #136
	ldmia	r3, {r1, r2, r3}
	ldr	r0, .L5+44
	bl	writeImage
	ldr	r3, [fp, #-140]
	str	r3, [sp, #0]
	sub	r3, fp, #152
	ldmia	r3, {r1, r2, r3}
	ldr	r0, .L5+48
	bl	writeImage
	ldr	r3, [fp, #-156]
	str	r3, [sp, #0]
	sub	r3, fp, #168
	ldmia	r3, {r1, r2, r3}
	ldr	r0, .L5+52
	bl	writeImage
	ldr	r3, [fp, #-108]
	mov	r0, r3
	bl	free
	sub	sp, fp, #4
	ldmfd	sp!, {fp, pc}
.L6:
	.align	2
.L5:
	.word	2498396
	.word	4904878
	.word	952566
	.word	7403274
	.word	-2498407
	.word	-4904867
	.word	-1437774
	.word	5857443
	.word	-4904877
	.word	-952567
	.word	-4272902
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.size	RGBtoYCC, .-RGBtoYCC
	.section	.rodata
	.align	2
.LC3:
	.ascii	"outRGB.bmp\000"
	.text
	.align	2
	.global	YCCtoRGB
	.type	YCCtoRGB, %function
YCCtoRGB:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #112
	str	r0, [fp, #-96]
	str	r1, [fp, #-100]
	str	r2, [fp, #-104]
	sub	r3, fp, #40
	mov	r0, r3
	ldr	r1, [fp, #-96]
	bl	readImage
	sub	r3, fp, #56
	mov	r0, r3
	ldr	r1, [fp, #-100]
	bl	readImage
	sub	r3, fp, #72
	mov	r0, r3
	ldr	r1, [fp, #-104]
	bl	readImage
	ldr	r3, [fp, #-32]
	mov	r2, r3
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r0, r3
	bl	malloc
	mov	r3, r0
	str	r3, [fp, #-76]
	ldr	r3, [fp, #-40]
	str	r3, [fp, #-88]
	ldr	r3, [fp, #-36]
	str	r3, [fp, #-84]
	ldr	r3, [fp, #-32]
	str	r3, [fp, #-80]
	mov	r3, #0
	str	r3, [fp, #-24]
	b	.L8
.L9:
	ldr	r3, [fp, #-24]
	mov	r3, r3, asr #1
	str	r3, [fp, #-20]
	ldr	r1, [fp, #-28]
	ldr	r2, [fp, #-24]
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	add	r3, r1, r3
	mov 	r4, r3
	ldrb	r3, [r3, #2]
	mov	r0, r3
	ldr	r1, [fp, #-60]
	ldr	r2, [fp, #-20]
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	add	r3, r1, r3
	mov 	r5, r3
	ldrb	r3, [r3, #2]
	add	r3, r0, r3
	sub	r3, r3, #144
	str	r3, [fp, #-16]
	ldrb	r3, [r4, #1]
	mov	r0, r3
	ldr	r1, [fp, #-44]
	ldr	r2, [fp, #-20]
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	add	r3, r1, r3
	mov 	r6, r3
	ldrb	r3, [r3, #1]
	add	r0, r0, r3
	ldrb	r3, [r5, #1]
	add	r3, r0, r3
	sub	r3, r3, #272
	str	r3, [fp, #-12]
	ldrb	r3, [r4, #0]
	mov	r0, r3
	ldrb	r3, [r6, #0]
	add	r3, r0, r3
	sub	r3, r3, #144
#APP
@ 211 "src/ColourSpace.c" 1
	USAT r3, #8, r3
@ 0 "" 2
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-16]
#APP
@ 209 "src/ColourSpace.c" 1
	USAT r3, #8, r3
@ 0 "" 2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-12]
#APP
@ 210 "src/ColourSpace.c" 1
	USAT r3, #8, r3
@ 0 "" 2
	str	r3, [fp, #-12]
	ldr	r1, [fp, #-76]
	ldr	r2, [fp, #-24]
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	add	r2, r1, r3
	mov 	r1, r2
	ldr	r3, [fp, #-16]
	uxtb	r3, r3
	strb	r3, [r1, #2]
	ldr	r3, [fp, #-12]
	uxtb	r3, r3
	strb	r3, [r1, #1]
	ldr	r3, [fp, #-8]
	uxtb	r3, r3
	strb	r3, [r1, #0]
	ldr	r3, [fp, #-24]
	add	r3, r3, #1
	str	r3, [fp, #-24]
.L8:
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-24]
	cmp	r2, r3
	bgt	.L9
	ldr	r3, [fp, #-76]
	str	r3, [sp, #0]
	sub	r3, fp, #88
	ldmia	r3, {r1, r2, r3}
	ldr	r0, .L11
	bl	writeImage
	ldr	r3, [fp, #-28]
	mov	r0, r3
	bl	free
	ldr	r3, [fp, #-44]
	mov	r0, r3
	bl	free
	ldr	r3, [fp, #-60]
	mov	r0, r3
	bl	free
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #4
	ldmfd	sp!, {fp, pc}
.L12:
	.align	2
.L11:
	.word	.LC3
	.size	YCCtoRGB, .-YCCtoRGB
	.section	.rodata
	.align	2
.LC4:
	.ascii	"RGB to YCC...\000"
	.align	2
.LC5:
	.ascii	"YCC to RGB...\000"
	.align	2
.LC6:
	.ascii	"Bad argument format.\000"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	str	r0, [fp, #-8]
	str	r1, [fp, #-12]
	ldr	r3, [fp, #-8]
	cmp	r3, #2
	bne	.L14
	ldr	r0, .L18
	bl	puts
	ldr	r3, [fp, #-12]
	add	r3, r3, #4
	ldr	r3, [r3, #0]
	mov	r0, r3
	bl	RGBtoYCC
	b	.L15
.L14:
	ldr	r3, [fp, #-8]
	cmp	r3, #4
	bne	.L16
	ldr	r0, .L18+4
	bl	puts
	ldr	r3, [fp, #-12]
	add	r3, r3, #4
	ldr	r1, [r3, #0]
	ldr	r3, [fp, #-12]
	add	r3, r3, #8
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-12]
	add	r3, r3, #12
	ldr	r3, [r3, #0]
	mov	r0, r1
	mov	r1, r2
	mov	r2, r3
	bl	YCCtoRGB
	b	.L15
.L16:
	ldr	r0, .L18+8
	bl	puts
.L15:
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #4
	ldmfd	sp!, {fp, pc}
.L19:
	.align	2
.L18:
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.size	main, .-main
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits
