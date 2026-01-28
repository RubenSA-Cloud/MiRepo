Suposiciones, EC2 en public subnet (simplificación)

Crear terraform modulos:

entorno
-pro
--maint.tf
--terraform.tfvars
-pre(opcional)
--main.tf
--terraform.tfvars

modules
-ec2
--main.tf
--outputs.tf
-Secrets
--main.tf

deploy
-docker-compose.yml

.github/
-workflows/


Crear EC2 instance with Amazon Linux or Ubuntu. en el modulo ec2 main.tf, crear Security group for the instance. en main.tf si es necesario que el Docker esté funcionando cuando se arranque la instancia usar user_data para arrancar el Docker. finalmente crear la pipeline con la carpeta pipeline y ejecutarla en el docker

-- para los opcional, 
 - Store en AWS Secret manager, crear el secrets con main.tf y pipeline lee 
 - para el multiple environments con la diferenciación de los módulos, solo sería crear un nuevo entorno pre, y llamar a los modulos.