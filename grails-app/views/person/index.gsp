<!DOCTYPE html>
<html>
<head>
   <title>Daftar Person</title>
   <style>
      body { font-family: Arial, sans-serif; margin: 20px; }
      .container { max-width: 800px; margin: 0 auto; }
      .form-section { background: #f5f5f5; padding: 20px 40px 20px 20px; margin-bottom: 20px; border-radius: 5px; }
      .data-section { background: #fff; padding: 20px; border: 1px solid #ddd; border-radius: 5px; }
      .form-group { margin-bottom: 15px; }
      label { display: block; margin-bottom: 5px; font-weight: bold; }
      input[type="text"], input[type="number"] { width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 3px; }
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
      <h1>Data Person</h1>
      
      <g:if test="${flash.error}">
         <div class="message error">${flash.error}</div>
      </g:if>
      <g:if test="${flash.success}">
         <div class="message success">${flash.success}</div>
      </g:if>
      <div id="flashMessage" data-success="${flash.success}" data-error="${flash.error}"style="display: none;"></div>
      
      <div class="form-section">
         <h2 style="margin-top: 0;">Tambah Person Baru</h2>
         <form action="${createLink(action: 'create')}" method="post">
            <div class="form-group">
               <label for="nama">Nama:</label>
               <input type="text" id="nama" name="nama" pattern="^[a-zA-Z\\s]*$" maxlength="200" title="Nama hanya boleh mengandung huruf dan spasi, maksimal 200 karakter">
               <small>Hanya huruf dan spasi, maksimal 200 karakter</small>
            </div>
            <div class="form-group">
               <label for="umur">Umur:</label>
               <input type="number" id="umur" name="umur" min="1" max="150" title="Umur harus antara 1-150 tahun">
               <small>Umur harus antara 1-150 tahun</small>
            </div>
            <button type="submit">Simpan Data</button>
         </form>
      </div>
      
      <div class="data-section">
         <h2>Daftar Person (Total: ${total})</h2>
         <g:if test="${total > 0}">
            <table>
               <thead>
                  <tr>
                     <th class="text-center">ID</th>
                     <th class="text-center">Nama</th>
                     <th class="text-center">Umur</th>
                     <th class="text-center">Tanggal Dibuat</th>
                     <th class="text-center">Tanggal Diperbarui</th>
                     <th class="text-center">Aksi</th>
                  </tr>
               </thead>
               <tbody>
                  <g:each in="${persons}" var="person" status="i">
                     <tr>
                        <td class="text-center">${i + 1}</td>
                        <td>${person.nama}</td>
                        <td class="text-center">${person.umur} Tahun</td>
                        <td class="text-center"><g:formatDate date="${person.dateCreated}" format="dd/MM/yyyy HH:mm" /></td>
                        <td class="text-center"><g:formatDate date="${person.lastUpdated}" format="dd/MM/yyyy HH:mm" /></td>
                        <td class="text-center">
                           <g:link action="show" id="${person.id}">Lihat</g:link> | 
                           <g:link action="edit" id="${person.id}">Edit</g:link> | 
                           <g:link action="destroy" onclick="confirmDelete('${person.id}', '${person.nama}'); return false;">Hapus</g:link>
                        </td>
                     </tr>
                  </g:each>
               </tbody>
            </table>
         </g:if>
         <g:else>
            <div class="no-data">Belum ada data person. Silakan tambah data baru.</div>
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
