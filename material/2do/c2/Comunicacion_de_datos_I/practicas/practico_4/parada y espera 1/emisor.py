#!/usr/bin/env python

"""
Emisor de bloques(UDP)
Parametros:  tiempo de espera por ack en milisegundos, Long de bloque en bytes, Numero de bloques a enviar
Estructura del frame:
-encapsulado en Eth-IP-UDP, es decir 18+20+8 bytes de overhead, lo que implica que el bloque a generar
  debe ser del tamano solicitado menos 46 bytes, para los calculos de tiempo de transmision
-El unico campo que nos interesa es el numero de secuencia (0 o 1), que va en el primer byte y sirve al protocolo.
-En los dos bytes que sigue, va un numero de bloque que solo sirve para que se pueda entender mejor el
  intercambio de frames. Este numero va de 00 a 99
-El resto de los bytes se rellena con el numero de secuencia(0 o 1)

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
#  timeout entre 1 y 10000 milisegundos
#  long_bloque entre100 y 1200 bytes
#  numero de bloques a enviar entre 1 y 100
#  agregar archivo de log

#Chequeo de numero de parametros
if len(sys.argv) != 4:
  print "emisor: numero de parametros erroneo"
  print "      emisor timeout longitud_bloque num_bloques"
  print "             timeout entre 1 y 10000 milisegundos"
  print "             longitud_bloque entre 100 y 1200 bytes"
  print "            num_bloques entre 1 y 100 bloques"
  sys.exit(1) 

#Chequeo de valores de los parametros
try:
  timeout = int(sys.argv[1])
except:
  print "Parametro timeout no es entero"
  sys.exit(1)
try:
  long_bloque = int(sys.argv[2])
except:
  print "Parametro long_bloque no es entero"
  sys.exit(1)
try:
  num_bloques = int(sys.argv[3])
except:
  print "Parametro num_bloques no es entero"
  sys.exit(1)
if timeout < 1 or timeout > 10000:
  print "El parametro timeout debe estar entre 1 y 10000 (milisegundos)"
  fin = 1
if long_bloque < 100 or long_bloque > 1200:
  print "El parametro longitud debe estar entre 100 y 1200 (bytes)"
  fin = 1
if num_bloques < 1 or num_bloques > 100:
  print "El parametro num_bloques debe estar entre 1 y 100"
  fin = 1
if fin == 1:
  sys.exit(1)


# inicializacion de socket
try:
  sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
  sock.bind((host_emisor, port_emisor))
  sock.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
  sock.settimeout(timeout/1000.)
except IOError, err:
  print "Error en inicializacion de socket:",  os.strerror(err.errno)
  sock.close()
  sys.exit(1)



#Creacion de cadenas
cero = "0"
uno = "1"
lng = long_bloque - 46
z = 1
while z < lng -3:
  cero = cero + "0"
  uno = uno + "1"
  z = z + 1

org = 0
env = 0


prox_bloque = "0"
pb = "0" + "00" + cero
ack = "K"
max_rnt = 8

i = 0
rnt = 0
tiem = 0
while(i <  num_bloques and rnt < max_rnt):
  try:
    now = datetime.now()
    sock.sendto(pb, (host_receptor, port_receptor))
    t=str(now.hour).zfill(2) + ":" + str(now.minute).zfill(2) + ":" + str(now.second).zfill(2) + "." + str(now.microsecond).zfill(6)
    env = env + 1
    if tiem == 0:
      tiempoi = now
      tiem = 1
    print t,"Enviado bloque_numero",i , "- Numero de secuencia", prox_bloque
    response = sock.recv(8192)
    now = datetime.now()
    t=str(now.hour).zfill(2) + ":" + str(now.minute).zfill(2) + ":" + str(now.second).zfill(2) + "." + str(now.microsecond).zfill(6)
    if response[0] == ack:
      kk = response[1]+ response[2]
      bl = response[4] + response[5]
      if response[3] == "A":
        acc = "Aceptado"
      else:
        acc = "No aceptado"
      print t, "Recibido Ack", kk, "originado por llegada de bloque",  bl, acc
      org = org + 1
      i = i + 1
      rnt = 0
      if i < 10:
        ss = "0" + str(i)
      else:
        ss = str(i)
      if prox_bloque == "0":
        pb = "1" + ss + uno
        prox_bloque = "1"
      else:
       prox_bloque = "0"
       pb = "0" + ss + cero
    else:
      rnt = rnt + 1
      print t,"Recibido frame desconocido,reintento", rnt
  except:
    rnt = rnt + 1
    now = datetime.now()
    t=str(now.hour).zfill(2) + ":" + str(now.minute).zfill(2) + ":" + str(now.second).zfill(2) + "." + str(now.microsecond).zfill(6)
    print t,"Timeout,reintento", rnt

now = datetime.now()
tiempof = now
ttotal = tiempof - tiempoi
t=str(now.hour).zfill(2) + ":" + str(now.minute).zfill(2) + ":" + str(now.second).zfill(2) + "." + str(now.microsecond).zfill(6)
if rnt == max_rnt:
  print t,"Cancelado por numero maximo de reintentos (", rnt, "). Bloque ", i
if i ==num_bloques:
  print t,"Enviados con exito ", i , " bloques"
print "Tiempo total:", ttotal
print "Cantidad de frames originales enviados:" , org
print "Cantidad de frames reenviados:", env

sock.close()

#Aqui van las estadisticas: bloques enviados, tiempo total, eficiencia, podria ir ademas el timeout, etc