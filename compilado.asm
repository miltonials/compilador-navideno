
.data

arrmain: .space 12
dmain: .word 0

saltoLinea: .asciiz "\n"
.text

main:
la $t0, arrmain
li $t1, 5
sw $t1, 0($t0)
li $t2, 3
sw $t2, 4($t0)
li $t3, 4
sw $t3, 8($t0)

# mostrar los valores del arreglo
li $t0, 0
la $t1, arrmain
lw $t2, 0($t1)
li $v0, 1
move $a0, $t2
syscall
li $v0, 4
la $a0, saltoLinea
syscall

li $t0, 1
la $t1, arrmain
lw $t2, 4($t1)
li $v0, 1
move $a0, $t2
syscall
li $v0, 4
la $a0, saltoLinea
syscall

li $t0, 2
la $t1, arrmain
lw $t2, 8($t1)
li $v0, 1
move $a0, $t2
syscall
li $v0, 4
la $a0, saltoLinea
syscall

#0
sw $t0, dmain
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
