.data
coorX: .byte   24
coorY: .byte   24 # coordenada X de un punto # coordenada Y de un punto
color:   .byte   0, 0, 100, 0     # color: máximo rojo + máximo azul => magenta 
repet: .word32 10
CONTROL: .word32 0x10000
DATA:    .word32 0x10008
.text
lwu   $s0, CONTROL($zero) # $s0 = dirección de CONTROL 
lwu   $s1, DATA($zero)    # $s1 = dirección de DATA
daddi $t0, $zero, 7       # $t0 = 7 -> función 7: limpiar pantalla gráfica
sd    $t0, 0($s0) # CONTROL recibe 7 y limpia la pantalla gráfica
lwu   $a2, color($zero)
lbu   $a0, coorX($zero)  
lbu   $a1, coorY($zero)   
ld $s6, repet($zero)
#dibujar una linea horizontal
loop: jal DibujarUnPixel
daddi $s6, $s6, -1
beqz $s6, fin
daddi $a0, $a0, 1 
j loop
#dibujar una linea
fin: halt

# dibujar un pixel recibe en a0 la cordenada x y en a1 la cordenada y. recibe el color en a2
DibujarUnPixel:  sb    $a0, 5($s1) # DATA+5 recibe el valor de coordenada X
sb    $a1, 4($s1) # DATA+4 recibe el valor de coordenada Y
sw    $a2, 0($s1) # DATA recibe el valor del color a pintar
daddi $t0, $zero, 5       # $t0 = 5 -> función 5: salida gráfica
sd    $t0, 0($s0) 
jr $ra

