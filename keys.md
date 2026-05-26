## andmebaasi võtmed (keys) – it-firma struktuuri näitel

### primary key (primaarvõti)
> **definitsioon:** väli või väljade kombinatsioon, mis peavad olema unikaalsed iga rea jaoks ja mis indekseeritakse, et tagada rea kiire otsing võtme väärtuse järgi; see ei tohi sisaldada null-väärtusi ning tabelil saab olla ainult üks primaarvõti. tavaliselt indekseeritakse see klasterdatud indeksiga, mis tähendab, et andmed tabelis järjestatakse ümber vastavalt indeksi järjekorrale, mis parandab oluliselt andmete jadaotsingut.
> 
> **milleks kasutatakse:** andmete unikaalsuse tagamiseks, ridade kiireks otsimiseks võtme väärtuse järgi ja andmete füüsiliseks ümberjärjestamiseks vastavalt indeksi järjekorrale, mis parandab oluliselt andmete jadaotsingut.
> 
> **erinevus teistest:** erineb teistest unikaalsetest võtmetest selle poolest, et tabelis saab olla ainult üks primary key, see ei tohi sisaldada null-väärtusi ning see indekseeritakse tavaliselt klasterdatud indeksiga.
```sql
create table employees (
    employee_id int primary key identity(1,1),
    first_name varchar(30) not null,
    last_name varchar(30) not null
);
```
> koodi käivitamise tulemus ja tabeli employees struktuur primary key-ga:

<img width="698" height="353" alt="изображение" src="https://github.com/user-attachments/assets/8f4717ab-5d67-4554-aa5a-bea76cb80944" />


---

### foreign key (välisvõti)
> definitsioon: välisvõti on veerg ühes tabelis, mis peab üheselt tuvastama midagi teises tabelis. seega peavad väärtused vastama selle teise tabeli primaarvõtmetele.
 
> milleks kasutatakse: viidete terviklikkuse hoidmiseks, mis tähendab, et kõik teie välisvõtmed vastavad tegelikult nende sihttabelite primaarvõtmetele. näiteks kõik üliõpilaste ja kursuste id-d teie registreerimistabelis vastavad tegelikele üliõpilaste ja kursuste id-dele.
 
> erinevus teistest: erinevalt primaarvõtmest, mis eksisteerib tabeli kohta ühes eksemplaris, sisaldab iga kirje kursustel osalevate üliõpilaste tabeli näites korraga mitut välisvõtit – üliõpilase id-d ja kursuse id-d, mis toimivad välisvõtmetena üliõpilaste tabelile ja kursuste tabelile.
```sql
create table assets (
    asset_id int primary key identity(1,1),
    asset_tag varchar(15) not null,
    employee_id int,
    foreign key (employee_id) references employees(employee_id)
);
```
> koodi käivitamise tulemus ja tabeli assets struktuur välisvõtmega:

<img width="724" height="362" alt="изображение" src="https://github.com/user-attachments/assets/2eb31a3a-b739-4835-8793-151207ed6fba" />

---

### unique key (unikaalne võti)
> **definitsioon:** sarnaneb primaarvõtmega, kuid mõnel andmebaasi platvormil võib see sisaldada null-väärtusi, kui need ei riku unikaalsuse piirangut. teisisõnu, kui unikaalne võti koosneb ühest veerust, saab tabelis olla ainult üks rida, mille selle veeru väärtus on null; kui võti koosneb rohkem kui ühest veerust, saab tabel sisaldada ainult ridu, mille nende veergude väärtused on null, nii et ei teki null-väärtuste mitteunikaalset dubleerimist võtme veergude lõikes. teistel platvormidel, sealhulgas mysql-is, võivad unikaalsuse piirangud sisaldada mitut null-väärtust; unikaalsuse piirang rakendub ainult null-väärtustest erinevatele väärtustele veergudes, millele see viitab.
>
> **milleks kasutatakse:** unikaalsuse piirangu rakendamiseks null-väärtustest erinevatele väärtustele veergudes, millele see viitab, tagades väärtuste mitteunikaalse dubleerimise puudumise võtme veergude lõikes.
>
> **erinevus teistest:** tabelis võib olla rohkem kui üks selline väärtus. indekseeritakse mitteklasterdatud indeksis.


```sql
create table servers (
    server_id int primary key identity(1,1),
    server_name varchar(30) not null,
    ip_address varchar(15) unique not null
);
```
> koodi käivitamise tulemus ja tabeli servers struktuur unique key-ga:

<img width="700" height="357" alt="изображение" src="https://github.com/user-attachments/assets/f27bb72d-5701-4ada-9487-aafa472174fe" />

---

### simple key (lihtvõti)
> **definitsioon:** võti, mis koosneb ainult ühest ainukesest veerust.
> 
> **milleks kasutatakse:** andmete unikaalsuse tagamiseks lihtsates tabelites, kus rea tuvastamiseks piisab ühest id-väljast.
> 
> **erinevus teistest:** erineb liitvõtmetest (composite, compound), kuna selle loomiseks ei kombineerita kunagi mitut veergu kokku.

```sql
create table repositories (
    repo_id int primary key identity(1,1),
    repo_name varchar(50) not null
);
```
> koodi käivitamise tulemus ja tabeli repositories struktuur, kus repo_id on simple key:

<img width="589" height="349" alt="изображение" src="https://github.com/user-attachments/assets/850946ae-b10f-412b-9da0-cddf2b01b52d" />

---

### composite key (liitvõti)
> **definitsioon:** võti, mis koosneb kahest või enamast veerust, et tagada rea unikaalsus kogu tabeli ulatuses.
> 
> **milleks kasutatakse:** olukordades, kus üksikud veerud võivad korduda, kuid niiden kombinatsioon peab olema rangelt kordumatu.
> 
> **erinevus teistest:** koosneb mitmest väljast, erinevalt simple key-st. selle osadeks võivad olla ka tavalised andmeväljad, mitte ainult viited teistele tabelitele.

```sql
create table office_attendance (
    work_date date,
    badge_number varchar(10),
    office_floor int,
    primary key (work_date, badge_number)
);
```
> koodi käivitamise tulemus ja tabeli office_attendance struktuur composite key-ga:

<img width="605" height="443" alt="изображение" src="https://github.com/user-attachments/assets/f142bc48-584e-4c73-83f8-c07d6ccfd57c" />

---

### compound key (koosandmevõti)
> **definitsioon:** liitvõtme spetsiifiline alaliik, mis koosneb mitmest veerust, kusjuures kõik need veerud on samaaegselt ka foreign key-d teistest tabelitest.
> 
> **milleks kasutatakse:** vahetabelite loomiseks ja unikaalsuse hoidmiseks mitu-mitmele seoste puhul.
> 
> **erinevus teistest:** erineb tavalisest composite key-st selle poolest, et kõik võtme koostisosad on kohustuslikult iseseisvad välisvõtmed.

```sql
create table repo_access (
    employee_id int,
    repo_id int,
    primary key (employee_id, repo_id),
    foreign key (employee_id) references employees(employee_id),
    foreign key (repo_id) references repositories(repo_id)
);
```
> koodi käivitamise tulemus ja tabeli repo_access struktuur compound key-ga:

<img width="623" height="419" alt="изображение" src="https://github.com/user-attachments/assets/c37c18c3-41bf-4954-8d76-c48ab945ea7b" />

---

### superkey (supervõti)
> **definitsioon:** mis tahes veergude kogum, mille abil saab rea tabelis unikaalselt tuvastada. see võib sisaldada ka liigseid andmeveerge.
> 
> **milleks kasutatakse:** andmebaasi loogiliseks analüüsiks ja minimaalsete unikaalsete kombinatsioonide otsimiseks.
> 
> **erinevus teistest:** see on kõige laiem võtme mõiste. iga esmane võti on ühtlasi supervõti, kuid mitte iga supervõti pole esmane võti, kuna supervõti võib sisaldada üleliigset infot.

```sql
create table hardware_inventory (
    item_id int primary key identity(1,1),
    serial_number varchar(50) unique not null,
    item_type varchar(20) not null
);
```
> koodi käivitamise tulemus ja tabeli hardware_inventory andmed supervõtme selgituseks:

<img width="747" height="427" alt="изображение" src="https://github.com/user-attachments/assets/82ac5e53-39fb-4962-8975-7a896fbbdc99" />

---

### candidate key (kandidaatvõti)
> **definitsioon:** minimaalne võimalik supervõti, mis suudab rida unikaalselt tuvastada ilma ühegi üleliigse veeruta.
> 
> **milleks kasutatakse:** nendest unikaalsetest väljadest valib andmebaasi projekteerija välja ühe, millest saab tabeli ametlik primary key.
> 
> **erinevus teistest:** erineb supervõtmest selle poolest, et sellest ei saa eemaldada mitte ühtegi veergu, ilma et unikaalsus kaoks. tabelis võib olla mitu kandidaati.

```sql
create table system_licenses (
    license_id int primary key identity(1,1),
    license_key varchar(50) unique not null,
    software_name varchar(30) not null
);
```
> koodi käivitamise tulemus ja tabeli system_licenses kandidaatvõtmed:

<img width="704" height="428" alt="изображение" src="https://github.com/user-attachments/assets/f4d859e0-ac97-466d-99a4-230ce0c6e16e" />

---

### alternate key (alternatiivne võti)
> **definitsioon:** kandidaatvõti, mida ei valitud tabeli peamiseks võtmeks (primary key).
> 
> **milleks kasutatakse:** täiendavaks andmete kontrolliks ja unikaalsuse tagamiseks tabelis.
> 
> **erinevus teistest:** see on n-ö "varuvõti". kuna eelnevas tabelis valiti peamiseks võtmeks license_id, siis teine unikaalne väli (license_key) sai alternatiivseks võtmeks.

```sql
create table digital_certificates (
    cert_id int primary key identity(1,1),
    thumbprint_code varchar(40) unique not null,
    owner_name varchar(50) not null
);
```
> koodi käivitamise tulemus ja tabeli digital_certificates struktuur alternate key esiletoomisega:

<img width="688" height="421" alt="изображение" src="https://github.com/user-attachments/assets/b5c1dbf5-b41a-4e91-aaf2-6427b06b2070" />

---

### kasutatud allikad
* https://stackoverflow.com/questions/2008260/understanding-keys-in-databases
* https://stackoverflow.com/questions/655446/what-is-a-simple-example-to-explain-what-a-foreign-key-is
