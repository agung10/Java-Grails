<!DOCTYPE html>
<html>
<head>
    <title>Detail Person</title>
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
    <h1>Detail Person</h1>
    
    <div class="form-section">
        <input type="hidden" name="id" value="${person?.id}">
        
        <div class="form-group">
            <label for="nama">Nama:</label>
            <input type="text" id="nama" name="nama" value="${person?.nama}" disabled>
        </div>
        <div class="form-group">
            <label for="umur">Umur:</label>
            <input type="number" id="umur" name="umur" value="${person?.umur}" min="1" max="120" disabled>
        </div>
        
        <a href="${createLink(action: 'index')}" class="cancel-btn" style="text-decoration: none; display: inline-block; padding: 10px 20px; color: white; border-radius: 3px;">Batal</a>
    </div>
</div>
</body>
</html>
