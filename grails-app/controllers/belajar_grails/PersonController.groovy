package belajar_grails
import belajar_grails.Person

class PersonController {
    def personService

    def index() {
        try {
            def persons = Person.list() ?: []
            def total = persons.size()
            
            [persons: persons, total: total]
        } catch (Exception e) {
            log.error("Error in index: ${e.message}", e)
            flash.error = "Error loading data: ${e.message}"
            [persons: [], total: 0]
        }
    }

    def create() {
        try {
            String nama = params.nama?.trim()
            String umurStr = params.umur?.trim()
            
            if (!nama && !umurStr) {
                flash.error = "Nama dan Umur harus diisi!"
                redirect(action: "index")
                return
            }
            
            if (!nama) {
                flash.error = "Nama tidak boleh kosong!"
                redirect(action: "index")
                return
            } else if (!nama.matches("^[a-zA-Z\\s]*\$")) {
                flash.error = "Nama hanya boleh mengandung huruf dan spasi!"
                redirect(action: "index")
                return
            } else if (nama.length() > 200) {
                flash.error = "Nama terlalu panjang! Maksimal 200 karakter."
                redirect(action: "index")
                return
            }
            
            if (!umurStr) {
                flash.error = "Umur tidak boleh kosong!"
                redirect(action: "index")
                return
            } else if (!umurStr.matches("^\\d+\$")) {
                flash.error = "Umur harus berupa angka!"
                redirect(action: "index")
                return
            }
            
            // Konversi umur ke Integer setelah memastikan formatnya valid
            Integer umur = umurStr.toInteger()
            if (umur < 1) {
                flash.error = "Umur tidak valid! Harus lebih besar dari 0."
                redirect(action: "index")
                return
            } else if (umur > 150) {
                flash.error = "Umur tidak valid! Maksimal 150 tahun."
                redirect(action: "index")
                return
            }
            
            def person = personService.store(nama, umur)
            if (person) {
                flash.success = "Data ${person.nama} berhasil disimpan!"
            } else {
                flash.error = "Gagal menyimpan data! Silakan coba lagi."
            }
        } catch (Exception e) {
            log.error("Error dalam create: ${e.message}", e)
            flash.error = "Terjadi kesalahan sistem! Silakan coba beberapa saat lagi."
        }
        
        redirect(action: "index")
    }

    def show() {
        Long id = params.id as Long
        def person = personService.findById(id)
        
        if (!person) {
            flash.error = "Data dengan ID ${id} tidak ditemukan!"
            redirect(action: "index")
            return
        }
        
        [person: person]
    }

    def edit() {
        Long id = params.id as Long
        def person = personService.findById(id)
        
        if (!person) {
            flash.error = "Data dengan ID ${id} tidak ditemukan!"
            redirect(action: "index")
            return
        }
        
        [person: person]
    }

    def update() {
        Long id = params.id as Long
        String nama = params.nama?.trim()
        String umurStr = params.umur?.trim()
        
        if (!nama && !umurStr) {
            flash.error = "Nama dan Umur harus diisi!"
            redirect(action: "edit", params: [id: id])
            return
        }
        
        if (!nama) {
            flash.error = "Nama tidak boleh kosong!"
            redirect(action: "edit", params: [id: id])
            return
        } else if (!nama.matches("^[a-zA-Z\\s]*\$")) {
            flash.error = "Nama hanya boleh mengandung huruf dan spasi!"
            redirect(action: "edit", params: [id: id])
            return
        } else if (nama.length() > 200) {
            flash.error = "Nama terlalu panjang! Maksimal 200 karakter."
            redirect(action: "edit", params: [id: id])
            return
        }
        
        if (!umurStr) {
            flash.error = "Umur tidak boleh kosong!"
            redirect(action: "edit", params: [id: id])
            return
        } else if (!umurStr.matches("^\\d+\$")) {
            flash.error = "Umur harus berupa angka!"
            redirect(action: "edit", params: [id: id])
            return
        }
        
        // Konversi umur ke Integer setelah memastikan formatnya valid
        Integer umur = umurStr.toInteger()
        if (umur < 1) {
            flash.error = "Umur tidak valid! Harus lebih besar dari 0."
            redirect(action: "edit", params: [id: id])
            return
        } else if (umur > 150) {
            flash.error = "Umur tidak valid! Maksimal 150 tahun."
            redirect(action: "edit", params: [id: id])
            return
        }
        
        def person = personService.update(id, nama, umur)
        
        if (person) {
            flash.success = "Data ${person.nama} berhasil diupdate!"
            redirect(action: "index")
        } else {
            flash.error = "Data gagal diupdate!"
            redirect(action: "edit", params: [id: id])
        }
    }

    def destroy() {
        Long id = params.id as Long
        String nama = params.nama
        boolean deleted = personService.delete(id)

        if (deleted) {
            flash.success = "Data ${nama} berhasil dihapus!"
        } else {
            flash.error = "Data dengan ID ${id} tidak ditemukan atau gagal dihapus!"
        }
        
        redirect(action: "index")
    }

    def findByName() {
        String nama = params.nama ?: "Agung"
        def person = personService.findByName(nama)

        if (person) {
            render "Data ditemukan: <br/> ID: ${person.id}<br/> Nama: ${person.nama}<br/> Umur: ${person.umur}"
        } else {
            render "Data dengan nama '${nama}' tidak ditemukan!"
        }
    }

    def findAllByName() {
        String nama = params.nama ?: "Agung"
        def persons = personService.findAllByName(nama)

        if (persons) {
            def result = "Data yang ditemukan dengan nama mengandung '${nama}':<br/><br/>"
            persons.each { person ->
                result += "ID: ${person.id}<br/>"
                result += "Nama: ${person.nama}<br/>"
                result += "Umur: ${person.umur}<br/>"
            }
            render result += "<br/>Total ditemukan: ${persons.size()}"
        } else {
            render "Tidak ada data yang mengandung nama '${nama}'"
        }
    }
}
