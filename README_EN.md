Scripts and guide for installing and creating an Oracle 19c database for testing purposes in a RHEL 8

If there is a host with RHEL8 ready to be used this step can be omitted, otherwise follow the step 0 to prepare a virtual machine in VirtualBox with RHEL8.

0. In the next link there is a detailed guide on how to prepare a virtual machine with RHEL8: https://developers.redhat.com/rhel8/install-rhel8-vbox#

FROM HERE THE NMEXT STEPS HAVE TO BE DONE AS THE ROOT USER

1. Add the entry referencing the FQDN, Fully Qualified Domain Name, of the host in the file /etc/hosts:

We can inspect the full name of the host in the file /etc/hostname using the next command:

cat /etc/hostname

The ip of the host can be seen using the command ifconfig.

We add this data to /etc/hosts, both the ip and the full name of the machine as one entrance at the end of the file following the next structure:

The file /etc/hosts has to end up like this, for example:

cat /etc/hosts

127.0.0.1 localhost localhost.localdomain localhost4 localhost4.localdomain4

::1 localhost localhost.localdomain localhost6 localhost6.localdomain6

192.168.1.12 rhel8.localdomain rhel8

2. Now we start preparing our system for the Oracle 19c database, starting with the prerequisites for the system following the Oracle good practices recommendations: Run the script prereq_settings.sh existing in the repository:

sh prereq_settings.sh

3. Change the Linux security settings to permissive modifying the file /etc/selinux/config editing the next parameter with the value indicated, afterwards it's necessary to reboot the system for the changes to be effective:

SELINUX=permissive

4. Disable the Linux firewall , otherwise if it's necessary to let it active it can be configured correctly for the Oracle database to work following the guide present at the web: https://oracle-base.com/articles/linux/linux-firewall-firewalld

To disable the firewall run:

systemctl stop firewalld

systemctl disable firewalld

5. Disable the transparent hugepages, active in RHEL8 by default, the system has to be rebooted once the hugepages configuration has been changed:

Verify the trasparent hugepages are active running the next command: cat /sys/kernel/mm/transparent_hugepage/enabled ## if the output is, [always] madvise never, it means that the trasparent hugepages are active and they have to be disabled

Comprobaos el kernel por defecto usado en el sistema y lo copiamos para usarlo en el siguiente comando: grubby --default-kernel

Modificamos los parámetros del kernel: grubby --args="transparent_hugepage=never" --update-kernel /boot/vmlinuz-4.18.0-513.24.1.el8_9.x86_64

Comprobamos que la modificación tenga efecto: grubby --info /boot/vmlinuz-4.18.0-513.24.1.el8_9.x86_64

6. Creamos los directorios necesarios para la base de datos y scripts adicionales, lanzando el script create_directories.sh disponible en el repositorio:

sh create_directories.sh

DESDE AQUÍ REALIZAMOS TODOS LOS PASOS COMO EL USUARIO oracle

7. Creamos script para cargar las variables del sistema de nuestra futura base de datos, lanzando el script create_envvar_script.sh existente en el repositorio, este script prepara las variables para una CDB llamada cdb1 y una pdb llamada pdb1, si la contendora o la PDB se llamaran de otra forma se debe modificar el script con los nombres adecuados:

sh create_envvar_script.sh

Debemos lanzar el fichero de variables cargado para cargar las variables antes de continuar o reiniciar la sesión o el host para que se carguen automáticamente.

8. Creamos los scripts de arranque y parada de la base de datos, usamos el scripts create_start_stop_scripts.sh existente en el repositorio:

sh create_start_stop_scripts.sh

COMENZAMOS CON LA INSTALACIÓN DEL SOFTWARE:

En este punto debemos tener en el host el zip conteniendo el software Oracle 19c

9. Lanzamos la instalación del software Oracle 19c con el script install_software_ora19c.sh:

Este script toma como ruta donde está almacenado el zip del software Oracle en la carpeta donde se descargo el repositorio del Github, si el zip está en otra ruta se debe modificar el script con la ruta correcta

sh install_software_ora19c.sh

10. Creamos la base de datos Oracle 19c Multitenant usando el script create_database.sh existente en el repositorio:

El script creará una contenedora y una PDB con los mismos nombres definidos en el script de variables.

Lanzamos la creación con:

sh create_database.sh

11. Editamos el fichero /etc/oratab para poner la entrada de la base de datos a Y para permitir el arranque automática al iniciar la máquina:

Un ejemplo de entrada de una CDB sería:

cdb1:/u01/app/oracle/product/19.0.0/dbhome_1:Y

CON ESTO HEMOS FINALIZADO LA CREACIÓN DE UNA BASE DE DATOS ORACLE 19C EN UN RHEL8


BIBLIOGRAFÍA:

Este repositorio está hecho mayormente gracias a la guía de la WEB oracle-base.com. La URL de la guía completa y detallada es la siguiente:

https://oracle-base.com/articles/19c/oracle-db-19c-installation-on-oracle-linux-8
