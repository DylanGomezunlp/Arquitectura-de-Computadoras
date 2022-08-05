.data
cadena: .asciiz "abcef" 
car: .asciiz "d" 
cant: .word 0
.code
lbu r1, car(r0)
dadd r2, r0, r0
dadd r3, r0, r0
loop: lbu r4, cadena(r2)
beqz r4, termino
dsubu r4, r4, r1
bnez r4, noigual
daddi r3, r3, 1
noigual: daddi r2, r2, 1
j loop
termino: sd r3, cant(r0)
halt  