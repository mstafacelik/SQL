-- id, isim ve irtibat fieldlarinin oldugu bir tedarik(supply) tablosu olusturun.
-- id field'ini Primary Key yapin.

create table supply(

id int,
namen varchar(25),
kontaktdaten varchar(50),
constraint id_pk primary key (id)

);


-- tedarikci_id , urun_id , urun_isim , musteri_isim  fieldlari olan urun 
-- tablosu olusturun. Bu tablodaki tedarikci_id fieldini supply tablosunun
-- PK 'si ile Foreign Key yapin.



create table product(

tedarikci_id int,
produkt_id int,
produkt_name varchar(25),
kunden_name varchar(25),
constraint tedarikci_id_fk foreign key(tedarikci_id)
references supply (id)

);

drop table product;
drop table supply;


INSERT INTO supply VALUES  (100, 'IBM', 'Ali Can'),
							(101, 'APPLE', 'Merve Temiz'),
							(102, 'SAMSUNG', 'Kemal Can'),
							(103, 'LG', 'Ali Can');

INSERT INTO product VALUES (100, 1001,'Laptop', 'Suleyman'), 
						(101, 1002,'iPad', 'Fatma'),
						(102, 1003,'TV', 'Ramazan'), 
						(103, 1004,'Phone', 'Ali Can');

SELECT * FROM supply;
SELECT * FROM product;

-- 'LG' firmasinda calisan 'Ali Can'in ismini 'Veli Can' olarak degistiriniz.


update supply
set kontaktdaten= 'Veli Can'
where kontaktdaten='Ali Can';
-- where isim='LG';     -> alternatif yazim


-- Ali Can'in aldigi urunun ismini Apple olarak degistirin

update product
set produkt_name='Apple'
where kunden_name='ALi Can';


-- Irtibat'i Merve Temiz olan kaydin sirket ismini getirin

select namen from supply 
where kontaktdaten='Merve Temiz';


/*
a) Urun tablosundan Ali Can'in aldigi urunun ismini, 
tedarik tablosunda irtibat Merve Temiz olan 
sirketin ismi ile degistirin. */

update product
set produkt_name= ( select namen
					from supply 
					where kontaktdaten='Merve Temiz' )
where kunden_name='ALi Can';


/*-------------------------------------------------------------------------
b) TV satin alan musterinin ismini, 
IBM'in irtibat'i ile degistirin.
-------------------------------------------------------------------------*/

update product
set kunden_name =(  select kontaktdaten 
					from supply 
					where namen ='IBM' )
where produkt_name='TV';


-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*-------------------------------------------------------------------------
1) Cocuklar tablosu olusturun.
 Icinde id,isim,veli_isim ve grade field'lari olsun. 
 Id field'i Primary Key olsun.
 --------------------------------------------------------------------------*/
CREATE TABLE cocuklar(
id INT,
isim VARCHAR(20),
veli_isim VARCHAR(10),
grade DOUBLE,
CONSTRAINT id_pk PRIMARY KEY (id)
);


/*-------------------------------------------------------------------------
 2)  Kayitlari tabloya ekleyin.
 (123, 'Ali Can', 'Hasan',75), 
 (124, 'Merve Gul', 'Ayse',85), 
 (125, 'Kemal Yasa', 'Hasan',85),
 (126, 'Rumeysa Aydin', 'Zeynep',85);
 (127, 'Oguz Karaca', 'Tuncay',85);
 (128, 'Resul Can', 'Tugay',85);
 (129, 'Tugay Kala', 'Osman',45);
 --------------------------------------------------------------------------*/
INSERT INTO cocuklar VALUES(123, 'Ali Can', 'Hasan',75),
							(124, 'Merve Gul', 'Ayse',85),
							(125, 'Kemal Yasa', 'Hasan',85),
							(126, 'Rumeysa Aydin', 'Zeynep',85),
							(127, 'Oguz Karaca', 'Tuncay',85),
							(128, 'Resul Can', 'Tugay',85),
							(129, 'Tugay Kala', 'Osman',45);
                            
/*-------------------------------------------------------------------------
3)puanlar tablosu olusturun. 
ogrenci_id, ders_adi, yazili_notu field'lari olsun, 
ogrenci_id field'i Foreign Key olsun 
--------------------------------------------------------------------------*/
CREATE TABLE puanlar(
ogrenci_id INT,
ders_adi VARCHAR(10),
yazili_notu DOUBLE,
CONSTRAINT puanlar_fk 
FOREIGN KEY (ogrenci_id) 
REFERENCES cocuklar (id)
);
/*-------------------------------------------------------------------------
4) puanlar tablosuna kayitlari ekleyin
 ('123','kimya',75), 
 ('124','fizik',65),
 ('125','tarih',90),
 ('126','kimya',87),
 ('127','tarih',69),
 ('128','kimya',93),
 ('129','fizik',25)
--------------------------------------------------------------------------*/
INSERT INTO puanlar VALUES ('123','kimya',75); 
INSERT INTO puanlar VALUES ('124','fizik',65); 
INSERT INTO puanlar VALUES ('125','tarih',90); 
INSERT INTO puanlar VALUES ('126','kimya',87); 
INSERT INTO puanlar VALUES ('127','tarih',69); 
INSERT INTO puanlar VALUES ('128','kimya',93); 
INSERT INTO puanlar VALUES ('129','fizik',25); 

/*-------------------------------------------------------------------------
5) Tum cocuklarin gradelerini puanlar tablosundaki yazili_notu ile update edin. 
--------------------------------------------------------------------------*/
select *from cocuklar;
select *from puanlar;

update cocuklar
set grade = (	select yazili_notu 
					from puanlar 
					where cocuklar.id=puanlar.ogrenci_id)
where id;


/*-------------------------------------------------------------------------
6) Ismi Kemal Yasa olan ogrencinin grade'ini puanlar tablosundaki 
ogrenci id'si 128 olan yazili notu ile update edin. 
--------------------------------------------------------------------------*/

update cocuklar
set grade =(select yazili_notu 
			from puanlar 
			where ogrenci_id=128 )
where isim ='Kemal Yasa'; 


/*-------------------------------------------------------------------------
7) Ders adi fizik olan kayitlarin yazili notunu Oguz Karaca'nin grade'i
ile update edin. 
--------------------------------------------------------------------------*/

update puanlar
set yazili_notu= (select grade 
				  from cocuklar 
				   where isim='Oguz Karaca')
where ders_adi='fizik';



/*-------------------------------------------------------------------------
8) Ali Can'in grade'ini, 124 ogrenci_id'li yazili_notu ile guncelleyin.
--------------------------------------------------------------------------*/

update cocuklar
set grade = (select yazili 
			from punlar 
			where id='124')
where isim='Ali Can';


/*-------------------------------------------------------------------------
9) Ders adi Kimya olan yazili notlarini Rumeysa Aydin'in 
grade'i ile guncelleyin.
--------------------------------------------------------------------------*/

update puanlar 
set yazili_notu=(select grade 
				 from cocuklar 
                 where isim='Rumeysa Aydin')
where ders_adi='kimya';



/*-------------------------------------------------------------------------
10) Ders adi tarih olan yazili notlarini Resul Can'in 
grade'i ile guncelleyin.
--------------------------------------------------------------------------*/


update puanlar
set yazili_notu=(select grade 
				 from cocuklar 
				 where isim='Resul Can')
where ders_adi='tarih';


/*------------------------------------------------------------------------
Mart_satislar isimli bir tablo olusturun, 
icinde urun_id, musteri_isim, urun_isim ve urun_fiyat field'lari olsun
1) Ismi hatice olan musterinin urun_id'sini 30,urun_isim'ini Ford yapin 
2) Toyota marka araclara %10 indirim yapin 
3) Ismi Ali olanlarin urun_fiyatlarini %15 artirin 
4) Honda araclarin urun id'sini 50 yapin.
--------------------------------------------------------------------------*/
CREATE TABLE mart_satislar 
(
 urun_id int,
 musteri_isim varchar(20),
 urun_isim varchar(10),
 urun_fiyat int 
);
INSERT INTO mart_satislar VALUES    (10, 'Ali', 'Honda',75000),
									(10, 'Ayse', 'Honda',95200), 
									(20, 'Hasan', 'Toyota',107500),
									(30, 'Mehmet', 'Ford', 112500), 
									(20, 'Ali', 'Toyota',88000),
									(10, 'Hasan', 'Honda',150000), 
									(40, 'Ayse', 'Hyundai',140000), 
									(20, 'Hatice', 'Toyota',60000);

select *from mart_satislar;

-- 1) Ismi hatice olan musterinin urun_id'sini 30,urun_isim'ini Ford yapin 

update mart_satislar
set urun_id=30, urun_isim='Ford'
where musteri_isim='Hatice';



-- 2) Toyota marka araclara %10 indirim yapin 

update mart_satislar
set urun_fiyat= urun_fiyat*90/100
where urun_isim='Toyota';


-- 3) Ismi A ile baslayan butun musterilerin urun_fiyatlarini %15 artirin  


update mart_satislar
set urun_fiyat= urun_fiyat*115/100
where musteri_isim like 'a%'; -- sadece like ile kullanimda case sensitive degil


-- 4) Honda araclarin urun id'sini 50 yapin.

update mart_satislar
set urun_id=50
where urun_isim='Honda';