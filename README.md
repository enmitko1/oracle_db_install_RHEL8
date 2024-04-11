# oracle_db_install_RHEL8
Scripts y guía para instalar una base de datos Oracle 19c para pruebas en un RHEL 8

Si se tiene una máquina con RHEL8 preparada saltarse el primer paso, en caso contrario seguir el paso 1 para preparar una máquina virtual en VirtualBox con RHEL8.

0. En el siguiente enlace existe una guía detallada de como preparar una máquina virtual con RHEL8:
   https://developers.redhat.com/rhel8/install-rhel8-vbox#

1. Realizada la preparación de nuestro sistema RHEL8 pasaremos a preparar el sistema para la base de datos Oracle 19c, empezando por los prerequisitos del sistema siguiendo las buenas prácticas de Oracle:
   Ejecutamos el script prereq_settings.sh existente en este repositorio:

   sh prereq_settings.sh

2. Configurar la seguridad de Linux a permisiva modifcando el fichero /etc/selinux/config editando los siguientes parámetros con los valores indicados a continuación y después debemos reiniciar el sistema para que los cambios tomen efecto:

   SELINUX=permissive
   setenforce Permissive

3. Desactivamos el firewall de Linux, en caso de querer dejarlo activo se puede configurar adecuadamente para que funcione la base de datos oracle siguiendo la guía siguiente:
   https://oracle-base.com/articles/linux/linux-firewall-firewalld

   Para desactivar el firewall hacemos:
   systemctl stop firewalld
   systemctl disable firewalld

4. Desactivamos las Hugepages transparentes, activas en RHEL8 por defecto, se debe reiniciar el sistema una vez se termine la configuración siguiente:

   Comprobamos que estén activas con el siguiente comando:
   cat /sys/kernel/mm/transparent_hugepage/enabled ## Si aparece la salida, [always] madvise never, significa que están activas y hay que desactivarlas

   Comprobaos el kernel por defecto usado en el sistema y lo copiamos para usarlo en el siguiente comando:
   grubby --default-kernel

   Modificamos los parámetros del kernel:
   grubby --args="transparent_hugepage=never" --update-kernel /boot/vmlinuz-4.18.0-513.24.1.el8_9.x86_64

   Comprobamos que la modificación tenga efecto:
   grubby --info /boot/vmlinuz-4.18.0-513.24.1.el8_9.x86_64
