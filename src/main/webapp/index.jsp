<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="description"
          content="Joe – Passionate Web Developer crafting beautiful digital experiences."/>
    <title>Joe | Web Developer Portfolio</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&family=Dancing+Script:wght@600&display=swap"
          rel="stylesheet"/>

    <!-- Font Awesome 6 (CDN – icons only, no framework) -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

    <!-- Project stylesheet -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css"/>
</head>
<body>

<%-- ═══════════════════════════════════════════════════════════
     READ & CLEAR session feedback (set by ContactServlet)
     ════════════════════════════════════════════════════════ --%>
<%
    String contactMsg     = (String) session.getAttribute("contactMsg");
    String contactMsgType = (String) session.getAttribute("contactMsgType");
    // Remove from session immediately after reading
    if (contactMsg != null) {
        session.removeAttribute("contactMsg");
        session.removeAttribute("contactMsgType");
    }
%>

<!-- ═══════════════════════════════════════════════════════════
     GLOBAL TOAST NOTIFICATION (shown after form redirect)
     ════════════════════════════════════════════════════════ -->
<% if (contactMsg != null) { %>
<div id="toastNotification"
     class="toast toast--<%= contactMsgType %> toast--visible"
     role="alert"
     aria-live="polite">
    <span class="toast__icon">
        <% if ("success".equals(contactMsgType)) { %>
            <i class="fa-solid fa-circle-check"></i>
        <% } else { %>
            <i class="fa-solid fa-circle-exclamation"></i>
        <% } %>
    </span>
    <span class="toast__message"><%= contactMsg %></span>
    <button class="toast__close" onclick="closeToast()" aria-label="Close">&times;</button>
</div>
<% } %>

<!-- ═══════════════════════════════════════════════════════════
     NAVIGATION BAR
     ════════════════════════════════════════════════════════ -->
<header class="navbar" id="navbar">
    <div class="navbar__container">

        <!-- Logo / Brand -->
        <a href="#home" class="navbar__logo">
            <span class="navbar__logo-dot">✦</span> Joe
        </a>

        <!-- Desktop Navigation Links -->
        <nav class="navbar__links" id="navLinks">
            <a href="#home"     class="navbar__link active" data-section="home">Home</a>
            <a href="#about"    class="navbar__link"        data-section="about">About</a>
            <a href="#skills"   class="navbar__link"        data-section="skills">Skills</a>
            <a href="#projects" class="navbar__link"        data-section="projects">Projects</a>
            <a href="#contact"  class="navbar__link"        data-section="contact">Contact</a>
        </nav>

        <!-- Hire Me CTA Button -->
        <a href="#contact" class="btn btn--primary navbar__cta">
            Hire Me <i class="fa-solid fa-arrow-right"></i>
        </a>

        <!-- Mobile Hamburger Toggle -->
        <button class="navbar__hamburger" id="hamburger"
                aria-label="Toggle navigation" aria-expanded="false">
            <span></span>
            <span></span>
            <span></span>
        </button>

    </div>
</header>

<!-- Mobile Drawer Menu -->
<div class="mobile-menu" id="mobileMenu" aria-hidden="true">
    <button class="mobile-menu__close" id="mobileMenuClose" aria-label="Close menu">
        <i class="fa-solid fa-xmark"></i>
    </button>
    <nav class="mobile-menu__links">
        <a href="#home"     class="mobile-menu__link">Home</a>
        <a href="#about"    class="mobile-menu__link">About</a>
        <a href="#skills"   class="mobile-menu__link">Skills</a>
        <a href="#projects" class="mobile-menu__link">Projects</a>
        <a href="#contact"  class="mobile-menu__link">Contact</a>
    </nav>
</div>
<div class="mobile-menu__overlay" id="mobileOverlay"></div>


<!-- ═══════════════════════════════════════════════════════════
     HERO SECTION
     ════════════════════════════════════════════════════════ -->
<section class="hero" id="home">
    <div class="hero__background">
        <div class="hero__blob hero__blob--1"></div>
        <div class="hero__blob hero__blob--2"></div>
        <div class="hero__blob hero__blob--3"></div>
        <div class="hero__particles" id="particles"></div>
    </div>

    <div class="container hero__container">

        <!-- Text Content -->
        <div class="hero__content" data-aos="fade-right">
            <p class="hero__greeting">Hello, I'm</p>
            <h1 class="hero__name">Joe</h1>
            <h2 class="hero__title">
                <span class="hero__title-static">I'm a </span>
                <span class="hero__title-dynamic" id="typingText"></span>
                <span class="hero__cursor">|</span>
            </h2>
            <p class="hero__tagline">
                Passionate Web Developer | Crafting Digital Experiences
            </p>
            <p class="hero__bio">
                I build beautiful, functional, and user-centered digital products
                with a love for clean code and elegant design.
            </p>

            <div class="hero__actions">
                <a href="#projects" class="btn btn--primary btn--lg">
                    <i class="fa-solid fa-eye"></i> View My Work
                </a>
                <a href="#contact" class="btn btn--outline btn--lg">
                    <i class="fa-solid fa-envelope"></i> Let's Talk
                </a>
            </div>

            <!-- Social Links -->
            <div class="hero__socials">
                <a href="#" class="social-link" aria-label="GitHub" title="GitHub">
                    <i class="fa-brands fa-github"></i>
                </a>
                <a href="#" class="social-link" aria-label="LinkedIn" title="LinkedIn">
                    <i class="fa-brands fa-linkedin-in"></i>
                </a>
                <a href="#" class="social-link" aria-label="Twitter" title="Twitter">
                    <i class="fa-brands fa-twitter"></i>
                </a>
                <a href="#" class="social-link" aria-label="Dribbble" title="Dribbble">
                    <i class="fa-brands fa-dribbble"></i>
                </a>
            </div>
        </div>

        <!-- Photo / Avatar -->
        <div class="hero__photo-wrap" data-aos="fade-left">
            <div class="hero__photo-ring"></div>
            <div class="hero__photo-ring hero__photo-ring--2"></div>
            <div class="hero__photo">
                <div class="hero__photo-placeholder">
                    <img alt="Joe's Photo" src="<%= request.getContextPath() %>/images/joe.jpg" >
                    <!-- <i class="fa-solid fa-user"></i> -->
                    <!-- <span>Joe's Photo</span> -->
                </div>
            </div>
            <!-- Floating badges -->
            <div class="hero__badge hero__badge--top">
                <i class="fa-solid fa-code"></i> Clean Code
            </div>
            <div class="hero__badge hero__badge--bottom">
                <i class="fa-solid fa-star"></i> 7+ Years Exp
            </div>
        </div>

    </div>

    <!-- Scroll indicator -->
    <a href="#about" class="hero__scroll-indicator" aria-label="Scroll down">
        <span>Scroll</span>
        <i class="fa-solid fa-chevron-down"></i>
    </a>
</section>


<!-- ═══════════════════════════════════════════════════════════
     ABOUT SECTION
     ════════════════════════════════════════════════════════ -->
<section class="about section" id="about">
    <div class="container">

        <div class="section-header">
            <span class="section-tag">Get To Know Me</span>
            <h2 class="section-title">About <span class="text-gradient">Me</span></h2>
            <div class="section-line"></div>
        </div>

        <div class="about__grid">

            <!-- Photo side -->
            <div class="about__photo-wrap" data-aos="fade-right">
                <div class="about__photo-frame">
                    <div class="about__photo-placeholder">
                    <img alt="About Photo" src="<%= request.getContextPath() %>/images/joe.jpg">
                        <!-- <i class="fa-solid fa-user-tie"></i> -->
                       <!-- <span>About Photo</span> -->
                    </div>
                </div>
                <div class="about__experience-badge">
                    <span class="about__experience-number">7+</span>
                    <span class="about__experience-text">Years of<br/>Experience</span>
                </div>
            </div>

            <!-- Text side -->
            <div class="about__content" data-aos="fade-left">
                <h3 class="about__subtitle">
                    A Passionate Web Developer Based Anywhere, Working Everywhere 🌍
                </h3>
                <p class="about__text">
                    Hi! I'm <strong>Joe</strong>, a full-stack web developer with a deep
                    passion for creating intuitive, beautiful, and high-performance web
                    applications. I specialize in turning complex problems into elegant,
                    user-friendly solutions.
                </p>
                <p class="about__text">
                    With expertise spanning both frontend and backend development, I love
                    working across the full stack — from pixel-perfect UIs to robust
                    server-side architectures. My toolkit includes Java, J2EE, JSP,
                    JavaScript, MySQL, and modern CSS3.
                </p>
                <p class="about__text">
                    When I'm not coding, you'll find me sketching UI concepts, exploring
                    design trends, or mentoring budding developers. I believe great software
                    is built at the intersection of <em>logic and creativity</em>.
                </p>

                <!-- Info grid -->
                <div class="about__info-grid">
                    <div class="about__info-item">
                        <span class="about__info-label">Name</span>
                        <span class="about__info-value">Joe</span>
                    </div>
                    <div class="about__info-item">
                        <span class="about__info-label">Role</span>
                        <span class="about__info-value">Web Developer</span>
                    </div>
                    <div class="about__info-item">
                        <span class="about__info-label">Email</span>
                        <span class="about__info-value">joe@codezerra.com</span>
                    </div>
                    <div class="about__info-item">
                        <span class="about__info-label">Available</span>
                        <span class="about__info-value available-dot">
                            <span class="dot-pulse"></span> Open to Work
                        </span>
                    </div>
                </div>

                <div class="about__actions">
                    <a href="cv.zip" download="joe-cv" class="btn btn--primary">
                        <i class="fa-solid fa-download"></i> Download CV
                    </a>
                    <a href="#contact" class="btn btn--outline">
                        <i class="fa-solid fa-paper-plane"></i> Contact Me
                    </a>
                </div>
            </div>

        </div>
    </div>
</section>


<!-- ═══════════════════════════════════════════════════════════
     SKILLS SECTION
     ════════════════════════════════════════════════════════ -->
<section class="skills section section--alt" id="skills">
    <div class="container">

        <div class="section-header">
            <span class="section-tag">What I Know</span>
            <h2 class="section-title">My <span class="text-gradient">Skills</span></h2>
            <div class="section-line"></div>
        </div>

        <div class="skills__grid">

            <!-- Left: Progress bars -->
            <div class="skills__bars" data-aos="fade-right">
                <h3 class="skills__col-title">Technical Proficiency</h3>

                <div class="skill-bar" data-percent="92">
                    <div class="skill-bar__header">
                        <span class="skill-bar__name">
                            <i class="fa-brands fa-java"></i> Java / J2EE
                        </span>
                        <span class="skill-bar__percent">92%</span>
                    </div>
                    <div class="skill-bar__track">
                        <div class="skill-bar__fill" data-width="92"></div>
                    </div>
                </div>

                <div class="skill-bar" data-percent="88">
                    <div class="skill-bar__header">
                        <span class="skill-bar__name">
                            <i class="fa-brands fa-html5"></i> HTML5 / CSS3
                        </span>
                        <span class="skill-bar__percent">88%</span>
                    </div>
                    <div class="skill-bar__track">
                        <div class="skill-bar__fill" data-width="88"></div>
                    </div>
                </div>

                <div class="skill-bar" data-percent="82">
                    <div class="skill-bar__header">
                        <span class="skill-bar__name">
                            <i class="fa-brands fa-js"></i> JavaScript / jQuery
                        </span>
                        <span class="skill-bar__percent">82%</span>
                    </div>
                    <div class="skill-bar__track">
                        <div class="skill-bar__fill" data-width="82"></div>
                    </div>
                </div>

                <div class="skill-bar" data-percent="85">
                    <div class="skill-bar__header">
                        <span class="skill-bar__name">
                            <i class="fa-solid fa-database"></i> MySQL / JDBC
                        </span>
                        <span class="skill-bar__percent">85%</span>
                    </div>
                    <div class="skill-bar__track">
                        <div class="skill-bar__fill" data-width="85"></div>
                    </div>
                </div>

                <div class="skill-bar" data-percent="78">
                    <div class="skill-bar__header">
                        <span class="skill-bar__name">
                            <i class="fa-brands fa-git-alt"></i> Git / Version Control
                        </span>
                        <span class="skill-bar__percent">78%</span>
                    </div>
                    <div class="skill-bar__track">
                        <div class="skill-bar__fill" data-width="78"></div>
                    </div>
                </div>

                <div class="skill-bar" data-percent="75">
                    <div class="skill-bar__header">
                        <span class="skill-bar__name">
                            <i class="fa-solid fa-palette"></i> UI/UX Design
                        </span>
                        <span class="skill-bar__percent">75%</span>
                    </div>
                    <div class="skill-bar__track">
                        <div class="skill-bar__fill" data-width="75"></div>
                    </div>
                </div>
            </div>

            <!-- Right: Tool / tech cards -->
            <div class="skills__cards" data-aos="fade-left">
                <h3 class="skills__col-title">Tools & Technologies</h3>
                <div class="skills__card-grid">
                    <div class="skill-card">
                        <i class="fa-brands fa-java skill-card__icon"></i>
                        <span>Java EE</span>
                    </div>
                    <div class="skill-card">
                        <i class="fa-solid fa-server skill-card__icon"></i>
                        <span>Tomcat</span>
                    </div>
                    <div class="skill-card">
                        <i class="fa-brands fa-html5 skill-card__icon"></i>
                        <span>HTML5</span>
                    </div>
                    <div class="skill-card">
                        <i class="fa-brands fa-css3-alt skill-card__icon"></i>
                        <span>CSS3</span>
                    </div>
                    <div class="skill-card">
                        <i class="fa-brands fa-js skill-card__icon"></i>
                        <span>JavaScript</span>
                    </div>
                    <div class="skill-card">
                        <i class="fa-solid fa-database skill-card__icon"></i>
                        <span>MySQL</span>
                    </div>
                    <div class="skill-card">
                        <i class="fa-brands fa-git-alt skill-card__icon"></i>
                        <span>Git</span>
                    </div>
                    <div class="skill-card">
                        <i class="fa-solid fa-code skill-card__icon"></i>
                        <span>JSP/JSTL</span>
                    </div>
                    <div class="skill-card">
                        <i class="fa-solid fa-layer-group skill-card__icon"></i>
                        <span>MVC Pattern</span>
                    </div>
                    <div class="skill-card">
                        <i class="fa-solid fa-mobile-screen skill-card__icon"></i>
                        <span>Responsive</span>
                    </div>
                </div>

                <!-- Stats row -->
                <div class="skills__stats">
                    <div class="skills__stat">
                        <span class="skills__stat-number" data-target="20">0</span>+
                        <span class="skills__stat-label">Projects</span>
                    </div>
                    <div class="skills__stat">
                        <span class="skills__stat-number" data-target="15">0</span>+
                        <span class="skills__stat-label">Clients</span>
                    </div>
                    <div class="skills__stat">
                        <span class="skills__stat-number" data-target="3">0</span>+
                        <span class="skills__stat-label">Years Exp.</span>
                    </div>
                </div>
            </div>

        </div>
    </div>
</section>


<!-- ═══════════════════════════════════════════════════════════
     PROJECTS SECTION
     ════════════════════════════════════════════════════════ -->
<section class="projects section" id="projects">
    <div class="container">

        <div class="section-header">
            <span class="section-tag">My Work</span>
            <h2 class="section-title">Featured <span class="text-gradient">Projects</span></h2>
            <div class="section-line"></div>
            <p class="section-subtitle">
                A selection of projects that showcase my skills and creativity.
            </p>
        </div>

        <!-- Filter Tabs -->
        <div class="projects__filters">
            <button class="filter-btn active" data-filter="all">All</button>
            <button class="filter-btn" data-filter="web">Web App</button>
            <button class="filter-btn" data-filter="ui">UI/UX</button>
            <button class="filter-btn" data-filter="db">Database</button>
        </div>

        <!-- Project Cards Grid -->
        <div class="projects__grid" id="projectsGrid">

            <!-- Project 1 -->
            <div class="project-card" data-category="web" data-aos="fade-up" data-aos-delay="0">
                <div class="project-card__image">
                    <div class="project-card__img-placeholder">
                        <i class="fa-solid fa-hospital"></i>
                    </div>
                    <div class="project-card__overlay">
                        <button class="project-card__view-btn"
                                onclick="openModal('proj1')"
                                aria-label="View project details">
                            <i class="fa-solid fa-expand"></i>
                        </button>
                        <a href="#" class="project-card__link-btn"
                           aria-label="Visit live project">
                            <i class="fa-solid fa-arrow-up-right-from-square"></i>
                        </a>
                    </div>
                </div>
                <div class="project-card__body">
                    <div class="project-card__tags">
                        <span class="tag">Java EE</span>
                        <span class="tag">MySQL</span>
                        <span class="tag">JSP</span>
                    </div>
                    <h3 class="project-card__title">HealthTrack Portal</h3>
                    <p class="project-card__desc">
                        Patient management system with appointment scheduling, medical records,
                        and doctor dashboard built with full J2EE stack.
                    </p>
                </div>
            </div>

            <!-- Project 2 -->
            <div class="project-card" data-category="ui" data-aos="fade-up" data-aos-delay="100">
                <div class="project-card__image">
                    <div class="project-card__img-placeholder" style="background: var(--gradient-pink)">
                        <i class="fa-solid fa-shop"></i>
                    </div>
                    <div class="project-card__overlay">
                        <button class="project-card__view-btn"
                                onclick="openModal('proj2')"
                                aria-label="View project details">
                            <i class="fa-solid fa-expand"></i>
                        </button>
                        <a href="#" class="project-card__link-btn">
                            <i class="fa-solid fa-arrow-up-right-from-square"></i>
                        </a>
                    </div>
                </div>
                <div class="project-card__body">
                    <div class="project-card__tags">
                        <span class="tag">CSS3</span>
                        <span class="tag">JavaScript</span>
                        <span class="tag">UI Design</span>
                    </div>
                    <h3 class="project-card__title">ShopEase E-commerce</h3>
                    <p class="project-card__desc">
                        A modern, fully responsive e-commerce storefront with cart management,
                        product filtering, and smooth checkout flow.
                    </p>
                </div>
            </div>

            <!-- Project 3 -->
            <div class="project-card" data-category="db" data-aos="fade-up" data-aos-delay="200">
                <div class="project-card__image">
                    <div class="project-card__img-placeholder" style="background: linear-gradient(135deg, #667eea, #764ba2)">
                        <i class="fa-solid fa-graduation-cap"></i>
                    </div>
                    <div class="project-card__overlay">
                        <button class="project-card__view-btn"
                                onclick="openModal('proj3')"
                                aria-label="View project details">
                            <i class="fa-solid fa-expand"></i>
                        </button>
                        <a href="#" class="project-card__link-btn">
                            <i class="fa-solid fa-arrow-up-right-from-square"></i>
                        </a>
                    </div>
                </div>
                <div class="project-card__body">
                    <div class="project-card__tags">
                        <span class="tag">JDBC</span>
                        <span class="tag">Servlet</span>
                        <span class="tag">MySQL</span>
                    </div>
                    <h3 class="project-card__title">EduConnect LMS</h3>
                    <p class="project-card__desc">
                        Learning management system featuring course enrollment, progress
                        tracking, quizzes, and instructor dashboards.
                    </p>
                </div>
            </div>

            <!-- Project 4 -->
            <div class="project-card" data-category="web" data-aos="fade-up" data-aos-delay="0">
                <div class="project-card__image">
                    <div class="project-card__img-placeholder" style="background: linear-gradient(135deg, #f093fb, #f5576c)">
                        <i class="fa-solid fa-chart-line"></i>
                    </div>
                    <div class="project-card__overlay">
                        <button class="project-card__view-btn"
                                onclick="openModal('proj4')"
                                aria-label="View project details">
                            <i class="fa-solid fa-expand"></i>
                        </button>
                        <a href="#" class="project-card__link-btn">
                            <i class="fa-solid fa-arrow-up-right-from-square"></i>
                        </a>
                    </div>
                </div>
                <div class="project-card__body">
                    <div class="project-card__tags">
                        <span class="tag">Java</span>
                        <span class="tag">Charts</span>
                        <span class="tag">Finance</span>
                    </div>
                    <h3 class="project-card__title">FinanceIQ Dashboard</h3>
                    <p class="project-card__desc">
                        Personal finance tracker with income/expense management,
                        visual charts, budget alerts and monthly PDF reports.
                    </p>
                </div>
            </div>

            <!-- Project 5 -->
            <div class="project-card" data-category="ui" data-aos="fade-up" data-aos-delay="100">
                <div class="project-card__image">
                    <div class="project-card__img-placeholder" style="background: linear-gradient(135deg, #4facfe, #00f2fe)">
                        <i class="fa-solid fa-plane"></i>
                    </div>
                    <div class="project-card__overlay">
                        <button class="project-card__view-btn"
                                onclick="openModal('proj5')"
                                aria-label="View project details">
                            <i class="fa-solid fa-expand"></i>
                        </button>
                        <a href="#" class="project-card__link-btn">
                            <i class="fa-solid fa-arrow-up-right-from-square"></i>
                        </a>
                    </div>
                </div>
                <div class="project-card__body">
                    <div class="project-card__tags">
                        <span class="tag">UI/UX</span>
                        <span class="tag">CSS3</span>
                        <span class="tag">Animations</span>
                    </div>
                    <h3 class="project-card__title">TravelBliss App</h3>
                    <p class="project-card__desc">
                        Travel booking UI with destination search, itinerary builder,
                        hotel listings, and smooth micro-animations.
                    </p>
                </div>
            </div>

            <!-- Project 6 -->
            <div class="project-card" data-category="db" data-aos="fade-up" data-aos-delay="200">
                <div class="project-card__image">
                    <div class="project-card__img-placeholder" style="background: linear-gradient(135deg, #43e97b, #38f9d7)">
                        <i class="fa-solid fa-boxes-stacked"></i>
                    </div>
                    <div class="project-card__overlay">
                        <button class="project-card__view-btn"
                                onclick="openModal('proj6')"
                                aria-label="View project details">
                            <i class="fa-solid fa-expand"></i>
                        </button>
                        <a href="#" class="project-card__link-btn">
                            <i class="fa-solid fa-arrow-up-right-from-square"></i>
                        </a>
                    </div>
                </div>
                <div class="project-card__body">
                    <div class="project-card__tags">
                        <span class="tag">Servlet</span>
                        <span class="tag">CRUD</span>
                        <span class="tag">Inventory</span>
                    </div>
                    <h3 class="project-card__title">StockMaster Inventory</h3>
                    <p class="project-card__desc">
                        Full-featured inventory management with barcode scanning support,
                        stock alerts, supplier tracking, and reports.
                    </p>
                </div>
            </div>

        </div><!-- /.projects__grid -->
    </div>
</section>


<!-- ═══════════════════════════════════════════════════════════
     PROJECT MODALS (6 modals — one per project)
     ════════════════════════════════════════════════════════ -->
<div class="modal-backdrop" id="modalBackdrop" onclick="closeModal()"></div>

<!-- Modal: Project 1 -->
<div class="modal" id="modal-proj1" role="dialog" aria-modal="true" aria-labelledby="modal-proj1-title">
    <button class="modal__close" onclick="closeModal()" aria-label="Close">&times;</button>
    <div class="modal__image">
        <div class="modal__img-placeholder">
            <i class="fa-solid fa-hospital"></i>
        </div>
    </div>
    <div class="modal__body">
        <div class="modal__tags">
            <span class="tag">Java EE</span><span class="tag">MySQL</span>
            <span class="tag">JSP</span><span class="tag">JDBC</span>
        </div>
        <h3 id="modal-proj1-title" class="modal__title">HealthTrack Portal</h3>
        <p class="modal__desc">
            A comprehensive patient management portal built on a pure J2EE stack.
            Doctors can manage patient records, schedule appointments, write prescriptions,
            and view appointment history — all from a clean, role-based dashboard.
        </p>
        <div class="modal__features">
            <h4>Key Features</h4>
            <ul>
                <li><i class="fa-solid fa-check"></i> Patient registration & profile management</li>
                <li><i class="fa-solid fa-check"></i> Appointment scheduling with conflict detection</li>
                <li><i class="fa-solid fa-check"></i> Medical records & prescription history</li>
                <li><i class="fa-solid fa-check"></i> Admin dashboard with analytics</li>
            </ul>
        </div>
        <div class="modal__actions">
            <a href="#" class="btn btn--primary btn--sm">
                <i class="fa-solid fa-arrow-up-right-from-square"></i> Live Demo
            </a>
            <a href="#" class="btn btn--outline btn--sm">
                <i class="fa-brands fa-github"></i> GitHub
            </a>
        </div>
    </div>
</div>

<!-- Modal: Project 2 -->
<div class="modal" id="modal-proj2" role="dialog" aria-modal="true" aria-labelledby="modal-proj2-title">
    <button class="modal__close" onclick="closeModal()" aria-label="Close">&times;</button>
    <div class="modal__image" style="background: var(--gradient-pink)">
        <div class="modal__img-placeholder"><i class="fa-solid fa-shop"></i></div>
    </div>
    <div class="modal__body">
        <div class="modal__tags">
            <span class="tag">CSS3</span><span class="tag">JavaScript</span>
            <span class="tag">jQuery</span><span class="tag">UI Design</span>
        </div>
        <h3 id="modal-proj2-title" class="modal__title">ShopEase E-commerce</h3>
        <p class="modal__desc">
            A pixel-perfect, fully responsive e-commerce storefront with an emphasis on
            seamless UX. Features smooth add-to-cart animations, product quick view,
            multi-step checkout, and a wishlist feature — all in pure vanilla JS.
        </p>
        <div class="modal__features">
            <h4>Key Features</h4>
            <ul>
                <li><i class="fa-solid fa-check"></i> Dynamic product filtering & search</li>
                <li><i class="fa-solid fa-check"></i> Shopping cart with local persistence</li>
                <li><i class="fa-solid fa-check"></i> Multi-step checkout flow</li>
                <li><i class="fa-solid fa-check"></i> Wishlist & comparison tools</li>
            </ul>
        </div>
        <div class="modal__actions">
            <a href="#" class="btn btn--primary btn--sm">
                <i class="fa-solid fa-arrow-up-right-from-square"></i> Live Demo
            </a>
            <a href="#" class="btn btn--outline btn--sm">
                <i class="fa-brands fa-github"></i> GitHub
            </a>
        </div>
    </div>
</div>

<!-- Modals 3-6 follow the same pattern — abbreviated for space -->
<div class="modal" id="modal-proj3" role="dialog" aria-modal="true" aria-labelledby="modal-proj3-title">
    <button class="modal__close" onclick="closeModal()" aria-label="Close">&times;</button>
    <div class="modal__image" style="background: linear-gradient(135deg, #667eea, #764ba2)">
        <div class="modal__img-placeholder"><i class="fa-solid fa-graduation-cap"></i></div>
    </div>
    <div class="modal__body">
        <div class="modal__tags">
            <span class="tag">JDBC</span><span class="tag">Servlet</span>
            <span class="tag">MySQL</span><span class="tag">JSP</span>
        </div>
        <h3 id="modal-proj3-title" class="modal__title">EduConnect LMS</h3>
        <p class="modal__desc">
            A feature-rich learning management system supporting student enrollment, course
            content delivery, progress tracking, quizzes with auto-grading, and
            instructor dashboards — built entirely on J2EE and MySQL.
        </p>
        <div class="modal__features">
            <h4>Key Features</h4>
            <ul>
                <li><i class="fa-solid fa-check"></i> Course catalog with enrollment system</li>
                <li><i class="fa-solid fa-check"></i> Quiz engine with auto-grading</li>
                <li><i class="fa-solid fa-check"></i> Progress tracking per student</li>
                <li><i class="fa-solid fa-check"></i> Instructor & admin dashboards</li>
            </ul>
        </div>
        <div class="modal__actions">
            <a href="#" class="btn btn--primary btn--sm"><i class="fa-solid fa-arrow-up-right-from-square"></i> Live Demo</a>
            <a href="#" class="btn btn--outline btn--sm"><i class="fa-brands fa-github"></i> GitHub</a>
        </div>
    </div>
</div>

<div class="modal" id="modal-proj4" role="dialog" aria-modal="true" aria-labelledby="modal-proj4-title">
    <button class="modal__close" onclick="closeModal()" aria-label="Close">&times;</button>
    <div class="modal__image" style="background: linear-gradient(135deg, #f093fb, #f5576c)">
        <div class="modal__img-placeholder"><i class="fa-solid fa-chart-line"></i></div>
    </div>
    <div class="modal__body">
        <div class="modal__tags"><span class="tag">Java</span><span class="tag">Charts</span><span class="tag">Finance</span></div>
        <h3 id="modal-proj4-title" class="modal__title">FinanceIQ Dashboard</h3>
        <p class="modal__desc">Personal finance tracker with real-time budget monitoring, visual expenditure charts, bill reminders, and automated monthly PDF reports exported via iText.</p>
        <div class="modal__features"><h4>Key Features</h4><ul>
            <li><i class="fa-solid fa-check"></i> Income & expense tracking</li>
            <li><i class="fa-solid fa-check"></i> Visual charts & trend analysis</li>
            <li><i class="fa-solid fa-check"></i> Budget limit alerts</li>
            <li><i class="fa-solid fa-check"></i> PDF export reports</li>
        </ul></div>
        <div class="modal__actions">
            <a href="#" class="btn btn--primary btn--sm"><i class="fa-solid fa-arrow-up-right-from-square"></i> Live Demo</a>
            <a href="#" class="btn btn--outline btn--sm"><i class="fa-brands fa-github"></i> GitHub</a>
        </div>
    </div>
</div>

<div class="modal" id="modal-proj5" role="dialog" aria-modal="true" aria-labelledby="modal-proj5-title">
    <button class="modal__close" onclick="closeModal()" aria-label="Close">&times;</button>
    <div class="modal__image" style="background: linear-gradient(135deg, #4facfe, #00f2fe)">
        <div class="modal__img-placeholder"><i class="fa-solid fa-plane"></i></div>
    </div>
    <div class="modal__body">
        <div class="modal__tags"><span class="tag">UI/UX</span><span class="tag">CSS3</span><span class="tag">Animations</span></div>
        <h3 id="modal-proj5-title" class="modal__title">TravelBliss App</h3>
        <p class="modal__desc">Award-winning travel booking interface featuring destination discovery, smart itinerary builder, hotel comparisons and beautiful micro-animations.</p>
        <div class="modal__features"><h4>Key Features</h4><ul>
            <li><i class="fa-solid fa-check"></i> Destination search & filtering</li>
            <li><i class="fa-solid fa-check"></i> Visual itinerary builder</li>
            <li><i class="fa-solid fa-check"></i> Hotel & flight listings</li>
            <li><i class="fa-solid fa-check"></i> Smooth micro-animations</li>
        </ul></div>
        <div class="modal__actions">
            <a href="#" class="btn btn--primary btn--sm"><i class="fa-solid fa-arrow-up-right-from-square"></i> Live Demo</a>
            <a href="#" class="btn btn--outline btn--sm"><i class="fa-brands fa-github"></i> GitHub</a>
        </div>
    </div>
</div>

<div class="modal" id="modal-proj6" role="dialog" aria-modal="true" aria-labelledby="modal-proj6-title">
    <button class="modal__close" onclick="closeModal()" aria-label="Close">&times;</button>
    <div class="modal__image" style="background: linear-gradient(135deg, #43e97b, #38f9d7)">
        <div class="modal__img-placeholder"><i class="fa-solid fa-boxes-stacked"></i></div>
    </div>
    <div class="modal__body">
        <div class="modal__tags"><span class="tag">Servlet</span><span class="tag">CRUD</span><span class="tag">Inventory</span></div>
        <h3 id="modal-proj6-title" class="modal__title">StockMaster Inventory</h3>
        <p class="modal__desc">Enterprise inventory system with real-time stock tracking, reorder alerts, supplier management, barcode support and detailed reporting.</p>
        <div class="modal__features"><h4>Key Features</h4><ul>
            <li><i class="fa-solid fa-check"></i> Real-time stock monitoring</li>
            <li><i class="fa-solid fa-check"></i> Supplier & PO management</li>
            <li><i class="fa-solid fa-check"></i> Low-stock email alerts</li>
            <li><i class="fa-solid fa-check"></i> Barcode scanning support</li>
        </ul></div>
        <div class="modal__actions">
            <a href="#" class="btn btn--primary btn--sm"><i class="fa-solid fa-arrow-up-right-from-square"></i> Live Demo</a>
            <a href="#" class="btn btn--outline btn--sm"><i class="fa-brands fa-github"></i> GitHub</a>
        </div>
    </div>
</div>


<!-- ═══════════════════════════════════════════════════════════
     CONTACT SECTION  ← PRIMARY FOCUS OF STEP 4
     ════════════════════════════════════════════════════════ -->
<section class="contact section section--alt" id="contact">
    <div class="container">

        <div class="section-header">
            <span class="section-tag">Get In Touch</span>
            <h2 class="section-title">Contact <span class="text-gradient">Me</span></h2>
            <div class="section-line"></div>
            <p class="section-subtitle">
                Have a project in mind or just want to say hello? I'd love to hear from you!
            </p>
        </div>

        <div class="contact__grid">

            <!-- Left: Info cards -->
            <div class="contact__info" data-aos="fade-right">

                <div class="contact-info-card">
                    <div class="contact-info-card__icon">
                        <i class="fa-solid fa-envelope"></i>
                    </div>
                    <div class="contact-info-card__text">
                        <span class="contact-info-card__label">Email Me</span>
                        <a href="mailto:joe@codezerra.com" class="contact-info-card__value">
                            joe@codezerra.com
                        </a>
                    </div>
                </div>

                <div class="contact-info-card">
                    <div class="contact-info-card__icon">
                        <i class="fa-solid fa-phone"></i>
                    </div>
                    <div class="contact-info-card__text">
                        <span class="contact-info-card__label">Call Me</span>
                        <a href="tel:+23280711845" class="contact-info-card__value">
                            +232 (80) 711-845
                        </a>
                    </div>
                </div>

                <div class="contact-info-card">
                    <div class="contact-info-card__icon">
                        <i class="fa-solid fa-location-dot"></i>
                    </div>
                    <div class="contact-info-card__text">
                        <span class="contact-info-card__label">Location</span>
                        <span class="contact-info-card__value">
                            Available Worldwide 🌍
                        </span>
                    </div>
                </div>

                <div class="contact-info-card">
                    <div class="contact-info-card__icon">
                        <i class="fa-solid fa-clock"></i>
                    </div>
                    <div class="contact-info-card__text">
                        <span class="contact-info-card__label">Response Time</span>
                        <span class="contact-info-card__value">
                            Within 24 hours ⚡
                        </span>
                    </div>
                </div>

                <!-- Social row -->
                <div class="contact__socials">
                    <p>Follow me on</p>
                    <div class="contact__social-links">
                        <a href="https://github.com/joemrnice" class="social-link" title="GitHub">
                            <i class="fa-brands fa-github"></i>
                        </a>
                        <a href="https://www.linkedin.com/in/joseph-lahai-kanu-b02291255/" class="social-link" title="LinkedIn">
                            <i class="fa-brands fa-linkedin-in"></i>
                        </a>
                        <a href="#" class="social-link" title="Twitter">
                            <i class="fa-brands fa-twitter"></i>
                        </a>
                        <a href="#" class="social-link" title="Dribbble">
                            <i class="fa-brands fa-dribbble"></i>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Right: Contact Form -->
            <div class="contact__form-wrap" data-aos="fade-left">
                <form class="contact-form"
                      id="contactForm"
                      action="<%= request.getContextPath() %>/contact"
                      method="POST"
                      novalidate>

                    <h3 class="contact-form__title">Send Me a Message 💜</h3>

                    <!-- Name + Email row -->
                    <div class="form-row">
                        <div class="form-group" id="group-name">
                            <label for="name" class="form-label">
                                Full Name <span class="required">*</span>
                            </label>
                            <div class="form-input-wrap">
                                <i class="fa-solid fa-user form-input-icon"></i>
                                <input type="text"
                                       id="name"
                                       name="name"
                                       class="form-input"
                                       placeholder="Your full name"
                                       maxlength="100"
                                       autocomplete="name"
                                       required/>
                            </div>
                            <span class="form-error" id="error-name"></span>
                        </div>

                        <div class="form-group" id="group-email">
                            <label for="email" class="form-label">
                                Email Address <span class="required">*</span>
                            </label>
                            <div class="form-input-wrap">
                                <i class="fa-solid fa-envelope form-input-icon"></i>
                                <input type="email"
                                       id="email"
                                       name="email"
                                       class="form-input"
                                       placeholder="your@email.com"
                                       maxlength="150"
                                       autocomplete="email"
                                       required/>
                            </div>
                            <span class="form-error" id="error-email"></span>
                        </div>
                    </div>

                    <!-- Subject -->
                    <div class="form-group" id="group-subject">
                        <label for="subject" class="form-label">
                            Subject <span class="required">*</span>
                        </label>
                        <div class="form-input-wrap">
                            <i class="fa-solid fa-tag form-input-icon"></i>
                            <input type="text"
                                   id="subject"
                                   name="subject"
                                   class="form-input"
                                   placeholder="What is this about?"
                                   maxlength="200"
                                   required/>
                        </div>
                        <span class="form-error" id="error-subject"></span>
                    </div>

                    <!-- Message -->
                    <div class="form-group" id="group-message">
                        <label for="message" class="form-label">
                            Message <span class="required">*</span>
                        </label>
                        <div class="form-input-wrap form-input-wrap--textarea">
                            <i class="fa-solid fa-message form-input-icon form-input-icon--top"></i>
                            <textarea id="message"
                                      name="message"
                                      class="form-input form-textarea"
                                      placeholder="Tell me about your project or idea..."
                                      maxlength="5000"
                                      rows="5"
                                      required></textarea>
                        </div>
                        <div class="form-textarea-footer">
                            <span class="form-error" id="error-message"></span>
                            <span class="form-char-count" id="charCount">0 / 5000</span>
                        </div>
                    </div>

                    <!-- Honeypot (anti-spam — hidden from real users) -->
                    <div style="display:none" aria-hidden="true">
                        <input type="text" name="website" tabindex="-1" autocomplete="off"/>
                    </div>

                    <!-- Submit Button -->
                    <button type="submit" class="btn btn--primary btn--full" id="submitBtn">
                        <span class="btn__text">
                            <i class="fa-solid fa-paper-plane"></i> Send Message
                        </span>
                        <span class="btn__loading" style="display:none">
                            <i class="fa-solid fa-spinner fa-spin"></i> Sending...
                        </span>
                    </button>

                    <p class="contact-form__note">
                        <i class="fa-solid fa-lock"></i>
                        Your information is safe. I'll never share your data.
                    </p>

                </form>
            </div>

        </div>
    </div>
</section>


<!-- ═══════════════════════════════════════════════════════════
     FOOTER
     ════════════════════════════════════════════════════════ -->
<footer class="footer">
    <div class="container">
        <div class="footer__grid">

            <div class="footer__brand">
                <a href="#home" class="footer__logo">
                    <span class="navbar__logo-dot">✦</span>Joe
                </a>
                <p class="footer__brand-text">
                    Passionate Web Developer crafting beautiful digital experiences,
                    one line of code at a time.
                </p>
                <div class="footer__socials">
                    <a href="#" class="social-link social-link--sm" title="GitHub">
                        <i class="fa-brands fa-github"></i>
                    </a>
                    <a href="#" class="social-link social-link--sm" title="LinkedIn">
                        <i class="fa-brands fa-linkedin-in"></i>
                    </a>
                    <a href="#" class="social-link social-link--sm" title="Twitter">
                        <i class="fa-brands fa-twitter"></i>
                    </a>
                    <a href="#" class="social-link social-link--sm" title="Dribbble">
                        <i class="fa-brands fa-dribbble"></i>
                    </a>
                </div>
            </div>

            <div class="footer__links-col">
                <h4 class="footer__col-title">Navigation</h4>
                <ul class="footer__links">
                    <li><a href="#home">Home</a></li>
                    <li><a href="#about">About</a></li>
                    <li><a href="#skills">Skills</a></li>
                    <li><a href="#projects">Projects</a></li>
                    <li><a href="#contact">Contact</a></li>
                </ul>
            </div>

            <div class="footer__links-col">
                <h4 class="footer__col-title">Services</h4>
                <ul class="footer__links">
                    <li><a href="#">Web Development</a></li>
                    <li><a href="#">UI/UX Design</a></li>
                    <li><a href="#">Database Design</a></li>
                    <li><a href="#">API Development</a></li>
                    <li><a href="#">Code Review</a></li>
                </ul>
            </div>

            <div class="footer__newsletter">
                <h4 class="footer__col-title">Stay Connected</h4>
                <p>Get updates on my latest projects and articles.</p>
                <div class="footer__newsletter-form">
                    <input type="email"
                           placeholder="your@email.com"
                           class="footer__newsletter-input"
                           aria-label="Newsletter email"/>
                    <button class="btn btn--primary btn--sm footer__newsletter-btn">
                        <i class="fa-solid fa-paper-plane"></i>
                    </button>
                </div>
            </div>

        </div>

        <div class="footer__bottom">
            <p>
                &copy; <%= new java.util.Date().getYear() + 1900 %>
                <strong>Joe</strong>. All rights reserved. Built with
                <i class="fa-solid fa-heart" style="color:var(--pink)"></i> &amp; Java EE.
            </p>
            <a href="#home" class="footer__back-top" aria-label="Back to top">
                <i class="fa-solid fa-chevron-up"></i>
            </a>
        </div>
    </div>
</footer>

<!-- jQuery (CDN) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<!-- Project JS -->
<script src="<%= request.getContextPath() %>/js/main.js"></script>

</body>
</html>