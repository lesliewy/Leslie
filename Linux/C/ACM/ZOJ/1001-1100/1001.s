	.file	"1001.c"
	.section	.rodata
.LC0:
	.string	"%d\n"
.LC1:
	.string	"%d %d"
	.text
.globl main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	andl	$-16, %esp
	subl	$32, %esp
	jmp	.L2
.L3:
	movl	28(%esp), %edx
	movl	24(%esp), %eax
	addl	%eax, %edx
	movl	$.LC0, %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	printf
.L2:
	movl	$.LC1, %eax
	leal	24(%esp), %edx
	movl	%edx, 8(%esp)
	leal	28(%esp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	__isoc99_scanf
	cmpl	$-1, %eax
	jne	.L3
	movl	$0, %eax
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu 4.4.1-4ubuntu8) 4.4.1"
	.section	.note.GNU-stack,"",@progbits
