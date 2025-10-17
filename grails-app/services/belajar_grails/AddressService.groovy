package belajar_grails

import grails.gorm.transactions.Transactional
import belajar_grails.Address
import belajar_grails.Person

@Transactional
class AddressService {
    def store(Long personId, String jalan, String kota, Integer kodePos) {
        def person = Person.get(personId)
        if (!person) {
            println "Person dengan ID ${personId} tidak ditemukan."
            return null
        }

        def address = new Address(jalan: jalan, kota: kota, kode_pos: kodePos, person: person)
        if (address.save(flush: true)) {
            return address
        }

        println "Failed to save address: ${address.errors}"
        return null

    }

    def findById(Long id) {
        return Address.get(id)
    }

    def update(Long id, String jalan, String kota, Integer kodePos) {
        def address = Address.get(id)
        if (address) {
            address.jalan = jalan
            address.kota = kota
            address.kode_pos = kodePos
            address.save(flush: true)
            return address
        }
        return null
    }

    def delete(Long id) {
        def address = Address.get(id)
        if (address) {
            address.delete(flush: true)
            return true
        }
        return false
    }
}
