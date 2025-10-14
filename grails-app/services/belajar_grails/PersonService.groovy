package belajar_grails

import grails.gorm.transactions.Transactional
import belajar_grails.Person

@Transactional
class PersonService {
    def store(String nama, Integer umur) {
        def p = new Person(nama: nama, umur: umur)
        p.save(flush: true)
        return p
    }

    def findById(Long id) {
        return Person.get(id)
    }

    def findByName(String nama) {
        return Person.findByNama(nama)
    }

    def findAllByName(String nama) {
        return Person.findAllByNamaLike("%${nama}%")
    }

    def update(Long id, String nama, Integer umur) {
        def p = Person.get(id)
        if (p) {
            p.nama = nama
            p.umur = umur
            p.save(flush: true)
            return p
        }
        return null
    }

    def delete(Long id) {
        def p = Person.get(id)
        if (p) {
            p.delete(flush: true)
            return true
        }
        return false
    }
}
