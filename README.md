[![Twitter URL](https://img.shields.io/twitter/url/https/twitter.com/fold_left.svg?style=social&label=Follow%20%40L69Eric)](https://twitter.com/L69Eric)

Formation DOCKER Linux
========
Récapitulatif essentiel de se qu'il faut retenir de la formation *Docker, prise en main des conteneurs (Réf. 4TY)* en E-Learning<br>

Les URL a retenir sont :<br>
<a href="https://hub.docker.com/" target="_blank">Le hub de Docker</a><br>
<a href="https://id.docker.com/login" target="_blank">Se connecter au Docker Hub</a><br>
<a href="https://docs.docker.com/docker-hub/" target="_blank">La documentation de Docker Hub</a><br>
<a href="https://docs.docker.com/get-started/overview/" target="_blank">Le guide de Docker Hub</a><br>

Dans la formation, il est conseillé de réaliser l'installation à partir du script suivant, quelque soit le *Linux* utilisé :<br>
<a href="https://get.docker.com/" target="_blank">**Script *Linux* d'installation*</a>

Je dispose de différents dépôts sur le hub Docker, personnel et professionnel afin de me permettre de créer et d'éditer des conteneurs pour mes différents projets.<br>

Récapitulatif de la formation
------------

<a href="https://www.docker.com/" target="_blank">Docker</a>

Toutes les commandes ont pour but de se rappeler les situations évoquées lors de cette formation vidéo car il n'y a pas de support texte.
Donc l'idée est de rédiger un listing des commandes utilisée dans cette formation.

### Installer Docker
-------------
Il faut passer par le script sh : <br>
<a href="https://get.docker.com/" target="_blank">*Script *Linux* d'installation*</a>

*Recommandation du formateur pour toute installation sur un système Linux*

Créer un scrit sh, par `vi install_docker.sh` et copier/coller le contenu du script web<br>
Puis une fois sauvegarder il faut exécuter le script avec `./install_docker.sh`<br>
Une fois installer, vérifier sa version :<br>
```
docker version
```

### Utilisation de Docker
-------------
On commence par lancer Hello-world comme sur tous les systèmes :<br>
```
docker run hello-world
```
Mais en général, lors de la récupération d'un image il faut un **repository** et un **tag** 

Pour un exemple normal ici avec Mapstore2<br>
Chargement (Pull) de la dernière image Docker à partir du Hub :<br>
```
docker pull geosolutionsit/mapstore2
docker run --name mapstore -p8080:8080  geosolutionsit/mapstore2
```
**repository** : geosolutionit<br>
**tag** : latest<br>

La commande aurait du être donc :
```
docker run library/hello-world:latest
```

Avec docker on récupère une imgage avec laquelle on peut créer des containers avec des ressources volumes différentes tout cela à partir de la même image
Donc l'idée est de découper ses ressources applicatifs par exemple une image tomcat qui est utilisée dans X container c'est le principe.

Observons de dépôt officiel de hello-world :<br>
<a href="https://hub.docker.com/_/hello-world" target="_blank">hello-world</a><br>

Ce qui est important c'est le dockerfile qui défini ce qui est réalisé dans l'image indépendante de l'OS
ici on a pas besoin d'OS car le code hello est fait en assembleur *hello.asm* ey aujourd'hui il est en langage C *hello.c*

```
FROM scratch
COPY hello /
CMD ["/hello"]
```

### Différentes commandes Docker
-------------
Lister les images docker disponible sur son OS :<br>
```
docker images
```

Démarrage d'une image avec des paramètres :<br>
```
docker run -i -t ubuntu /bin/bash
```
**-i** : mode interactif<br>
**-t** : on demande une console text pour renvoyer les résultats<br>
 
Ici docker lance un contaiuner auquel il attribut un code hexxadecimal et un nom du container par défaut<br>
Il se connecte au container ubuntu pour sortir il faut taper `exit`<br>

>Voir tous les conteneurs actifs :
```
docker ps
```
Voir tous les conteneurs arrêtés:
```
docker ps -a
```
Suppression d'un container :
```
docker rm -fv hello-world
```
Ou en passant par le code Hexadecimal
```
docker rm -fv 22fdb
```
***f** : forcer l'arrêt du container avant sa suppression<br>
**v** : supprime les volumes associés aux conteneurs mais aussi ce quia été fait sur le système fichier<br>

Lancement d'un container :
```
docker run -it --name test ubuntu
```
*plus besoin de /bin/bash car c'est son comportement mais là le conteneur s'appelle test*<br>
donc le bash est lancé et on peut démarrer des modification sans changer l'image.<br>
>Lister les container et là le container s'appelle *test*<br>
```
docker ps -a
```
On peut opbserver les différences avec l'image en tapant :<br>
```
docker diff test
```
Tous les chgangements sont listés en étant préfixés avec :<br>
**C** : pour CHANGE<br>
**A** : pour ADD ou APPEND<br>
**D** : pour DELETE<br>

Garder un container et en créer une image :<br>
```
docker commit test ubuntumodif:1.0
```
Là les modifications sont sauvegardées <br>
on peut voir la nouvelle image en faisant `docker images` à nouveau<br>
Désormais on peut lancer autant d'instance de cet nouvelle image.<br>
<br>
Montre toutes les identifiant des conteneur : <br>
```
docker ps -aq
```
<br>

### Différentes commandes Docker avec interaction sur le container
-------------
Créer un container et qui va utiliser la redirection des volumes vers le système de fichier local. On démarre une image de type Web. <br>
Exemple avec NGINX :
```
docker run -d --name web -v /home/jpg/web:/usr/share/html:ro -p 88:80 nginx
```
**-d** : Le container va avoir sont propre cycle de vie<br>
**-name** : crée le nom du container<br>
**-v** : paramètre pour le volume<br>
**-p** : paramètre pour les ports, 80 port container et 88 port le local<br>
**/home/jpg/web** : dossier local<br>
**/usr/share/html** : volume du container qui va pointer sur le dossier local<br>
**ro** : création d'une étanchéïté du conteneur en passant des droits ro comme readonly<br>
**nginx** : va chercher sur le hub la dernière version de nginx<br>

Pour supprimer ce container mais conserver le volume local :<br>
```
docker rm -f web
```
Ou<br>
```
docker stop web
docker rm web
```
<br>
Autre exemple, avec un container de base de données avec un stockage dans le container :<br>

```
docker run -d --name bd -p 27017:27017 mongo:3.0.3
```

**-d** : Le container va avoir sont propre cycle de vie<br>
**-name** : crée le nom du container<br>
**-p** : paramètre pour les ports, 27017 port container et 27017 port le local<br>
**mongo:3.0.3** : image mongo version 3.0.3 du hub docker<br>
<br>
Là on observe que si on supprime ou migre on aura pas accès à la base puisque elle est embarqué dan sle container.<br>
Une bonne pratique est de dédier un espace dans le système de fichier local.<br>
Ainsi on aura créé une persistence de la donnée qui par la suite peut être archiver et sauvegardé.<br>
Autre commandes : <br>
```
docker run -d --name bd -p 27017:27017 -v /home/jpg/data:/data/db  mongo:3.0.3 
```

**-d** : Le container va avoir sont propre cycle de vie<br>
**-name** : crée le nom du container<br>
**-p** : paramètre pour les ports, 80 port container et 88 port le local<br>
**-v** : paramètre pour le volume<br>
**/home/jpg/data** : dossier local<br>
**/data/db** : volume du container qui va pointer sur le dossier local<br>
**mongo:3.0.3** : image mongo version 3.0.3 du hub docker<br>

Voir ce qui se passe dans le container bd :<br>
```
docker inspect bd
```
<br>

Voir le log de la base :<br> 
```
docker logs bd
```
<br>

### Utilisation de Docker Hub
-------------

Lister les commande Docker :<br>
```
docker
```

La commande Docker *search* :<br>
```
docker search --help
```

Example avec *mongo*, ici on cherche une image avec minimu 100 stars (étoile):
```
docker search -s 100 mongo
```

<br>

### Le fichier DockerFile
Il faut vérifier les image en cascade et s'assurer que l'image vient d'une source fiable.<br>
au FROM du dockerfile :
Il faut aller vérifier sur github le code source pour contrôler qu'il n'y a pas de problème.<br>
On a 3 niveaux de sécurité :<br>
1. Premier niveau on est partie d'une image de base officielle.<br>
2. On a été à l'intérieur du code source pour vérifier qu'il n'y pas de code malveillant ou de porte dérobée.<br>
3. C'est bien docker hub qui a fait le build donc docker hub garantie que l'image est bien le reflet compilé de code source et du dockerfile (AUTOMATED BUILD)<br>
<br><br>

### Manipulation et création d'images Docker
-------------
Cette partie traite de la création de ses propres images.<br>
### Le fichier DockerFile

Nous souhaitons qu'un scipt bash heartbeat.sh `./heartbeat.sh` s'exécute automatiquement dans un système.<br>

Redaction du Dockerfile : <br>
```
MAINTAINER Ric69 "spaaro69@yahoo.fr" <n'existe plus>
LABEL maintainer="spaaro69@yahoo.fr"

COPY heartbeat.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV HEARBEATSTEP 2
ENTRYPOINT ["/entrypoint.sh"]
CMD ["heartbeat"]

```

Vérifier si on a pas d'image heartbeat :<br>
```
docker images | grep heart
```

Pour voir toutes les images :<br>
```
docker images -a
```

Création du build de l'image avec heartbeat :<br>
```
docker build -t dockofhome2019/heartbeat:1.0 .
```

Suppression l'image avec heartbeat :<br>
```
docker rmi -f dockofhome2019/heartbeat:1.0
```


### Utilisation du système de couche

Dans la création de DOckerfile pour créer ses images il faut faire un enchainement des commandes dans le RUN <br>
En les chainant avec `&&` <br>
Du coup l'image aura la taille seulement de la fin de la commande RUN c'est une gestion du cache beaucoup plus fine<br>
Toujours utiliser les même images de base. Et se fixer sur une images de base c'est une bonne pratique.<br>
<br>

**Attention différence entre l'ID et TAG** <br> 
L'ID d'une image est le seul identifiant de l'image et garantie unicité d'une image, il est unique
Le TAG est une façon d'appeler une image par un nom ou plusieurs noms pouvant définir une image, il peut être multiple<br>

<br><br>
Les images sont stockées au chemin suivant avec Docker desktop Windows :<br>
C:\Users\Public\Documents\Hyper-V\Virtual hard disks<br>




<br><br>
Reférence
-------------
@Edition 2021
