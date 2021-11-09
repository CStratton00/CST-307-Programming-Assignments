# Collin Stratton
# CST-307
# Procedures and Stack Management
# Dr. Citro Ricardo

# This is a program that takes a number from the user and finds the factorial of the number

# How to use: 
# 1. Reinitialize simulator
# 2. Clear Registers
# 3. Load factorial.asm into QtSPIM
# 4. Run the program
# 5. Enter the number to factorial in the console
# 6. Type y to continue and n to exit
# 7. Repeat steps 4-7

    .text
main:
    jal start                   # jump to the start of the program

start:
    la      $a0, Enter          # load the text from Enter into $a0
    li      $v0, 4              # load string print command into $v0
    syscall                     # print the text to the console

    li      $v0, 5              # load the int in the console to be loaded
    syscall                     # load the int into $a0

    add     $s1, $v0, $zero     # store the value of $v0 into $s1
    li      $s2, 1              # load 1 into $s2 as a base case
    
    beq     $s1, $zero, zero_case   # if the user enters 0 go to special case

    add     $a0, $s1, $zero     # pass the value for the fib function into $a0
    jal     factorial           # jump to factorial function

    add     $a0, $v1, $zero     # set $a0 to the final fib value
    li      $v0, 1              # load print int value into $v0
    syscall                     # print the integer

    jal loop_factorial          # jump to loop_factorial

factorial:
    addi    $sp, $sp, -8        # grow the stack pointers
    sw      $a0, 0($sp)         # store the arguments
    sw      $ra, 4($sp)         # store the return address

    bne     $a0, $s2, recursion # if n != 1 call recursion
    add     $v1, $s2, $zero     # store $s2 in $v1
    addi    $sp, $sp, 8         # restore stack pointers and remove stack frame

    jr      $ra                 # return to start function

    recursion: 
        addi    $a0, $a0, -1    # subtract 1 from n
        jal     factorial       # jump to factorial

        lw      $a0, 0($sp)     # store the arguments
        lw      $ra, 4($sp)     # store the return address
        addi    $sp, $sp, 8     # restore stack pointers and remove stack frame
        mul     $v1, $a0, $v1   # multiply the current n value by the total value

        jr      $ra             # return to factorial function

loop_factorial:
    la 		$a0, Loop	        # load Loop into $a0
	li 		$v0, 4				# load string print command into $v0
	syscall						# runs command

	la		$a0, string_space	# move the user word into argument $a0
	li		$a1, 1024			# load immediate register $a1 to store length of size 1024 bytes
	li 		$v0, 8				# load string read command into $v0
	syscall						# runs command
	
	la		$t1, string_space   # move the user word into argument $t1
	lb		$t4, ($t1)			# load the first byte into $t4
	lb		$t5, yes			# load yes character into $t5
	beq 	$t4, $t5, start	    # run loops if $t4 = $t5
	bne 	$t4, $t5, exit		# run exit if $t4 != $t5

zero_case:
    li      $a0, 1              # load 1 into $a0
    li      $v0, 1              # regsiter $v0 to print int
    syscall                     # print to the console

    jal     loop_factorial      # jump to loop_factorial

exit:
	la 		$a0, goodbye	    # load goodbye into $a0
	li 		$v0, 4			    # load string print command into $v0
	syscall					    # runs command

	li		$v0, 10			    # load immediate $v0 to exit program
	syscall					    # system call exit program


    .data
Enter:          .asciiz "Enter value of n: "
Loop:           .asciiz "\nDo you want to continue[y/n]: "
yes:            .asciiz "y"
goodbye:        .asciiz "Goodbye"

string_space:	.space 1024