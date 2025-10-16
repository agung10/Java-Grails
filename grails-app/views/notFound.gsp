<!doctype html>
<html>
    <head>
        <title>Halaman Tidak Ditemukan</title>
        <meta name="layout" content="main">
        <g:if env="development"><asset:stylesheet src="errors.css"/></g:if>
        <style>
            .notfound-hero { max-width: 900px; margin: 40px auto; padding: 24px; background: #fff; border: 1px solid #e5e7eb; border-radius: 12px; box-shadow: 0 10px 15px -3px rgba(0,0,0,0.1), 0 4px 6px -2px rgba(0,0,0,0.05); }
            .notfound-header { display:flex; align-items:center; gap:14px; margin-bottom: 12px; }
            .notfound-badge { display:inline-flex; align-items:center; justify-content:center; width:40px; height:40px; border-radius:9999px; background:#fef3c7; color:#d97706; font-weight:700; }
            .notfound-title { margin:0; font-size: 22px; color:#111827; }
            .notfound-subtitle { margin:0; color:#6b7280; }
            .notfound-meta { margin-top: 16px; padding: 12px; background: #f9fafb; border: 1px dashed #e5e7eb; border-radius: 8px; }
            .notfound-actions { margin-top: 18px; display:flex; gap:12px; flex-wrap: wrap; }
            .btn { display:inline-block; padding:10px 14px; border-radius:8px; text-decoration:none; font-weight:600; }
            .btn-primary { background:#111827; color:#fff; }
            .btn-secondary { background:#f3f4f6; color:#111827; }
        </style>
    </head>
    <body>
        <div id="content" role="main">
            <div class="container">
                <div class="notfound-hero">
                    <div class="notfound-header">
                        <div class="notfound-badge">404</div>
                        <div>
                            <h1 class="notfound-title">Halaman Tidak Ditemukan</h1>
                            <p class="notfound-subtitle">Maaf, halaman yang Anda cari tidak dapat ditemukan.</p>
                        </div>
                    </div>

                    <div class="notfound-meta">
                        <p><strong>Path:</strong> ${request.forwardURI}</p>
                        <p><strong>Status:</strong> 404 Not Found</p>
                    </div>

                    <div class="notfound-actions">
                        <a class="btn btn-primary" href="${createLink(uri: '/')}" title="Kembali ke beranda">Kembali ke Beranda</a>
                        <a class="btn btn-secondary" href="javascript:history.back()" title="Kembali">Kembali</a>
                        <a class="btn btn-secondary" href="${createLink(controller:'person', action:'index')}" title="Kelola Person">Kelola Person</a>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
