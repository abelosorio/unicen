#!/usr/bin/env python

"""
Receptor de bloques (UDP)
Parametros:  Long del ack en bytes
Estructura del frame:
-encapsulado en Eth-IP-UDP, es decir 18+20+8 bytes de overhead, lo que implica que el bloque a generar
  debe ser del tamano solicitado menos 46 bytes, para los calculos de tiempo de transmision
-Campos en el ack: lo unico que lleva el ack es la indicacion de ack (K), se le agregan campos que el protocolo 
  de parada y espera no interpreta, y que sirven para entender lo que esta pasando en la linea
-Un caracter K que interpreta el protocolo de parada y espera
-Dos caracteres que llevan el numero de ack que se va emitiendo, se incrementa en uno por cada ack
-Un caracter que indica si el ack se envia porque se acepto un frame (A) o por que llego uno que no se acepto (N)
-Dos caracteres que indican el numero de bloque recibido que genero este ack (se haya o no aceptado) 
-El unico campo que nos interesa es el primer byte que lleva el ack (K)
-El resto de los bytes se rellena con ese valor

"""
 
import socket
import sys
import os
from datetime import datetime

port_receptor = 9003
#host_receptor = '10.0.0.21'
host_receptor = '255.255.255.255'
port_emisor = 9004
#host_emisor = '10.0.0.20'
host_emisor = '255.255.255.255'
size = 8192

fin = 0

#Analisis de parametros: 
#  long_ack entre100 y 1200 bytes
#agregar numero de bloques a enviar y archivo de log

#Chequeo de numero de parametros
if len(sys.argv) != 2:
  print "receptor: numero de parametros erroneo"
  print "      receptor longitud_ack"
  print "             longitud_ack entre 100 y 1200 bytes"
  sys.exit(1) 

#Chequeo de valores de los parametros
try:
  long_ack = int(sys.argv[1])
except:
  print "Parametro long_ack no es entero"
  sys.exit(1)

if long_ack < 100 or long_ack > 1200:
  print "El parametro longitud debe estar entre 100 y 1200 (bytes)"
  fin = 1

if fin == 1:
  sys.exit(1)

# inicializacion de socket
espera_por_primer_bloque = 100
try:
  sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
  sock.bind((host_receptor, port_receptor))
  sock.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
  sock.settimeout(espera_por_primer_bloque)
except IOError, err:
  print "Error en inicializacion de socket:",  os.strerror(err.errno)
  sock.close()
  sys.exit(1)

#Creacion de cadenas
ack = "K"
uno = "1"
lng = long_ack - 46
z = 1
while z < lng - 6:
  ack = ack + "K"
  z = z + 1


bloque_esperado = "0"
num_ack = 0
nck = "00"
recibidos = ""
try:
  i = 0
  while (i < 100):
    i = i + 1
    bloque = sock.recv(8192)   
    now = datetime.now()
    tr=str(now.hour).zfill(2) + ":" + str(now.minute).zfill(2) + ":" + str(now.second).zfill(2) + "." + str(now.microsecond).zfill(6)  
    now = datetime.now()   
    b = bloque[0]
    nbl = bloque[1] + bloque[2]
    if b == bloque_esperado:
      x = "A"
    else:
      x = "N"
    kk = "K" + nck + x + nbl + ack
    sock.sendto(kk, (host_emisor, port_emisor))
    te=str(now.hour).zfill(2) + ":" + str(now.minute).zfill(2) + ":" + str(now.second).zfill(2) + "." + str(now.microsecond).zfill(6)
    num_ack = num_ack + 1
    nckv = nck
    nck = str(num_ack).zfill(2)
    if b == bloque_esperado:
      print tr,"Recibido bloque numero", nbl, "numero de secuencia" ,b, "se esperaba", bloque_esperado ," correcto"
      recibidos = recibidos + "-" + nbl
      print te, "Envia ack", nckv 
      if bloque_esperado == "0":
        bloque_esperado = "1"
      else:
        bloque_esperado = "0"
    else:
       print tr, "Recibido bloque numero", nbl, "numero de secuencia", b, "se esperaba", bloque_esperado ," incorrecto"
       print te, "Envia ack", nckv 
except:
  now = datetime.now()
  t=str(now.hour).zfill(2) + ":" + str(now.minute).zfill(2) + ":" + str(now.second).zfill(2) + "." + str(now.microsecond).zfill(6)
  print t, "No se recibio bloque en tiempo limite, finaliza el receptor"
  print "Lista de bloques recibidos:" + recibidos
sock.close()
