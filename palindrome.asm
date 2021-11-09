# Collin Stratton
# CST-307
# I/O System Design Tool and MIPS Assembly
# Dr. Citro Ricardo

# This is a program that takes a word from the user
# and determines if the word is a palindrome or not. 

# Registers used:
#   $t0 - the first character address in string S
#   $t1 - the last character address in string S
#   $t2 - the character at address $t0
#   $t3 - the character at address $t1
#   $t4 - used to check if user wants to continue
#   $t5 - used to check if user wants to continue
#   $v0 - syscall parameter
#   $a0 - syscall parameter
#   $a1 - syscall parameter

# How to use: 
# 1. Reinitialize simulator
# 2. Clear Registers
# 3. Load palindrome.asm into QtSPIM
# 4. Run the program
# 5. Enter the word to check in the console
# 6. Type y to continue and n to exit
# 7. Repeat steps 4-7

	.text
# main body of the program to read the string S
main:
	jal 	loop_palindrome		# jump to loop_palindrome function

# function to get a new word to check if palindrome
loop_palindrome:
	la 		$a0, check	# load check into $a0
	li 		$v0, 4		# load string print command into $v0
	syscall				# runs command
	
	la		$a0, string_space	# move the user word into argument $a0
	li		$a1, 1024			# load immediate register $a1 to store length of size 1024 bytes
	li		$v0, 8				# load immediate register $v0 to read the string at $a1
	syscall						# make the system call
	jal		start				# jump to start function

# loads the user entered word
start: 
	la		$t0, string_space	# set $t0 to the first letter (A = S)
	la		$t1, string_space	# set $t1 to the first letter (B = S)
	jal 	find_end_of_word	# jump to the find_end_of_word function

# loop to set $t1 to the last letter of the inputted word
find_end_of_word:
	lb		$t2, ($t1)			# load the byte at $t1 into $t2
	beqz	$t2, end_of_word	# if $t2 == 0, branch out of the loop to end_of_word
	addu	$t1, $t1, 1			# else increment $t1
	b		find_end_of_word	# loop

# when at the end of the loop remove the \0 and \n
end_of_word:
	subu 	$t1, $t1, 2			# move two positions back from the end of the word
	jal 	check_palindrome	# jump to check_palindrome

# check to make sure $t0 and $t1 equal back to middle
check_palindrome:
	bge		$t0, $t1, is_palindrome		# if $t0 >= $t1, palindrome

	lb		$t2, ($t0)					# load $t0 into $t2
	lb		$t3, ($t1)					# load $t1 into $t3
	bne		$t2, $t3, not_palindrome	# if $t2 != $t3, not palindrome

	addu	$t0, $t0, 1					# increment $t0
	subu	$t1, $t1, 1					# decrement $t1

# function to print that a word is a palindrome and exit
is_palindrome:
	la		$a0, msg1	# load message 1 into register $a0
	li		$v0, 4		# load $v0 to print string
	syscall				# make the system call
	b 		repeat		# call repeat function

# function to print that a word is not a palindrome and exit
not_palindrome:
	la		$a0, msg2	# load message 2 into register $a0
	li		$v0, 4		# load $v0 to print string
	syscall				# make the system call
	b 		repeat		# call repeat function

# function to check if the user wants to loop
repeat: 
	la 		$a0, cont				# load continue into $a0
	li 		$v0, 4					# load string print command into $v0
	syscall							# runs command

	la		$a0, string_space		# move the user word into argument $a0
	li		$a1, 1024				# load immediate register $a1 to store length of size 1024 bytes
	li 		$v0, 8					# load string read command into $v0
	syscall							# runs command
	
	la		$t1, string_space			# move the user word into argument $t1
	lb		$t4, ($t1)					# load the first byte into $t4
	lb		$t5, terminal_yes			# load terminal_yes character into $t5
	beq 	$t4, $t5, loop_palindrome	# run loops if $t4 = $t5
	bne 	$t4, $t5, exit				# run exit if $t4 != $t5

# exit the program
exit:
	la 		$a0, goodbye	# load goodbye into $a0
	li 		$v0, 4			# load string print command into $v0
	syscall					# runs command

	li		$v0, 10			# load immediate $v0 to exit program
	syscall					# system call exit program


	.data
# program data storage
check:   		.asciiz "Enter a word you want to check: "
cont:    		.asciiz "Would you like to continue[y/n]: "
terminal_yes:	.asciiz "y"
goodbye:		.asciiz "Goodbye"

string_space:	.space 1024
msg1:			.asciiz "Is a Palindrome\n"
msg2:			.asciiz "Not a Palindrome\n"
