DibujarUnPixel: lbu   $a0, coorX($zero)   # $a0 = valor de coordenada X
sb    $a0, 5($s1) # DATA+5 recibe el valor de coordenada X
lbu   $a1, coorY($zero)   # $a1 = valor de coordenada Y
sb    $a1, 4($s1) # DATA+4 recibe el valor de coordenada Y
sw    $a2, 0($s1) # DATA recibe el valor del color a pintar
daddi $t0, $zero, 5       # $t0 = 5 -> función 5: salida gráfica
sd    $t0, 0($s0) 
jr $ra