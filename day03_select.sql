/*==================================SELECT-WHERE=============================================
Verileri SELECT komutu ile veritabanindan cekerken filtreleme yapmak icin : 
 
SELECT ile birlikte WHERE komutu kullanilabilir.
-----Syntax----- :
SELECT field1, field2 
FROM tablo_adi 
WHERE kosul;
-- SELECT -- hangi sutunlari(field) getirsin
-- FROM -- hangi tablodan(table) getirsin
-- WHERE -- hangi satirlari(record) getirsin
=========================================================================================*/

CREATE TABLE meslek_lisesi (
okul_no CHAR(4) UNIQUE,
isim VARCHAR(50) NOT NULL,
derece DOUBLE,
adres VARCHAR(100),
son_degisiklik_tarihi DATE
);
SELECT * FROM meslek_lisesi;
INSERT INTO meslek_lisesi VALUES('101','Matti Tag', 89,'Stuttgart', '2020-11-23');      
INSERT INTO meslek_lisesi VALUES('102','Rico Leo', 94,'Munchen', '2020-11-23');
INSERT INTO meslek_lisesi VALUES('103','Thomas Gun', 78,'Berlin', '2020-11-23');
INSERT INTO meslek_lisesi VALUES('104','Stefan Ulf', 69,'Stuttgart', '2020-11-23');
INSERT INTO meslek_lisesi VALUES('105','Ulf Leo', 90,'Munchen', '2020-11-23');
INSERT INTO meslek_lisesi VALUES('106','Marcus Gun ', 85,'Istanbul', '2020-11-23');
INSERT INTO meslek_lisesi VALUES('107','Leo Tah', 75,'Stuttgart', '2020-11-23');
INSERT INTO meslek_lisesi VALUES('108','Adrian Ulf', 79,'Berlin', '2020-11-23');
INSERT INTO meslek_lisesi VALUES('109','MAtti Gen', 80,'Berlin', '2020-11-23');

-- Frage 1 : Derecesi 80'dan yuksek olan ogrencilerin tum bilgilerini getirin.

select*from meslek_lisesi where(derece>80);

-- Frage 2: Derecesi 90'dan yuksek olan ogrencilerin tum bilgilerini getirin.

select isim from meslek_lisesi where derece<80;

-- Frage 3: Adresi Istanbul olan ogrencilerin isim ve derece bilgilerini listeleyin.

select isim, derece from meslek_lisesi where adres='Istanbul';

-- Frage 4: okul_no'su 1005 olan ogrencinin isim ve adres bilgisini listeleyin.

select isim, adres from meslek_lisesi where okul_no=1005;

-- Frage 5: Derecesi 70 ile 80 arasinda olan ogrencilerin okul_no ve adreslerini listeleyin.

select okul_no, adres from meslek_lisesi where derece>70 and derece<80;

-- *************************************************************************
CREATE TABLE ogretmen_lisesi(
id int,
isim VARCHAR(45),
adres VARCHAR(100),
sinav_notu DOUBLE
);
INSERT INTO ogretmen_lisesi VALUES (111, 'Adam Alexander', 'Stuttgart', 75);
INSERT INTO ogretmen_lisesi VALUES (112, 'Arnd Julian', 'Berlin', 85);
INSERT INTO ogretmen_lisesi VALUES (113, 'Christian Samuel', 'Stuttgart', 70);
INSERT INTO ogretmen_lisesi VALUES (114, 'Brun Timo', 'Berlin', 90);
INSERT INTO ogretmen_lisesi VALUES (115, 'Frido Alina', 'Stuttgart',70);
INSERT INTO ogretmen_lisesi VALUES (116, 'Henrik Bea', 'Istanbul', 85);
INSERT INTO ogretmen_lisesi VALUES (117, 'Justus Daniela', 'Istanbul', 85);
SELECT * FROM ogretmen_lisesi;

/*-------------------------------------------------------------------------
Frage 1: Sinav notu 80'den buyuk olan ogrencilerin tum bilgilerini listeleyin.
---------------------------------------------------------------------------*/

select*from ogretmen_lisesi where sinav_notu>80;

/*-------------------------------------------------------------------------
Frage 2: Adresi Istanbul olan ogrencilerin isim ve adres bilgilerini listeleyin.
---------------------------------------------------------------------------*/


select isim, adres from ogretmen_lisesi where adres='Istanbul';

/*-------------------------------------------------------------------------
Frage 3: id'si 114 olan ogrencilerin tum bilgilerini listeleyin.
---------------------------------------------------------------------------*/

select*from gymnasium where id=114;

/*================================== SELECT-BETWEEN =============================================
BETWEEN iki mantiksal ifade ile tanimlayabilecegimiz durumlari tek komutla 
yazabilme imkani verir, yazdigimiz iki sinir da araliga dahildir!!!
-----Syntax-----
SELECT field1,field2,...
FROM table_name
WHERE field_name 
BETWEEN deger1 AND deger2;
-----Syntax-----
SELECT field1,field2,...
FROM table_name
WHERE field_name 
BETWEEN deger1 OR deger2;
=========================================================================================*/


/*==========================AND (ve) Operatoru kullanimi==================================
=> And ile belirtilen sartlarin tamami gerceklesiyorsa o kayit listelenir,
Sartlardan bir tanesi bile tutmazsa listelenmez.
SELECT * FROM matematik WHERE sinav1 < 50 AND sinav2 < 50
Bu ornekte hem sinav1 hem de sinav2 field'i 50'den kucuk olan kayitlar listelenecektir.



/*==========================OR (veya) Operatoru kullanimi==================================
=> Or ile belirtilen sartlardan en az biri gerceklesiyorsa o kayit listelenir,
sartlardan hicbiri gerceklesmiyorsa o kayit listelenmez.
SELECT * FROM matematik WHERE sinav1 < 50 OR sinav2 < 50
Bu ornekte sinav1 veya sinav2 field'i 50'den kucuk olan kayitlar listelenecektir.
=========================================================================================*/

/*-------------------------------------------------------------------------
Q4: Sinav notu 70'ten buyuk 80'den kucuk olan ogrencilerin tum bilgilerini listeleyin.
---------------------------------------------------------------------------*/
-- 1. Yol

select *from gymnasium where sinav_notu>70 AND sinav_notu<80;

-- 2. Yol

select*from gymnasium where sinav_notu between 70 and 80 ;

/*-------------------------------------------------------------------------
Q5: Adam Alexander ve Murat arasinda olan ogrencilerin isimlerini listeleyin.
---------------------------------------------------------------------------*/

select*from gymnasium where isim between 'Adam' and 'Frido' ;

-- NOT : String ifadeleri BETWEEN komutu ile kiyaslamak istedigimizde bize
-- sonucu ASCII degerlerine gore siralayarak gonderir.
/*-------------------------------------------------------------------------
Q6: Istanbul ile Berlin arasinda olan ogrencilerin isimlerini listeleyin.
---------------------------------------------------------------------------*/

select isim from gymnasium where adres between 'Istanbul' and 'Berlin';


-- **************************************************************
CREATE TABLE personel(
id char(5),
isim varchar(50),
maas int
);

INSERT INTO personel VALUES('10001','Ahmet Aslan',7000);
INSERT INTO personel VALUES('10002','Mehmet Yilmaz',12000);
INSERT INTO personel VALUES('10003','Meryem',7215);
INSERT INTO personel VALUES('10004','Veli Han',5000);
INSERT INTO personel VALUES('10005','Mustafa Ali',5500);
INSERT INTO personel VALUES('10006','Ayse Can',5600);
INSERT INTO personel VALUES('10010','Ayse',4700);
INSERT INTO personel VALUES('10009','Ayse Cemile',4000);
INSERT INTO personel VALUES('10008','Ayse Cano',4300);
INSERT INTO personel VALUES('10007','Can Ayse',7700);
INSERT INTO personel VALUES('10011','Yeliz Alina',12700);

SELECT * FROM personel;

/*-------------------------------------------------------------------------
Q7: id'si 10005 ile 10009 arasinda olan personelin bilgilerini listele
---------------------------------------------------------------------------*/

select*from personel where id between 10005 and 10009;

/*-------------------------------------------------------------------------
Q8: Ismi Mehmet Yilmaz ile Veli arasinda olan personel bilgilerini listeleyin
---------------------------------------------------------------------------*/

select*from personel where isim between 'Mehmet Yilmaz' and 'Veli';

/*-------------------------------------------------------------------------
Q9: Ismi Ahmet ile Ayse Cano arasinda olan personel bilgilerini listeleyin
---------------------------------------------------------------------------*/

select*from personel where isim between 'Ahmet' and 'Ayse Cano' ; 

/*-------------------------------------------------------------------------
Q10: Maasi 7000 ya da ismi Ayse olan personel id'lerini listeleyin
---------------------------------------------------------------------------*/

select id from personel where maas=7000 or isim='Ayse';

/*-------------------------------------------------------------------------
Q11: Id'si 10001, 10005 ya da 10008 olan personel isimlerini listeleyin
---------------------------------------------------------------------------*/

select isim from personel where id = '10001' or id ='10005' or id ='10008';

/*================================== SELECT-IN ===========================================
IN birden fazla mantiksal ifade ile tanimlayabilecegimiz durumlari tek komutla yazabilme
imkani verir. IN icerisine yazacagimiz sartlar ayni field'a ait olmali.
-----Syntax-----
SELECT field1,field2,...
FROM table_name
WHERE field_name IN (deger1,deger2,...);
=========================================================================================*/

/*-------------------------------------------------------------------------
Q12: Id'si 10001, 10005 ya da 10008 olan personel isimlerini listeleyin
---------------------------------------------------------------------------*/

select isim from personel where id in ('10001', '10005', '10008');

/*-------------------------------------------------------------------------
Q13: Maasi sadece 7000 veya 12000 olan personelin bilgilerini listele
---------------------------------------------------------------------------*/

select *from personel where maas in ('7000','12000');

/*================================== SELECT-LIKE =============================================
LIKE keyword sorgulama yaparken belirli patternleri kullanabilmemize olanak saglar.
-----Syntax-----
 SELECT field1,field2,...
 FROM table_name
 WHERE field LIKE pattern
 
 ----------------
 Pattern icin :
 % karakteri 0 veya daha fazla karakteri belirtir
 _ karakteri tek bir karakteri temsil eder.
=========================================================================================*/
/*-------------------------------------------------------------------------
Q14: Ismi A ile baslayan personeli listeleyiniz
---------------------------------------------------------------------------*/

select*from personel where isim like 'a%';

/*-------------------------------------------------------------------------
Q15: Isminde Ayse olan personelin isimlerini listeleyiniz
---------------------------------------------------------------------------*/

select*from personel where isim like '%ayse%';

/*-------------------------------------------------------------------------
Q16: Ismi n harfi ile biten personeli listeleyiniz
---------------------------------------------------------------------------*/


select*from personel where isim like '%n';

/*-------------------------------------------------------------------------
Q17: Isminin 2. harfi e olan personeli listeleyiniz
---------------------------------------------------------------------------*/

select*from personel where isim like '_e%';

/*-------------------------------------------------------------------------
Q18: Isminin 2. harfi e olup diger harflerinde y olan personeli listeleyiniz
---------------------------------------------------------------------------*/

select*from personel where isim like '_e%' and isim like '%y%';

/*-------------------------------------------------------------------------
Q19: Isminde a harfi olmayan personeli listeleyiniz
---------------------------------------------------------------------------*/

select*from personel where isim not like '%a%';

/*-------------------------------------------------------------------------
Q20: Maasi 5 haneli olan personeli listeleyiniz
---------------------------------------------------------------------------*/

select*from personel where maas like '_____';

/*-------------------------------------------------------------------------
Q21: 1. harfi a ve 7. harfi a olan personeli listeleyiniz
---------------------------------------------------------------------------*/
select*from personel where isim like 'a_____a%';
