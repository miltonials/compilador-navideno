
.data

saltoLinea: .asciiz "\n"
dhola: .word 0
chola: .word 0
holamain: .word 0
hola2main: .float 0.0

.text

hola:
#5
sw $t0, dhola
li $t0, 0
main:
#5
sw $t0, holamain
li $t0, 0
#3.3
s.s $f0, hola2main
l.s $f12, hola2main
li $v0, 2
syscall
li $t0, 0
li $a0, hola
li.s $f1, hola2
jal hola

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
