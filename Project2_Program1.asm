# This is a program that computes and prints the sum
# of two numbers specified at runtime by the user.
# Registers used:
#   n1  - used to hold the first user number
#   n2  - used to hold the second user number
#   result - used to display the summed numbers
#   $t0 - used to hold the first number.
#   $t1 - used to hold the second number.
#   $t2 - used to hold the sum of $t1 and $t2.
#   $v0 - syscall parameter.
#   $a0 - syscall parameter.

.text
# main body of code to sum program
main:
    # get first input
    la $a0, n1      # move the user value into argument $a0
    li $v0, 4       # load immediate register $v0 to print $a0
    syscall         # print $a0
    li $v0, 5       # load immediate register $v0 to read integer in $a0
    syscall         # load integer from console
    move $t0, $v0   # move integer from $v0 to $t0

    # get second input
    la $a0, n2      # move the user value into argument $a0
    li $v0, 4       # load immediate register $v0 to print $a0
    syscall         # print $a0
    li $v0, 5       # load immediate register $v0 to read integer in $a0
    syscall         # load integer from console
    move $t1, $v0   # move integer from $v0 to $t0

    # calculate and print out the result
    la $a0, result      # load the result into $a0
    li $v0, 4           # load immediate register $v0 to print $a0
    syscall             # print $a0
    add $t2, $t0, $t1   # sum $t1 and $t0 and load the value into $t2
    move $a0, $t2       # move the value of $t2 into $a0
    li $v0, 1           # load immediate register $v0 to print int in $a0
    syscall             # print $a0

    # end program
    li $v0, 10      # load immediate $v0 to exit program
    syscall         # exit program

# values to grab from the user
.data
    n1: .asciiz "First number: "
    n2: .asciiz "Second number: "
    result: .asciiz "Sum: "
