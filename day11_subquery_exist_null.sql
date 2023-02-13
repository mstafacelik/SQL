/* ======================== EXISTS CONDITION ===========================
EXISTS Condition subquery'ler ile kullanilir. IN ifadesinin kullanimina benzer olarak, EXISTS ve NOT EXISTS ifadeleri de 
alt sorgudan getirilen degerlerin icerisinde bir degerin olmasi veya olmamasi durumunda islem yapilmasini saglar.
======================================================================*/

CREATE TABLE mayis_satislar
(
urun_id int,
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO mayis_satislar VALUES (10, 'Mark', 'Honda'),
								  (10, 'Mark', 'Honda'),
								  (20, 'John', 'Toyota'),
							 	  (30, 'Amy', 'Ford'),
								  (20, 'Mark', 'Toyota'),
							 	  (10, 'Adem', 'Honda'),
								  (40, 'John', 'Hyundai'),
								  (20, 'Eddie', 'Toyota');
                                  
CREATE TABLE nisan_satislar
(
urun_id int,
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO nisan_satislar VALUES   (10, 'Hasan', 'Honda'),
									(10, 'Kemal', 'Honda'),
									(20, 'Ayse', 'Toyota'),
									(50, 'Yasar', 'Volvo'),
									(20, 'Mine', 'Toyota');

select*from mayis_satislar;
select*from nisan_satislar;





/*----------------------------------------------------------------
SORU 1 : Her iki ayda da ayni id ile satilan urunlerin urun_id'lerini
ve urunleri mayis ayinda alanlarin isimlerini getiren bir query yaziniz.
----------------------------------------------------------------*/ 

-- 1. yol day10 da daki method ile

select urun_id, musteri_isim 
from  mayis_satislar
where urun_id in ( select urun_id
				   from  nisan_satislar
				   where mayis_satislar.urun_id=nisan_satislar.urun_id);


-- 2. yol exists ile
-- 2. yol un (where exists) in ilk yoldan (where field_name in) farki where den sonra fiel ismi girmeden direkt sadece exists yazilmasi. 

select urun_id, musteri_isim 
from  mayis_satislar
where exists ( select urun_id         -- > nisan satislarinda yer alan urun id lerini bize mayis satislari icin filtreler
			   from  nisan_satislar
			   where mayis_satislar.urun_id=nisan_satislar.urun_id);



/*----------------------------------------------------------------
SORU 2 : Her iki ayda da satilan urun_isimleri ( ayni urunlerin, urun_isim'ini) ve urunleri nisan ayinda 
alan musterilerin isimlerini getiren bir Query yaziniz.
----------------------------------------------------------------*/ 


select musteri_isim, urun_isim
from nisan_satislar
where exists (select urun_isim
			  from mayis_satislar
			  where nisan_satislar.urun_isim= mayis_satislar.urun_isim);



/*----------------------------------------------------------------
SORU 3 : Nisan ayinda satilip mayis ayinda satilmayan urun ismini ve satin alan kisiyi listeleyen bir QUERY yaziniz.
----------------------------------------------------------------*/

select urun_isim, musteri_isim
from nisan_satislar
where not exists( select urun_isim    -- not exists yerine !exists de yazabiliriz. 
		  from mayis_satislar
		  where mayis_satislar.urun_isim= nisan_satislar.urun_isim );
          
          
/*----------------------------------------------------------------
SORU 4 : Mayis ayinda satilip nisan ayinda satilmayan urun id ve satin alan kisiyi listeleyen bir QUERY yaziniz.
----------------------------------------------------------------*/


select urun_id, musteri_isim
from mayis_satislar
where not exists (select urun_id 
				  from nisan_satislar
				  where nisan_satislar.urun_id=mayis_satislar.urun_id);
                  


/* ======================== IS NULL CONDITION ===========================
    Arama yapilan field'da NULL degeri almis kayitlari getirir.
======================================================================*/


CREATE TABLE insanlar
(
ssn char(9),
isim varchar(50),
adres varchar(50)
);

INSERT INTO insanlar VALUES(123456789, 'Ali Can', 'Istanbul');
INSERT INTO insanlar VALUES(234567890, 'Veli Cem', 'Ankara');
INSERT INTO insanlar VALUES(345678901, 'Mine Bulut', 'Izmir');
INSERT INTO insanlar (ssn, adres) VALUES(456789012, 'Bursa');
INSERT INTO insanlar (ssn, adres) VALUES(567890123, 'Denizli');


-- Ismi null olan kayitlari listeleyin 

select*
from insanlar
where isim is null;


-- Ismi null olan kayitlari 'isimsiz' olarak guncelleyin 

update  insanlar 
set isim='isimsiz'
where isim is null;

-- ismi 'isimsiz' olan kayitlari siliniz

delete from insanlar
where isim='isimsiz';


-- Ismi null olan kayitlari siliniz

delete from insanlar
where isim is null;