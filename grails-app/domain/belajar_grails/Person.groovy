package belajar_grails

class Person {
    String nama
    Integer umur

    static constraints = {
        nama blank: false
        umur min: 0
    }
}
