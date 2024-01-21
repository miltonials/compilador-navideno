
.data

miBoolmain: .word 0
print0: .asciiz "dentro del if"
print1: .asciiz "Dentro del else"

saltoLinea: .asciiz "\n"
.text

main:
li $t1,3233
li $t1,3333
#3333 == 3233
j false1
true1:
li $t0,1
j fin_1
false1:
li $t0,0
fin_1:
sw $t0, miBoolmain
li $t0, 0
blt $t1, $t0, true2
j false2
true2:
li $t0,1
j fin_2
false2:
li $t0,0
fin_2:
li $t2,6
li $t1,4
beq $0, 1, if_0
j else_0
if_0:
la $a0, print0
jal printStr
la $a0, saltoLinea
jal printStr
j fin_else0
else_0:
la $a0, print1
jal printStr
la $a0, saltoLinea
jal printStr
fin_else0:

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
