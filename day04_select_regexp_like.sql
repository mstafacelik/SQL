/*==================================SELECT-REGEXP_LIKE====================================
  -- 'c' => case-sensitive demektir
  -- 'i' => case-insensitive demektir ve default case-insensitive aktiftir.
  
-----Syntax-----
 SELECT sutun1,sutun2,...
 FROM tablo_adi
 WHERE REGEXP_LIKE(sutun_adi, 'pattern[]','c'[])
=========================================================================================*/

CREATE TABLE kelimeler
    (
        id int UNIQUE,
        kelime VARCHAR(50) NOT NULL,
        harf_sayisi int
    );
    
    INSERT INTO kelimeler 
    VALUES  (1001, 'hot', 3),
			(1002, 'hat', 3),
			(1003, 'hit', 3),
			(1004, 'hbt', 3),
			(1005, 'hct', 3),
			(1006, 'adem', 4),
			(1007, 'selim', 5),
			(1008, 'yusuf', 5),
			(1009, 'hip', 3),
			(1010, 'HOT', 3),
			(1011, 'hOt', 3),
			(1012, 'h9t', 3),
			(1013, 'hoot', 4),
			(1014, 'haaat', 5),
			(1015, 'h-t', 7),
			(1016, 'h?t', 7),
			(1017, 'hooooot', 7);
    
SELECT * FROM kelimeler;

-- Q1 : Icerisinde 'ot' veya 'at' bulunan kelimeleri case-sensitive'e dikkat ederek listele
-- NOT: VEYA islemi icin | karakteri kullanilir.

select*from kelimeler where REGEXP_LIKE (kelime, 'ot|at', 'c');


-- Q2 : Icerisinde 'ot' veya 'at' bulunan kelimeleri case-sensitive'e dikkat etmeksizin listele

select*from kelimeler where regexp_like(kelime, 'ot|at', 'i');
select*from kelimeler where regexp_like(kelime, 'ot|at'); -- 'i' yazmasak da default olarak case-sensitive olmadigi icin ayni sonucu verir

-- Q3 : 'ho' veya 'hi' ile baslayan kelimeleri case-sensitive'e dikkat etmeksizin listele
-- NOT: Baslangici gostermek icin ^ karakteri kullanilir.

select*from kelimeler where regexp_like (kelime, '^ho|^hi');
select*from kelimeler where regexp_like (kelime, '^(ho|hi)'); -- ^ parantezine alarak da olur

-- Q4 : Sonu 't' veya 'm' ile bitenler kelimeleri case-sensitive'e dikkat etmeksizin listele
-- NOT: Bitisi gostermek icin $ karakteri kullanilir.

select*from kelimeler where regexp_like (kelime, '(t$|m$)');
select*from kelimeler where regexp_like (kelime, '(t|m)$');  -- $ karakterini sondan paranteze alarak da olur

-- Q5 : h ile baslayip t ile biten 3 harfli kelimeleri (h ile t kucuk harfli olanlari) listeleyiniz
-- NOT : [!-~] = Butun karakterleri (özel karakter, sayi, harf) ifade eder.
-- NOT : [a-zA-Z0-9] = Harf ve rakamlari temsil eder.
-- NOT : [!-~], [a-zA-Z0-9]  ifadeleri  LIKE ta ögrendigimiz _ karakteri ile ayni isleve sahiptir. Yani _ , [!-~] , [a-zA-Z0-9]  bir karakterlik yer isgal eder

select*from kelimeler where regexp_like (kelime, '^h[!-~]t','c');       -- 1. yol
select*from kelimeler where regexp_like (kelime, '^h[a-zA-Z0-9]t','c'); -- 2. yol 

select*from kelimeler where kelime like 'h_t'; -- 
-- bu cözüm de yukaridaki ayni sonucu verir. Ancak REGEXP_LIKE'dan farkli olarak case-sensitivity'e dikkat etmez!!!
-- sorgumuzun case sensitive olmasini istiyorsak REGEXP_LIKE sorgusunu tercih etmeliyiz

SELECT kelime
FROM kelimeler
WHERE REGEXP_LIKE(kelime, 'h[A-Z]t','c'); -- 2. karakteri sadece A'dan Z'ye olanlari filtreler.

SELECT kelime
FROM kelimeler
WHERE REGEXP_LIKE(kelime, 'h[a-z]t','c'); -- 2. karakteri sadece sadece a' dan z'ye olanlari filtreler.

SELECT kelime
FROM kelimeler
WHERE REGEXP_LIKE(kelime, 'h[0-9]t','c'); -- 2. karakteri sadece sadece 0 dan 9 a kadar olanlari filtreler.

SELECT kelime
FROM kelimeler
WHERE REGEXP_LIKE(kelime, 'h[!-~]t','c'); -- 2. karakteri ozel karakter, rakam ve harf olanlari filtreler.

-- Q6 : 2. harfi O olan 3 harfli kelimeleri (O harfi buyuk olanlari) listeleyiniz

select kelime from kelimeler where regexp_like(kelime, '[!-~]O[!-~]', 'c');             -- 1. yol
select kelime from kelimeler where regexp_like(kelime, '[a-zA-Z0-9]O[a-zA-Z0-9]', 'c'); -- 2. yol

-- Dogru Cozum
SELECT kelime
FROM kelimeler
WHERE REGEXP_LIKE (kelime, '^.[O][a-zA-Z]$','c');


-- Q7 : 2. ve 3. harfi o olan tum kelimeleri (case sensitive olmaksizin) listeleyiniz


select*from kelimeler where regexp_like(kelime, '[a-zA-Z0-9]oo[a-zA-Z0-9]'); 

select*from kelimeler where kelime like('%oo%'); 
 

