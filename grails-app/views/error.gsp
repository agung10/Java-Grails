<!doctype html>
<html>
    <head>
        <title><g:if env="development">Grails Runtime Exception</g:if><g:else>Error</g:else></title>
        <meta name="layout" content="main">
        <g:if env="development"><asset:stylesheet src="errors.css"/></g:if>
        <style>
            .error-hero { max-width: 900px; margin: 40px auto; padding: 24px; background: #fff; border: 1px solid #e5e7eb; border-radius: 12px; box-shadow: 0 10px 15px -3px rgba(0,0,0,0.1), 0 4px 6px -2px rgba(0,0,0,0.05); }
            .error-header { display:flex; align-items:center; gap:14px; margin-bottom: 12px; }
            .error-badge { display:inline-flex; align-items:center; justify-content:center; width:40px; height:40px; border-radius:9999px; background:#fee2e2; color:#b91c1c; font-weight:700; }
            .error-title { margin:0; font-size: 22px; color:#111827; }
            .error-subtitle { margin:0; color:#6b7280; }
            .error-meta { margin-top: 16px; padding: 12px; background: #f9fafb; border: 1px dashed #e5e7eb; border-radius: 8px; }
            .error-actions { margin-top: 18px; display:flex; gap:12px; flex-wrap: wrap; }
            .btn { display:inline-block; padding:10px 14px; border-radius:8px; text-decoration:none; font-weight:600; }
            .btn-primary { background:#111827; color:#fff; }
            .btn-secondary { background:#f3f4f6; color:#111827; }
            .stack-container { margin-top: 24px; }
            .stack-title { margin:0 0 8px 0; font-size:16px; color:#374151; }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="error-hero">
                <div class="error-header">
                    <div class="error-badge">!</div>
                    <div>
                        <h1 class="error-title"><g:if env="development">Terjadi Kesalahan Aplikasi</g:if><g:else>Terjadi Kesalahan</g:else></h1>
                        <p class="error-subtitle">Maaf, terjadi sesuatu yang tidak diharapkan. Silakan coba lagi.</p>
                    </div>
                </div>

                <div class="error-meta">
                    <p><strong>Path:</strong> ${path}</p>
                    <g:if test="${message}"><p><strong>Pesan:</strong> ${message}</p></g:if>
                </div>

                <div class="error-actions">
                    <a class="btn btn-primary" href="${createLink(uri: '/')}" title="Kembali ke beranda">Kembali ke Beranda</a>
                    <a class="btn btn-secondary" href="javascript:history.back()" title="Kembali">Kembali</a>
                </div>

                <g:if env="development">
                    <div class="stack-container">
                        <h3 class="stack-title">Detail Error (Development)</h3>
                        <g:if test="${Throwable.isInstance(exception)}">
                            <g:renderException exception="${exception}" detailsClass="alert alert-danger" stackClass="bg-body-secondary" snippetClass="bg-body-secondary snippet" lineErrorClass="bg-danger" />
                        </g:if>
                        <g:elseif test="${request.getAttribute('javax.servlet.error.exception')}">
                            <g:renderException exception="${request.getAttribute('javax.servlet.error.exception')}" />
                        </g:elseif>
                        <g:else>
                            <ul class="errors">
                                <li>An error has occurred</li>
                                <li>Exception: ${exception}</li>
                                <li>Message: ${message}</li>
                                <li>Path: ${path}</li>
                            </ul>
                        </g:else>
                    </div>
                </g:if>
            </div>
        </div>
    </body>
    </html>
