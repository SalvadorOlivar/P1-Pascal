#! /usr/bin/env python

import os, sys
import shutil
import time
import subprocess

def dir(nombre):
    return os.path.normcase("./" + nombre)

def arch(carpeta,nombre):
    return os.path.normcase("./" + carpeta + "/" + nombre)


ejecutable = dir('principal')

if os.name == 'nt':
    ejecutable = ejecutable +  '.exe'

    
stream = os.popen('fpc -Co -Cr -gl -Miso principal.pas')
output = stream.read()
stream.close()

if "compiled" not in output:
    print (output)
    print ("**************************************************************************")
    print ("Su programa no compiló. Por favor corrija los errores y vuelva a ejecutar.")
    print ("**************************************************************************")
else:
    correctos = 0
    erroneos  = 0
    timeouts  = 0
    
    for p in sorted(os.listdir(dir('entradas'))):
        path_entrada = arch('entradas',p)
        path_salida  = arch('salidas',p)
        path_mio     = arch('mios',p)
        path_diff    = arch('diffs',p)

        try:
            subprocess.run([ejecutable], stdin=open(path_entrada, "r")
                                       , stdout=open(path_mio, "w")
                                       , timeout=0.5, check=True)
            
            f_entrada = open(path_entrada, "r")
            entrada = f_entrada.read()[:-1]
            f_entrada.close()
            f_salida = open(path_salida, "r")
            salida = f_salida.read()
            f_salida.close()
            f_mio = open(path_mio, "r")
            output = f_mio.read()
            f_mio.close()

            if salida == output:
                print (" -- El caso", p[:2]," se resolvió correctamente")
                correctos += 1
            else:
                print("**********************************")
                print("El caso", p[:2], " tiene errores")
                print("La entrada es: ")
                print(entrada)
                print("Su programa genera:")
                print(output)
                print("El resultado correcto es:")
                print(salida)
                print("**********************************")
                erroneos += 1
                
        except subprocess.TimeoutExpired:
            print("**********************************")
            print("El caso", p[:2]
                 ," ha agotado el tiempo de ejecución, revise los loops")
            print("**********************************")
            timeouts += 1

    print ("Correctos: ", correctos, " Errores: ", erroneos, " Timeouts: ", timeouts)
