
CREATE DATABASE IK_Sisstemi;
GO 
USE IK_Sisstemi;
GO

-- ************************************************
-- 2. TABLOLARI OLUÞTURMA (PK ve FK'lara Dikkat Ederek Sýralama)
-- ************************************************

-- 2.1. birimler Tablosu (Referans Verilen Ýlk Tablo)
CREATE TABLE birimler (
    birim_id INT PRIMARY KEY,
    birim_ad CHAR(25) NOT NULL
);
GO

-- 2.2. calisanlar Tablosu (birimler'e FK içerir)
CREATE TABLE calisanlar (
    calisan_id INT PRIMARY KEY,
    ad CHAR(25) NOT NULL,
    soyad CHAR(25) NOT NULL,
    maas INT NOT NULL,
    katilma_tarihi DATETIME NOT NULL,
    calisan_birim_id INT NOT NULL,
    -- FOREIGN KEY Tanýmlamasý: calisanlar <- birimler
    CONSTRAINT FK_CalisanBirim FOREIGN KEY (calisan_birim_id) REFERENCES birimler(birim_id)
);
GO

-- 2.3. unvan Tablosu (calisanlar'a FK içerir)
CREATE TABLE unvan (
    unvan_calisan_id INT NOT NULL,
    unvan_ad CHAR(25) NOT NULL,
    unvan_tarih DATETIME NOT NULL,
    -- Composite Primary Key (Bir çalýþanýn ayný tarihte ayný unvaný olamaz)
    PRIMARY KEY (unvan_calisan_id, unvan_tarih), 
    -- FOREIGN KEY Tanýmlamasý: unvan <- calisanlar
    CONSTRAINT FK_UnvanCalisan FOREIGN KEY (unvan_calisan_id) REFERENCES calisanlar(calisan_id)
);
GO

-- 2.4. ikramiye Tablosu (calisanlar'a FK içerir)
CREATE TABLE ikramiye (
    ikramiye_calisan_id INT NOT NULL,
    ikramiye_ucret INT NOT NULL,
    ikramiye_tarih DATETIME NOT NULL,
    -- Composite Primary Key (Bir çalýþana ayný tarihte ikramiye kaydý girilemez)
    PRIMARY KEY (ikramiye_calisan_id, ikramiye_tarih),
    -- FOREIGN KEY Tanýmlamasý: ikramiye <- calisanlar
    CONSTRAINT FK_IkramiyeCalisan FOREIGN KEY (ikramiye_calisan_id) REFERENCES calisanlar(calisan_id)
);
GO

-- ************************************************
-- 3. VERÝ GÝRÝÞÝ (INSERT INTO)
-- ************************************************

-- 3.1. birimler tablosuna veri ekleme
INSERT INTO birimler (birim_id, birim_ad) VALUES (1, 'Yazilim');
INSERT INTO birimler (birim_id, birim_ad) VALUES (2, 'Donanim');
INSERT INTO birimler (birim_id, birim_ad) VALUES (3, 'Insan Kaynaklari');
INSERT INTO birimler (birim_id, birim_ad) VALUES (4, 'Pazarlama');
INSERT INTO birimler (birim_id, birim_ad) VALUES (5, 'Arastirma');
GO

-- 3.2. calisanlar tablosuna veri ekleme
INSERT INTO calisanlar (calisan_id, ad, soyad, maas, katilma_tarihi, calisan_birim_id) VALUES (101, 'Deniz', 'Yýlmaz', 60000, '2023-01-20', 1);
INSERT INTO calisanlar (calisan_id, ad, soyad, maas, katilma_tarihi, calisan_birim_id) VALUES (102, 'Emre', 'Kara', 75000, '2022-11-15', 2);
INSERT INTO calisanlar (calisan_id, ad, soyad, maas, katilma_tarihi, calisan_birim_id) VALUES (103, 'Ayþe', 'Demir', 90000, '2021-06-10', 3);
INSERT INTO calisanlar (calisan_id, ad, soyad, maas, katilma_tarihi, calisan_birim_id) VALUES (104, 'Burak', 'Cevik', 50000, '2023-05-01', 4);
INSERT INTO calisanlar (calisan_id, ad, soyad, maas, katilma_tarihi, calisan_birim_id) VALUES (105, 'Gizem', 'Aydýn', 80000, '2022-03-25', 1);
INSERT INTO calisanlar (calisan_id, ad, soyad, maas, katilma_tarihi, calisan_birim_id) VALUES (106, 'Can', 'Öztürk', 110000, '2021-01-01', 2);
INSERT INTO calisanlar (calisan_id, ad, soyad, maas, katilma_tarihi, calisan_birim_id) VALUES (107, 'Ece', 'Acar', 55000, '2024-02-14', 3);
INSERT INTO calisanlar (calisan_id, ad, soyad, maas, katilma_tarihi, calisan_birim_id) VALUES (108, 'Furkan', 'Tekin', 120000, '2020-09-17', 5);
GO

-- 3.3. unvan tablosuna veri ekleme
INSERT INTO unvan (unvan_calisan_id, unvan_ad, unvan_tarih) VALUES (101, 'Yazilim Uzmani', '2023-01-20');
INSERT INTO unvan (unvan_calisan_id, unvan_ad, unvan_tarih) VALUES (102, 'Donanim Uzmani', '2022-11-15');
INSERT INTO unvan (unvan_calisan_id, unvan_ad, unvan_tarih) VALUES (103, 'Insan Kaynaklari Mudur', '2021-06-10');
INSERT INTO unvan (unvan_calisan_id, unvan_ad, unvan_tarih) VALUES (104, 'Pazarlama Uzmani', '2023-05-01');
INSERT INTO unvan (unvan_calisan_id, unvan_ad, unvan_tarih) VALUES (105, 'Yazilim Uzmani', '2022-03-25');
INSERT INTO unvan (unvan_calisan_id, unvan_ad, unvan_tarih) VALUES (106, 'Mudur', '2021-01-01');
INSERT INTO unvan (unvan_calisan_id, unvan_ad, unvan_tarih) VALUES (107, 'Uzman Yardimcisi', '2024-02-14');
INSERT INTO unvan (unvan_calisan_id, unvan_ad, unvan_tarih) VALUES (108, 'Yonetici', '2020-09-17');
INSERT INTO unvan (unvan_calisan_id, unvan_ad, unvan_tarih) VALUES (102, 'Proje Yoneticisi', '2023-12-01'); -- Birden fazla unvan örneði
GO

-- 3.4. ikramiye tablosuna veri ekleme
INSERT INTO ikramiye (ikramiye_calisan_id, ikramiye_ucret, ikramiye_tarih) VALUES (101, 5000, '2023-10-01');
INSERT INTO ikramiye (ikramiye_calisan_id, ikramiye_ucret, ikramiye_tarih) VALUES (102, 3000, '2023-10-01');
INSERT INTO ikramiye (ikramiye_calisan_id, ikramiye_ucret, ikramiye_tarih) VALUES (103, 6000, '2023-10-01');
INSERT INTO ikramiye (ikramiye_calisan_id, ikramiye_ucret, ikramiye_tarih) VALUES (104, 4000, '2023-10-01');
INSERT INTO ikramiye (ikramiye_calisan_id, ikramiye_ucret, ikramiye_tarih) VALUES (105, 5000, '2023-10-01');
INSERT INTO ikramiye (ikramiye_calisan_id, ikramiye_ucret, ikramiye_tarih) VALUES (106, 7000, '2023-10-01');
GO


-- ************************************************
-- 4. KONTROL SORGULARI (Soru 2'deki tablo çýktýlarý için)
-- ************************************************

SELECT * FROM birimler;
SELECT * FROM calisanlar;
SELECT * FROM unvan;
SELECT * FROM ikramiye;
GO


-- ************************************************
-- 5. RAPORLAMA SORGULARI (Soru 3-10)
-- ************************************************

-- Soru 3: "Yazýlým” veya “Donaným” birimlerinde çalýþanlarýn ad, soyad ve maaþ bilgileri
SELECT
    c.ad,
    c.soyad,
    c.maas
FROM
    calisanlar c
INNER JOIN
    birimler b ON c.calisan_birim_id = b.birim_id
WHERE
    b.birim_ad IN ('Yazilim', 'Donanim');
GO

-- Soru 4: Maaþý en yüksek olan çalýþanlarýn ad, soyad ve maaþ bilgileri
SELECT
    ad,
    soyad,
    maas
FROM
    calisanlar
WHERE
    maas = (SELECT MAX(maas) FROM calisanlar);
GO

-- Soru 5: Birimlerin her birinde kaç adet çalýþan olduðu ve birimlerin isimleri
SELECT
    b.birim_ad,
    COUNT(c.calisan_id) AS Calisan_Sayisi
FROM
    birimler b
LEFT JOIN
    calisanlar c ON b.birim_id = c.calisan_birim_id
GROUP BY
    b.birim_ad;
GO

-- Soru 6: Birden fazla çalýþana ait olan unvanlarýn isimlerini ve o unvan altýnda çalýþanlarýn sayýsýný
SELECT
    unvan_ad,
    COUNT(unvan_calisan_id) AS Calisan_Sayisi
FROM
    unvan
GROUP BY
    unvan_ad
HAVING
    COUNT(unvan_calisan_id) > 1;
GO

-- Soru 7: Maaþlarý “50000” ve “100000” arasýnda deðiþen çalýþanlarýn ad, soyad ve maaþ bilgileri
SELECT
    ad,
    soyad,
    maas
FROM
    calisanlar
WHERE
    maas BETWEEN 50000 AND 100000;
GO

-- Soru 8: Ýkramiye hakkýna sahip çalýþanlara ait ad, soyad, birim, unvan ve ikramiye ücreti bilgileri
SELECT
    c.ad,
    c.soyad,
    b.birim_ad AS Birim,
    u.unvan_ad AS Unvan,
    i.ikramiye_ucret AS Ikramiye_Ucreti
FROM
    calisanlar c
INNER JOIN
    ikramiye i ON c.calisan_id = i.ikramiye_calisan_id
INNER JOIN
    birimler b ON c.calisan_birim_id = b.birim_id
INNER JOIN
    unvan u ON c.calisan_id = u.unvan_calisan_id
WHERE
    i.ikramiye_ucret IS NOT NULL
ORDER BY c.calisan_id; -- Çýktýyý düzenlemek için eklendi
GO

-- Soru 9: Ünvaný “Yönetici” ve “Müdür” olan çalýþanlarýn ad, soyad ve ünvanlarý
SELECT
    c.ad,
    c.soyad,
    u.unvan_ad AS Unvan
FROM
    calisanlar c
INNER JOIN
    unvan u ON c.calisan_id = u.unvan_calisan_id
WHERE
    u.unvan_ad IN ('Yonetici', 'Mudur', 'Insan Kaynaklari Mudur'); -- Veri giriþine göre 'Insan Kaynaklari Mudur' da eklendi.
GO

-- Soru 10: Her birimde en yüksek maaþ alan çalýþanlarýn ad, soyad ve maaþ bilgileri (CTE ile tek sorgu)
WITH RankedSalaries AS (
    SELECT
        c.ad,
        c.soyad,
        c.maas,
        b.birim_ad,
        ROW_NUMBER() OVER (PARTITION BY b.birim_ad ORDER BY c.maas DESC) as rn
    FROM
        calisanlar c
    INNER JOIN
        birimler b ON c.calisan_birim_id = b.birim_id
)
SELECT
    ad,
    soyad,
    maas,
    birim_ad
FROM
    RankedSalaries
WHERE
    rn = 1;
GO
