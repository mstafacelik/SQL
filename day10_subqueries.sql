/*================================= SUBQUERY =================================
	Sorgu icinde calisan sorguya SUBQUERY (ALT SORGU) denir.
============================================================================*/

use sys;

Drop table personel;

CREATE TABLE personel
(
id int,
isim varchar(50),
sehir varchar(50),
maas int,
sirket varchar(20)
);

INSERT INTO personel VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Honda');
INSERT INTO personel VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'Toyota');
INSERT INTO personel VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Honda');
INSERT INTO personel VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Ford');
INSERT INTO personel VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Hyundai');
INSERT INTO personel VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Ford');
INSERT INTO personel VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Honda');


CREATE TABLE sirketler
(
sirket_id int,
sirket varchar(20),
personel_sayisi int
);

INSERT INTO sirketler VALUES(100, 'Honda', 12000);
INSERT INTO sirketler VALUES(101, 'Ford', 18000);
INSERT INTO sirketler VALUES(102, 'Hyundai', 10000);
INSERT INTO sirketler VALUES(103, 'Toyota', 21000);

SELECT * FROM personel;
SELECT * FROM sirketler;


-- ======================== WHERE ile SUBQUERY ===========================
/*----------------------------------------------------------------
 1) Personel sayisi 15.000'den cok olan sirketlerin isimlerini
 ve bu sirkette calisan personelin isimlerini listeleyin
----------------------------------------------------------------*/
-- 1. Adim : Personel sayisi 15000'den buyuk olan sirketleri listeleyiniz
SELECT sirket
FROM sirketler
WHERE personel_sayisi>15000; -- Ford ve Toyota dondurur.


-- 2. Adim : Ford ve Toyota'da calisan personeli listeleyiniz.
SELECT isim , sirket 
FROM personel
WHERE sirket IN ('Ford','Toyota');


-- 3. Adim : Personel sayisi 15000'den cok olan sirketleri ve bu sirketlerde calisan personeli listeleyiniz
SELECT isim , sirket 
FROM personel
WHERE sirket IN (SELECT sirket
                FROM sirketler
                WHERE personel_sayisi>15000); -- bu sekilde komutumuzu dinamiklestirdik.
                
                
-- Honda sirketinin personel sayisini 16000 olarak guncelleyiniz

update sirketler
set personel_sayisi=16000
where sirket='Honda';

/*----------------------------------------------------------------
 2) Sirket_id'si 101'den buyuk olan sirketlerin 
 maaslarini ve sehirlerini listeleyiniz
----------------------------------------------------------------*/


select maas, sehir 
from personel
where sirket in (select sirket      -- > iki tabloda da ortak baglayabilecimiz yer sirket oldugu icin 'where sirket in' seklinde yazdik
				 from sirketler 
				 where sirket_id>101);



/*----------------------------------------------------------------                
  3) Ankara'daki sirketlerin sirket id ve personel 
  sayilarini listeleyiniz.
----------------------------------------------------------------*/

select sirket_id, personel_sayisi 
from sirketler 
where sirket in (select sirket 
				from personal 
				where sehir='Ankara');


/*----------------------------------------------------------------                
  4) Veli Yilmaz isimli personelin calistigi sirketlerin sirket 
  ismini ve personel sayilarini listeleyiniz.
----------------------------------------------------------------*/

select sirket, personel_sayisi 
from sirketler 
where sirket in (select sirket 
			   from personel 
			   where isim ='Veli Yilmaz');
               

/* ======================== SELECT ile SUBQUERY ===========================
  SELECT ile SUBQUERY kullanimi :
  
-- SELECT -- hangi sutunlari(field) getirsin
-- FROM -- hangi tablodan(table) getirsin
-- WHERE -- hangi satirlari(record) getirsin
  
 * Yazdigimiz QUERY'lerde SELECT satirinda field isimleri kullaniyoruz.
  Dolayisiyla eger SELECT satirinda bir SUBQUERY yazacaksak sonucun
  tek bir field donmesi gerekir.
  
  * SELECT satirinda SUBQUERY yazacaksak SUM, COUNT, MIN, MAX ve AVG gibi 
  fonksiyonlar kullanilir. Bu fonksiyonlara AGGREGATE FUNCTION denir.
=> Interview Question : Subquery'i Select satirinda kullanirsaniz ne ile 
kullanmaniz gerekir?
=========================================================================*/

/*----------------------------------------------------------------
 SORU 1- Her sirketin ismini, personel sayisini ve personelin 
 ortalama maasini listeleyen bir QUERY yazin.
----------------------------------------------------------------*/

select sirket, personel_sayisi, (select avg(maas) 
							     from personel 
							     where sirketler.sirket=personel.sirket) -- burada where ile iki tablo arasinda gruplandirma yapiyoruz
from sirketler;


/*----------------------------------------------------------------
SORU 2- Her sirketin ismini ve personelin aldigi max. maasi 
listeleyen bir QUERY yazin.
----------------------------------------------------------------*/


select sirket, (select MAX(maas)    
			  from personel     
              where sirketler.sirket=personel.sirket)
from sirketler;


/*----------------------------------------------------------------
SORU 3- Her sirketin id'sini, ismini ve toplam kac sehirde 
bulundugunu listeleyen bir QUERY yaziniz.
----------------------------------------------------------------*/

select sirket_id, sirket, (select count(sehir)
						   from personel
                           where sirketler.sirket=personel.sirket)
from sirketler;

/*----------------------------------------------------------------
SORU 4- ID'si 101'den buyuk olan sirketlerin id'sini, ismini ve 
toplam kac sehirde bulundugunu listeleyen bir QUERY yaziniz.
----------------------------------------------------------------*/

 select sirket_id, sirket, (select count(sehir)  
						    from personel
                            where sirketler.sirket=personel.sirket) as toplam_sehir -- > burada toplam sehir yazarak subquery yi isimlendirdik. 
 from sirketler																		-- > as yazmasak da olur
 where sirket_id>101;


/*----------------------------------------------------------------
SORU 5- Her sirketin ismini,personel sayisini ve personelin 
aldigi max. ve min. maasi listeleyen bir QUERY yazin.
----------------------------------------------------------------*/   

select sirket, personel_sayisi, (select max(maas)
								 from personel
                                 where sirketler.sirket=personel.sirket) as max_maas,
								 (select min(maas)
								 from personel
                                 where sirketler.sirket=personel.sirket) as min_maas
from sirketler;


/*----------------------------------------------------------------
SORU 6- Her sirketin ismini ve personel sayisini ve iscilere
odedigi toplam maasi listeleyen bir QUERY yazin.
----------------------------------------------------------------*/

select sirket, personel_sayisi, (select sum(maas)
								from personel
								where sirketler.sirket=personel.sirket) as toplam_odenen_maas
from sirketler;

