/* ====================================== UPDATE ========================================
Tabloda varolan herhangi bir record'a ait verinin degistirilmesi icin kullanilir.
-----Syntax-----
UPDATE table_name
SET field1=''
WHERE condition;

NOT: Update islemlerinin yapilabilmesi icin Ayarlar->SQL Editor-> "safe Updates" check box'taki  tik isareti secili olmamali.
========================================================================================*/
/*--------------------------------------------------------------------------------------
1) Bir firmalar tablosu olusturun icinde id,
isim ve iletisim_isim field'lari olsun. 
Id ve isim'i beraber Primary Key yapin.
---------------------------------------------------------------------------------------*/


create table unternehmen (

id int,
namen varchar(25),
kontakt varchar(50),
constraint unternehmen_pm primary key(id,kontakt)

);

/*--------------------------------------------------------------------------------------
2) Icine 3 kayit ekleyin :
(1, 'ACB', 'Ali Can'), 
(2, 'RDB', 'Veli Gul'), 
(3, 'KMN', 'Ayse Gulmez').
---------------------------------------------------------------------------------------*/

insert into unternehmen values
(1, 'ACB', 'Ali Can'), 
(2, 'RDB', 'Veli Gul'), 
(3, 'KMN', 'Ayse Gulmez') ;

select*from unternehmen;

-- id si 3 olan firmanin ismini 'KRM' olarak güncelleyiniz.

update unternehmen 
set namen='KRM'
where id=3;

-- Iletisim ismi Veli Gul olan firmanin id'sini 4, ismini FDS olarak guncelleyiniz.

update unternehmen 
set namen='FDS', id='4'
where kontakt='Veli Gul';


-- Ismi ACB olan firmanin iletisim ismini 'Osman Can' olarak guncelleyiniz.

update unternehmen
set kontakt='Osman Can'
where namen='ABC';

update unternehmen
set kontakt ='Ayse Can'
where kontakt='Osman Can';