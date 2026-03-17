# Mini Projet SQL

 **Auteur :** Gaspard Vuillet

## Descriptif

Le département d'éthylologie de l'université de Rennes a mené une étude approfondie dans les bars de la ville. L'objectif était de recueillir des informations détaillées sur les bières proposées. En parallèle, des sondages ont été réalisés auprès des habitants en 2026 pour évaluer leurs expériences et préférences en matière de consommation de bière. Cette base de données compile les résultats de ces recherches, offrant un aperçu précieux des habitudes de consommation et des appréciations des bières locales.


## Schema

$$ Personne (\underline{id}, nom, prenom, adresse, telephone)

\\Brasserie (\underline{id}, nom, adresse, patron)

\\Bar (\underline{id}, nom, adresse, patron)

\\Biere (\underline{id}, nom, degre )

\\Vend (\underline{bar,biere}, prix )

\\Bois (\underline{client, bar,biere}, quantite )

\\Avis (\underline{personne, bar}, note )$$

![diagrame entité association](./Untitled.png)

## Requetes
- recupration des buveurs
$\\\Pi_{nomB,prenomB}(Personne \bowtie_{Personne.id = Bois.client}Bois)$

```
SELECT DISTINCT nomB, PrenomB FROM Personne 
            JOIN bois ON bois.client = Personne.id
```
- recuperation des nom de bars avec leur note moyenne dans l'ordre décroissant
$\\\Pi_{nomB, avg(note)}(Bar \bowtie_{bar=id} Avis)$
```
SELECT nomB, avg (note) from Bar 
            join avis on bar=id 
            group by nomB 
            order by avg (note) DESC
```
- recuperation du client le plus aigris
$\\\Pi_{nomB, PrenomB}(Personne \bowtie_{personne=id} Avis)$
```
SELECT nomB, PrenomB from Personne 
            join avis on personne=id 
            group by nomB 
            order by avg (note) ASC 
            limit 1
```
- recuperation de la liste des personne qui on deja donner leur avis sur un bar ou ils ne sont jamais aller

$\\\Pi_{nomB, PrenomB}(Personne \bowtie_{client=id} Avis)\backslash (\Pi_{nomB, PrenomB}  \sigma_{Bois.bar = Avis.Bar}(Personne \bowtie_{personne=id} Avis \bowtie_{client=id} Bois))$
```
Select nomB, prenomB from Personne 
            join avis on personne =id 
EXCEPT Select nomB, prenomB from Personne
            join Avis on personne= id 
            join Bois on client = id 
            where Bois.bar = Avis.Bar
```
- recuperation des patrons de bars qui ne boivent pas 
$\\\Pi_{nomB, PrenomB}(Personne \bowtie_{personne.id =patron} Bar) \backslash (\Pi_{nomB, PrenomB}(Personne \bowtie_{client= Personne.id} Bois))$

```
Select Personne.nomB, prenomB from Personne 
            join Bar on patron =Personne.id 
EXCEPT 
Select nomB, prenomB from Personne 
            join Bois on client= Personne.id
```