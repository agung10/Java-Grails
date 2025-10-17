package belajar_grails
import belajar_grails.Address
import belajar_grails.Person

class AddressController {
    def addressService

    def index() {
        try {
            def addresses = Address.list() ?: []
            def total = addresses.size()

            [addresses: addresses, personList: Person.list(), total: total]
        } catch (Exception e) {
            log.error("Error in index: ${e.message}", e)
            flash.message = "Error loading data: ${e.message}"
            [addresses: [], personList: Person.list(), total: 0]
        }
    }

    def create() {
        try {
            Long person_id = params.long('person_id')
            String jalan = params.jalan?.trim()
            String kota = params.kota?.trim()
            String kodePosStr = params.kode_pos?.trim()

            // Validasi semua field
            if (!person_id || !jalan || !kota || !kodePosStr) {
                flash.error = "Semua field harus diisi!"
                redirect(action: "index")
                return
            } else if (kota.length() > 100) {
                flash.error = "Nama kota terlalu panjang! Maksimal 100 karakter."
                redirect(action: "index")
                return
            } else if (!kodePosStr.matches("^\\d{5}\$")) {
                flash.error = "Kode Pos harus berupa 5 digit angka!"
                redirect(action: "index")
                return
            }

            Integer kodePos = kodePosStr.toInteger()
            def address = addressService.store(person_id, jalan, kota, kodePos)
            if (address) {
                flash.success = "Alamat berhasil disimpan!"
                redirect(action: "index")
            } else {
                flash.error = "Gagal menyimpan alamat! Silakan coba lagi."
                redirect(action: "index")
            }
        } catch (Exception e) {
            log.error("Error dalam create address: ${e.message}", e)
            flash.error = "Terjadi kesalahan sistem! Silakan coba beberapa saat lagi."
            redirect(action: "index")
        }
    }

    def show() {
        Long id = params.id as Long
        def address = addressService.findById(id)

        if (address) {
            render(view: "show", model: [address: address])
        } else {
            flash.error = "Alamat tidak ditemukan!"
            redirect(action: "index")
        }
    }

    def edit() {
        Long id = params.id as Long
        def address = addressService.findById(id)

        if (address) {
            render(view: "edit", model: [address: address])
        } else {
            flash.error = "Alamat tidak ditemukan!"
            redirect(action: "index")
        }
    }

    def update() {
        Long id = params.id as Long
        String jalan = params.jalan?.trim()
        String kota = params.kota?.trim()
        String kodePosStr = params.kode_pos?.trim()

        // Validasi semua field
        if (!jalan || !kota || !kodePosStr) {
            flash.error = "Semua field harus diisi!"
            redirect(action: "edit", params: [id: id])
            return
        } else if (kota.length() > 100) {
            flash.error = "Nama kota terlalu panjang! Maksimal 100 karakter."
            redirect(action: "edit", params: [id: id])
            return
        } else if (!kodePosStr.matches("^\\d{5}\$")) {
            flash.error = "Kode Pos harus berupa 5 digit angka!"
            redirect(action: "edit", params: [id: id])
            return
        }

        Integer kodePos = kodePosStr.toInteger()
        def address = addressService.update(id, jalan, kota, kodePos)
        if (address) {
            flash.success = "Alamat berhasil diperbarui!"
            redirect(action: "index")
        } else {
            flash.error = "Gagal memperbarui alamat! Silakan coba lagi."
            redirect(action: "edit", params: [id: id])
        }
    }

    def destroy() {
        Long id = params.id as Long
        String nama = params.nama
        boolean deleted = addressService.delete(id)

        if (deleted) {
            flash.success = "Data ${nama} berhasil dihapus!"
        } else {
            flash.error = "Data dengan ID ${id} tidak ditemukan atau gagal dihapus!"
        }
        
        redirect(action: "index")
    }
}
