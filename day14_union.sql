use sys;
-- ====================== UNION ======================
/*
    Iki farkli sorgulamanin sonucunu birlestiren islemdir.
    Iki veya daha fazla Sorgu ifadesinin sonuc kumelerini 
    birlestirerek tek bir sonuc kumesi olusturur.
    2.sorgunun sonuna ORDER BY komutunu kullanirsaniz 
    tum tabloyu istediginiz siralamaya gore siralar.
   
    NOT: Secilen Field SAYISI ve DATA TYPE'i ayni olmalidir.
    
    Syntax:
    ----------
    SELECT sutun_adi,sutun_adi2, .. FROM tablo_adi1
    UNION
    SELECT sutun_adi1, sutun_adi2, .. FROM tablo_adi2;
    
    NOT: UNION operatoru SADECE benzersiz degerleri alir. 
    Benzer verileri almak icin UNION ALL kullanilir.
======================================================*/
CREATE TABLE personal(
id int,
isim varchar(50),
sehir varchar(50),
maas int,
sirket varchar(20)
);
INSERT INTO personal VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');
INSERT INTO personal VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');
INSERT INTO personal VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500,'Honda');
INSERT INTO personal VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');
INSERT INTO personal VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
INSERT INTO personal VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');
INSERT INTO personal VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');
INSERT INTO personal VALUES(345678902, 'Mehmet Ozturk', 'Izmir', 3500,'Honda');

-- Soru 1) Honda ve Tofas'ta calisan benzersiz isimdeki personelleri listeleyin

select isim
from personal						-- > Honda ve Tofas'ta calisan personeller ama biz benzer olan isimleri bulmak istiyoruz
where sirket in ('Honda','Tofas');  


select isim
from personal
where sirket = 'Honda'
UNION
select isim
from personal
where sirket = 'Tofas';

-- Soru 2) Honda, Ford ve Tofas'ta calisan "benzersiz isimdeki" personelleri listeleyin

select isim
from personal
where sirket = 'Honda'
UNION
select isim
from personal
where sirket = 'Tofas'
UNION
select isim
from personal
where sirket = 'Ford';

-- Soru 3) Honda, Ford ve Tofas'ta calisan butun personelleri listeleyin
-- Benzersiz isimler demedigi icin UNION ALL i kullanacagiz

select*
from personal
where sirket='Honda'
UNION ALL
select*
from personal
where sirket='Ford'
UNION ALL
select*
from personal
where sirket='Tofas';





-- Soru 4) Maasi 4000'den fazla olan isci isimlerini ve 5000'den fazla maas alinan sehirleri gosteren sorguyu yaziniz

select isim
from personal
where maas > 4000
UNION
select sehir
from personal
where maas>5000;


-- Soru 5) Mehmet Ozturk ismindeki personellerin isim, aldigi maaslari ve Istanbul'daki personelin sehir, maaslarini bir tabloda gosteren sorgu yaziniz

select isim as isci_sehir, maas as maaslar  -- > fieldlarin isimlerini ilk sorgunun select inden sonraki siralamayi baz alarak getirir.
from personal
where isim='Mehmet Ozturk'
UNION
select sehir, maas
from personal
where sehir='Istanbul';


-- Soru 6) Mehmet Ozturk ismindeki personellerin aldigi isim, maaslari 
-- ve Istanbul'daki personelin sehir, maaslarini en yuksekten dusuge dogru siralayarak bir tabloda gosteren sorguyu yaziniz.


select maas, isim as isim_sehir
from personal
where isim='Mehmet Ozturk'
UNION
select maas, sehir
from personal
where sehir ='Istanbul'
order by maas desc;

-- Soru 7) Sehirlerde odenen ucreti 3000'den fazla olan sehirleri 
-- ve personelden ucreti 5000'den az olanlarin isimlerini bir tabloda gosteren sorguyu yaziniz

select sehir as sehir_calisanIsim
from personal
where maas>3000
UNION
select isim
from personal
where maas<5000;

-- Soru 8) 5000'den az maas alanlarin, arti Honda calisani olmayanlarin bilgilerini listeleyen bir sorgu yaziniz.

select*
from personal
where maas < 5000
UNION	
select*
from personal
where sirket != 'Honda';

-- Soru 9) Ismi Mehmet Ozturk olanlari ve ek olarak Istanbul'da calismayanlarin isimlerini ve sehirlerini listeleyen sorguyu yaziniz.

select isim, sehir
from personal
where isim='Mehmet Ozturk'
UNION
select isim, sehir
from personal
where sehir <> 'Istanbul';

-- != ile <> ayni anlamdadir