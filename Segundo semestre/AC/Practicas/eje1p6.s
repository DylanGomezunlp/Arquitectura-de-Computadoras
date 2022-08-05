.data
CONTROL: .word32  0x10000
DATA:    .word32  0x10008
texto:   .asciiz  0   
.text
lwu   $s0, DATA($zero)
lwu   $s1, CONTROL($zero)   

daddi $t2, $zero, 0       #t2= cantidad de datos leidos
daddi $s2,$zero,0         #s2 es un contador para avanzar en el arreglo
daddi $t0, $zero, 9
loopLeer: sd  $t0, 0($s1) #envio a control el 9, para leer una letra
lbu $a0, 0($s0)           #me traigo de DATA lo que lei
sb $a0, texto($s2)        #llevo el dato leido a la posicion en texto
daddi $a0, $a0, -0x30       #resto para saber si terminar de leer (si es 0 en ascii va a terminar de leer)
beqz $a0, finLoop
daddi $s2,$s2, 1            #sumo para avanzar en el vector
daddi $t2, $t2, 1           #t2= cantidad de datos leidos
j loopLeer

finLoop: sb $0, texto($s2)
daddi $t1, $zero, texto    #t1= direccion comienzo del texto
daddi $t0, $zero, 4        #codigo para que imprima un dato
sd  $t1, 0($s0)            #guardo lo que esta en la direccion de t1 en DATA
sd  $t0, 0($s1)            #llevo a CONTROL el codigo para imprimir un caracter
halt