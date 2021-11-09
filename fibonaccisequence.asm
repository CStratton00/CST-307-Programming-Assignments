# Collin Stratton
# CST-307
# Procedures and Stack Management
# Dr. Citro Ricardo

# This is a program that takes a number from the user and finds the fibonacci value of the number

# How to use: 
# 1. Reinitialize simulator
# 2. Clear Registers
# 3. Load fibonaccisequence.asm into QtSPIM
# 4. Run the program
# 5. Enter the number to find the fibonacci value in the console
# 6. Type y to continue and n to exit
# 7. Repeat steps 4-7

    .text
main:
    jal     start               # jump to the start of the program

start:
    la      $a0, Enter          # load the text from Enter into $a0
    li      $v0, 4              # load string print command into $v0
    syscall                     # print the text to the console

    li      $v0, 5              # load the int in the console to be loaded
    syscall                     # load the int into $a0

    move    $t2, $v0            # move n to $t2
    move    $a0, $t2            # copy n to $a0
    move    $v0, $t2            # copy n to $v0
    jal     fibonacci           # call fib (n)

    move    $t3, $v0            # result is in $t3 from fib function
    la      $a0, result         # print F_
    li      $v0, 4              # load print into $v0
    syscall                     # print to the console

    move    $a0, $t2            # print n value
    li      $v0, 1              # load print int into $v0
    syscall

    la      $a0, result2        # print =
    li      $v0, 4              # load print into $v0
    syscall                     # print to the console

    move    $a0, $t3            # print the answer
    li      $v0, 1              # load print int into $vo
    syscall                     # print to the console

    jal     loop_fibonacci      # jump to loop_fibonacci

fibonacci:
    beqz    $a0, zero_case      # if n = 0 return 0
    beq     $a0, 1, one_case    # if n = 1 return 1

    sub     $sp, $sp, 4         # store return address on stack
    sw      $ra, 0($sp)         # load return address

    sub     $a0, $a0, 1         # n - 1
    jal     fibonacci           # find fib(n - 1)
    add     $a0, $a0, 1         # set n back to original value

    lw      $ra, 0($sp)         # restore return address from stack
    add     $sp, $sp, 4

    sub     $sp, $sp, 4         # Push return value to stack
    sw      $v0, 0($sp)

    sub     $sp, $sp, 4         # store return address on stack
    sw      $ra, 0($sp)

    sub     $a0, $a0, 2         # n - 2
    jal     fibonacci           # find fib(n - 2)
    add     $a0, $a0, 2         # set n back to original value

    lw      $ra, 0($sp)         # restore return address from stack
    add     $sp, $sp, 4

    lw      $s7, 0($sp)         # pop return value from stack
    add     $sp, $sp, 4

    add     $v0, $v0, $s7       # find f(n - 2) + fib(n - 1)
    jr      $ra                 # decrement/next in stack

zero_case:
    li      $v0, 0              # load 0 into $a0
    jr      $ra                 # return to start

one_case: 
    li      $v0, 1              # load 1 into $a0
    jr      $ra                 # return to start

loop_fibonacci:
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

exit:
	la 		$a0, goodbye	    # load goodbye into $a0
	li 		$v0, 4			    # load string print command into $v0
	syscall					    # runs command

	li		$v0, 10			    # load immediate $v0 to exit program
	syscall					    # system call exit program

# data variables storing text
    .data
Enter:          .asciiz "Enter a non-negative number to find the Fibonnacci Sequence: "
Loop:           .asciiz "\nDo you want to continue[y/n]: "
result:         .asciiz "F_"
result2:        .asciiz " = "
yes:            .asciiz "y"
goodbye:        .asciiz "Goodbye"

string_space:	.space 1024