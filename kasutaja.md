## sql server – kasutajate autentimine ja õiguste haldamine

[põhimõisted](README.md) | [protseduurid sql serveris](protseduur.md) | [protseduurid xamppis](xampp_protseduurid.md) | [kasutaja sql serveris](kasutaja.md) | [kasutaja xamppis](kasutaja_xampp.md) | [create kasutajad konspekt](create_kasutajad.md) | [trigerid sql serveris](triger.md) | [trigerid xamppis](triger_xampp.md) | [hotelliruum](hotelliruum.md) | [keys - kodutöö](keys.md)

mis on autentimine sql serveris?

### autentimine tähendab kasutaja tuvastamist ehk kontrollimist, kas kasutajal on õigus sql serverisse sisse logida.

## sql serveris kasutatakse kahte peamist autentimise tüüpi:

1. **windows authentication**
selle puhul kasutatakse samu kasutajaandmeid, millega logitakse sisse windows operatsioonisüsteemi.
> kasutajanimi ja parool on seotud windowsiga
> turvalisem lahendus
> paroole haldab windows
> kasutaja ei pea eraldi sql serveri parooli teadma

2. **sql server authentication**
selle puhul luuakse kasutaja otse sql serverisse.
> selle puhul luuakse kasutaja otse sql serverisse.
> kasutaja ei ole seotud windowsiga
> määratakse eraldi kasutajanimi ja parool
> sobib veebirakenduste jaoks: direktor_nastja
> näide kasutajast: director_nastja
> parool: 1234Aа
> kasutaja loomine sql serveris

---

### 1. serveritaseme kasutaja loomine (login)

**sammud**
> ava: security → logins
> tee paremklikk ja vali: new login...

<img width="2559" height="1599" alt="изображение" src="https://github.com/user-attachments/assets/075eaa48-5860-4774-9aa6-c8504bf4810c" />

> harjutamiseks võib eemaldada linnukese: user must change password at next login

**server roles**
menüüst server roles saab määrata serveri üldised õigused.
> tavaliselt piisab rollist: public

<img width="2559" height="1599" alt="изображение" src="https://github.com/user-attachments/assets/d69782d3-cb4a-46a9-b2da-52c04a08bef1" />

<img width="290" alt="изображение" src="https://github.com/user-attachments/assets/da0d2e58-c904-429d-93a8-9ff6908cc8f7" />

<img width="2559" height="1599" alt="изображение" src="https://github.com/user-attachments/assets/bfb22147-d5fa-4005-a2dc-3c92b3b07f5c" />

---

### 2. andmebaasi kasutaja loomine (user)

**sammud**
> ava: database → security → users
> tee paremklikk: new user...
> seosta kasutaja loginiga

<img width="2537" height="634" alt="изображение" src="https://github.com/user-attachments/assets/ae50b245-402d-4728-9667-2cbff45faba4" />

**membership ja õigused**
menüüst membership saab määrata kasutaja rollid.
> db_datareader → võib lugeda
> db_datawriter → võib kirjutada

<img width="755" height="314" alt="изображение" src="https://github.com/user-attachments/assets/bed0ac8c-d4f8-46aa-b650-e9cb0395873d" />

---

### sql server authentication mode muutmine

kui ilmub viga: error 18456, siis on tavaliselt lubatud ainult windows authentication.

**lahendus**
> server → properties
> security
> vali: sql server and windows authentication mode

---

### grant käsud õiguste jagamiseks

grant käsuga antakse kasutajale õigused.

käsk	tähendus
SELECT	lugemine
INSERT	lisamine
UPDATE	muutmine
DELETE	kustutamine

---

### õiguste kontroll – director_nastja

testime määratud õigusi andmebaasis samm-sammult.

**1. väljund (select)**
> kood andmete vaatamiseks:

<img width="824" height="89" alt="изображение" src="https://github.com/user-attachments/assets/cde70865-315b-47c0-979e-826e70e19809" />

> tulemus tabelis enne uute andmete lisamist:

<img width="743" height="217" alt="изображение" src="https://github.com/user-attachments/assets/3715e367-022d-410f-bddc-4f2e062ef0c6" />

---

**2. lisamine (insert)**
> kood uute andmete lisamiseks:

<img width="964" height="213" alt="изображение" src="https://github.com/user-attachments/assets/8952da14-b95b-44ff-8965-29676c18530d" />

> käsu edukas täitmine ja tulemus tabelis, kuhu ilmus kass bebe:

<img width="552" height="220" alt="изображение" src="https://github.com/user-attachments/assets/08f8b72a-efe5-452e-a35d-937dab460ffb" />

---

**3. kustutamine (delete)**
> kood kustutamise testimiseks:

<img width="639" height="105" alt="изображение" src="https://github.com/user-attachments/assets/b646049b-f0c4-4af3-b1a8-7833d70378be" />

> kuna kasutajal on delete keelatud (deny), siis süsteem kuvab tõrke ja andmeid kustutada ei luba.

<img width="1022" height="134" alt="изображение" src="https://github.com/user-attachments/assets/6fc2c32e-a460-454f-aa93-9590ff31a6e3" />

---

**4. uue tabeli loomise katse (create table)**
> kood uue tabeli loomiseks:

<img width="579" height="99" alt="изображение" src="https://github.com/user-attachments/assets/49b8438a-eaeb-4f7d-b89f-562524ad48aa" />

> käsu täitmise tulemus ja teade süsteemilt, et tabelite loomine on keelatud:

<img width="795" height="141" alt="изображение" src="https://github.com/user-attachments/assets/db48e315-8f5f-4f09-b2bc-1360c99fd6e5" />

---

**5. andmete uuendamine (update)**
> kood vanuse muutmiseks:

<img width="670" height="103" alt="изображение" src="https://github.com/user-attachments/assets/863c7187-e804-492e-9104-3a7042990a70" />

--- 

**6. kasutaja isiklike õiguste kontroll (fn_my_permissions)**
> kood määratud õiguste nimekirja vaatamiseks tabeli loomad kohta:

<img width="861" height="98" alt="изображение" src="https://github.com/user-attachments/assets/76a1da5f-c517-412c-81cd-16552b33753c" />

> selle käsu abil saab iga kasutaja ise kontrollida, millised õigused talle antud tabelis täpselt kuuluvad.

<img width="608" height="261" alt="изображение" src="https://github.com/user-attachments/assets/d14ccd63-1ecb-4374-864f-7949254a2550" />
