.data
a: .word 1
b: .word 2
c: .word 2
d: .word 0
.code
ld r1,a(r0)
ld r2,b(r0)
ld r3,c(r0)
ld r5,d(r0)
beq r1,r2,iguales
j inco
iguales: daddi r5,r5,1
inco: beq r2,r3, igu2
j inco2
igu2: daddi r5,r5,1
inco2: beq r1,r3, igu3
j incondicional3
igu3: daddi r5,r5,1
incondicional3: sd r5, d(r0)
halt