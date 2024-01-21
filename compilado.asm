
.data

andyhola: .word 0
dmain: .word 0

returnInt: .word 0
returnFloat: .float 0.0
returnChar: .byte 0
saltoLinea: .asciiz "\n"
.text

hola:
#3
li $t0, 3
sw $t0, andyhola
li $t0, 0
lw $v0, andyhola
sw $v0, returnInt
jr $ra
main:
add $t0, $t0, 3
add $t0, $t0, 7
#7 + 3 + 2
sw $t0, dmain
li $t0, 0
jal hola
j end_program

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
