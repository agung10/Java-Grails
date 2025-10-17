package belajar_grails
import belajar_grails.Person

class Address {
    String jalan
    String kota
    Integer kode_pos
    Date dateCreated
    Date lastUpdated

    static mapping = {
        dateCreated column: 'created_at'
        lastUpdated column: 'updated_at'
    }

    static belongsTo = [person: Person]

    static constraints = {
        jalan blank: false, maxSize: 255
        kota blank: false, maxSize: 100
        kode_pos nullable: true, maxSize: 20
        person nullable: false
        dateCreated nullable: true
        lastUpdated nullable: true
    }
}
