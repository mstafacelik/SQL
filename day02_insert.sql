/*========================================
               VERI GIRISI
========================================*/
-- INSERT INTO + tablo adi + VALUES + (std_id CHAR(4),std_name VARCHAR(25),std_age int)
-- Degerleri girerken dikkat edilmesi gereken Tabloyu 
-- olustururken degerleri atadigimiz veri cinsinden olmasi
-- String ifadeleri tek tirnak icinde yaziyoruz.
-- Date data tipi de String gibi tek tirnak icine yazilir,
-- ayrica MySQL 'in default tarih formati YYYY-MM-DD seklindedir.
/*******************************************************
-> Bir field'a kaydedilecek verileri UNIQUE yapmak icin 
 table olustururken field isminin yanina UNIQUE yaziyoruz.
-> Bir field'a kaydedilecek verilerde null olmasin istiyorsak 
table olustururken field isminin yanina NOT NULL yaziyoruz.
*********************************************************/

-- Fen Lisesi ogrencilerinin okul no , isim , derece, adres ve
-- son degisiklik tarihi field'lari olan tablosunu hazirlayalim.
-- okul no field'i UNIQUE olmali, isim field'i da bos birakilmasin.
use sys;

create table fen_lisesi_ogrencileri(

okul_no int unique,
isim varchar(25) not null,
derece double,
adres varchar(75),
son_degisiklik_tarihi date

);

select*from fen_lisesi_ogrencileri;

insert into fen_lisesi_ogrencileri values(11,'Stefan', 5, 'München', '2030-12-31' );

insert into fen_lisesi_ogrencileri values(12, 'Thomas', 4.5, 'Stuttgart', '2030-10-30');
insert into fen_lisesi_ogrencileri values(13, 'Ali', 4.5, 'Stuttgart', '2030-8-30');
insert into fen_lisesi_ogrencileri values(14, 'Memet', 4.5, 'Frankfurt', '2030-8-30');
insert into fen_lisesi_ogrencileri values(15, 'Esra', 4.5, 'Berlin', '2030-1-30');
-- insert into fen_lisesi_ogrencileri values(15, 'Veli', 4.5, 'Heidelberg', '2030-1-30'); --> okul no uniqeu olmasi gerektigi
-- icin bu satir eklenemez, hata verir
insert into fen_lisesi_ogrencileri values(16, 'Esra', 4.5, 'Frankreich', '2025-1-30'); -- okul no yu degistirirsek ekleyebiliriz
-- insert into fen_lisesi_ogrencileri values(17, null, 4.5, 'Berlin', '2030-1-30'); --> isim not null olmasi gerektigi icin hata verir

insert into fen_lisesi_ogrencileri values(null, 'Esra', null, null, null);
insert into fen_lisesi_ogrencileri values(null, 'Esra', null, null, null);

insert into fen_lisesi_ogrencileri (isim, adres) values('Abuzittin',  'istanbul');
-- insert into fen_lisesi_ogrencileri (okul_no, adres) values(17,  'istanbul'); --> bu satir eklenemez, cünkü isim not null !!!
insert into fen_lisesi_ogrencileri (okul_no, isim, adres) values(17, 'Ezgi', 'istanbul');


-- UNIQUE olarak belirledigimiz bir field'a istedigimiz kadar NULL deger kaydedebiliriz
-- ancak data tipi String ise hiclik ifadesini sadece 1 kere kaydeder,
-- diger kayitlarda duplicate hatasi verir.


/* ----------------------------------------------
Q1 : okul_no, isim , adres, derece fieldlari olan 
anadolu lisesi table olusturun. okul_no CHAR ve UNIQUE, 
isim NOT NULL olacak
------------------------------------------------- */

create Table anadolu_lisesi(

okul_no char(4) unique,
isim varchar(25) not null,
adres varchar(20),
derece double
);

select *from anadolu_lisesi;

insert into anadolu_lisesi values('1001','Ali','Izmir', 5);
insert into anadolu_lisesi values('1002','Veli','Istanbul', 4.5);
insert into anadolu_lisesi values('1003','Deli','Antalya', 4.6);
insert into anadolu_lisesi values('1004','Memo','Bodrum', 4.2);
insert into anadolu_lisesi values('1005','Keko','Izmir', 4.1);
insert into anadolu_lisesi values(null,'Hüso','Izmir', 4.7);
insert into anadolu_lisesi values(null,'Abuzittin','Izmir', 4.9);
insert into anadolu_lisesi values('1005','Muhittin','Izmir', 3.1);

-- biden fazla komutu secip ayni anda tabolya insert emtye calisirsak MySQL java gibi yukaridan asagiya calisir 
-- ve ilk buldugu hataya kadar tabloya verileri ekler. Ilk hatadan itibaren veri girisi durur.

insert into anadolu_lisesi (isim, adres) values('Mustafa', 'Japonya');
-- insert into anadolu_lisesi (okul_no, adres, derece) values('1006', 'istanbul', 4.2); --> Calismaz cunku isim not null !!!



