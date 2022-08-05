.data
CONTROL: .word32  0x10000
DATA:    .word32  0x10008
texto:   .asciiz "ingrese un numero"
num1:    .word32 0
num2:    .word32 0 
.text

lwu   $s0, DATA($zero)
lwu   $s1, CONTROL($zero)
daddi $t1, $zero, texto
daddi $t2, $zero, 4
sd    $t1, 0($s0)
sd    $t2, 0($s1) 
halt