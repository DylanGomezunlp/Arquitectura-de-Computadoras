
.data
M: .word 100
cantMayores: .word 0
array: .word 123, 1888, 99, 10, 1, 300, 255
Tamanio: .word 7
.code 
    ld $a0,M($zero)#a0=numero M
    ld $a1, Tamanio($zero)#a1=tamaño del arreglo
    daddi $a2, $zero, array#a2=direccion del comienzo del arreglo
    jal subrutina
    sd $v0, cantMayores($zero)#guardo el valor del registro de retorno en memoria
    halt

subrutina: daddi $v0, $zero, 0
beqz $a1, fin
loop: ld $t0, 0($a2)#necesito guardar el registro a0 en uno temporal para no perderlo en la siguiente operacion
slt $t0,$a0,$t0 #comparo si a0 es menor a t0, si es verdad dejo un 1 en t0 
daddi $a2, $a2, 8#sigo en el arreglo
beqz $t0, continuo#si t0=0 no sumo el valor, ya que el numero es del arreglo no es mas grande que M
daddi $v0, $v0, 1#si llego aca es porque el valor es mas grande que M, y sumo 
continuo: daddi $a1, $a1, -1 #decremento la cantidad de caracteres faltantes
bnez $a1, loop #si quedan caracteres continuo
fin: jr $ra



