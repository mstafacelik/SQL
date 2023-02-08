/*================================== DELETE ============================================
DELETE FROM table_name komutu tablodaki tum recordlari siler.
Eger tum kayitlar silindikten sonra tabloyu gormek isterseniz size sadece bos bir tablo
gosterir. 
DELETE komutu sadece datalari siler, tabloyu silmez.
=======================================================================================*/

/*===============================================================================================
-- DELETE FROM tablo_adi;  Tablonun tum icerigini siler.
-- Bu komut bir DML komutudur. Dolayisiyla devaminda WHERE gibi cumlecikler
-- kullanilabilir.
    
    -- DELETE FROM tablo_adi
    -- WHERE field = veri;
    
--    DELETE FROM ogrenciler;     -- Tum verileri sil.
--    SAVEPOINT ABC;     -- Verilen konuma kodlari kaydeder.
--    ROLLBACK TO  ABC;  -- Silinen Verileri geri getir.

-- NOT : Bilgileri geri getirirken sikinti yasamamak icin ayarlar sql execution auto commit tiki kaldir
==================================================================================================*/ 
USE sys;
CREATE TABLE children
(
id char(3),
isim varchar(50),
veli_isim varchar(50),
yazili_notu int,
CONSTRAINT cocuklar_pk
PRIMARY KEY (id)
);
INSERT INTO children VALUES(123, 'Ali Can', 'Hasan',75),
							(124, 'Merve Gul', 'Ayse',85), 
							(125, 'Kemal Yasa', 'Ali',85);
SELECT * FROM children;

-- Veli Ismi Ali ya da Ayse olan kaydi siliniz

delete from children
where veli_isim in ('Ali','Ayse');
-- where veli_isim='Ali' or veli_isim='Ayse'; -> alternatif yazim


-- Yazili notu 84'ten buyuk olan cocuklari silin

delete from children
where yazili_notu> 84;


-- Yazili notu 85'ten farkli olan cocuklari silin 

delete from children
where not yazili_notu=85;

delete from children
where yazili_notu!=85;

delete from children
where yazili_notu <> 85;


CREATE TABLE isimler
    (
        id CHAR(3),
        isim VARCHAR(50),
        veli_isim VARCHAR(50),
        yazili_notu int       
    );
  
    INSERT INTO isimler VALUES(123, 'Ali Can', 'Hasan',75),
							(124, 'Merve Gul', 'Ayse',85),
							(125, 'Kemal Yasa', 'Hasan',85),
							(126, 'Nesibe Yilmaz', 'Ayse',95),
							(127, 'Mustafa Bak', 'Can',99);
                            
savepoint yedekleme;

delete from isimler 
where id > 125;

rollback to yedekleme;

select*from isimler;