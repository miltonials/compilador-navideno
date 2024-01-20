
.data


temp1main: .word 0
temp2main: .word 0
temp3main: .word 0
temp4main: .word 0
temp5main: .word 0
temp6main: .word 0
temp7main: .word 0
temp8main: .word 0

salto: .asciiz "\n"

.text

main:
add $t0, $t0, 6
add $t0, $t0, 5
add $t0, $t0, -4
add $t0, $t0, 3
add $t0, $t0, 2
add $t0, $t0, 1
#1 + 2 + 3 + -4 + 5 + 6
sw $t0, temp1main
lw $a0, temp1main
li $v0, 1
syscall
li $t0, 0
add $t0, $t0, 5
add $t0, $t0, 5
mul $t0, $t0, -1
add $t0, $t0, 5
add $t0, $t0, 5
mul $t0, $t0, -1
add $t0, $t0, 5
add $t0, $t0, 5


addi		$v0, $0, 4		# system call #4 - print string
la		$a0, salto
syscall						# execute


sw $t0, temp2main
lw $a0, temp2main
li $v0, 1
syscall
li $t0, 0
add $t1, $t1, 5
add $t1, $t1, 5
add $t1, $t1, 5
add $t1, $t1, 5
add $t1, $t1, 5
add $t1, $t1, 5
#finParentesis
add $t0, $t0, $t1
li $t1, 0


addi		$v0, $0, 4		# system call #4 - print string
la		$a0, salto
syscall						# execute


sw $t0, temp3main
lw $a0, temp3main
li $v0, 1
syscall
li $t0, 0
add $t1, $t1, 5
add $t1, $t1, 5
add $t0, $t0, 5
add $t0, $t0, 5
add $t0, $t0, 5
add $t0, $t0, $t1
li $t1, 0


addi		$v0, $0, 4		# system call #4 - print string
la		$a0, salto
syscall						# execute


sw $t0, temp4main
lw $a0, temp4main
li $v0, 1
syscall
li $t0, 0
add $t1, $t1, 5
add $t1, $t1, 10
add $t0, $t0, 3
add $t0, $t0, 2
add $t0, $t0, 1
add $t0, $t0, 4
mul $t1, $t1, -1
add $t0, $t0, 0
add $t0, $t0, $t1
li $t1, 0


addi		$v0, $0, 4		# system call #4 - print string
la		$a0, salto
syscall						# execute


sw $t0, temp5main
lw $a0, temp5main
li $v0, 1
syscall
li $t0, 0
add $t1, $t1, 3
add $t1, $t1, 2
add $t1, $t1, 1
add $t1, $t1, 4
add $t1, $t1, 5
add $t1, $t1, 10
mul $t1, $t1, -1
add $t1, $t1, 0
#finParentesis
add $t0, $t0, $t1
li $t1, 0


addi		$v0, $0, 4		# system call #4 - print string
la		$a0, salto
syscall						# execute


sw $t0, temp6main
lw $a0, temp6main
li $v0, 1
syscall
li $t0, 0
add $t1, $t1, 1
add $t1, $t1, 2
add $t0, $t0, 8
add $t0, $t0, 7
add $t0, $t0, 5
add $t0, $t0, 1
add $t0, $t0, $t1
li $t1, 0


addi		$v0, $0, 4		# system call #4 - print string
la		$a0, salto
syscall						# execute


sw $t0, temp7main
lw $a0, temp7main
li $v0, 1
syscall
li $t0, 0
add $t4, $t4, 5
add $t4, $t4, 5
add $t4, $t4, 5
#finParentesis
add $t3, $t3, 10
#finParentesis
mul $t3, $t3, -1
add $t2, $t2, 2
add $t1, $t1, 5
add $t1, $t1, 5
mul $t2, $t2, -1
add $t1, $t1, 1
#finParentesis
add $t3, $t3, $t4
li $t4, 0
add $t2, $t2, $t3
li $t3, 0
add $t1, $t1, $t2
li $t2, 0
add $t0, $t0, $t1
li $t1, 0


addi		$v0, $0, 4		# system call #4 - print string
la		$a0, salto
syscall						# execute


sw $t0, temp8main
lw $a0, temp8main
li $v0, 1
syscall
li $t0, 0

j end_program


#SYSCALL MIPS
printStr:
    li $v0, 4
    syscall
    jr $ra
.end printStr

readStr:
    li $v0, 8
    syscall
    jr $ra
.end readStr

printInt:
    li $v0, 1
    syscall
    jr $ra
.end printInt

readInt:
    li $v0, 5
    syscall
    jr $ra #jr es jump register, salta a la dirección que está en $ra y $ra es el registro de activación
.end readInt

printFloat:
    li $v0, 2
    syscall
    jr $ra
.end printFloat

readFloat:
    li $v0, 6
    syscall
    jr $ra
.end readFloat

printChar:
    li $v0, 11
    syscall
    jr $ra
.end printChar

readChar:
    li $v0, 12
    syscall
    jr $ra
.end readChar

printBool:
    li $v0, 1
    syscall
    jr $ra
.end printBool

readBool:
    li $v0, 5
    syscall
    jr $ra
.end readBool

end_program:
    li $v0, 10
    syscall
.end end_program
