#Name -Ravi Bansal
#Roll No-:13CS30026
#Assignment_1 compilers
#Aim-: To convert the .c file to .S file and comment it.
#Registers used
# %edi -> 1st argument to a function
# %rsi -> 2nd argument to a function
# %rdx -> 3rd argument to a function
# %rcx -> 4th argument to a function
# %rax -> returns the value from the function
	.file	"assgn1.c"		#filename
	.section	.rodata		#rawdata (read only section)
.LC0:			#temporary variable for string
	.string	"Enter the order: "		#Label of string -1st printf
.LC1:
	.string	"%d"					#Label of string scanf
.LC2:			#temporary variable for string
	.string	"Enter matix A in row-major: "	#Label of string-2nd string
.LC3:			#temporary variable for string
	.string	"Enter matix B in row-major: "	#Label of string-3rd printf
.LC4:			#temporary variable for string
	.string	"The output matrix is:"	#Label of string -4th printf
.LC5:			
	.string	"%d "	#Label of string-scanf 
	.text			#code starts here
	.globl	main	#defining main as global	
	.type	main, @function	#defining main as a fuction
main:				#main function starts here
.LFB0:
	.cfi_startproc	#initializes some internal data structures and emits architecture dependent initial CFI(call frame information) instructions
	pushq	%rbp	#save old base pointer
	.cfi_def_cfa_offset 16 	
	.cfi_offset 6, -16
	movq	%rsp, %rbp		#rbp <-- rsp,set new base pointer
	.cfi_def_cfa_register 6
	subq	$4816, %rsp	#create space for local 2D array
	movl	$.LC0, %edi #push the 1st argument to the printf function
	movl	$0, %eax   #eax <-- 0
													# Doesn't create a dependency on the previous value, that the cpu would have to wait on.
													# Without this behaviour, every single 32bit instruction in 64bit mode would have to wait on something 
													# that happened before, even though that upper 32 bits register would almost never be used
	call	printf	#call printf to print
	leaq	-4812(%rbp), %rax #rax <-- rbp - 4812 (load the address of n to rax)
	movq	%rax, %rsi	# rsi <-- rax (copy the value of n to rsi)
	movl	$.LC1, %edi	#copy %d to edi for the first argument of scanf
	movl	$0, %eax	#eax <-- 0
	call	__isoc99_scanf	#call scanf
	movl	$.LC2, %edi	# edi <-- address of printf string(for the first argument)
	movl	$0, %eax	# eax <-- 0
	call	printf		# call printf
	movl	-4812(%rbp), %eax #eax <-- rbp - 4812 (to store the value of n into eax)
	leaq	-4800(%rbp), %rdx #rdx <-- rbp - 4800 (to store the address of A[0][0] in rdx)
	movq	%rdx, %rsi	#rsi <-- rdx  (to copy the address of A[0][0] into rsi i.e. the second argument to the function ReadMatrix)
	movl	%eax, %edi	#edi <-- eax  (to copy the value of n to edi i.e. the first argument to ReadMatrix function)
	call	ReadMatrix	#Call the ReadMatrix Function
	movl	$.LC3, %edi	# edi <-- address of printf string(for the first argument)
	movl	$0, %eax 	# eax <-- 0
	call	printf 		#call printf to print
	movl	-4812(%rbp), %eax #store the value of n in eax 
	leaq	-3200(%rbp), %rdx #load the address of B[0][0] to rdx
	movq	%rdx, %rsi	#rsi <-- rdx, second argument for ReadMatrix
	movl	%eax, %edi	#eax <-- edi, first argument for RadMatrix
	call	ReadMatrix  #call the ReadMatrix Function
	movl	-4812(%rbp), %eax	#store the value of n in eax
	leaq	-1600(%rbp), %rcx	#load the address of C[0][0] to rcx (4th argument to MultiplyMatrix Function) 
	leaq	-3200(%rbp), %rdx 	#load the address of B[0][0] to rdx (3rd argument to MultiplyMatrix Function)
	leaq	-4800(%rbp), %rsi 	#load the address of A[0][0] to rsi (2nd argument to MultiplyMatrix Function)
	movl	%eax, %edi 	#store the value of n to edi (1st argument to MultiplyMatrix Function
	call	MultiplyMatrix #call MultiplyMatrix Function
	movl	$.LC4, %edi	# edi <-- address of printf string(for the first argument)
	call	puts #call puts to print
	movl	$0, -4808(%rbp) #initialize i to 0
	jmp	.L2 #jump to L2 for conditions for for loop
.L5:
	movl	$0, -4804(%rbp) #initailize j to 0
	jmp	.L3 #jump to L3 for conditions for inner for loop
.L4:
	movl	-4804(%rbp), %eax #eax =j
	movslq	%eax, %rcx  #rcx <-- eax (convert 32- bit j into 64-bit j)
	movl	-4808(%rbp), %eax #eax = i
	movslq	%eax, %rdx  #rdx <-- eax (convert 32- bit i into 64-bit i)
	movq	%rdx, %rax #rax= rdx
	salq	$2, %rax # shift 2 bit to left i.e. multiply 4 to i 
	addq	%rdx, %rax #rax = 4*i+i=5*i
	salq	$2, %rax # shift 2 bit to left i.e. rax = 20*i
	addq	%rcx, %rax  #rax = 20*i+j
	movl	-1600(%rbp,%rax,4), %eax  #eax = C[0][0]+80*i+4*j (i.e. C[i][j])
	movl	%eax, %esi #esi = i
	movl	$.LC5, %edi #copy %d to edi for the first argument of printf
	movl	$0, %eax #eax = 0
	call	printf #call Printf to print
	addl	$1, -4804(%rbp) #increase j by 1
.L3:
	movl	-4812(%rbp), %eax #eax = n
	cmpl	%eax, -4804(%rbp) #compare the value of j with n ,if j is less than n then it is true
	jl	.L4 #jump to L4 if above condition is true
	movl	$10, %edi #Store the new line character to edi
	call	putchar #call putchar to print
	addl	$1, -4808(%rbp) #increase i by 1
.L2:
	movl	-4812(%rbp), %eax #eax = n
	cmpl	%eax, -4808(%rbp) #compare the value of i with n, if i is less than n then it is true
	jl	.L5 #jump to L5 if above comparision is true
	movl	$0, %eax #eax = 0
	leave #return 0
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.section	.rodata
.LC6:
	.string	"The input matrix is:" #Label for String
	.text 	
	.globl	ReadMatrix #defining the ReadMatrix as global
	.type	ReadMatrix, @function
ReadMatrix:
.LFB1:
	.cfi_startproc
	pushq	%rbp	#save old base pointer
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#rbp <-- rsp,set new base pointer
	.cfi_def_cfa_register 6
	subq	$32, %rsp	#Create 32 byte stack frame
	movl	%edi, -20(%rbp)	# rbp - 20 <-- edi (copy the address of first parameter n to rbp - 20)
	movq	%rsi, -32(%rbp)	# rbp - 32 <-- rsi (copy the address of second parameter i.e. A[0][0])
	movl	$0, -8(%rbp)	# initialize i to 0
	jmp	.L8
.L11:
	movl	$0, -4(%rbp)	#initaialize j to 0
	jmp	.L9 				#jump to L9 (i.e. inner for loop)
.L10:
	movl	-8(%rbp), %eax	#store the value of i to eax
	movslq	%eax, %rdx 		#rdx <-- eax (convert 32- bit i into 64-bit i)
	movq	%rdx, %rax 		#rax <-- rdx (copy the value of i to rax)
	salq	$2, %rax 		# shift 2 bit to left i.e. multiply 4 to i 
	addq	%rdx, %rax 		#rax <-- rax + rdx (rax = 5*i) 
	salq	$4, %rax 		#shift 4 bit to left i.e. mutliply by 16 to (5*i) (i.e. rax = 80*i)
	movq	%rax, %rdx 		#rdx <-- rax copy the value of rax to tdx 
	movq	-32(%rbp), %rax #store the starting address of data[0][0] to rax
	addq	%rax, %rdx 		#rdx <-- rax + rdx ,copy the value of (starting address of array + 80*i)
	movl	-4(%rbp), %eax 	#eax <-- rbp-4 , copy the value of j to eax
	cltq 					#convert the number stored in eax to 64-bit and copy this to rax
	salq	$2, %rax 		#shift the value stored at rax left by two bits i.e. multiply it by 4 i.e. rax = 4*j
	addq	%rdx, %rax 		#rax <-- rdx + rax , rax = address of data[0][0]+80*i+4*j
	movq	%rax, %rsi		#rsi <-- rax, store the value into rsi os rax
	movl	$.LC1, %edi 	#copy %d to edi for the first argument of scanf
	movl	$0, %eax		
	call	__isoc99_scanf	#call Scanf
	addl	$1, -4(%rbp) 	#increment j by 1
.L9:
	movl	-4(%rbp), %eax	#copy the address of j to eax
	cmpl	-20(%rbp), %eax	 #compare the value of eax with n if less than execute jump
	jl	.L10		# jump to L10 if the above comparision is true
	addl	$1, -8(%rbp)	# increase the value of i by 1
.L8:
	movl	-8(%rbp), %eax	#eax <-- rbp - 8 (to copy the address of i to eax)
	cmpl	-20(%rbp), %eax	#compare the value i(eax) with n(-20(%rbp))
	jl	.L11	# jump to L11(i.e. inner for loop) if the above comparision is true
	movl	$.LC6, %edi 	#push the 1st argument to the printf function i.e. string in .LC6
	call	puts	#call puts to print
	movl	$0, -8(%rbp) #initialize i to 0
	jmp	.L12
.L15:
	movl	$0, -4(%rbp) #initialize j to 0
	jmp	.L13	#jump to L13 i.e. after the first for loop
.L14:
	movl	-8(%rbp), %eax #eax <-- rbp - 8, Copy the value of i to eax
	movslq	%eax, %rdx  #rdx <-- eax (convert 32- bit i into 64-bit i)
	movq	%rdx, %rax 	#rax <-- rdx (copy the 64-bit value i to rax)
	salq	$2, %rax 	#shift the value in rax left by 2 bits i.e. rax = 4*i
	addq	%rdx, %rax  #rax <-- rdx+rax, rax = 5*i
	salq	$4, %rax  	#shift the value in rax left by 4 bits i.e. rax = 80*i
	movq	%rax, %rdx 	#rdx <-- rax, rdx = 80*i
	movq	-32(%rbp), %rax #store the address of data[0][0] to rax
	addq	%rax, %rdx  #rdx = 80*i + address of data[0][0]
	movl	-4(%rbp), %eax #eax = j
	cltq 	#convert the number stored in eax to 64-bit and copy this to rax
	movl	(%rdx,%rax,4), %eax #eax <-- (rdx + 4*rax), eax = 80*i + address of data[0][0] + 4*j
	movl	%eax, %esi #esi <-- eax 
	movl	$.LC5, %edi #copy %d to edi for the first argument of printf
	movl	$0, %eax #eax <-- 0
	call	printf	# call printf to print 
	addl	$1, -4(%rbp)	#increase j by 1
.L13:
	movl	-4(%rbp), %eax	#eax <-- rbp - 4, store the value of j to eax
	cmpl	-20(%rbp), %eax #compare the value of j with n, if j is smaller than n then the below jump is executed
	jl	.L14	#jump to L14 if the above comparision is true
	movl	$10, %edi #store the new line character to edi
	call	putchar   # call put char to print the character stored at edi
	addl	$1, -8(%rbp) #increase i by 1
.L12:
	movl	-8(%rbp), %eax #eax <-- rbp - 8,store the value of i to eax
	cmpl	-20(%rbp), %eax	#compare the value of j with n , if it is less than n then it is true.
	jl	.L15	#jump to L15 if the above comparision is true
	leave		# return
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	ReadMatrix, .-ReadMatrix
	.section	.rodata
.LC7:
	.string	"The transposed matrix is:" #Label of string string
	.text
	.globl	TransposeMatrix #define the TransposeMatrix as global function
	.type	TransposeMatrix, @function
TransposeMatrix:
.LFB2:
	.cfi_startproc
	pushq	%rbp #save old base pointer
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp 	#rbp <-- rsp,set new base pointer
	.cfi_def_cfa_register 6
	subq	$32, %rsp #create a 32 byte stack frame for this function
	movl	%edi, -20(%rbp) #rbp -20 <-- edi (store the value of n to rbp-20)
	movq	%rsi, -32(%rbp) #rbp - 32 <-- rsi (store the address of data[0][0] tp rbp-32)
	movl	$0, -12(%rbp) 	#initialize i to 0
	jmp	.L17	#jump to L17 i.e. for loop
.L20:
	movl	$0, -8(%rbp)	#initialize j to 0
	jmp	.L18	#jump to L18
.L19:
	movl	-12(%rbp), %eax	#store the value of i at eax
	movslq	%eax, %rdx 	#rdx <-- eax (convert 32- bit i into 64-bit i)
	movq	%rdx, %rax 	#rax <-- rdx 
	salq	$2, %rax 	#shift the value of rax 2 bit to left , rax = 4*i
	addq	%rdx, %rax 	#rax= rdx+rax, rdx= 5*i
	salq	$4, %rax 	#shift the value of rax 4 bit to left , rax = 80*i
	movq	%rax, %rdx 	#rdx <-- rax, rdx = 80*i
	movq	-32(%rbp), %rax #rax = address of data[0][0] 
	addq	%rax, %rdx 	#rdx = #rax = address of data[0][0] + 80*i
	movl	-8(%rbp), %eax #eax = j
	cltq	#convert the number stored in eax to 64-bit and copy this to rax
	movl	(%rdx,%rax,4), %eax #eax = rdx + 4*rax, #eax = address of data[0][0] + 80*i + 4*j
	movl	%eax, -4(%rbp) # rbp - 4 <-- eax 
	movl	-12(%rbp), %eax #eax <-- rbp-12, store the value of i at eax
	movslq	%eax, %rdx 	#rdx <-- eax (convert 32- bit i into 64-bit i)
	movq	%rdx, %rax 	#rax <-- rdx
	salq	$2, %rax    #shift the value at rax by 2 bits left, rax = 4*i
	addq	%rdx, %rax 	#rax= rdx+rax, rdx= 5*i
	salq	$4, %rax 	#shift the value of rax 4 bit to left , rax = 80*i
	movq	%rax, %rdx 	#rdx <-- rax, rdx = 80*i
	movq	-32(%rbp), %rax #rax = address of data[0][0] 
	leaq	(%rdx,%rax), %rcx #load the address of data[0][0] + 80*i to rcx
	movl	-8(%rbp), %eax 	#eax = j
	movslq	%eax, %rdx 	#rdx <-- eax (convert 32- bit j into 64-bit j)
	movq	%rdx, %rax 	#rax <-- rdx
	salq	$2, %rax 	#shift the value at rax by 2 bits left, rax = 4*j
	addq	%rdx, %rax 	#rax= rdx+rax, rdx= 5*j
	salq	$4, %rax 	#shift the value of rax 4 bit to left , rax = 80*j
	movq	%rax, %rdx 	#rdx <-- rax, rdx = 80*j
	movq	-32(%rbp), %rax #rax = address of data[0][0]
	addq	%rax, %rdx 	#rdx = address of data[0][0] + 80*j
	movl	-12(%rbp), %eax #eax= i
	cltq	#convert the number stored in eax to 64-bit and copy this to rax
	movl	(%rdx,%rax,4), %edx #edx = rdx + 4*rax, edx = address of data[0][0] + 80*j + 4*i
	movl	-8(%rbp), %eax #eax = j;
	cltq	#convert the number stored in eax to 64-bit and copy this to rax
	movl	%edx, (%rcx,%rax,4) #(rcx+4*rax = edx) i.e. data[i][j]=data[j][i]
	movl	-8(%rbp), %eax 	#eax = j
	movslq	%eax, %rdx 	#rdx <-- eax (convert 32- bit j into 64-bit j)
	movq	%rdx, %rax  #rax <-- rdx
	salq	$2, %rax 	#shift the value at rax by 2 bits left, rax = 4*j
	addq	%rdx, %rax 	#rax= rdx+rax, rdx= 5*j
	salq	$4, %rax 	#shift the value of rax 4 bit to left , rax = 80*j
	movq	%rax, %rdx  #rdx <-- rax, rdx = 80*j
	movq	-32(%rbp), %rax #rax = address of data[0][0]
	leaq	(%rdx,%rax), %rcx #load the address of data[0][0] + 80*j to rcx
	movl	-12(%rbp), %eax #eax = i
	cltq	#convert the number stored in eax to 64-bit and copy this to rax
	movl	-4(%rbp), %edx #edx = t
	movl	%edx, (%rcx,%rax,4) #rcx + 4*rax = edx( data[j][i]=t)
	addl	$1, -8(%rbp) #increase j by 1
.L18:
	movl	-8(%rbp), %eax	#store the value of j to eax
	cmpl	-12(%rbp), %eax #compare the value of j with i,if j is less than i then execute the below jump
	jl	.L19	#jump to L19 
	addl	$1, -12(%rbp) #increase i by 1
.L17:
	movl	-12(%rbp), %eax	#store the value of i at eax
	cmpl	-20(%rbp), %eax	#compare the value of i with n, if i is less than n then execute the jump below
	jl	.L20	#jump to L20 i.e. inner for loop
	movl	$.LC7, %edi  ##push the 1st argument to the printf function
	call	puts	#call puts to print
	movl	$0, -12(%rbp) #initialize i to 0
	jmp	.L21	#jump to L21
.L24:
	movl	$0, -8(%rbp) #initialize j to 0
	jmp	.L22 #jump to L22 for inner for loop
.L23:
	movl	-12(%rbp), %eax #eax = i
	movslq	%eax, %rdx #rdx <-- eax (convert 32- bit i into 64-bit i)
	movq	%rdx, %rax  #rax <-- rdx
	salq	$2, %rax 	#shift the value at rax by 2 bits left, rax = 4*i
	addq	%rdx, %rax 	#rax= rdx+rax, rdx= 5*i
	salq	$4, %rax 	#shift the value of rax 4 bit to left , rax = 80*i
	movq	%rax, %rdx 	#rdx <-- rax, rdx = 80*i
	movq	-32(%rbp), %rax #rax = address of data[0][0]
	addq	%rax, %rdx 	#load the address of data[0][0] + 80*i to rax
	movl	-8(%rbp), %eax #eax = j
	cltq	#convert the number stored in eax to 64-bit and copy this to rax
	movl	(%rdx,%rax,4), %eax #eax = rdx+4*rax, eax = address of data[0][0]+80*i +4*j
	movl	%eax, %esi #esi =eax
	movl	$.LC5, %edi #copy %d to edi for the first argument of printf
	movl	$0, %eax 	
	call	printf	#call printf to print
	addl	$1, -8(%rbp) #increase j by 1
.L22:
	movl	-8(%rbp), %eax #eax=j
	cmpl	-20(%rbp), %eax #compare the value of j with n, if j is less than n then it is true and the below jump is executed
	jl	.L23 #jump to L23 
	movl	$10, %edi #store the new line character to edi
	call	putchar #call putchar to print character
	addl	$1, -12(%rbp) #increase i by 1
.L21:
	movl	-12(%rbp), %eax #eax = i
	cmpl	-20(%rbp), %eax #compare i with n, if i is less than n then it is true and the below jump is executed 
	jl	.L24 #jump to L24 for the first for loop
	leave #return
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	TransposeMatrix, .-TransposeMatrix
	.globl	VectorMultiply
	.type	VectorMultiply, @function
VectorMultiply:
.LFB3:
	.cfi_startproc
	pushq	%rbp #save old base pointer
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp 	#rbp <-- rsp,set new base pointer
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp) #rbp - 20 <-- n
	movq	%rsi, -32(%rbp) #rbp - 32 <-- address of L[i][0]
	movq	%rdx, -40(%rbp) #rbp - 40 <-- address of R[j][0]
	movl	$0, -4(%rbp) 	#initialize result to 0
	movl	$0, -8(%rbp) 	#initialize i to 0
	jmp	.L26 #jump to L26 i.e. condition for for loop
.L27:
	movl	-8(%rbp), %eax #eax = i
	cltq	#convert the number stored in eax to 64-bit and copy this to rax
	leaq	0(,%rax,4), %rdx #rdx = 4*i
	movq	-32(%rbp), %rax #rax = addrss of L[i][0]
	addq	%rdx, %rax #rax = address of L[i][0] +4*i
	movl	(%rax), %edx	#edx=rax
	movl	-8(%rbp), %eax 	#eax = i;
	cltq 	#convert the number stored in eax to 64-bit and copy this to rax
	leaq	0(,%rax,4), %rcx #rcx = 4*i
	movq	-40(%rbp), %rax #rax = address of R[j][0]
	addq	%rcx, %rax 	#rax = address of R[j][0] + 4*i
	movl	(%rax), %eax #eax = address of R[j][0] + 4*i
	imull	%edx, %eax #eax = L[i] * R[i]
	addl	%eax, -4(%rbp) #result = result + L[i]*R[i]
	addl	$1, -8(%rbp) #increase i by 1
.L26:
	movl	-8(%rbp), %eax #eax = i
	cmpl	-20(%rbp), %eax #compare i with n , if i is less than n then it is true
	jl	.L27 #jump to L27 i.e. inside the for loop
	movl	-4(%rbp), %eax #eax = result
	popq	%rbp # pop the base pointer from the stack
	.cfi_def_cfa 7, 8
	ret 	#return eax
	.cfi_endproc
.LFE3:
	.size	VectorMultiply, .-VectorMultiply
	.globl	MultiplyMatrix #Declare the MultiplyMatrix as Global Function
	.type	MultiplyMatrix, @function
MultiplyMatrix:
.LFB4:
	.cfi_startproc
	pushq	%rbp 	#save old base pointer
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp 	#rbp <-- rsp,set new base pointer
	.cfi_def_cfa_register 6
	pushq	%rbx	#
	subq	$56, %rsp	#create 56 byte stack frame
	.cfi_offset 3, -24
	movl	%edi, -36(%rbp) # store the value of n to rbp-36
	movq	%rsi, -48(%rbp)	#store the value of address of L[0][0] to rbp-48
	movq	%rdx, -56(%rbp)	#store the value of address of R[0][0] to rbp-56
	movq	%rcx, -64(%rbp)	#store the value of address of M[0][0] to rbp-64
	movq	-56(%rbp), %rdx #rdx <-- rbp-56 , store the address of R[0][0] to rdx
	movl	-36(%rbp), %eax #eax <-- rbp-36 , store the value n in rbp-36
	movq	%rdx, %rsi  	#rsi <-- rdx ,store the address of R[0][0] to rsi(second argument for TransposeMatrix)
	movl	%eax, %edi		#edi <-- eax , store the value of n to edi (first argument for TransposeMatrix) 
	call	TransposeMatrix #call the function TransposeMatrix
	movl	$0, -24(%rbp) #initialize i to 0
	jmp	.L30 #jump to L30 i.e. outer for loop
.L33:
	movl	$0, -20(%rbp) #initialize j to 0
	jmp	.L31 #jump to L31 i.e. inner for loop
.L32:
	movl	-24(%rbp), %eax #eax = i
	movslq	%eax, %rdx #rdx <-- eax (convert 32- bit i into 64-bit i)
	movq	%rdx, %rax #rax <-- rdx
	salq	$2, %rax 	#shift the value at rax by 2 bits left, rax = 4*i
	addq	%rdx, %rax 	#rax= rdx+rax, rdx= 5*i
	salq	$4, %rax 	#shift the value of rax 4 bit to left , rax = 80*i
	movq	%rax, %rdx 	#rdx <--rax
	movq	-64(%rbp), %rax #rax = address of M[0][0]
	leaq	(%rdx,%rax), %rbx #load the address of M[0][0] +80*i
	movl	-20(%rbp), %eax #eax = j
	movslq	%eax, %rdx 	#rdx <-- eax (convert 32- bit j into 64-bit j)
	movq	%rdx, %rax 	#rax = rdx (i.e. j)
	salq	$2, %rax 	#shift the value of rax 2 bit to left, rax = 4*j
	addq	%rdx, %rax 	#rax = 5*j
	salq	$4, %rax 	#rax is shifted by 4 bits to the left i.e. rax = 80*j
	movq	%rax, %rdx 	#rdx = rax = 80*j
	movq	-56(%rbp), %rax #rax = address of R[0][0]
	addq	%rdx, %rax #rax = address of R[0][0] + 80*j
	movq	%rax, %rsi 	#rsi =rax
	movl	-24(%rbp), %eax #eax = i
	movslq	%eax, %rdx 	#rdx <-- eax (convert 32- bit i into 64-bit i)
	movq	%rdx, %rax  #rax = rdx (i.e. i)
	salq	$2, %rax 	#shift the value of rax 2 bit to left, rax = 4*i
	addq	%rdx, %rax 	#rax = 5*i
	salq	$4, %rax 	#rax is shifted by 4 bits to the left i.e. rax = 80*i
	movq	%rax, %rdx 	#rdx = rax = 80*i
	movq	-48(%rbp), %rax #rax = address of L[0][0]
	addq	%rdx, %rax 	#rax = address of L[0][0]+ 80*i
	movq	%rax, %rcx #rcx = rax
	movl	-36(%rbp), %eax  #eax = n
	movq	%rsi, %rdx 	#rdx = address of R[0][0] + 80*j (i.e. R[j][0]),(3rd argument to VectorMultiply)
	movq	%rcx, %rsi  #rsi = addrss of L[0][0] + 80*i (i.e. L[i][0]),(2nd argument to VectorMultiply)
	movl	%eax, %edi  #edi = eax (1st argument to VectorMultiply)
	call	VectorMultiply #call the VectorMltiply Function
	movl	-20(%rbp), %edx #edx = j
	movslq	%edx, %rdx #rdx <-- eax (convert 32- bit j into 64-bit j)
	movl	%eax, (%rbx,%rdx,4) #value at (address of M[0][0] +80*i + 4*j) i.e. M[i][j] = eax (i.e. result )
	addl	$1, -20(%rbp) #increase j by 1
.L31:
	movl	-20(%rbp), %eax #eax = j
	cmpl	-36(%rbp), %eax #compare the value of j with n, if j is less than n then it is true
	jl	.L32 	#jump to L32
	addl	$1, -24(%rbp) #increase i by 1
.L30:
	movl	-24(%rbp), %eax #eax = i
	cmpl	-36(%rbp), %eax #compare i with n, if i is less than n then it is true and below jump is executed
	jl	.L33 #jump to inner for loop condition
	addq	$56, %rsp  #add 56 bytes to rsp
	popq	%rbx 	#pop pointer rbx
	popq	%rbp   #pop pointer rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	MultiplyMatrix, .-MultiplyMatrix
	.ident	"GCC: (Ubuntu 4.8.4-2ubuntu1~14.04) 4.8.4"
	.section	.note.GNU-stack,"",@progbits
