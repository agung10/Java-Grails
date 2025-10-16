package belajar_grails

class Person {
    String nama
    Integer umur
    Date dateCreated
    Date lastUpdated

    static mapping = {
        dateCreated column: 'created_at'
        lastUpdated column: 'updated_at'
    }

    static constraints = {
        nama blank: false, nullable: false, maxSize: 150
        umur nullable: false, min: 1
        dateCreated nullable: true
        lastUpdated nullable: true
    }
}
