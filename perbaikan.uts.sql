-- 1. PERSIMPANGAN
CREATE TABLE erd_persimpangan (
    id_persimpangan VARCHAR(10) PRIMARY KEY,
    nama_persimpangan VARCHAR(100) NOT NULL,
    lokasi VARCHAR(255) NOT NULL
);

INSERT INTO erd_persimpangan
(id_persimpangan, nama_persimpangan, lokasi)
VALUES
('P001', 'Perempatan Sleko', 'Pertemuan Jl. Trunojoyo, Jl. Mayjen Sungkono, dan Jl. Soekarno-Hatta'),
('P002', 'Perempatan Te''an', 'Pertemuan Jl. D.I. Panjaitan dan Jl. Raya Ponorogo'),
('P003', 'Perempatan 501', 'Pertemuan Jl. Urip Sumoharjo, Jl. Tirta Raya, dan Jl. Sido Makmur, wilayah barat Kota Madiun'),
('P004', 'Perempatan Tugu', 'Pertemuan Jl. Pahlawan, Jl. Panglima Sudirman, dan Jl. Cokroaminoto, pusat Kota Madiun'),
('P005', 'Perempatan Klegen', 'Jl. M. Thamrin dan jalan di sekitarnya'),
('P006', 'Perempatan Salak (Simpang Asahan)', 'Pertemuan Jl. Letjen Haryono, Jl. Asahan, dan Jl. Salak'),
('P007', 'Perempatan Rejoagung (Tugu UKS)', 'Jl. Basuki Rahmat, batas utara Kota Madiun menuju Nglames'),
('P008', 'Perempatan Sriti', 'Pertemuan Jl. Urip Sumoharjo dan Jl. A. Yani'),
('P009', 'Perempatan Bali', 'Jl. Bali dan akses menuju Stadion Wilis'),
('P010', 'Perempatan Serayu', 'Sepanjang koridor Jl. Serayu, Kota Madiun'),
('P011', 'Perempatan PGA', 'Sepanjang koridor Jl. Serayu, berdekatan dengan Perempatan Serayu');


-- 2. PETUGAS
CREATE TABLE erd_petugas (
    id_petugas VARCHAR(10) PRIMARY KEY,
    nama_petugas VARCHAR(100) NOT NULL,
    jabatan VARCHAR(60) NOT NULL
);

INSERT INTO erd_petugas
(id_petugas, nama_petugas, jabatan)
VALUES
('PT001', 'Andi Pratama', 'Administrator Sistem'),
('PT002', 'Budi Santoso', 'Operator Lalu Lintas'),
('PT003', 'Citra Maharani', 'Teknisi Perangkat'),
('PT004', 'Dimas Saputra', 'Petugas Pemantauan'),
('PT005', 'Eka Wulandari', 'Operator Lalu Lintas'),
('PT006', 'Fajar Ramadhan', 'Teknisi Perangkat'),
('PT007', 'Gita Permata', 'Administrator Sistem'),
('PT008', 'Hendra Wijaya', 'Petugas Pemantauan'),
('PT009', 'Intan Puspita', 'Operator Lalu Lintas'),
('PT010', 'Joko Setiawan', 'Teknisi Perangkat');


-- 3. RUAS JALAN
CREATE TABLE erd_ruas_jalan (
    no_ruas VARCHAR(10) PRIMARY KEY,
    id_persimpangan VARCHAR(10) NOT NULL,
    lebar_jalan DECIMAL(6,2) NOT NULL,
    kepadatan VARCHAR(20) NOT NULL,

    FOREIGN KEY (id_persimpangan)
        REFERENCES erd_persimpangan(id_persimpangan),

    CHECK (lebar_jalan > 0),
    CHECK (kepadatan IN (
        'Lancar', 'Sedang', 'Padat', 'Sangat Padat'
    ))
);

INSERT INTO erd_ruas_jalan
(no_ruas, id_persimpangan, lebar_jalan, kepadatan)
VALUES
('RJ001', 'P001', 8, 'Sedang'),
('RJ002', 'P002', 10, 'Padat'),
('RJ003', 'P003', 7, 'Sangat Padat'),
('RJ004', 'P004', 12, 'Lancar'),
('RJ005', 'P005', 9, 'Sedang'),
('RJ006', 'P006', 8, 'Padat'),
('RJ007', 'P007', 11, 'Lancar'),
('RJ008', 'P008', 7, 'Sangat Padat'),
('RJ009', 'P009', 10, 'Sedang'),
('RJ010', 'P010', 9, 'Padat');


-- 4. LAMPU LALU LINTAS
CREATE TABLE erd_lampu_lalu_lintas (
    id_lampu VARCHAR(10) PRIMARY KEY,
    no_ruas VARCHAR(10) NOT NULL,
    durasi_merah INT NOT NULL,
    durasi_kuning INT NOT NULL,
    durasi_hijau INT NOT NULL,
    arah VARCHAR(20) NOT NULL,

    FOREIGN KEY (no_ruas)
        REFERENCES erd_ruas_jalan(no_ruas),

    CHECK (
        durasi_merah > 0
        AND durasi_kuning > 0
        AND durasi_hijau > 0
    ),

    CHECK (arah IN (
        'Utara', 'Selatan', 'Timur', 'Barat'
    ))
);

INSERT INTO erd_lampu_lalu_lintas
(id_lampu, no_ruas, durasi_merah,
 durasi_kuning, durasi_hijau, arah)
VALUES
('L001', 'RJ001', 60, 3, 30, 'Utara'),
('L002', 'RJ002', 60, 3, 30, 'Selatan'),
('L003', 'RJ003', 60, 3, 30, 'Timur'),
('L004', 'RJ004', 60, 3, 30, 'Barat'),
('L005', 'RJ005', 55, 3, 35, 'Utara'),
('L006', 'RJ006', 55, 3, 35, 'Selatan'),
('L007', 'RJ007', 55, 3, 35, 'Timur'),
('L008', 'RJ008', 55, 3, 35, 'Barat'),
('L009', 'RJ009', 50, 3, 40, 'Utara'),
('L010', 'RJ010', 50, 3, 40, 'Selatan');


-- 5. PERANGKAT DETEKSI
CREATE TABLE erd_perangkat_deteksi (
    id_perangkat VARCHAR(10) PRIMARY KEY,
    no_ruas VARCHAR(10) NOT NULL,
    status_alat VARCHAR(30) NOT NULL,
    lokasi_pasang VARCHAR(100) NOT NULL,

    FOREIGN KEY (no_ruas)
        REFERENCES erd_ruas_jalan(no_ruas),

    CHECK (status_alat IN (
        'Aktif',
        'Tidak Aktif',
        'Dalam Pemeliharaan'
    ))
);

INSERT INTO erd_perangkat_deteksi
(id_perangkat, no_ruas, status_alat, lokasi_pasang)
VALUES
('PD001', 'RJ001', 'Aktif', 'Perempatan Sleko'),
('PD002', 'RJ002', 'Aktif', 'Perempatan Te''an'),
('PD003', 'RJ003', 'Aktif', 'Perempatan 501'),
('PD004', 'RJ004', 'Aktif', 'Perempatan Tugu'),
('PD005', 'RJ005', 'Aktif', 'Perempatan Klegen'),
('PD006', 'RJ006', 'Aktif', 'Perempatan Salak'),
('PD007', 'RJ007', 'Aktif', 'Perempatan Rejoagung (Tugu UKS)'),
('PD008', 'RJ008', 'Tidak Aktif', 'Perempatan Sriti'),
('PD009', 'RJ009', 'Aktif', 'Perempatan Bali'),
('PD010', 'RJ010', 'Dalam Pemeliharaan', 'Perempatan Serayu'),
('PD011', 'RJ010', 'Aktif', 'Perempatan PGA');


-- 6. SENSOR FISIK
CREATE TABLE erd_sensor_fisik (
    id_sensor VARCHAR(10) PRIMARY KEY,
    id_perangkat VARCHAR(10) NOT NULL UNIQUE,
    jenis_sensor VARCHAR(60) NOT NULL,
    ambang_jarak DECIMAL(8,2) NOT NULL,

    FOREIGN KEY (id_perangkat)
        REFERENCES erd_perangkat_deteksi(id_perangkat),

    CHECK (ambang_jarak > 0)
);

INSERT INTO erd_sensor_fisik
(id_sensor, id_perangkat, jenis_sensor, ambang_jarak)
VALUES
('SF001', 'PD001', 'Sensor Ultrasonik', 10),
('SF002', 'PD002', 'Sensor Ultrasonik', 15),
('SF003', 'PD003', 'Sensor Infrared', 8),
('SF004', 'PD004', 'Sensor Infrared', 12),
('SF005', 'PD005', 'Sensor Radar', 20),
('SF006', 'PD006', 'Sensor Radar', 25),
('SF007', 'PD007', 'Sensor Ultrasonik', 18),
('SF008', 'PD008', 'Sensor Infrared', 10),
('SF009', 'PD009', 'Sensor Radar', 15),
('SF010', 'PD010', 'Sensor Ultrasonik', 12);


-- 7. KAMERA CCTV
CREATE TABLE erd_kamera_cctv (
    id_kamera VARCHAR(10) PRIMARY KEY,
    id_perangkat VARCHAR(10) NOT NULL UNIQUE,
    resolusi VARCHAR(60) NOT NULL,
    fps INT NOT NULL,

    FOREIGN KEY (id_perangkat)
        REFERENCES erd_perangkat_deteksi(id_perangkat),

    CHECK (fps > 0)
);

INSERT INTO erd_kamera_cctv
(id_kamera, id_perangkat, resolusi, fps)
VALUES
('KC001', 'PD001', '1920x1080 (Full HD)', 30),
('KC002', 'PD002', '1920x1080 (Full HD)', 25),
('KC003', 'PD003', '1280x720 (HD)', 30),
('KC004', 'PD004', '2560x1440 (2K)', 30),
('KC005', 'PD005', '1920x1080 (Full HD)', 60),
('KC006', 'PD006', '1280x720 (HD)', 25),
('KC007', 'PD007', '2560x1440 (2K)', 25),
('KC008', 'PD008', '1920x1080 (Full HD)', 30),
('KC009', 'PD009', '3840x2160 (4K)', 30),
('KC010', 'PD010', '1280x720 (HD)', 30);


-- 8. PEMANTAUAN
CREATE TABLE erd_pemantauan (
    id_pemantauan VARCHAR(10) PRIMARY KEY,
    no_ruas VARCHAR(10) NOT NULL,
    id_petugas VARCHAR(10) NOT NULL,
    id_perangkat VARCHAR(10) NOT NULL,
    waktu_pengamatan DATETIME NOT NULL,
    jumlah_kendaraan INT NOT NULL,
    panjang_antrean DECIMAL(8,2) NOT NULL,
    kecepatan_kendaraan DECIMAL(8,2) NOT NULL,
    kondisi_kepadatan VARCHAR(20) NOT NULL,

    FOREIGN KEY (no_ruas)
        REFERENCES erd_ruas_jalan(no_ruas),

    FOREIGN KEY (id_petugas)
        REFERENCES erd_petugas(id_petugas),

    FOREIGN KEY (id_perangkat)
        REFERENCES erd_perangkat_deteksi(id_perangkat),

    CHECK (
        jumlah_kendaraan >= 0
        AND panjang_antrean >= 0
        AND kecepatan_kendaraan >= 0
    ),

    CHECK (kondisi_kepadatan IN (
        'Lancar', 'Sedang', 'Padat', 'Sangat Padat'
    ))
);

INSERT INTO erd_pemantauan
(id_pemantauan, no_ruas, id_petugas, id_perangkat,
 waktu_pengamatan, jumlah_kendaraan, panjang_antrean,
 kecepatan_kendaraan, kondisi_kepadatan)
VALUES
('PM001', 'RJ001', 'PT001', 'PD001', '2026-10-17 07:00:00', 85, 45, 20, 'Sedang'),
('PM002', 'RJ002', 'PT002', 'PD002', '2026-10-17 07:15:00', 120, 65, 15, 'Padat'),
('PM003', 'RJ003', 'PT003', 'PD003', '2026-10-17 07:30:00', 150, 80, 10, 'Sangat Padat'),
('PM004', 'RJ004', 'PT004', 'PD004', '2026-10-17 08:00:00', 100, 50, 18, 'Padat'),
('PM005', 'RJ005', 'PT005', 'PD005', '2026-10-17 08:15:00', 70, 30, 25, 'Sedang'),
('PM006', 'RJ006', 'PT006', 'PD006', '2026-10-17 12:00:00', 60, 25, 30, 'Lancar'),
('PM007', 'RJ007', 'PT007', 'PD007', '2026-10-17 12:15:00', 95, 40, 22, 'Sedang'),
('PM008', 'RJ008', 'PT008', 'PD008', '2026-10-17 16:00:00', 130, 70, 12, 'Padat'),
('PM009', 'RJ009', 'PT009', 'PD009', '2026-10-17 16:15:00', 160, 90, 8, 'Sangat Padat'),
('PM010', 'RJ010', 'PT010', 'PD010', '2026-10-17 17:00:00', 140, 75, 10, 'Sangat Padat');


-- 9. PENYESUAIAN DURASI
CREATE TABLE erd_penyesuaian_durasi (
    id_penyesuaian VARCHAR(10) PRIMARY KEY,
    id_pemantauan VARCHAR(10) NOT NULL,
    id_petugas VARCHAR(10) NOT NULL,
    waktu_penyesuaian DATETIME NOT NULL,
    durasi_hijau_baru INT NOT NULL,

    FOREIGN KEY (id_pemantauan)
        REFERENCES erd_pemantauan(id_pemantauan),

    FOREIGN KEY (id_petugas)
        REFERENCES erd_petugas(id_petugas),

    CHECK (durasi_hijau_baru > 0)
);

INSERT INTO erd_penyesuaian_durasi
(id_penyesuaian, id_pemantauan, id_petugas,
 waktu_penyesuaian, durasi_hijau_baru)
VALUES
('PJ001', 'PM001', 'PT001', '2026-10-17 07:00:00', 35),
('PJ002', 'PM002', 'PT002', '2026-10-17 07:15:00', 40),
('PJ003', 'PM003', 'PT003', '2026-10-17 07:30:00', 45),
('PJ004', 'PM004', 'PT004', '2026-10-17 08:00:00', 30),
('PJ005', 'PM005', 'PT005', '2026-10-17 08:15:00', 25),
('PJ006', 'PM006', 'PT006', '2026-10-17 12:00:00', 30),
('PJ007', 'PM007', 'PT007', '2026-10-17 12:15:00', 35),
('PJ008', 'PM008', 'PT008', '2026-10-17 16:00:00', 40),
('PJ009', 'PM009', 'PT009', '2026-10-17 16:15:00', 50),
('PJ010', 'PM010', 'PT010', '2026-10-17 17:00:00', 45);


SELECT 'Persimpangan' AS nama_tabel, COUNT(*) AS jumlah
FROM erd_persimpangan
UNION ALL
SELECT 'Petugas', COUNT(*) FROM erd_petugas
UNION ALL
SELECT 'Ruas Jalan', COUNT(*) FROM erd_ruas_jalan
UNION ALL
SELECT 'Lampu Lalu Lintas', COUNT(*) FROM erd_lampu_lalu_lintas
UNION ALL
SELECT 'Perangkat Deteksi', COUNT(*) FROM erd_perangkat_deteksi
UNION ALL
SELECT 'Sensor Fisik', COUNT(*) FROM erd_sensor_fisik
UNION ALL
SELECT 'Kamera CCTV', COUNT(*) FROM erd_kamera_cctv
UNION ALL
SELECT 'Pemantauan', COUNT(*) FROM erd_pemantauan
UNION ALL
SELECT 'Penyesuaian Durasi', COUNT(*) FROM erd_penyesuaian_durasi;


SELECT * FROM erd_persimpangan;
SELECT * FROM erd_petugas;
SELECT * FROM erd_ruas_jalan;
SELECT * FROM erd_lampu_lalu_lintas;
SELECT * FROM erd_perangkat_deteksi;
SELECT * FROM erd_sensor_fisik;
SELECT * FROM erd_kamera_cctv;
SELECT * FROM erd_pemantauan;
SELECT * FROM erd_penyesuaian_durasi;
