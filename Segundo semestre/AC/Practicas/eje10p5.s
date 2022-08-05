.data
vocales: .asciiz 'AEIOUaeiou0'
cadena: .asciiz 'abcdef'
cant: .word 0
#la subrutina se vocal recibe solo un caracter(lbu $a0, letra($0))-la subrutina contarvocal recibe toda una cadena
 .code
 daddi $sp, $0, 0x400
 daddi $a0, $0, cadena
 jal contarVoc
 sd $a0, cant($zero)
 halt

contarVoc: daddi $sp,$sp, -24#push
sd $ra, 0($sp)
sd $s0, 8($sp)
loopCV: lbu $a1, cadena($s0)#agarro un caracter
beqz $a1, finContarV
jal es_vocal
bnez $v1, es_Vocal_CV#v1 es el booleano que me tiene que devolver es_vocal
daddi $s0, $s0, 1#avanzo en el arreglo
j loopCV
es_Vocal_CV: daddi $s1, $s1, 1# sumo un 1 en s1 si es una vocal
daddi $s0, $s0, 1#avanzo en el arreglo
j loopCV
finContarV: dadd $a0, $s1, $0
ld $ra, 0($sp)#pop
ld $s0, 8($sp)
daddi $sp,$sp, 24
jr $ra 


es_vocal: dadd $v1, $0, $0 #v1=es el booleano que me indica si es vocal o no
 daddi $t2, $0, 0
 loop: lbu $t1, vocales($t2)
 beqz $t1, fin_vocal
 beq $a1, $t1, si_es_voc
 daddi $t2, $t2, 1
 j loop
si_es_voc: daddi $v1, $0, 1
fin_vocal: jr $ra
