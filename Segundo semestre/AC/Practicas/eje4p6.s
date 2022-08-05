.data
CONTROL:    .word32 0x10000
DATA:       .word32 0x10008
bien:   .asciiz "Bienvenido"
Contra:      .asciiz "13163"
CdelTeclado:     .asciiz ""
error:      .asciiz "ERROR"

            .text
            daddi $sp,$0,0x400
            lwu $s0,CONTROL($0)
            lwu $s1,DATA($0)
            daddi $s2,$s2,9

inicio:     daddi $a0,$0,4
            daddi $a1,$0,0
            jal ingreso
            daddi $a0,$0,0
            jal comprobar
            beqz $v0,inicio
            halt

comprobar:  lbu $t0,Contra($a0)
            lbu $t1,CdelTeclado($a0)
            beqz $t0,es_Contra
            daddi $a0,$a0,1
            beq $t1,$t0,comprobar
            daddi $t0,$0,error
            daddi $v0,$0,0 
            sd $t0,0($s1) 
            j fin
es_Contra:   daddi $t0,$0,bien
            sd $t0,0($s1)
            daddi $v0,$0,1 
fin:        daddi $t0,$0,6 
            sd $t0,0($s0)
            daddi $t0,$0,4
            sd $t0,0($s0)
            jr $ra 

ingreso:    daddi $sp,$sp,-8
            sd $ra,0($sp)
iLOOP:      jal char
            sb $v0,CdelTeclado($a1) 
            daddi $a1,$a1,1
            daddi $a0,$a0,-1 
            bnez $a0,iLOOP
            ld $ra,0($sp)
            daddi $sp,$sp,8
            jr $ra

char:       sd $s2,0($s0) 
            lbu $v0,0($s1)
            jr $ra