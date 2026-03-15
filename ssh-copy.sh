#!/bin/bash
# Script para copiar claves SSH a múltiples hosts listados en un archivo.
#
# Uso: ./ssh-copy.sh /ruta/a/clave.pub
# Requiere:
#   - Un archivo `hosts` en el directorio actual (una IP por línea, sin espacios).
#   - La clave pública SSH en el primer argumento.
#
# Autor: Pablo Martín Anaquín (@anaquinpm)
# Fecha: 13-03-2026

# Configuración
USER_NAME="${USER:-$(id -un)}"  # Usuario actual, con fallback
HOST_FILE="$PWD/hosts"
ERROR_FILE="/tmp/ssh-copy_error.txt.$(date +%s.%N)"
PUBLIC_KEY_FILE="$1"

# Validación de argumentos
if [ $# -ne 1 ]; then
    echo "Error: Se requiere exactamente un argumento (ruta a la clave pública)."
    echo "Uso: $0 /ruta/a/clave.pub"
    exit 1
fi

if [ ! -f "$PUBLIC_KEY_FILE" ]; then
    echo "Error: El archivo de clave pública '$PUBLIC_KEY_FILE' no existe."
    exit 2
fi

if [ ! -f "$HOST_FILE" ]; then
    echo "Error: El archivo de hosts '$HOST_FILE' no existe."
    exit 3
fi

# Verificar que el archivo de clave pública sea legible
if [ ! -r "$PUBLIC_KEY_FILE" ]; then
    echo "Error: No se puede leer el archivo de clave pública '$PUBLIC_KEY_FILE'."
    exit 4
fi

# Limpiar archivos temporales al salir (incluso en errores)
trap 'rm -f "$ERROR_FILE"' EXIT
# Leer hosts (ignorar líneas vacías y comentarios)
mapfile -t HOSTS < <(grep -vE '^\s*#|^$' "$HOST_FILE" | tr -d '\r')

for IP in "${HOSTS[@]}"; do
    [ -z "$IP" ] && continue
    echo "Copiando clave a $USER_NAME@$IP..."
    ssh-copy-id -i "$PUBLIC_KEY_FILE" -o StrictHostKeyChecking=no "$USER_NAME@$IP" 2>"$ERROR_FILE"
    RESULT=$?
    if [ $RESULT -eq 0 ]; then
        echo "✅ Clave copiada exitosamente a $IP"
    else
        echo "❌ Error al copiar clave a $IP:"
        if [ -s "$ERROR_FILE" ]; then
            cat "$ERROR_FILE"
        else
            echo "Error desconocido (verifique conexión o permisos)."
        fi
    fi
    echo ""
done

echo "✅ Proceso completado. Revisar resultados anteriores."
exit 0