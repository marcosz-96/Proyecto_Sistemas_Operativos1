## **```PD: Para ver informe de agregados, ver README_2.```**

## Trabajo Final: 
# <u>Sistemas Operativos</u>

### Tema: ```./Funciones_Automatizadas.SO```

_Este proyecto tiene como finalidad crear un programa que permita a lo  usuarios gestionar de manera más práctica y sencilla ciertas funcionalidades del sistema que podrian ser complejas de realizar manualmente, como ser:_

- **```gestionar informes del uso de CPU, memoria y disco del sistema.```**
- **```realizar la limpieza de archivos temporales y caché de navegadores más usados.```**
- **```verificar y actualizar paquetes instalados en el sistema.```**

#### Instrucciones de uso: 
- Para poder utilizar el programa, es necesario contar con el sistema operativo Linux y que su sistema operativo tenga instalado la terminal (bash) ya que el programa es solamente compatible con el sistema operativo mencionado.
- Una vez instalada la terminal, debe acceder a la carpeta donde está guardado el programa con el siguiente comando ```cd nombre_del_programa``` (proyecto-sistemas-operativos), en este caso.
- Ya estando en la terminal debe solicitar permisos de ejecución del programa con el siguiente comando desde la terminal ```chmod +x_nombre_del_archivo.sh```.
- Una vez solicitado el permiso de ejecucion del archivo donde esta el  programa, se puede realizar la ejecucion del programa con el siguiente comando ```./nombre_del_programa.sh```.
- Una vez que se complete con los pasos antes mencionados, le saldrá un menú de opciones para que pueda elegir la funcionalidad que desea que el programa realice.
- 1: **Generar un informe de uso de memoria, disco y CPU.**
- Por ejemplo: genera un informe y lo guarda en el siguiente archivo de la siguiente manera, ```agregar_archivo_al_log(){
        echo  "$1" >> $archivo_log
        echo ""  >> $archivo_log
    }``` para poder visualizarlo si así lo desea.
- 2: **Realizar limpieza de archivos temporales del sistema y caché de los navegadores.**
- Por ejemplo: en la siguiente fraccion de código ```impiar_navegadores(){
        navegador =$1
        ruta_cache =$2
        echo "limpiando navegador $navegador"
        if [-d "$ruta_cache"]; then
            rm -rf "$ruta_cache"
            echo "Caché del navegador $navegador eliminado."
        else 
            echo "No se encontraron archivos caché del navegador $navegador."
        fi
    }``` se muestra una parte de como se realiza la limpieza de los navegadores.
- 3: **Verificar y actualizar paquetes instalados en el sistema.**
- Por ejemplo: en este caso verifica de la siguiente manera ```if apt list --upgradable 2>/dev/null | grep  -q "upgradable"; then``` si hay actualizaciones  disponibles, y si es así, se procede a actualizar.
- 4: **Para poder finalizar el programa.**

###  Contribuciones:
Si tienes interés en contribuir con este proyecto, a continuación te dejo un enlace para poder acceder al mismo...
En el enlace a continuación se muestra detalladamente como está hecho y organizado el proyecto, si tienes algunas sugerencias o ideas para mejorar el proyecto, no dudes en hacermelo saber.

https://github.com/marcosz-96/Proyecto_Sistemas_Operativos1.git

MIT Licence [2024] [Proyecto Sistemas Operativos]


**Integrantes: ```_Llera Tomás, Courel Brian y Gomez Marco._```**

