CREATE TABLE persimpangan (
    id_persimpangan VARCHAR(10) PRIMARY KEY,
    nama_persimpangan VARCHAR(100) NOT NULL,
    lokasi VARCHAR(255) NOT NULL
);

CREATE TABLE petugas (
    id_petugas VARCHAR(10) PRIMARY KEY,
    nama_petugas VARCHAR(100) NOT NULL,
    jabatan VARCHAR(50) NOT NULL
);

CREATE TABLE penyesuaian_durasi (
    id_penyesuaian VARCHAR(10) PRIMARY KEY,
    waktu_penyesuaian DATETIME NOT NULL,
    durasi_hijau_baru INT NOT NULL,
    id_persimpangan VARCHAR(10) NOT NULL,
    id_petugas VARCHAR(10) NOT NULL,
    CONSTRAINT fk_penyesuaian_persimpangan
        FOREIGN KEY (id_persimpangan)
        REFERENCES persimpangan(id_persimpangan),
    CONSTRAINT fk_penyesuaian_petugas
        FOREIGN KEY (id_petugas)
        REFERENCES petugas(id_petugas)
);
