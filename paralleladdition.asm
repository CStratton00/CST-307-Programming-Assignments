# Collin Stratton
# CST-307
# Parallel Addition
# Dr. Citro Ricardo

# This program sums two arrays into a third array

    .text
main:
    addi    $t0, $zero, 0       # sets $t0 to 0
    li      $s0, 0              # load immediate 0 into $s0

    li      $v0, 4              # load immediate print message in $v0
    la      $a0, proc1          # load proc 1 into $a0
    syscall                     # syscall to print message

    li      $t0, 0              # load immediate $t0 into 0
  
loop:
    lw      $t1, arrA($t0)      # load word arrA at position $t0 to $t1
    lw      $t2, arrB($t0)      # load word arrB at position $t0 to $t2

    li      $v0, 4              # load immediate print message in $v0
    la      $a0, proc2          # load proc 2 into $a0
    syscall                     # syscall to print message

    add     $s0, $t1, $t2       # add the values of $t1 and $t2 to $s0
    sw      $s0, arrC($t0)      # save $s0 to arrC
    
    li      $v0, 4              # load immediate print message in $v0
    la      $a0, proc3          # load proc 3 into $a0
    syscall                     # syscall to print message

    beq     $t0, 36, printMsg   # check if t0 is 4 then printMsg
    add     $t0, $t0, 4         # add 4 for next index of array
    
    j       loop                # jump to loop

printMsg:  
    li      $v0, 4              # load immediate print message in $v0
    la      $a0, msg            # load message into $a0
    syscall                     # syscall to print message

    li      $t0, 0              # load immediate $t0 into 0

printArray:
    lw      $t1, arrC($t0)      # load word from arrC at position $t0 into $t1
    li      $v0, 1              # load print int into $v0
    move    $a0, $t1            # move the value from $t0 into $a0
    syscall                     # print the value

    li      $v0, 4              # load immediate print message in $v0
    la      $a0, space          # load space into $a0
    syscall                     # syscall to print message
    
    beq     $t0, 36, exitProg   # check if t0 is 8 then exit program
    add     $t0, $t0, 4         # add 4 for next index of array
    j       printArray          # jump to printArray

exitProg:
	la 		$a0, goodbye	    # load goodbye into $a0
	li 		$v0, 4			    # load string print command into $v0
	syscall					    # runs command

	li		$v0, 10			    # load immediate $v0 to exit program
	syscall					    # system call exit program

    .data
# declare array
arrA:       .word 2, 3, 4, 3, 5, 6, 7, 6, 5, 1
arrB:       .word 4, 2, 7, 23, 8, 2, 45, 1, 9, 6
arrC:       .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

proc1:      .asciiz "Starting program\nInitializing array A with processor 1\nInitializing array B with processor 2\n\n"
proc2:      .asciiz "processor 3: summing array values...\n\n"
proc3:      .asciiz "processor 4: inserting value into array C...\n\n"
msg:        .asciiz "The sum of arrA and arrB is: "
space:      .asciiz " "
goodbye:    .asciiz "\nGoodbye"