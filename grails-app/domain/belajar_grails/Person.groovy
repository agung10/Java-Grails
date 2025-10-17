package belajar_grails
import belajar_grails.Address

class Person {
    String nama
    Integer umur
    Date dateCreated
    Date lastUpdated

    static mapping = {
        dateCreated column: 'created_at'
        lastUpdated column: 'updated_at'
    }

    static hasMany = [listAddress: Address]

    static constraints = {
        nama blank: false, maxSize: 150
        umur nullable: false, min: 1
        dateCreated nullable: true
        lastUpdated nullable: true
    }
}
