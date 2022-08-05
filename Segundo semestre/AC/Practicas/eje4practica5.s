.data
peso: .double 53.0
estatura: .double 175.0
imc: .double 0.0
estado: .word 0
valor1: .double 18.5
valor2: .double 25.00
valor3: .double 30.00
uno: .word 1
.code
l.d f1, peso(R0)
l.d f2, estatura(R0)#f1=peso, f2=estatura
mul.d f2, f2, f2 #f2=(f2)^2
l.d f6, estado(r0)  #f6=18.5
l.d f8, valor1(r0)#f8=25
l.d f9, valor2(r0)#f9=30
div.d f5, f1, f2
l.d f10, valor3(r0) #f5=imc
s.d f5, imc(r0)
c.lt.d f5, f8 # si f5<f8 FP=1, osea, si f5 es menor a 18.5 fp=1
bc1f esMenorA18
c.lt.d f5, f9# si  f5<f9 fp=1, osea, si f5 es menor a 25 fp=1
bc1f esMenorA25
c.lt.d f5, f10 # si f5<f10 fp=1, osea, si f5 es menor a 30 fp=1
bc1f esMenorA30
nop
j esMayorA30
esMenorA18: daddi r1,r1, 1
sd r1,estado(r0)
j fin
esMenorA25: daddi r1,r1, 2
sd r1,estado(r0)
j fin
esMenorA30: daddi r1,r1, 3
sd r1,estado(r0)
j fin
esMayorA30: daddi r1,r1, 4
sd r1,estado(r0)
j fin
fin: Halt