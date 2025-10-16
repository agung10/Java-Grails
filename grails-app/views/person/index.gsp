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
      .no-data { text-align: center; color: #666; padding: 20px; }
   </style>
</head>
<body>
   <div class="container">
      <h1>Data Person</h1>
      
      <g:if test="${flash.message}">
         <div class="message ${flash.message.contains('Error') || flash.message.contains('Gagal') ? 'error' : 'success'}">${flash.message}</div>
      </g:if>
      
      <div class="form-section">
         <h2>Tambah Person Baru</h2>
         <form action="${createLink(action: 'create')}" method="post">
            <div class="form-group">
               <label for="nama">Nama:</label>
               <input type="text" id="nama" name="nama">
            </div>
            <div class="form-group">
               <label for="umur">Umur:</label>
               <input type="number" id="umur" name="umur" min="1" max="120">
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
                     <th>ID</th>
                     <th>Nama</th>
                     <th>Umur</th>
                     <th>Tanggal Dibuat</th>
                     <th>Tanggal Diperbarui</th>
                     <th>Aksi</th>
                  </tr>
               </thead>
               <tbody>
                  <g:each in="${persons}" var="person">
                     <tr>
                        <td>${person.id}</td>
                        <td>${person.nama}</td>
                        <td>${person.umur} Tahun</td>
                        <td><g:formatDate date="${person.dateCreated}" format="dd/MM/yyyy HH:mm" /></td>
                        <td><g:formatDate date="${person.lastUpdated}" format="dd/MM/yyyy HH:mm" /></td>
                        <td>
                           <a href="${createLink(action: 'show', params: [id: person.id])}">Lihat</a> |
                           <a href="${createLink(action: 'edit', params: [id: person.id])}">Edit</a> |
                           <a href="${createLink(action: 'destroy', params: [id: person.id, nama: person.nama])}" 
                              onclick="return confirm('Yakin hapus data ini?')">Hapus</a>
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
</html>
