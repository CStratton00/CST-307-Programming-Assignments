# This is a program that prints the larger of two
# numbers specified at runtime by the user.
# Registers used:
#   n1  - used to hold the first user number
#   n2  - used to hold the second user number
#   result - used to display the larger number
#   $t0 - used to hold the first number.
#   $t1 - used to hold the second number.
#   $t2 - used to hold the sum of $t1 and $t2.
#   $v0 - syscall parameter.
#   $a0 - syscall parameter.

.text
# main body of code to compare two values
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

  # compare the two values
  slt $t2, $t1, $t0           # sets $t2 to 1 if $t1 < $t0
  bne $t2, $zero, print_num   # if $t2 is 0 run print_num else keep going
  move $t0, $t1               # set $t0 equal to $t1

  print_num:          # function to print value if $t1 > $t0
    la $a0, result    # load the result into $a0
    li $v0, 4         # load immediate register $v0 to print $a0
    syscall           # print $a0

  move $a0, $t0   # move the value of $t0 into $a0
  li $v0, 1       # load immediate register $v0 to print int in $a0
  syscall         # print $a0

  # end program
  li $v0, 10      # load immediate $v0 to exit program
  syscall         # exit program

# values to grab from the user
.data
  n1: .asciiz "First number: "
  n2: .asciiz "Second number: "
  result: .asciiz "The larger integer number is: "
