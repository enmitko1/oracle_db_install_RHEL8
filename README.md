# oracle_db_install_RHEL8
Scripts y guía para instalar una base de datos Oracle 19c para pruebas en un RHEL 8

Si se tiene una máquina con RHEL8 preparada saltarse el primer paso, en caso contrario seguir el paso 1 para preparar una máquina virtual en VirtualBox con RHEL8.

0. En el siguiente enlace existe una guía detallada de como preparar una máquina virtual con RHEL8:
   https://developers.redhat.com/rhel8/install-rhel8-vbox#

DESDE AQUÍ REALIZAMOS TODOS LOS PASOS CON ROOT

1. Añadimos la entrada referente al FQDN, Fully Qualified Domain Name, del host en el archivo /etc/hosts:

   Revisamos el nombre completo del host en el /etc/hostname mediante el siguiente comando:

   cat /etc/hostname

   La ip del host la podemos revisando el comando ifconfig.

   Añadimos los datos anteriores a /etc/hosts, al final del fichero con la siguiente estructura:

   <IP-address>  <fully-qualified-machine-name>  <machine-name>

   El fichero /etc/hosts debe quedar así, por ejemplo:

   cat /etc/hosts
   
   127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
   
   ::1         localhost localhost.localdomain localhost6 localhost6.localdomain6

   192.168.1.12 rhel8.localdomain rhel8

2. Realizada la preparación de nuestro sistema RHEL8 pasaremos a preparar el sistema para la base de datos Oracle 19c, empezando por los prerequisitos del sistema siguiendo las buenas prácticas de Oracle:
   Ejecutamos el script prereq_settings.sh existente en este repositorio:

   sh prereq_settings.sh

3. Configurar la seguridad de Linux a permisiva modifcando el fichero /etc/selinux/config editando los siguientes parámetros con los valores indicados a continuación y después debemos reiniciar el sistema para que los cambios tomen efecto:

   SELINUX=permissive

   setenforce Permissive

4. Desactivamos el firewall de Linux, en caso de querer dejarlo activo se puede configurar adecuadamente para que funcione la base de datos oracle siguiendo la guía siguiente:
   https://oracle-base.com/articles/linux/linux-firewall-firewalld

   Para desactivar el firewall hacemos:

   systemctl stop firewalld

   systemctl disable firewalld

5. Desactivamos las Hugepages transparentes, activas en RHEL8 por defecto, se debe reiniciar el sistema una vez se termine la configuración siguiente:

   Comprobamos que estén activas con el siguiente comando:
   cat /sys/kernel/mm/transparent_hugepage/enabled ## Si aparece la salida, [always] madvise never, significa que están activas y hay que desactivarlas

   Comprobaos el kernel por defecto usado en el sistema y lo copiamos para usarlo en el siguiente comando:
   grubby --default-kernel

   Modificamos los parámetros del kernel:
   grubby --args="transparent_hugepage=never" --update-kernel /boot/vmlinuz-4.18.0-513.24.1.el8_9.x86_64

   Comprobamos que la modificación tenga efecto:
   grubby --info /boot/vmlinuz-4.18.0-513.24.1.el8_9.x86_64

6. Creamos los directorios necesarios para la base de datos y scripts adicionales, lanzando el script create_directories.sh disponible en el repositorio:

   sh create_directories.sh


DESDE AQUÍ REALIZAMOS TODOS LOS PASOS COMO EL USUARIO oracle

7. Creamos script para cargar las variables del sistema de nuestra futura base de datos, lanzando el script create_envvar_script.sh existente en el repositorio, este script prepara las variables para una CDB llamada cdb1 y una pdb llamada pdb1, si la contendora o la PDB se llamaran de otra forma se debe modificar el script con los nombres adecuados:

   sh create_envvar_script.sh

8. Creamos los scripts de arranque y parada de la base de datos, usamos el scripts create_start_stop_scripts.sh existente en el repositorio:

    sh create_start_stop_scripts.sh
