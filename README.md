# oracle_db_install_RHEL8
Scripts y guía para instalar una base de datos Oracle 19c para pruebas en un RHEL 8

Si se tiene una máquina con RHEL8 preparada saltarse el primer paso, en caso contrario seguir el paso 1 para preparar una máquina virtual en VirtualBox con RHEL8.

0. En el siguiente enlace existe una guía detallada de como preparar una máquina virtual con RHEL8:
   https://developers.redhat.com/rhel8/install-rhel8-vbox#

1. Realizada la preparación de nuestro sistema RHEL8 pasaremos a preparar el sistema para la base de datos Oracle 19c, empezando por los prerequisitos del sistema siguiendo las buenas prácticas de Oracle:
   Ejecutamos el script prereq_settings.sh existente en este repositorio:

   sh prereq_settings.sh
