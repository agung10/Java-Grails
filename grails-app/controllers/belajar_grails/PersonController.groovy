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
            flash.message = "Error loading data: ${e.message}"
            [persons: [], total: 0]
        }
    }

    def create() {
        try {
            String nama = params.nama?.trim()
            Integer umur = params.umur as Integer

            if (!nama || nama.isEmpty()) {
                flash.message = "Nama harus diisi!"
                redirect(action: "index")
                return
            }
            
            if (!umur || umur <= 0) {
                flash.message = "Umur harus diisi dan lebih dari 0!"
                redirect(action: "index")
                return
            }
            
            def person = personService.store(nama, umur)
            if (person) {
                flash.message = "Data ${person.nama} berhasil disimpan!"
            } else {
                flash.message = "Gagal menyimpan data! Periksa kembali inputan Anda."
            }
        } catch (Exception e) {
            flash.message = "Error: ${e.message}"
            println "Exception in create: ${e.message}"
            e.printStackTrace()
        }
        
        redirect(action: "index")
    }

    def show() {
        Long id = params.id as Long
        def person = personService.findById(id)
        
        if (!person) {
            flash.message = "Data dengan ID ${id} tidak ditemukan!"
            redirect(action: "index")
            return
        }
        
        [person: person]
    }

    def edit() {
        Long id = params.id as Long
        def person = personService.findById(id)
        
        if (!person) {
            flash.message = "Data dengan ID ${id} tidak ditemukan!"
            redirect(action: "index")
            return
        }
        
        [person: person]
    }

    def update() {
        Long id = params.id as Long
        String nama = params.nama
        Integer umur = params.umur as Integer
        
        if (!nama || !umur) {
            flash.message = "Nama dan Umur harus diisi!"
            redirect(action: "edit", params: [id: id])
            return
        }
        
        def person = personService.update(id, nama, umur)
        
        if (person) {
            flash.message = "Data ${person.nama} berhasil diupdate!"
            redirect(action: "index")
        } else {
            flash.message = "Data gagal diupdate!"
            redirect(action: "edit", params: [id: id])
        }
    }

    def destroy() {
        Long id = params.id as Long
        String nama = params.nama
        boolean deleted = personService.delete(id)

        if (deleted) {
            flash.message = "Data ${nama} berhasil dihapus!"
        } else {
            flash.message = "Data dengan ID ${id} tidak ditemukan atau gagal dihapus!"
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
