#!/bin/bash
version=$1
homegoi=$2
goversion=$3 #parametro opcional.

#if [ ! $EUID -e 0 ]; then
if [ ! $(whoami) = "root" ]; then
  echo "Se requieren permisos ROOT para instalar GO"
  echo "Intenta con el comando: sudo sh instalar-go.sh"
  exit 1
fi

#verificar si existe alguna versión instalada

#si existe versión instalada pedir confirmación y eliminarla.

DIR='/usr/local'
GOROOT="${DIR}/go"
GOBIN="${GOROOT}/bin"

# Verificar si existe una versión anterior
confirm="";
if [ -d ${GOROOT} ]; then
  if [ "$goversion" = "" ]; then
    echo "Se instalará la versión: go${version}!";
    read -p "Desea eliminar la versión instalada? [SI (enter) ó NO]: " confirm;
     
  fi
  echo "confirmación: "$confirm;
  if [ "$confirm" = '' -o "$confirm" = 's' -o "$confirm" = 'si' -o "$confirm" = 'SI' -o "$confirm" = 'S' ]; then
    
    rm -fr ${GOROOT:-/usr/local/go}
  else
    echo "Actualización INTERRUMPIDA.";
    exit 2;
  fi

else
  echo "NO se encuentra versión de GO instalada!";

fi

#exit 10;

#Instalar versión indicada.
archi="${homegoi}/go${version}.linux-amd64.tar.gz";
echo "Instalando versión: go${version} desde el archivo ${archi} ...";
tar xzf ${archi} -C ${DIR};


# Configurar entorno para Golang
sh ./configurar-go.sh;

sudo -k
