SELECT
    p.nama_persimpangan,
    COUNT(pd.id_penyesuaian) AS jumlah_penyesuaian,
    AVG(pd.durasi_hijau_baru) AS rata_rata_durasi_hijau
FROM penyesuaian_durasi AS pd
JOIN persimpangan AS p
    ON pd.id_persimpangan = p.id_persimpangan
JOIN petugas AS pt
    ON pd.id_petugas = pt.id_petugas
WHERE pd.durasi_hijau_baru >= 30
GROUP BY p.id_persimpangan;
