<!DOCTYPE html>
<html>
<head>
   <title>Daftar Alamat</title>
   <style>
      body { font-family: Arial, sans-serif; margin: 20px; }
      .container { max-width: 800px; margin: 0 auto; }
      .form-section { background: #f5f5f5; padding: 20px 40px 20px 20px; margin-bottom: 20px; border-radius: 5px; }
      .data-section { background: #fff; padding: 20px; border: 1px solid #ddd; border-radius: 5px; }
      .form-group { margin-bottom: 15px; }
      label { display: block; margin-bottom: 5px; font-weight: bold; }
      input[type="text"], input[type="number"], select { width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 3px; }
      button { background: #007bff; color: white; padding: 10px 20px; border: none; border-radius: 3px; cursor: pointer; }
      button:hover { background: #0056b3; }
      .message { padding: 10px; margin: 10px 0; border-radius: 3px; }
      .success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
      .error { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
      table { width: 100%; border-collapse: collapse; margin-top: 20px; }
      th, td { padding: 10px; text-align: left; border-bottom: 1px solid #ddd; }
      th { background-color: #f8f9fa; }
      .text-center { text-align: center; }
      .no-data { text-align: center; color: #666; padding: 20px; }
   </style>
</head>
<body>
   <div class="container">
      <h1>Data Alamat</h1>
      
      <g:if test="${flash.error}">
         <div class="message error">${flash.error}</div>
      </g:if>
      <g:if test="${flash.success}">
         <div class="message success">${flash.success}</div>
      </g:if>
      <div id="flashMessage" data-success="${flash.success}" data-error="${flash.error}"style="display: none;"></div>

      <div class="form-section">
         <h2 style="margin-top: 0;">Tambah Alamat Baru</h2>
         <form action="${createLink(action: 'create')}" method="post">
               <div class="form-group">
                  <label for="person_id">Person:</label>
                  <select id="person_id" name="person_id">
                     <option value="">Pilih Person</option>
                     <g:each in="${personList}" var="person">
                        <option value="${person.id}">${person.nama}</option>
                     </g:each>
                  </select>
               </div>
               <div class="form-group">
                  <label for="jalan">Alamat Jalan:</label>
                  <input type="text" id="jalan" name="jalan" maxlength="200">
                  <small>Maksimal 200 karakter</small>
               </div>
               <div class="form-group">
                  <label for="kota">Kota:</label>
                  <input type="text" id="kota" name="kota" maxlength="100">
                  <small>Maksimal 100 karakter</small>
               </div>
               <div class="form-group">
                  <label for="kode_pos">Kode Pos:</label>
                  <input type="text" id="kode_pos" name="kode_pos" pattern="[0-9]{5}">
                  <small>5 digit angka</small>
               </div>
               <button type="submit">Simpan Alamat</button>
         </form>
      </div>

      <div class="data-section">
         <h2>Daftar Alamat (Total: ${total})</h2>
         <g:if test="${total > 0}">
            <table>
               <thead>
                  <tr>
                     <th class="text-center">No</th>
                     <th class="text-center">Person</th>
                     <th class="text-center">Alamat</th>
                     <th class="text-center">Kota</th>
                     <th class="text-center">Kode Pos</th>
                     <th class="text-center">Aksi</th>
                  </tr>
               </thead>
               <tbody>
                  <g:each in="${addresses}" var="address" status="i">
                        <tr>
                           <td class="text-center">${i + 1}</td>
                           <td>${address.person.nama}</td>
                           <td class="text-center">${address.jalan}</td>
                           <td class="text-center">${address.kota}</td>
                           <td class="text-center">${address.kode_pos}</td>
                           <td class="text-center">
                              <g:link action="show" id="${address.id}">Lihat</g:link> | 
                              <g:link action="edit" id="${address.id}">Edit</g:link> | 
                              <g:link action="destroy" onclick="confirmDelete('${address.id}', '${address.jalan?.encodeAsJavaScript()}'); return false;">Hapus</g:link>
                           </td>
                        </tr>
                  </g:each>
               </tbody>
            </table>
         </g:if>
         <g:else>
            <div class="no-data">Belum ada data alamat. Silakan tambah data baru.</div>
         </g:else>
      </div>
   </div>
</body>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
   document.addEventListener('DOMContentLoaded', showFlashMessage);
   function showFlashMessage() {
      const flashMessage = document.getElementById('flashMessage');
      const success = flashMessage.dataset.success;
      const error = flashMessage.dataset.error;

      if (success) {
         Swal.fire('Berhasil!', success, 'success');
      } else if (error) {
         Swal.fire('Gagal!', error, 'error');
      }
   }

   function confirmDelete(id, nama) {
      Swal.fire({
         title: 'Konfirmasi Hapus',
         text: `Apakah Anda yakin ingin menghapus data ` + nama + `?`,
         icon: 'warning',
         showCancelButton: true,
         confirmButtonColor: '#d33',
         cancelButtonColor: '#3085d6',
         confirmButtonText: 'Ya, Hapus!',
         cancelButtonText: 'Batal'
      }).then((result) => {
         if (result.isConfirmed) {
            window.location.href = `${createLink(action: 'destroy')}?id=` + id + `&nama=` + nama;
         }
      });
   }
</script>
</html>