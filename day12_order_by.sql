
/* ======================== ORDER BY ===========================
=> ORDER BY komutu belli bir field'a gore NATURAL ORDER olarak siralama yapmak icin kullanilir.
=> ORDER BY komutu sadece SELECT komutu ile kullanilir.
=> ORDER BY komutuna ozel olarak, siralama yapacagimiz field ismi yerine field sirasini da yazabiliriz.
=> Isimleri natural order'a gore siralamak icin sorgunun sonuna ORDER BY (field_name) yazmak yeterlidir.
=> Isimleri ters siralama ile yazdirmak isterseniz DESC, natural order'a gore siralamak icin ASC yazariz. ASC yazmasak da zeten default olarak natural order sirali getirir.
=> Ayni degerde olan kayitlari, tablodaki kayit sirasina gore getirir.
==============================================================*/

CREATE TABLE menschen
(
ssn char(9),
isim varchar(50),
soyisim varchar(50),
adres varchar(50)
);

INSERT INTO menschen VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO menschen VALUES(234567890, 'Veli','Cem', 'Ankara');
INSERT INTO menschen VALUES(345678901, 'Mine','Bulut', 'Ankara');
INSERT INTO menschen VALUES(256789012, 'Mahmut','Bulut', 'Istanbul');
INSERT INTO menschen VALUES (344678901, 'Mine','Yasa', 'Ankara');
INSERT INTO menschen VALUES (345678901, 'Ali','Yilmaz', 'Istanbul');

SELECT * FROM menschen;


-- Soru 1: menschen tablosundaki datalari adres'e gore siralayin 

select*
from menschen 
order by adres;


-- Soru 2: Isim' i Mine olanlari soyisim sirali olarak listeleyen Query yaziniz.

select*
from menschen 
where isim='Mine' 
order by soyisim;



-- Soru 3: menschen tablosundaki soyismi BULUT olanlari isim sirali olarak listeleyin.

select*
from menschen
where soyisim='BULUT' 
order by isim;


-- Soru 4: menschen tablosundaki tum kayitlari SSN numarasi buyukten kucuge olarak siralayin.

select*
from menschen
order by ssn desc;


-- Soru 5: menschen tablosundaki tum kayitlari soyisimler ters sirali, isimler Natural sirali olarak listeleyin.

select*
from menschen
order by soyisim desc, isim asc;   -- asc yazmasak da olur zaten default olarak natural sirali getirir 



-- Soru 6 : menschen tablosundaki tum kayitlari adresler ters sirali, soyisimler ters sirali olarak listeleyin.


select*
from menschen
order by adres desc, isim desc, soyisim desc;   -- > burada 2. ve 3. siralama sartina ne zaman gecer? Eger 1. sart ayni ise. 
                                                -- Yani adresler tersten siralanirken ayni isimli sehirler var ise 2. sart olan isimleri tersten siralar.
												-- Eger isimler de ayni ise yani hem sehir hem isim ayni ise 3. sart olan soyisme gore tersten siralar.
												-- Bu da ayni ise :) kayit sirasina gore siralar.
                                                



/* ======================== ALIASES ===========================
   Aliases kodu ile tablo yazdirilirken, field isimleri "sadece o cikti icin" degistirilebilir. 
===============================================================*/

CREATE TABLE employees
(
employee_id char(9),
employee_name varchar(50),
employee_birth_city varchar(50)
);

INSERT INTO employees VALUES (123456789, 'Ali Can', 'Istanbul'),
							 (234567890, 'Veli Cem', 'Ankara'),
							 (345678901, 'Mine Bulut', 'Izmir');
                             

select* from employees;

select employee_id as id, 
	   employee_name as isim, 
       employee_birth_city as 
       sehir from employees;
       
       
/* ======================== GROUP BY CLAUSE ===========================
   Group By komutu sonuclari bir veya daha fazla sutuna gore
   gruplamak icin SELECT komutuyla birlikte kullanilir.
   
   GROUP BY komutu her grup basina bir satir dondurur.
   
   GROUP BY AGGREGATE fonksiyonlariyla birlikte kullanilir.
======================================================================*/  

CREATE TABLE manav (
    isim VARCHAR(50),
    urun_adi VARCHAR(50),
    urun_miktar INT
);

INSERT INTO manav VALUES( 'Ali', 'Elma', 5),
						( 'Ayse', 'Armut', 3),
						( 'Veli', 'Elma', 2),
						( 'Hasan', 'Uzum', 4),
						( 'Ali', 'Armut', 2),
						( 'Ayse', 'Elma', 3),
						( 'Veli', 'Uzum', 5),
						( 'Ali', 'Armut', 2),
						( 'Veli', 'Elma', 3),
						( 'Ayse', 'Uzum', 2),
						( 'Ali', null, 2),
						( 'Ayse', 'Armut', 1),
						( 'Ayse', 'Elma', 4),
						( 'Ayse', null, 3);
SELECT * FROM manav;

-- Soru 1 : isme gore, alinan urunlerin toplam kilosunu bulup, isim sirasina gore siralayin.
       
select isim, sum(urun_miktar) as toplam_kg
from manav
group by isim     -- > burada ismi ayni olanlari tek sutunda(grupta) gruplandirdik.
order by isim;    -- > burda da sonuclari siraladik

-- Soru 2 : isme gore, alinan urunlerin toplam kilosunu bulup, isim sirasina gore ters siralayin.

select isim, sum(urun_miktar) as toplam_kg
from manav
group by isim
order by isim desc;

-- Soru 3 : isme gore, alinan urunlerin toplam kilosunu bulup, max kiloya gore  siralayin.

select isim, sum(urun_miktar) as toplam_kg
from manav
group by isim
order by toplam_kg desc;


-- 4) Urun ismine gore, urunu alan toplam kisi sayisini,
-- kisi sayisina gore siralayiniz.

select urun_adi, count(isim) as toplam_kisi
from manav
group by urun_adi
order by toplam_kisi;



-- 5) Alinan kilo miktarina gore musteri sayisini urun miktar sirasina gore listeleyiniz.

select urun_miktar, count(isim) as musteri_sayisi  -- > count(urun_miktar) seklinde de yazabiliriz.
from manav
group by urun_miktar
order by urun_miktar;


-- 6) Satilan meyve turune (urun_adi) gore urun alan kisi sayisini, urun_adi NATURAL ORDER'a gore gosteren QUERY yaziniz.
-- NULL olarak girilen meyveyi listelemesin.


select urun_adi, count(isim) as kisi_sayisi  -- > count(urun_adi) seklinde de yazilabilir.
from manav
where urun_adi is not null
group by urun_adi
order by urun_adi;


-- 7) Satilan meyvenin 4 harfli olmasina (urun_adi) gore urun alan kisi sayisini, urun_adi NATURAL ORDER'a gore gosteren QUERY yaziniz.
-- NULL olarak girilen meyveyi listelemesin.

select urun_adi, count(isim) as kisi_sayisi  -- > count(urun_adi) seklinde de yazilabilir.
from manav
where urun_adi like '____'
group by urun_adi
order by urun_adi;



-- 8) Satilan meyve turune (urun_adi) gore satilan (urun_miktari)
-- MIN ve MAX urun miktarlarini, MAX urun miktarina gore siralayarak
-- listeleyen OUERY yaziniz.
-- NULL olarak girilen meyveyi listelemesin.

select urun_adi, min(urun_miktar) as min_urun_kg,  max(urun_miktar) as max_urun_kg
from manav
where urun_adi is not null
group by urun_adi
order by  max_urun_kg desc;


-- 8) Kisi ismine ve urun_adina gore satilan urunlerin toplamini
-- gruplandiran ve isime gore ters sirada listeleyen QUERY yaziniz.


select isim, urun_adi, sum(urun_miktar) as toplam_kg
from manav
group by isim, urun_adi
order by isim desc; 

