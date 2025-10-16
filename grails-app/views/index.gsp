<%@ page import="grails.util.Environment; org.springframework.core.SpringVersion; org.springframework.boot.SpringBootVersion"
%><!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Welcome to Grails</title>
    <style>
        .home-hero { max-width: 1100px; margin: 40px auto; padding: 28px; background: #ffffff; border: 1px solid #e5e7eb; border-radius: 14px; box-shadow: 0 10px 15px -3px rgba(0,0,0,0.1), 0 4px 6px -2px rgba(0,0,0,0.05); }
        .home-header { display:flex; align-items:center; gap:22px; }
        .home-logo { background:#111827; padding:16px; border-radius:12px; display:flex; align-items:center; justify-content:center; }
        .home-title { margin:0; font-size:28px; color:#111827; }
        .home-subtitle { margin:6px 0 0 0; color:#6b7280; }
        .home-actions { margin-top: 20px; display:flex; gap:12px; flex-wrap:wrap; }
        .btn { display:inline-block; padding:10px 16px; border-radius:10px; text-decoration:none; font-weight:600; }
        .btn-primary { background:#111827; color:#fff; }
        .btn-secondary { background:#f3f4f6; color:#111827; }
        .home-grid { margin-top: 26px; display:grid; grid-template-columns: repeat(auto-fit, minmax(260px, 1fr)); gap:16px; }
        .card { border:1px solid #e5e7eb; border-radius:12px; padding:16px; background:#fafafa; }
        .card h3 { margin:0 0 8px 0; font-size:16px; color:#374151; }
        .card p { margin:0; color:#6b7280; }
    </style>
</head>
<body>
<content tag="nav">
    <li class="nav-item dropdown">
        <a href="#" class="nav-link dropdown-toggle" role="button" data-bs-toggle="dropdown" aria-expanded="false">Application Status <span class="caret"></span></a>
        <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#">Server: ${request.getServletContext().getServerInfo()}</a></li>
            <li><a class="dropdown-item" href="#">Host: ${InetAddress.getLocalHost()}</a></li>
            <li><a class="dropdown-item" href="#">Environment: ${Environment.current.name}</a></li>
            <li><a class="dropdown-item" href="#">App version:
                <g:meta name="info.app.version"/></a>
            </li>
            <li><a class="dropdown-item" href="#">App profile: ${grailsApplication.config.getProperty('grails.profile')}</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="#">Grails version:
                <g:meta name="info.app.grailsVersion"/></a>
            </li>
            <li><a class="dropdown-item" href="#">Groovy version: ${GroovySystem.getVersion()}</a></li>
            <li><a class="dropdown-item" href="#">JVM version: ${System.getProperty('java.version')}</a></li>
            <li><a class="dropdown-item" href="#">Spring Boot version: ${SpringBootVersion.getVersion()}</a></li>
            <li><a class="dropdown-item" href="#">Spring version: ${SpringVersion.getVersion()}</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="#">Reloading active: ${Environment.reloadingAgentEnabled}</a></li>
        </ul>
    </li>
    <li class="nav-item dropdown">
        <a href="#" class="nav-link dropdown-toggle" role="button" data-bs-toggle="dropdown" aria-expanded="false">Artefacts <span class="caret"></span></a>
        <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#">Controllers: ${grailsApplication.controllerClasses.size()}</a></li>
            <li><a class="dropdown-item" href="#">Domains: ${grailsApplication.domainClasses.size()}</a></li>
            <li><a class="dropdown-item" href="#">Services: ${grailsApplication.serviceClasses.size()}</a></li>
            <li><a class="dropdown-item" href="#">Tag Libraries: ${grailsApplication.tagLibClasses.size()}</a></li>
        </ul>
    </li>
    <li class="nav-item dropdown">
        <a href="#" class="nav-link dropdown-toggle" role="button" data-bs-toggle="dropdown" aria-expanded="false">Installed Plugins<span class="caret"></span></a>
        <ul class="dropdown-menu dropdown-menu-right">
            <g:each var="plugin" in="${applicationContext.getBean('pluginManager').allPlugins}">
                <li><a class="dropdown-item" href="#">${plugin.name} - ${plugin.version}</a></li>
            </g:each>
        </ul>
    </li>
</content>

<div id="content" role="main">
    <div class="container">
        <section class="home-hero">
            <div class="home-header">
                <div class="home-logo">
                    <asset:image src="grails-cupsonly-logo-white.svg" style="height:48px; width:auto;"/>
                </div>
                <div>
                    <h1 class="home-title">Selamat Datang di Aplikasi Grails</h1>
                    <p class="home-subtitle">Mulai kelola data Anda atau jelajahi komponen aplikasi.</p>
                </div>
            </div>

            <div class="home-actions">
                <a class="btn btn-primary" href="${createLink(controller:'person', action:'index')}">Kelola Person</a>
                <a class="btn btn-secondary" href="https://docs.grails.org" target="_blank" rel="noopener">Dokumentasi Grails</a>
            </div>

            <div class="home-grid">
                <div class="card">
                    <h3>Status Aplikasi</h3>
                    <p>Environment: ${Environment.current.name}, Grails: <g:meta name="info.app.grailsVersion"/></p>
                </div>
                <div class="card">
                    <h3>Kontroler Tersedia</h3>
                    <ul style="margin:8px 0 0 18px;">
                        <g:each var="c" in="${grailsApplication.controllerClasses.sort { it.fullName } }">
                            <li class="controller"><g:link controller="${c.logicalPropertyName}">${c.fullName}</g:link></li>
                        </g:each>
                    </ul>
                </div>
            </div>
        </section>
    </div>
</div>

</body>
</html>
