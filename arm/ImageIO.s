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
	.file	"ImageIO.c"
	.section	.rodata
	.align	2
.LC0:
	.ascii	"r\000"
	.text
	.align	2
	.global	readImage
	.type	readImage, %function
readImage:
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, fp, lr}
	add	fp, sp, #8
	sub	sp, sp, #36
	mov	r4, r0

	@ Replaced str	r1, [fp, #-40]
	@ Replaced ldr	r0, [fp, #-40]
	mov r0, r1
	
	ldr	r1, .L3
	bl	fopen
	mov	r3, r0
	str	r3, [fp, #-16]

	@ Removed ldr	r0, [fp, #-16]

	mov	r1, #18
	mov	r2, #0
	bl	fseek

	@ Replaced sub	r3, fp, #32
	@ Replaced mov	r0, r3
	sub r0, fp, #32

	mov	r1, #4
	mov	r2, #1
	ldr	r3, [fp, #-16]
	bl	fread

	@ Replaced sub	r3, fp, #32
	@ Replaced add	r3, r3, #4
	@ Replaced mov	r0, r3
	sub r0, fp, #28
	
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [fp, #-16]
	bl	fread
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-28]
	mul	r3, r3, r2
	str	r3, [fp, #-24]
	
	@ Removed ldr	r3, [fp, #-24]

	mov	r2, r3

	@ Removed mov	r3, r2

	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r0, r3
	bl	malloc
	mov	r3, r0
	str	r3, [fp, #-20]
	ldr	r0, [fp, #-16]
	mov	r1, #54
	mov	r2, #0
	bl	fseek
	ldr	r2, [fp, #-20]
	ldr	r3, [fp, #-24]
	mov	r0, r2
	mov	r1, #3
	mov	r2, r3
	ldr	r3, [fp, #-16]
	bl	fread
	ldr	r0, [fp, #-16]
	bl	fclose
	mov	ip, r4
	sub	r3, fp, #32
	ldmia	r3, {r0, r1, r2, r3}
	stmia	ip, {r0, r1, r2, r3}
	mov	r0, r4
	sub	sp, fp, #8
	ldmfd	sp!, {r4, fp, pc}
.L4:
	.align	2
.L3:
	.word	.LC0
	.size	readImage, .-readImage
	.section	.rodata
	.align	2
.LC1:
	.ascii	"w\000"
	.text
	.align	2
	.global	writeImage
	.type	writeImage, %function
writeImage:
	@ args = 20, pretend = 16, frame = 72
	@ frame_needed = 1, uses_anonymous_args = 0
	sub	sp, sp, #16
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #72
	str	r0, [fp, #-72]
	add	r0, fp, #8
	stmia	r0, {r1, r2, r3}
	ldr	r0, [fp, #-72]
	ldr	r1, .L7
	bl	fopen

	@ Replaced mov	r3, r0
	@ Repalced str	r3, [fp, #-8]
	str	r0, [fp, #-8]

	sub	r3, fp, #62
	mov	r2, #54
	mov	r0, r3
	mov	r1, #0
	bl	memset
	mov	r3, #66
	strb	r3, [fp, #-62]
	mov	r3, #77
	strb	r3, [fp, #-61]
	mov	r3, #54
	strb	r3, [fp, #-52]
	mov	r3, #40
	strb	r3, [fp, #-48]
	mov	r3, #24
	strb	r3, [fp, #-34]
	ldr	r2, [fp, #16]
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	add	r3, r3, #54
	str	r3, [fp, #-68]

	@ Replaced sub	r3, fp, #62
	@ Replaced add	r3, r3, #2
	sub r3, fp, #60

	@ Replaced sub	r2, fp, #68
	@ Replaced mov	r1, r2
	sub r1, fp, #68
	
	mov	r0, r3
	mov	r2, #4
	bl	memcpy

	@ Replaced sub	r3, fp, #62
	@ Replaced add	r3, r3, #18
	sub r3, fp, #44

	@ Replaced add	r2, fp, #8
	@ Replaced mov	r1, r2
	add r1, fp, #8

	mov	r0, r3
	mov	r2, #4
	bl	memcpy

	@ Replaced sub	r3, fp, #62
	@ Replaced add	r2, r3, #22
	@ Replaced mov	r0, r2
	sub r0, fp, #40
	
	@ Replaced add	r3, fp, #8
	@ Replaced add	r3, r3, #4
	add r3, fp, #12

	mov	r1, r3
	mov	r2, #4
	bl	memcpy

	@ Replaced sub	r3, fp, #62
	@ Replaced mov	r0, r3
	sub r0, fp, #62

	mov	r1, #1
	mov	r2, #54
	ldr	r3, [fp, #-8]
	bl	fwrite

	@ Replaced ldr	r2, [fp, #20]
	@ Replaced mov	r0, r2
	ldr	r0, [fp, #20]

	@ Replaced ldr	r3, [fp, #16]
	@ Replaced mov	r2, r3
	ldr	r2, [fp, #16]

	mov	r1, #3
	ldr	r3, [fp, #-8]
	bl	fwrite
	ldr	r3, [fp, #20]
	mov	r0, r3
	bl	free
	ldr	r0, [fp, #-8]
	bl	fclose
	sub	sp, fp, #4
	ldmfd	sp!, {fp, lr}
	add	sp, sp, #16
	bx	lr
.L8:
	.align	2
.L7:
	.word	.LC1
	.size	writeImage, .-writeImage
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits
