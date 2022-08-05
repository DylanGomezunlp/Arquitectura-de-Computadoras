.data
CONTROL: .word32 0x10000
DATA:    .word32 0x10008
MSJ: .asciiz "debe ingresar un numero"
NUMEROS: .word 0
.text
lwu   $s0, CONTROL($zero) # $s0 = dirección de CONTROL 
lwu   $s1, DATA($zero)    # $s1 = dirección de DATA
jal ingresarNum
daddi $a1, $zero, NUMEROS
daddi $a0, $zero, $v0
jal procesarNum
daddi $s2, $zero, 9
ld $v0, 0($s0)
ld $s2, 0($s1)
halt

ingresarNum: daddi $t7, $zero, 0
daddi $t3, $t3, 10
dadd $t4, $zero, $zero
loopIng: daddi $t0, $zero, 9
sd $t0, 0($s0)
lb $t1, 0($s1) #t1=dato en asccii que lei
daddi $t1, $t1, -0x30
slt $t2, $zero, $t1#Compara t1 con 0, dejando t2=1 si t1 es menor que 0 (valores con signo)
bnez $t2, mayoraCero
daddi $t6, $zero, 4
daddi $t5, $zero, MSJ
sd $t5, 0($s1)
sd $t6, 0($s0)
daddi $v0, $zero, 0
j fin
mayoraCero: slt $t2, $t1, $t3
bnez $t2, esNum
daddi $t6, $zero, 4
daddi $t5, $zero, MSJ
sd $t5, 0($s1)
sd $t6, 0($s0)
daddi $v0, $zero, 0
j fin
esNum: daddi $v0, $v0, 1
dadd $t7, $t7, $t1 #t7 contador de nums
slti $t6, $t7, 597
beqz $t6, fin
sd $t1, NUMEROS($t4)
daddi $t4, $t4, 8
daddi $t0, $zero, 2
sd $t1, 0($s1)
sd $t0, 0($s0)
j loopIng
fin: jr $ra

procesarNum: daddi $t1, $zero, 3
loop: ld $t0, 0($a0)
daddi $a0, $a0, 8
daddi $a1, $a1, -1
beq $t0, $t1, sigo
j loop
sigo: daddi $v0, $v0, 1
beqz $a1, final
j loop
final: jr $ra