#CS231258 SHAFAY MEHMOOD
#CS221027 MUSTAFA MURTAZA
#CS231156 MUHAMMAD ATEEB UR REHMAN
#CS231143 MUHAMMAD ABUZAR TARIQ
.data
# Strings and prompts for user interface
welcomePrompt: .asciiz "\nWelcome to the Typing Master Game.\n"
chooseDifficulty: .asciiz "Choose any difficulty level to Start:\n"
difficultyLevels: .asciiz "0. Start again\n1. Easy mode\n2. Hard mode\n3. Exit\n"
invalidPrompt: .asciiz "Invalid Prompt!!!\n\n"
easyPrompt: .asciiz "You have entered the easy mode.\n\n"
hardPrompt: .asciiz "You have entered the hard mode.\n\n"
stringPrompt: .asciiz "Write the below string:\n\n"
retryPrompt: .asciiz "\nEnter 1 to try again or 0 to exit: "
wrongInputPrompt: .asciiz "Your input was incorrect!\n\n"

# Memory buffers and variables
userInput: .space 500  # User input ke liye buffer
selectedString: .word 0  # Randomly chosen string ka address
stringLength: .word 0  # String ki length
typedCharacters: .word 0  # User ke typed characters count

# Strings for easy mode
easyString1: .asciiz "The fox jumps over lazy dog.\n"
easyString2: .asciiz "Typing is fun and easy.\n"
easyString3: .asciiz "They don't know me son!\n"
easyString4: .asciiz "Learning new skills is great.\n"
easyString5: .asciiz "Keep calm and code on.\n"
easyStringArray: .word easyString1, easyString2, easyString3, easyString4, easyString5

# Strings for hard mode
hardString1: .asciiz "Success is not final, failure is not fatal: It is the courage to continue that counts.\n"
hardString2: .asciiz "In the end, we will remember not the words of our enemies, but the silence of our friends.\n"
hardString3: .asciiz "Good things come to those who wait, but better things come to those who work for it.\n"
hardString4: .asciiz "The only limit to our realization of tomorrow is our doubts of today.\n"
hardString5: .asciiz "Understanding is deeper than knowledge. There are many who know but few who understand.\n"
hardStringArray: .word hardString1, hardString2, hardString3, hardString4, hardString5

# Result strings
endMsg: .asciiz "\nCalculating your typing speed...\n"
completedTime: .asciiz "\nYou completed it in (seconds): "
resultCharacters: .asciiz "\nYou typed (Characters count): "
resultMsg: .asciiz "\nYour typing speed is (Characters Per Second): "
errorMsg: .asciiz "\nElapsed time is too small! Try again.\n\n"

.text
.globl main

main:
    jal Welcome  # Game start karte hain
    li $v0, 10  # Exit syscall
    syscall

Welcome:
    # Welcome message aur difficulty options show karo
    la $a0, welcomePrompt
    li $v0, 4
    syscall

    la $a0, chooseDifficulty
    li $v0, 4
    syscall

    la $a0, difficultyLevels
    li $v0, 4
    syscall

    # User ka difficulty level read karo
    li $v0, 5
    syscall
    move $t0, $v0  # Input save in $t0

    # User choice ke basis pe jump karo
    beq $t0, 3, exitGame  # Exit
    beq $t0, 0, Welcome   # Restart
    beq $t0, 1, callEasy  # Easy mode
    beq $t0, 2, callHard  # Hard mode
    bne $t0, 0, invalidChoice  # Invalid choice

callEasy:
    jal easyLevel
    j Welcome

callHard:
    jal hardLevel
    j Welcome

invalidChoice:
    # Invalid input ka message show karo
    la $a0, invalidPrompt
    li $v0, 4
    syscall
    j Welcome

exitGame:
    jr $ra  # Return from the program

# Function: Easy Level
easyLevel:
    # Easy mode ka welcome message
    la $a0, easyPrompt
    li $v0, 4
    syscall
retryEasy:
    # Random string select karo
    li $a1, 5
    li $v0, 42
    syscall
    move $t2, $a0

    la $t3, easyStringArray
    sll $t2, $t2, 2
    add $t3, $t3, $t2
    lw $t4, 0($t3)
    sw $t4, selectedString

    # Display selected string
    move $a0, $t4
    li $v0, 4
    syscall

    # Start time capture karo
    li $v0, 30
    syscall
    move $t1, $a0

    # User se string type karne ko bolo
    la $a0, stringPrompt
    li $v0, 4
    syscall

    la $a0, userInput
    li $a1, 500
    li $v0, 8
    syscall

    # User input ko compare karo
    la $t5, userInput
    lw $t6, selectedString
    li $t7, 0
compare_easy:
    lb $t8, 0($t5)
    lb $t9, 0($t6)
    bne $t8, $t9, incorrect_easy
    beqz $t8, correct_easy
    addi $t5, $t5, 1
    addi $t6, $t6, 1
    addi $t7, $t7, 1
    j compare_easy

incorrect_easy:
    # Wrong input ka message dikhayein
    la $a0, wrongInputPrompt
    li $v0, 4
    syscall

    la $a0, retryPrompt
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    beq $v0, 1, retryEasy
    j Welcome

correct_easy:
    # End time capture karen aur speed calculate karein
    li $v0, 30
    syscall
    move $t2, $a0

    sub $t2, $t2, $t1
    li $t3, 1000
    div $t2, $t3
    mflo $t2

    blt $t2, 1, time_too_small_easy

    # Result show karein
    la $a0, completedTime
    li $v0, 4
    syscall
    move $a0, $t2
    li $v0, 1
    syscall

    la $a0, resultCharacters
    li $v0, 4
    syscall
    move $a0, $t7
    li $v0, 1
    syscall

    div $t7, $t7, $t2
    mflo $t8

    la $a0, resultMsg
    li $v0, 4
    syscall
    move $a0, $t8
    li $v0, 1
    syscall

    j Welcome

time_too_small_easy:
    # Agar time chhota hai, to error show karein
    la $a0, errorMsg
    li $v0, 4
    syscall
    j retryEasy

# Function: Hard Level
hardLevel:
    # Hard mode ka welcome message
    la $a0, hardPrompt
    li $v0, 4
    syscall
retryHard:
    # Random string select karo
    li $a1, 5
    li $v0, 42
    syscall
    move $t2, $a0

    la $t3, hardStringArray
    sll $t2, $t2, 2
    add $t3, $t3, $t2
    lw $t4, 0($t3)
    sw $t4, selectedString

    # Display selected string
    move $a0, $t4
    li $v0, 4
    syscall

    # Start time capture karo
    li $v0, 30
    syscall
    move $t1, $a0

    # User se string type karne ko bolo
    la $a0, stringPrompt
    li $v0, 4
    syscall

    la $a0, userInput
    li $a1, 500
    li $v0, 8
    syscall

    # User input ko compare karo
    la $t5, userInput
    lw $t6, selectedString
    li $t7, 0
compare_hard:
    lb $t8, 0($t5)
    lb $t9, 0($t6)
    bne $t8, $t9, incorrect_hard
    beqz $t8, correct_hard
    addi $t5, $t5, 1
    addi $t6, $t6, 1
    addi $t7, $t7, 1
    j compare_hard

incorrect_hard:
    # Wrong input ka message dikhayein
    la $a0, wrongInputPrompt
    li $v0, 4
    syscall

    la $a0, retryPrompt
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    beq $v0, 1, retryHard
    j Welcome

correct_hard:
    # End time capture karen aur speed calculate karein
    li $v0, 30
    syscall
    move $t2, $a0

    sub $t2, $t2, $t1
    li $t3, 1000
    div $t2, $t3
    mflo $t2

    blt $t2, 1, time_too_small_hard

    # Result show karein
    la $a0, completedTime
    li $v0, 4
    syscall
    move $a0, $t2
    li $v0, 1
    syscall

    la $a0, resultCharacters
    li $v0, 4
    syscall
    move $a0, $t7
    li $v0, 1
    syscall

    div $t7, $t7, $t2
    mflo $t8

    la $a0, resultMsg
    li $v0, 4
    syscall
    move $a0, $t8
    li $v0, 1
    syscall

    j Welcome

time_too_small_hard:
    # Agar time chhota hai, to error show karein
    la $a0, errorMsg
    li $v0, 4
    syscall
    j retryHard
