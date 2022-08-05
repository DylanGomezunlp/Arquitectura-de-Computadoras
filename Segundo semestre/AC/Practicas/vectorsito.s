#Escribir un programa que lea un arreglo(tabla1) de N datos en punto
#flotante almacenados en la memoria, y genere un segundo 
#arreglo(tabla2) cuyos N-1 elementos sean el promedio de cada par de datos 
#consecutivos del arreglo original. 
#Es decir, el primer elemento de la tabla2 deberá ser el promedio entre los 
#elementos 1 y 2 de la tabla1,
#el segundo elemento de la tabla2 debera ser el promedio entre 
#los elementos 2 y 3 de la tabla1 etc..
#El cálculo del promedio se debe realizar en una subrutina.
#El arreglo tabla2 debe quedar almacenado en memoria a continuación de tabla1-
#Una vez generado el arreglo tabla2, todos sus elementos deben visualizarse en la pantalla 
#terminal del simulador. Esto debe implementarse a traces de otra subrutina que reciba
#como parametro la dirección inicial del arreglo. Considerar N=12.//los datos los lei desdew teclado para mayor dificultad (?????)
.data
DATA: .word32 0x10008
CONTROL: .word32 0x10000
cadena: .double 0.0,0.0,0.0,0.0,0.0,0.0
cadena2: .double 0.0
.text
lwu $s0,DATA($zero)
lwu $s1,CONTROL($zero)
#leerNumeros y guardarlos en vector en punto flotante
daddi $s3, $zero, 6#s3= cant caracteres
daddi $t0, $zero, 8
daddi $t1, $zero, 0
daddi $t3, $zero, 2
mtc1 $t3, F3
cvt.d.l F3, F3
loopLeer: sd $t0,0($s1) #control recibe 8 y lee un numero
          l.d F0,0($s0) #f0 recibe el numero leido
          s.d F0, cadena($t1)
          daddi $t1, $t1, 8
          daddi $s3, $s3, -1
          beqz $s3, finLeer
          j loopLeer
finLeer:  daddi $s3, $zero, 6
          daddi $t1, $zero, 0
          daddi $t2, $zero, 0
          daddi $t1, $zero, 0
loopProm: l.d F2, cadena($t1)
          daddi $t1, $t1, 8
          l.d F1, cadena($t1)
          daddi $s3, $s3, -1
          beqz $s3, finProm
          jal promedio 
          s.d F1, cadena2($t2)
          daddi $t1, $t1, 8
          daddi $t2, $t2, 8
          j loopProm
finProm: daddi $a0,$zero,cadena2
jal imprimir

halt
#leerNumeros y guardarlos en vector en punto flotante
#recibe en a0, y en a1 los dos numeros, suma los dos, los divide por dos y devuelve todo en v0
promedio: add.d F1, F2, F1 
          div.d F1, F1, F3
          jr $ra
#recibe en a0 la direccion donde tiene que imprimir
imprimir: daddi $t1, $zero, 3
          daddi $t0, $zero, 5
loopImprimir: l.d F1,0($a0) #tomo el primer dato del arreglo y lo guardo en un registro de punto flotante
          s.d F1, 0($s0)#lo llevo a DATA como punto flotante con s.d
          sd $t1,0($s1)
          daddi $a0,$a0, 8
          daddi $t0, $t0, -1
          beqz $t0, finImprimir
          j loopImprimir
finImprimir: jr $ra
