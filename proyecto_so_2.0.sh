#En este proyecto están integradas las mejorías sugeridas en la presentación
#Definiremos los colores:
RED='\033[91m'
GREEN='\033[92m'
YELLOW='\033[93m'
CYAN='\033[96m'
MAGENTA='\033[95m'
NC='\033[0m'

LOG_FILE="actualizacion_$(date +%Y%m%d_%H%M%S).log"

#Aplicamos los colores a las funciones 

generar_informes(){
    echo -e "${GREEN}Generando informes...${NC}"
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
    #una vez generado el informe, preguntamos al usuario si desea ver el mismo
    read -p "¿Desea ver el informe generado? (s/n):"  respuesta
    if [[ "$respuesta" == "s" || "$respuesta" == "S" ]]; then
        #Si la respuesta es 's', mostramos el informe
    echo -e "${YELLOW}El informe es: ${NC}"
    echo "----------------------------------------------------------------------"
        cat "$archivo_log"
    else 
        #Si la respuesta es 'n', avisamos que se guardó el informe y cerramos el script
        echo  "El informe se ha guardado en \"$archivo_log\"."
}

#2da Función: Limpiar archivos temporales y caché del sistema
#Esta función nos permite eliminar archivos temporales del sistema y caché de los navegadores.

limpiar_cache_y_archivos_tmp(){
    echo -e "${MAGENTA}Limpiando caché y archivos temporales...${NC}"

    #En el primer paso de procede a eliminar los archivos temporales del sistema
    if sudo rm -rf /tmp/*; then
        echo "Los archivos temporales en /tem/ han sido eliminados."
    else
        echo -e "${RED}No hay archivos temporales en /tmp/${NC}"
    fi


    #lo siguiente es realizar la limpieza de los archivos caché del sistema 
    if sudo apt-get clean; then
        echo "Los archivos caché APT del sistema, han sido elimidados."
    else 
        echo -e "${RED}No hay archivos caché APT en el sistema.${NC}"
    fi

    #Luego, procedemos a la lmpieza de los navegadores
    echo "Empezando limpieza de navegadores..."


    limpiar_navegadores(){
        navegador=$1
        ruta_cache=$2
        echo "limpiando navegador $navegador..."
        if [ -d "$ruta_cache" ]; then
            rm -rf "$ruta_cache"
            echo "Caché del navegador $navegador eliminado."
        else 
            echo -e "${RED}No se encontraron archivos caché del navegador $navegador.${NC}"
        fi
    }

limpiar_navegadores "FireFox" "$HOME/.cache/mozilla/firefox"
limpiar_navegadores "Google Chrome" "$HOME/.cache/google-chrome"
echo -e "${GREEN}Limpieza completada con éxito.${NC}"

}

#3ra Función: Actualización e instalación de paquetes
#Esta funcion nos permite verificar si hay actualizaciones disponibles y proceder a instalarlas.
actualizar_sistema(){
    echo -e "${CYAN}Verificando actualizaciones disponibles${NC}"
    echo "..."

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
            echo -e "${RED}No hay actualizaciones disponibles.${NC}"
        fi
}

#4ta Función: Menú Interactivo
while true; do
    echo "-------------------------------------------------------------------------"
    echo -e "${CYAN}===>Bienvenido al menú de opciones<===${NC}"
    echo "¡A continuación te presentamos las siguienbtes opciones para que puedas!:"
    echo "-------------------------------------------------------------------------"
    echo -e "${YELLOW}1. Generar un informe de uso de CPU, memoria y disco."
    echo "2. Verificar y actualizar en sistema."
    echo "3. Realizar una limpieza de archivos temporales y caché."
    echo "4. Finalizar el programa.${NC}"
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
        echo -e "${GREEN}Gracias por utilizar el programa.${NC}"  
        break #Sale del bucle
        ;;
    *)
        echo -e "${RED}Opción no válida, por favor elija una opción válida.${NC}"
        ;;
    esac
done
