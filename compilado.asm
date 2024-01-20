
.data

saltoLinea: .asciiz "\n"
temp1main: .word 0
print0: .asciiz "hola"
print3: .word 1 - ( 2 - ( 10 + ( 5 + 5 + 5 ) ) ) + 5 + 5
print4: .word 5 / 5
print5: .asciiz "Soy un string"

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
li $t0, 0
la $a0, print0
jal printStr
la $a0, saltoLinea
jal printStr
lw $a0, temp1main
jal printInt
la $a0, saltoLinea
jal printStr
#finParentesis
#finParentesis
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
lw $a0, print3
jal printInt
la $a0, saltoLinea
jal printStr
lw $a0, print4
jal printInt
la $a0, saltoLinea
jal printStr
la $a0, print5
jal printStr
la $a0, saltoLinea
jal printStr

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
