
-- Group by Kisa Tekrar

CREATE TABLE emekciler
(
id int,
isim varchar(50),
sehir varchar(50),
maas int,
sirket varchar(20)
);

INSERT INTO emekciler VALUES (123456789, 'Gunter Yilmaz', 'Istanbul', 5500, 'Honda'),
							(234567890, 'Thomas Aca', 'Istanbul', 4500, 'Toyota'),
							(345678901, 'Stefan Olg', 'Berlin', 3500,'Honda'),
							(456789012, 'Stefan Olg', 'Izmir', 6000, 'Ford'),
							(567890123, 'Stefan Olg', 'Berlin', 7000, 'Tofas'),
							(456715012, 'Thomas Aca', 'Ankara', 4500, 'Ford'),
							(123456710, 'Ugur Sahin', 'Mainz', 4500, 'Honda');
                            
select*from emekciler;

-- 1) Isme gore toplam maaslari bulun

select isim, sum(maas) as maaslar_toplami
from emekciler
group by isim ;



-- 2) Sehre gore toplam isci sayisini büyükten kücüge yazdirin

select sehir, count(id) as isciler_toplami -- > count () parantez icine isim, sehir, maas, sirket yazarak da sonucu bulabilirdik
from emekciler							   --  > yani count(isim), count(sehir) count(maas), count(sirket)
group by sehir
order by isciler_toplami desc;


-- 3) Sirketlere gore maasi 5000 liradan fazla olan isci sayisini bulun

select sirket, count(id) as maasi_5000_ustu_isciSayisi
from emekciler
where maas >5000
group by sirket;


-- 4) Her sirket icin Min ve Max maasi bulun

select sirket, min(maas) as min_maas, max(maas) as max_maas
from emekciler
group by sirket;



/*======================== HAVING CLAUSE =======================================================================================
- HAVING, AGGREGATE FUNCTION'lar ile birlikte kullanilan FILTRELEME komutudur. Aggregate fonksiyonlar ile ilgili bir kosul koymak 
  icin GROUP BY'dan sonra HAVING cumlecigi kullanilir. 
- Yani wehere ile, tabloda var olan "MEVCUT" bir field(sütun) da filtreleme yapilirken having ile, 
  aggregate function la olusturulan "YENI" field(sütun) da filtreleme yapilir.
- Where-> basit filter da kullaniliyor, having-> group by da kullaniliyor.
================================================================================================================================*/

-- Soru 1 : Sirketlere göre isci sayisi 1 den buyuk olanlari yazdiriniz

select sirket, count(isim) as isci_sayisi_birdenBüyük
from emekciler
group by sirket
having isci_sayisi_birdenBüyük>1;


-- Soru 2) Toplam geliri 8000 liradan fazla olan isimleri gosteren sorgu yaziniz

select isim, sum(maas) as toplam_gelir 
from emekciler
group by isim
having toplam_gelir>8000;

-- Soru 3 : Her sirketin minumum maaslarini eger 4000'den buyukse yazdiriniz


select sirket, min(maas)    -- burada as yazip devaminda isimlendirme yapmak opsiyonel
from emekciler
group by sirket
having min(maas)>4000;

-- HATIRLATMA
-- Yeni create ettigimiz bir field uzerinden filtreleme yaptigimiz icin
-- WHERE cumlecigini kullanamayiz, WHERE cumlecigi sadece tablomuzda var olan
-- field'lar icin bir filtreleme yapar.


-- Soru 4:  Eger bir sehirde alinan MAX maas 5000'den dusukse sehir ismini ve MAX maasi veren sorgu yaziniz

select sehir, max(maas) as max_maas
from emekciler
group by sehir 
having max_maas<5000;


-- Soru 5: Eger bir sehirde alinan MAX maas 5000'den buyukse sehir ismini ve MAX maasi, sehir isim sirali veren sorgu yaziniz

select sehir, max(maas) as max_maas
from emekciler
group by sehir 
having max_maas>5000
order by sehir;


/*============================ LIMIT ====================================================================================
>Tablodaki verilerin belli bir kismini listelemek icin LIMIT komutunu kullaniriz.
>LIMIT komutundan sonra kullandigimiz sayi kadar kaydi bize getirir.
>Eger belirli bir aralikta calismak istiyorsak bu durumda iki sayi gireriz, ancak bu sayilardan ilki baslangic noktamizi 
ifade ederken ikincisi kac kayit getirecegimizi belirtir. Baslangic  noktasi dahil edilmez!
========================================================================================================================*/


-- Soru 1) Isciler tablosundan ilk 5 kaydi getiriniz

select*
from emekciler 
limit 5;



-- Soru 2) Isim sirali tablodan ilk 3 kaydi listeleyin.

select*
from emekciler
order by isim
limit 3;

-- Soru 3) Maas sirali tablodan 4. kayittan 6. kayda kadar olan
-- kayitlarin isim ve sehir bilgilerini listeleyin.


select isim, sehir
from emekciler
order by maas
limit 3,3;


-- Soru 4) Maasi en yuksek 3 kisinin bilgilerini listeleyen sorguyu yaziniz.

select*
from emekciler
order by maas desc
limit 3;


-- Soru 5) Maasi en dusuk 3 kisinin sadece isimlerini listeleyen sorguyu yaziniz.

select isim
from emekciler
order by maas
limit 3;

-- Soru 6) Maasi en dusuk 3 kisinin isimlerini, sehirlerini, isim sirali listeleyen sorguyu yaziniz.

select isim, sehir
from emekciler
order by maas, isim
limit 3;

-- Soru 7) Maasi en dusuk 3 kisinin isimlerini, sehirlerini, isim ve sehir sirali listeleyen sorguyu yaziniz.

select isim, sehir
from emekciler
order by maas, isim, sehir
limit 3;

-- Soru 8) Maas'i 4000'den buyuk olan 3 kisinin isimlerini ve sehirlerini siralayiniz.


select sehir, isim
from emekciler
where maas>4000
limit 3;

select*From emekciler;

-- Soru 9) Maas'i 4000'den buyuk olan 3 kisinin isimlerini ve sehirlerini, maas sirali siralayiniz.

select sehir, isim
from emekciler
where maas>4000
order by maas
limit 3;



/*============================ DISTINCT ===========================
    DISTINCT cumlecigi bir Sorgu ifadesinde benzer olan kayitlari
    filtrelemek icin kullanilir. Dolayisiyla secilen sutun veya 
    sutunlar icin benzersiz veri iceren satirlar olusturmaya yarar.
    
    Syntax :
    --------
    SELECT DISTINCT field_name1, field_name2,...
    FROM table_name
    
===============================================================*/

-- Soru 1 : iscilerin yasadigi sehirleri distinct olarak listeleyin

select distinct sehir
from emekciler;

-- Soru 2 : iscilerin isimlerini ve yasadigi sehirleri distinct olarak listeleyin.

select distinct sehir, isim  -- Şehir ve ismi birlikte distinct yaptik
from emekciler;

/*
-- Group By'da bir field a gore gruplama yapip, Aggregate Function'lar yardimiyla baska bir field'da islem yapip bize islem yaptigi field'i
-- yeni bir field olarak donduruyor.
-- DISTINCT cumlecigi bir Sorgu ifadesinde  benzer olan kayitlari filtrelemek icin kullanilir.
-- DISTINCT komutu bize  bir field'daki kayitlarin tek bir ornegini dondurur.
*/


CREATE TABLE gemüsehändler (
    isim VARCHAR(50),
    urun_adi VARCHAR(50),
    urun_miktar INT
);

INSERT INTO gemüsehändler VALUES( 'Ali', 'Elma', 5),
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
						
					
-- Soru 3 : gemüsehändler tablosundan, satilan farkli meyve türlerini listeleyiniz.


select distinct urun_adi 
from gemüsehändler;

-- Soru 4:  Satilan farkli meyve turlerini NULL olmayanlari listeleyiniz.

select distinct urun_adi
from gemüsehändler
where urun_adi is not null;


-- Soru 5:  Satilan farkli meyve turlerini NULL olmayanlari isim sirali listeleyiniz.


select urun_adi
from gemüsehändler
where urun_adi is not null
order by urun_adi;


-- Alternatif cözüm

select distinct urun_adi 
from manav 
where urun_adi!='null'; 

-- Soru 6 : Manavda kac cesit meyve satildigini listeleyen bir query yaziniz

select count(distinct urun_adi) as urun_cesidi_sayisi
from gemüsehändler
where urun_adi is not null; -- bunu yazmasak da null lari getirmiyor


-- Soru 7 : Satilan meyve ve satin alan kisi isimlerinden farkli olan ikilileri listeleyen query yaziniz

select  distinct isim, urun_adi
from gemüsehändler;
