#En este proyecto elegimos 3 funciones para presentar,
#las cuales son: 

#1ra Función: Generar informes, esta funcion nos permite,
#obtener un informe sobre el uso actual de la CPU, memoria y alamacenamiento 
#al momemto de realizar la consulta de la misma.

generar_informes(){
    #Primero, definimos un archivo log, que es donde se van a guardar los informes
    archivo_log="informes_$(date +%Y%m%d_%H%M%S).log"

    #Funcion adicional para agregar archivos al log
    agregar_archivo_al_log(){
        echo  "$1" >> $archivo_log
        echo ""  >> $archivo_log
    }
    
    #Luego, Obtenemos los datos de uso de la CPU
    agregar_archivo_al_log "Uso de CPU:"
    top -b -n 1 | grep "Cpu(s)" >> "$archivo_log"
    
    #Tambien, obtenemos datos de uso de la Memoria
    agregar_archivo_al_log "Uso de Memoria:"
    free -h >> "$archivo_log"
    
    #Y por ultimo, obtenemos datos de uso del Disco
    agregar_archivo_al_log "Uso de Disco:"
    df -h >> "$archivo_log"
    echo "----------------------------------------------------------------------"
    #Enviamos mensaje de confirmación de informes hechos.
    echo "Informes generados y guardados en \"$archivo_log\"."
    echo "----------------------------------------------------------------------"
    echo "_El informe es el siguiente:"
    echo "----------------------------------------------------------------------"
    cat "$archivo_log"
    echo "----------------------------------------------------------------------"
    echo "Para poder ver el listado de informes, ingrese lo siguiente:"
    echo "'ls -l informes_*.log'"
    echo "----------------------------------------------------------------------"
    echo "Si desea ver el informe de nuevo, escriba lo siguiente:"
    echo "'cat\"$archivo_log\"'"
}

#2da Función: Limpiar archivos temporales y caché del sistema
#Esta función nos permite eliminar archivos temporales del sistema y caché de los navegadores.

limpiar_cache_y_archivos_temp(){
    echo "Limpiando caché y archivos temporales..."

    #En el primer paso de procede a eliminar los archivos temporales del sistema
    if sudo rm -rf /tem/*; then
        echo "Los archivos temporales en /tem/ han sido eliminados."
    else
        echo "No se pudo eliminar los archivos temporales en /tem/"
    fi

    #lo siguiente es realizar la limpieza de los archivos caché del sistema 
    if sudo apt-get clean; then
        echo "Los archivos caché APT del sistema, limpiado."
    else 
        echo "No se pudo limpiar los archivos caché APT del sistema."
    fi

    #Luego, procedemos a la lmpieza de los navegadores
    echo "Empezando limpieza de navagadores..."

    limpiar_navegadores(){
        navegador =$1
        ruta_cache =$2
        echo "limpiando navegador $navegador"
        if [-d "$ruta_cache"]; then
            rm -rf "$ruta_cache"
            echo "Caché del navegador $navegador eliminado."
        else 
            echo "No se encontraron archivos caché del navegador $navegador."
        fi
    }

echo "Empezando limpieza de navegadores"
limpiar_navegadores "FireFox" "$HOME/.cache/mozilla/firefox"
limpiar_navegadores "Google Chrome" "$HOME/.cache/google-chrome"
echo "Limpieza completada con éxito."
}

#3ra Función: Actualización e instalación de paquetes
#Esta funcion nos permite verificar si hay actualizaciones disponibles y proceder a instalarlas.
actualizar_sistema(){
    echo "Verificando actualizaciones disponibles..."

    #En caso de haber actualizaciones, actualiza la lista de paquetes disponibles
    sudo apt-get update >> "$LOG_FILE" 2>&1

    #Verificamos si hay actualizaciones disponibles
    if apt list --upgradable 2>/dev/null | grep  -q "upgradable"; then
        echo "Actualizaciones disponibles, procediendo a instalarlas..."    

        #Instalamos y registramos los cambios
        sudo apt-get dist-upgrade -y >> "$LOG_FILE" 2>&1

        #Registramos la fecha de actualización
        echo "Actualización realizada con éxito el día: $(date)" >> "$LOG_FILE"
        echo "---------------------------------------------------" >> "$LOG_FILE"
        else 
            echo "No hay actualizaciones disponibles"
        fi
}

#4ta Función: Menú Interactivo
while true; do
    echo "-------------------------------------------------------------------------"
    echo "===>Bienvenido al menú de opciones<==="
    echo "¡A continuación te presentamos las siguienbtes opciones para que puedas!:"
    echo "-------------------------------------------------------------------------"
    echo "1. Generar un informe de uso de CPU, memoria y disco."
    echo "2. Verificar y actualizar en sistema."
    echo "3. Realizar una limpieza de archivos temporales y caché."
    echo "4. Finalizar el programa."
    echo "-------------------------------------------------------------------------"
    read -p "Elija una opción: " opcion

    case $opcion in
    1) 
        generar_informes 
        ;;
    2) 
        actualizar_sistema 
        ;;
    3) 
        limpiar_cache_y_archivos_temp 
        ;;
    4) 
        echo "Gracias por utilizar el menú de opciones"  
        break #Sale del bucle
        ;;
    *)
        echo "Opción no válida, por favor elija una opción válida"
        ;;
    esac
done
