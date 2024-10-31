#En este proyecto elegimos 3 funciones para presentar,
#las cuales son: 

#1ra Función: Generar informes, esta funcion nos permite,
#obtener un informe sobre el uso actual de la CPU, memoria y alamacenamiento 
#al momemto de realizar la consulta de la misma.

generar_informes(){
    #Primero, definimos un archivo log, que es donde se van a guardar los informes
    archivo_log="informes_$(date +%Y%m%d_%H%M%S).log"

    #Luego, Obtenemos los datos de uso de la CPU
    echo "Uso de CPU:" > "$archivo_log"
    top -b -n 1 | grep "Cpu(s)" >> "$archivo_log"
    echo "" >> "$archivo_log"

    #Tambien, obtenemos datos de uso de la Memoria
    echo "Uso de Memoria:" >> "$archivo_log"
    free -h >> "$archivo_log"
    echo "" >> "$archivo_log"

    #Y por ultimo, obtenemos datos de uso del Disco
    echo "Uso de Disco:" >> "$archivo_log"
    df -h >> "$archivo_log"
    echo "" >> "$archivo_log"

    #Enviamos mensaje de confirmación de informes hechos.
    echo "Informes generados y guardados exitosamente en "$archivo_log"."
    echo "--------------------------------------------------------------"
    echo "Para poder ver el listado de informe, por favor
    escriba lo siguiente 'ls -l informes_*.log'"
    echo "--------------------------------------------------------------"
    echo "Si desea ver el informe generado, escriba lo siguiente,
    'cat informes_$(date +%Y%m%d_%H%M%S).log'"
}

#2da Función: Limpiar archivos temporales y caché del sistema
#Esta función nos permite eliminar archivos temporales y caché del sistema.

limpiar_cache_y_archivos_temp(){
    echo "Limpiando caché y archivos temporales..."

    #En el primer paso de procede a eliminar los archivos temporales del sistema
    sudo rm -rf /tem/*
    echo "Los archivos temporales en /tem/ han sido eliminados."

    #lo siguiente es realizar la limpieza de los archivos caché del sistema 
    sudo apt-get clean
    echo "Los archivos caché APT del sistema, limpiado."

    #Luego, procedemos a la lmpieza de los navegadores
    echo "Empezando limpieza de navagadores..."
    #Empezamos con FireFox
    echo "Limpiando FireFox..."
    if [ -d "$HOME/.cache/mozilla/firefox" ]; then
        rm -rf "$HOME/.cache/mozilla/firefox/*"
        echo "Caché del navegador FireFox eliminado con éxito."
    else
        echo "No se encontraron archivos caché en el navegador FireFox."
    fi

    #Seguimos con el navegador Google
    echo "Limpiando Google Chrome..."
    if [ -d "$HOME/.cache/google-chrome" ]; then
        rm -rf "$HOME/.cache/google-chrome/*"
        echo "Caché del navegador Google Chrome eliminado con éxito."
    else
        echo "No se encontraron archivos caché en el Google Chrome."
    fi

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
    echo "-----------------------------------------------------------------------"
    echo "Bienvenido al menú de opciones"
    echo "A continuación te presentamos las siguienbtes opciones para que puedas:"
    echo "-----------------------------------------------------------------------"
    echo "1. Generar un informe de uso de CPU, memoria y disco"
    echo "2. Verificar y actualizar en sistema"
    echo "3. Realizar una limpieza de archivos temporales y caché"
    echo "4. Finalizar el programa"
    echo "-----------------------------------------------------------------------"
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