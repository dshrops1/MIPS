#Author : Dustin Shropshire
# Guessing game

	.data

numToGuess: .word 6
pleaseGuess: .asciiz "please guess a number\n"
rightOn: .asciiz  "good guess\n"
toHigh: .asciiz  "too high\n"
toLow: .asciiz "to low\n"
congrats: .asciiz "you got it right\n"
allWrong: .asciiz "you had your five guesses\n"

	.text 
	
		#let user enter a number 
		#pass that to a procesdure that prints
		#one of the following messages
		# if it = numToGuess "good guess"
		#if <numToGuess "to low"
		#if >numToGuess "too high"
		#and returns 1 for "good guess" 
		#and 0 for other options
		#allow no more than 5 guesses
		#if number is guessed before 5 exit
		#after 5 print "you had your five guesses and exit
		
	#to be used as a count
	li $s1, 0
main:	#will return here 5 times unless user gets right
	
	
	add $s1, $s1, 1 # counter incremented by 1
	beq $s1, 6, endWrong #exit if user has had 5 guesses
	
	#prints please guess a number	
	li $a0, 0
	la $a0, pleaseGuess
	li $v0, 4
	syscall
	
	#reads in the users guess and stores it in s0
	li $a0, 0
	li $v0, 5
	syscall
	li $s0, 0
	add $s0 , $zero, $v0
	
	#storing the guess in an arugment variable for procedure 
	li $a1, 0
	add $a1, $s0, $zero
	
	#jump and link the return address in $ra
	jal evaluateGuess #return value in $v1
	
	#based of return value from procedure 1 = congradulate and exit
	#else return to main 
	
	beq $v1, 1, endRight #go here if guessed right
	
	#else we jump back to top
	j main

#this is where we will print the responce to users guess and return 1 or 0
evaluateGuess:	

	li $t0, 0
	lw $t0, numToGuess #temp storage to compare 
	
	bne $t0, $a1, toLow1 #branches if user dident guess correctly
	
	#in here put code for "good guess and then return jump as well as return 1
	#return value placed in $v0
	li $a0, 0
	la $a0, rightOn
	li $v0, 4
	syscall
	
	li $v1 , 1 #return value
	jr $ra #return address
	
toLow1: 
	
	bgt $a1, $t0, toHigh1 #branches if user guess is greater than actual num
	
		
	#code for to low and jump return as well as return 0	
	#return value placed in $v1
	
	li $a0, 0
	la $a0, toLow
	li $v0, 4
	syscall
	
	li $v1, 0 #return value
	jr $ra #return address
	 
toHigh1: #code for "to high" as well as return 0	 placed in $v1

	li $a0, 0
	la $a0, toHigh
	li $v0, 4
	syscall 
	
	li $v1, 0 #return value
	jr $ra #return address
	
endRight: #print congrats and them jump to exit

	li $a0, 0
	la $a0, congrats
	li $v0, 4
	syscall
	
	j exit
	
endWrong: #print had 5 guesses and then exit

	li $a0, 0
	la $a0, allWrong
	li $v0, 4
	syscall
	
	j exit
	  
exit: #where to go at end of program	   
	 
	  