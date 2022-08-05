.data
CONTROL: .word32  0x10000
DATA:    .word32  0x10008
texto:   .asciiz "ingrese un numero"
cant:    .word32 19
num1:    .word32 0
num2:    .word32 0 
.text
daddi $sp, $0, 0x400
lwu   $s0, DATA($zero)
lwu   $s1, CONTROL($zero)
daddi $a3, $zero, 4
daddi $a1, $zero, texto
jal ingreso
halt


ingreso:  daddi $sp,$sp, -24 #push
          sd $ra, 0($sp)
          sd $s0, 8($sp)
          sd $s1, 16($sp)

          daddi $a3, $zero, 4
          daddi $a1, $zero, texto
          sd $a1, 0($s0)
          sd $a3, 0($s1)            #termina el primer ingrese un numero

          daddi $t0, $zero, 8
          sd  $t0, 0($s1)           #envio a control el 9, para leer un numero
          ld $a0, 0($s0)            #me traigo de DATA lo que lei
          sd $a0, num1($0)          #llevo el dato leido a la etiqueta num1

          daddi $a3, $zero, 4
          daddi $a1, $zero, texto
          sd $a1, 0($s0)
          sd $a3, 0($s1)            #termina el segundo ingrese un numero

          sd $t0, 0($s1)            #envio a control el 9, para leer un numero
          ld $a1, 0($s0)            #me traigo de DATA lo que lei
          sd $a1, num2($0)          #llevo el dato leido a la etiqueta num2
          jal resultado             #a0= num1, a1=num2, en v0 va a estar el resultado de la suma

          ld $ra, 0($sp)  #pop
          ld $s0, 8($sp)
          ld $s1, 16($sp)
          daddi $sp,$sp, 24
          jr $ra
  
resultado:  daddi $s3, $s3, 0
            dadd $s3, $a0, $a1
            sd $s3, 0($s0)        #envio a DATA lo que voy a imprimir
            daddi $t0, $zero, 2
            sd  $t0, 0($s1)       #envio un 2 para imprimir en pantalla el numero recibido 
            jr $ra