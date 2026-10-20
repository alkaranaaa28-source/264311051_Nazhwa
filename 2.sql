-- CREATE: Menambahkan minimal 3 data ke tabel persimpangan
INSERT INTO persimpangan
(id_persimpangan, nama_persimpangan, lokasi)
VALUES
('P001', 'Perempatan Sleko', 'Jl. Trunojoyo'),
('P002', 'Perempatan Tean', 'Jl. D.I. Panjaitan'),
('P003', 'Perempatan Tugu', 'Jl. Pahlawan');

-- CREATE: Menambahkan minimal 3 data ke tabel petugas
INSERT INTO petugas
(id_petugas, nama_petugas, jabatan)
VALUES
('PT001', 'Andi Pratama', 'Administrator Sistem'),
('PT002', 'Budi Santoso', 'Operator Lalu Lintas'),
('PT003', 'Citra Maharani', 'Teknisi Perangkat');

-- CREATE: Menambahkan minimal 3 data ke tabel penyesuaian_durasi
INSERT INTO penyesuaian_durasi
(id_penyesuaian, waktu_penyesuaian, durasi_hijau_baru,
 id_persimpangan, id_petugas)
VALUES
('PJ001', '2026-10-19 07:00:00', 35, 'P001', 'PT001'),
('PJ002', '2026-10-19 07:15:00', 40, 'P002', 'PT002'),
('PJ003', '2026-10-19 07:30:00', 45, 'P003', 'PT003');

-- READ: Menampilkan seluruh data tabel persimpangan
SELECT * FROM persimpangan;

-- UPDATE: Mengubah durasi lampu hijau berdasarkan ID
UPDATE penyesuaian_durasi
SET durasi_hijau_baru = 40
WHERE id_penyesuaian = 'PJ001';

-- DELETE: Menghapus satu data penyesuaian berdasarkan ID
DELETE FROM penyesuaian_durasi
WHERE id_penyesuaian = 'PJ003';
