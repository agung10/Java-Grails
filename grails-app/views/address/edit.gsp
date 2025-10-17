<!DOCTYPE html>
<html>
<head>
   <title>Edit Address</title>
   <style>
      body { font-family: Arial, sans-serif; margin: 20px; }
      .container { max-width: 600px; margin: 0 auto; }
      .form-section { background: #f5f5f5; padding: 20px 40px 20px 20px; border-radius: 5px; }
      .form-group { margin-bottom: 15px; }
      label { display: block; margin-bottom: 5px; font-weight: bold; }
      input[type="text"], input[type="number"] { width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 3px; }
      button { background: #007bff; color: white; padding: 10px 20px; border: none; border-radius: 3px; cursor: pointer; margin-right: 10px; }
      button:hover { background: #0056b3; }
      .cancel-btn { background: #6c757d; }
      .cancel-btn:hover { background: #545b62; }
      .message { padding: 10px; margin: 10px 0; border-radius: 3px; }
      .success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
      .error { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
   </style>
</head>
<body>
   <div class="container">
      <h1>Edit Address</h1>
      
      <g:if test="${flash.error}">
         <div class="message error">${flash.error}</div>
      </g:if>
      <g:if test="${flash.success}">
         <div class="message success">${flash.success}</div>
      </g:if>
      <div id="flashMessage" data-success="${flash.success}" data-error="${flash.error}"style="display: none;"></div>
      
      <div class="form-section">
         <form action="${createLink(action: 'update')}" method="post">
            <input type="hidden" name="id" value="${address?.id}">

            <div class="form-group">
               <label>Person:</label>
               <input type="text" value="${address?.person?.nama}" disabled>
            </div>
            <div class="form-group">
               <label for="jalan">Alamat Jalan:</label>
               <input type="text" id="jalan" name="jalan" maxlength="200" value="${address?.jalan}">
               <small>Maksimal 200 karakter</small>
            </div>
            <div class="form-group">
               <label for="kota">Kota:</label>
               <input type="text" id="kota" name="kota" maxlength="100" value="${address?.kota}">
               <small>Maksimal 100 karakter</small>
            </div>
            <div class="form-group">
               <label for="kode_pos">Kode Pos:</label>
               <input type="text" id="kode_pos" name="kode_pos" pattern="[0-9]{5}" value="${address?.kode_pos}">
               <small>5 digit angka</small>
            </div>
            
            <button type="submit">Ubah Data</button>
            <a href="${createLink(action: 'index')}" class="cancel-btn" style="text-decoration: none; display: inline-block; padding: 10px 20px; color: white; border-radius: 3px;">Batal</a>
         </form>
      </div>
   </div>
</body>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
   document.addEventListener('DOMContentLoaded', function() {
      const flashMessage = document.getElementById('flashMessage');
      const success = flashMessage.dataset.success;
      const error = flashMessage.dataset.error;

      if (success) {
         Swal.fire('Berhasil!', success, 'success');
      } else if (error) {
         Swal.fire('Gagal!', error, 'error');
      }
   });
</script>
</html>
