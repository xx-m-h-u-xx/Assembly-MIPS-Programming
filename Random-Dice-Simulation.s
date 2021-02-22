#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Random Dice-Simulation Program
# it will randomly generate 8 dice, numbers of between 0 and 6 from a single throw
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.data
 #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 # This is the data segment 
 # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
    lineSeparator:       .asciiz " | "
    messageResult:       .asciiz "\n>>>> Total result of this dice throw is: "

.text
 #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     # This is the body of the program 
 #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  main:
  
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # Generates 8 random integers in the range 0-9 from the dice
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    li	$t0, 8		  # maximum iterations 1
    li	$t1, 0		  # setting initial iteration number
    li  $s0, 0      # declaring $s0 as a saved total throw result register
  
	  loop:
      li	$v0, 42		  # randint-range syscall
      li  $a0, 0      # setting 0 at start of argument
      li	$a1, 7	   	# upper bound of the randint (dice's highest number +1)
     syscall
      
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # Branches to the "loop" statement if $a0 is equal to zero (dice do not have this)
    # then it increments the number of iterations on $t1 - that's acting as an counter 
    # then adds randomly generated numbers in $a0 with saved value in $s0, where it gets stored in $s0
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    beqz  $a0, loop
    addi	$t1, $t1, 1	          # increment the number of iterations
    add   $s0, $s0, $a0     	  # stores & adds on generated number each time in $s0

     
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #~ Prints out random number saved in $a0
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    li $v0, 1		# print-integer-syscall
    syscall

    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #~ Prints a line separator between the numbers
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    li $v0, 4          		# print-string callcode 
    la $a0, lineSeparator     	# loads address of string variable
    syscall

    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #~ Program checks if current counter($t1) = maximum iterations ($t0) --> goes to subroutine labelled "next"
    #~ Repeats iteration, jumps to statement specified as "loop"
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    beq $t1, $t0, next	  # branch proceeds to "next" subroutine if iterations is 10
    j loop			          # jumps to caller “loop”


    next:

    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #~ Prints a message using print-string-service-4
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    li $v0, 4
    la $a0, messageResult
    syscall

    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #~ Prints the totalled sum of dice-throw in-line with the message shown
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    li $v0, 1
    la $a0, ($s0)
    syscall

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~ Instructs  system to exit the program
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
exit:
li $v0, 10		
syscall
