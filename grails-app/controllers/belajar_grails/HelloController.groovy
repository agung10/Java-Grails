package belajar_grails

class HelloController {
    PersonService personService

    def index() {
        render "Hallo Dunia dari Grails"
    }

    def listPerson() {
        def persons = Person.list()
        def result = "Database Contents:<br/><br/>"
        
        persons.each { person ->
            result += "ID: ${person.id}<br/>"
            result += "Nama: ${person.nama}<br/>"
            result += "Umur: ${person.umur}<br/>"
            result += "---<br/>"
        }
        
        render result += "<br/>Total ditemukan: ${persons.size()}"
    }

    def addPerson() {
        try {
            def p = personService.store("Agung", 24)
            render "Data dengan nama: ${p.nama} yang berumur ${p.umur} tahun telah berhasil disimpan!"
        } catch (Exception e) {
            render "Error: ${e.message}"
        }
    }

    def viewPerson() {
        Long id = params.id as Long ?: 1
        def person = personService.findById(id)
        
        if (person) {
            render "Data ditemukan:<br/>ID: ${person.id}<br/>Nama: ${person.nama}<br/>Umur: ${person.umur}"
        } else {
            render "Data dengan ID ${id} tidak ditemukan!"
        }
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

    def editPerson() {
        Long id = params.id as Long ?: 1 // Default ID
        String nama = params.nama ?: "Agung Baru"
        Integer umur = params.umur as Integer ?: 25
        
        def person = personService.update(id, nama, umur)
        
        if (person) {
            render "Data berhasil diupdate:<br/>ID: ${person.id}<br/>Nama: ${person.nama}<br/>Umur: ${person.umur}"
        } else {
            render "Data dengan ID ${id} tidak ditemukan atau gagal diupdate!"
        }
    }

    def deletePerson() {
        Long id = params.is as Long ?: 1
        boolean deleted = personService.delete(id)

        if (deleted) {
            render "Data dengan ID ${id} berhasil dihapus!"
        } else {
            render "Data dengan ID ${id} tidak ditemukan atau gagal dihapus!"
        }
    }
}
