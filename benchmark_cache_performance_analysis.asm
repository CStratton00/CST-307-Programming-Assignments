# Author: William B Hurst
# Extra Commentary: Collin Stratton
# Creation date: 2019Sep18
# Updated date: 2021May16
#
# this is a simple program that demonstrates
# how a computer system that utilizes 4-Byte Words
# can have significantly different Performance
# characteristics based on whether it uses
# Main Memory and Cache Data Transfer configurations of:
#
# 1) One Block Word
# 2) Four Block Words
# 3) Non-Burst
# 4) Burst
#
# from a computer system that utilizes:
#
# *)  4 byte words
#-------------------------------------------------
# the system has the following characteristics
#-------------------------------------------------
#        Observed Miss Penalty Rates of
#-------------------------------------------------
# *)  1 Clock Cycle to Read from Main Memory
# *)  3 clock Cycles to transfer the 4 blocks of data
#-------------------------------------------------
#
# The program asks the user to input:
#
# *) One  word block miss penalty rate
# *) Four word block miss penalty rate
#
#-------------------------------------------------
# the data will be stored as follows in the program:
#
# 	$t0 - used to hold the first number
# 	$t1 - used to hold the second number
# 	$t2 - used to hold multiplication of $t0 * $t1
#-------------------------------------------------

	.text
	.globl	main
main: # main block of code that moves and defines values and registers

	# fist block of code prints to the console information for the user
	# the text is determined at the bottom of the file, loaded, and displayed
	#----------------------------------------------------------------------
	li	$v0, 4										# print string
	la	$a0, programDesc					# load address for 'The Program Description'
	syscall												# execute command
	li	$v0, 4										# print string
	la	$a0, oWMissRateReq				# load address "One-Word-Penalty-Miss-Rate"
	syscall												# execute command
	li	$v0, 6										# float one-Word-Miss-Penalty-Rate
	syscall												# execute command

	s.s	$f0, oWordMissRate				# store $f0 ==> one-Word-Miss-Penalty-Rate

	li	$v0, 4										# print string
	la	$a0, fWMissRateReq				# load address of 4-Word Miss Rate Request
	syscall												# execute command
	li	$v0, 6										# float four-Word-Miss-Penalty-Rate
	syscall												# execute command

 	s.s	$f0, fWordMissRate	# store $f0 ==> four-Word-Miss-Penalty-Rate

	# perform the intended operation - multiply
	# Miss_Penalty_ave = (Miss_Penalty_rate)(Miss_Penalty_Cycles)
	#----------------------------------------------------------------------

	# One Word Miss Penalty Calculations
	# this block of code determines the one word miss penalty calculation by
	# multiplying the miss rate by the miss cycle time
	# this value is then outputted in the console

	#----------------------------------------------------------------------
	l.s	$f0, oWordMissRate				# load $f0 <== one-word-miss-penalty-rate
	l.s	$f1, oWordMissCTime				# load $f1 <== one-word-miss-penalty-cycle-time
	mul.s	$f2, $f0, $f1						# mul: $f2 = $f0 * $f1
	s.s	$f2, oWordMissAve					# stor $f2 ==> one-word-miss-penalty-average

 	li	$v0, 4										# print string
	la	$a0, oWordMissCalcOut			# one-Word-Miss-Penalty-Calculations Header
	syscall												# execute command
 	li	$v0, 4										# print string
	la	$a0, oWordMissRateOut			# "one-Word-miss-penalty-rate-out
	syscall												# execute command
 	li	$v0, 2										# print float
	l.s	$f12, oWordMissRate				# one-Word-miss-penalty-rate
	syscall												# execute command
	li	$v0, 4										# print string
	la	$a0, oWordMissCTimeOut		# one-Word-miss-penalty-Cycle-Time-Out
	syscall												# execute command
 	li	$v0, 2										# print float
	l.s	$f12, oWordMissCTime			# one-Word-miss-penalty-Cycle-Time
	syscall												# execute command
	li	$v0, 4										# print string
	la	$a0, oWordMissAveOut			# one-Word-miss-penalty-Average-Out
	syscall												# execute command
 	li	$v0, 2										# print float
	l.s	$f12, oWordMissAve				# one-Word-miss-penalty-average
	syscall												# execute command
	#----------------------------------------------------------------------

	# Four Word (Non-Burst) Miss Penalty Calculations
	# this block of code determines the four word miss penalty calculation by
	# multiplying the miss rate by the miss cycle time
	# this value is then outputted in the console

	#----------------------------------------------------------------------
	l.s	$f0, fWordMissRate				# load $f0 <== four-Word-miss-penalty-rate
	l.s	$f1, nbfWordMissCTime			# load $f1 <== four-Word-(Non-Burst)-miss-penalty-cycle-time
	mul.s	$f2, $f0, $f1						# mul: $f2 = $f0 * $f1
	s.s	$f2, nbfWordMissAve				# stor $f2 ==> four-Word-(Non-Burst)-miss-penalty-average

 	li	$v0, 4										# print string
	la	$a0, nbfWordMissCalcOut		# four-Word-(Non-Burst)-Miss-Calculations Header
	syscall												# execute command
 	li	$v0, 4										# print string
	la	$a0, nbfWordMissRateOut		# "four-Word-(Non-Burst)-miss-penalty-rate-Out
	syscall												# execute command
 	li	$v0, 2										# print float
	l.s	$f12, fWordMissRate				# four-Word-miss-penalty-rate
	syscall												# execute command
	li	$v0, 4										# print string
	la	$a0, nbfWordMissCTimeOut  # four-Word-(Non-Burst)-miss-penalty-Cycle-Time-Out
	syscall												# execute command
 	li	$v0, 2										# print float
	l.s	$f12, nbfWordMissCTime		# four-Word-(Non-Burst)-miss-penalty-Cycle-Time
	syscall												# execute command
	li	$v0, 4										# print string
	la	$a0, nbfWordMissAveOut		# four-Word-(Non-Burst)-Miss-Average-Out
	syscall												# execute command
 	li	$v0, 2										# print float
	l.s	$f12, nbfWordMissAve			# four-Word-(Non-Burst)-Miss-Penalty-Average
	syscall												# execute command
	#----------------------------------------------------------------------

	# Four Word (Burst) Miss Penalty Calculations
	# this block of code determines the four word miss penalty calculation for
	# burst by multiplying the miss rate by the miss cycle time
	# this value is then outputted in the console

	#----------------------------------------------------------------------
	l.s	$f0, fWordMissRate				# load $f0 <== four-Word-miss-penalty-rate
	l.s	$f1, bfWordMissCTime			# load $f1 <== four-Word-(Burst)-miss-penalty-cycle-time
	mul.s	$f2, $f0, $f1						# mul: $f2 = $f0 * $f1
	s.s	$f2, bfWordMissAve				# stor $f2 ==> four-Word-(Burst)-miss-penalty-average

 	li	$v0, 4										# command: print string
	la	$a0, bfWordMissCalcOut		# four-Word-(Burst)-Miss-Calculations Header
	syscall												# execute command
 	li	$v0, 4										# command: print string
	la	$a0, bfWordMissRateOut		# "four-Word-(Burst)-miss-penalty-rate-Out
	syscall												# execute command
 	li	$v0, 2										# command: print float
	l.s	$f12, fWordMissRate				# four-Word-miss-penalty-rate
	syscall												# execute command
	li	$v0, 4										# command: print string
	la	$a0, bfWordMissCTimeOut  	# four-Word-(Burst)-miss-penalty-Cycle-Time-Out
	syscall												# execute command
 	li	$v0, 2										# command: print float
	l.s	$f12, bfWordMissCTime			# four-Word-(Burst)-miss-penalty-Cycle-Time
	syscall												# execute command
	li	$v0, 4										# command: print string
	la	$a0, bfWordMissAveOut			# four-Word-(Burst)-Miss-Average-Out
	syscall												# execute command
 	li	$v0, 2										# command: print float
	l.s	$f12, bfWordMissAve				# four-Word-(Burst)-Miss-Penalty-Average
	syscall												# execute command
	li	$v0, 4										# command: print string
	la	$a0, theEnd								# load address of string "theEnd" into $a0
	syscall												# execute command
	li	$v0, 10										# command: terminate program
	syscall												# execute command
	#----------------------------------------------------------------------

	.data
# this block of code is the extra variables used throughout the program
#-----------------------------------
oWordMissRate:		.float	0.0
oWordMissCTime:		.float	5.0
oWordMissAve:		.float	0.0

fWordMissRate:		.float	0.0

nbfWordMissCTime:	.float	20.0
nbfWordMissAve:		.float	0.0

bfWordMissCTime:		.float	8.0
bfWordMissAve:		.float	0.0
#-----------------------------------------------------------------------------

# programDesc displays text to the console for the user
programDesc:		.asciiz "This program is designed to demonstrate
	\n'Benchmark Cache Performance Impacts' through the 'Cache Miss Penalty Variances'
	\nthat are found from:
	\n\t'different System Block Sizes' and from:
	\n\t'different Data Tranfer Policies.
	\n\nThe Different Block sizes compared here are:
	\n\t'(1 Word Block) vs. (4 Word Block)'.
	\n\nAnd the different I/O Policies compared here are:
	\n\t'(NonBurst) vs (Burst)' Data Transfer.
	\nPlease provide the Two Primary Data Factors;
	\nThose factors are:"
oWMissRateReq:	.asciiz	"\nPlease enter a (1-Word Block) Percent Miss Penalty Rate:\t  "
fWMissRateReq:	.asciiz	"\nPlease enter a (4-Word Block) Percent Miss Penalty Rate:\t  "
	#-----------------------------------------------------------------------------
oWordMissCalcOut: .asciiz "\n\n
	=============================================================================================\n
	\t        One Word Block Miss Penalty Calculation Results\n
	=============================================================================================\n"
	#-----------------------------------------------------------------------------
	oWordMissRateOut:	.asciiz	"\nUsing a One-Word Block Percent Miss Penalty Rate of: \t\t\t"
	oWordMissCTimeOut:	.asciiz "\nthe (One-Word Block) Miss Penalty Cycle Time is: \t\t\t\t"
	oWordMissAveOut:	.asciiz "\nMaking your One-Word Block Miss Penalty Average: \t\t\t\t"
	#-----------------------------------------------------------------------------
	nbfWordMissCalcOut: .asciiz "\n\n
	=============================================================================================\n
	\t        Four Word Block (Non-Burst) Miss Penalty Calculation Results\n
	=============================================================================================\n"
	#-----------------------------------------------------------------------------
	nbfWordMissRateOut:	.asciiz	"\nUsing a Four-Word Block (Non-Burst) Percent Miss Penalty Rate of: \t\t"
	nbfWordMissCTimeOut:	.asciiz "\nthe Four-Word Block (Non-Burst) Miss Penalty Cycle Time is: \t\t"
	nbfWordMissAveOut:	.asciiz "\nMaking your Four-Word Block (Non-Burst) Miss Penalty Average: \t\t"
	#-----------------------------------------------------------------------------
	bfWordMissCalcOut: .asciiz "\n\n
	============================================================================================\n
	\t        Four Word Block (Burst) Miss Penalty Calculation Results\n
	============================================================================================\n"
	#-----------------------------------------------------------------------------
	bfWordMissRateOut:	.asciiz	"\nUsing a Four-Word Block (Burst) Percent Miss Penalty Rate of: \t\t"
	bfWordMissCTimeOut:	.asciiz "\nthe Four-Word Block (Burst) Miss Penalty Cycle Time is: \t\t\t"
	bfWordMissAveOut:	.asciiz "\nMaking your Four-Word Block (Burst) Miss Penalty Average: \t\t\t"
	#-----------------------------------------------------------------------------
	#-----------------------------------------------------------------------------
cflf:   .asciiz	"\n"
theEnd: .asciiz "\n\n
===========================================================================================\n
\t\t\t<<<<<<< The End >>>>>>>\n
===========================================================================================\n"
