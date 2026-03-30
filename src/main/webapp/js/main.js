/* ============================================================
   JoePortfolio — main.js
   Handles: Navbar, Typing effect, Scroll animations,
            Skill bars, Project filters, Modals,
            Contact form validation, Toast, Counters
   Author : Code Zerra
   ============================================================ */

$(document).ready(function () {

    /* ── 1. NAVBAR SCROLL BEHAVIOR ──────────────────────── */
    const $navbar = $('#navbar');

    $(window).on('scroll.navbar', function () {
        if ($(this).scrollTop() > 50) {
            $navbar.addClass('scrolled');
        } else {
            $navbar.removeClass('scrolled');
        }
    });

    /* ── 2. ACTIVE NAV LINK ON SCROLL ─────────────────── */
    const sections = ['home', 'about', 'skills', 'projects', 'contact'];

    $(window).on('scroll.navActive', function () {
        const scrollPos = $(this).scrollTop() + 100;

        sections.forEach(function (id) {
            const $section = $('#' + id);
            if ($section.length === 0) return;

            const top    = $section.offset().top;
            const bottom = top + $section.outerHeight();

            if (scrollPos >= top && scrollPos < bottom) {
                $('.navbar__link').removeClass('active');
                $('.navbar__link[data-section="' + id + '"]').addClass('active');
            }
        });
    });

    /* ── 3. SMOOTH SCROLL FOR ALL ANCHOR LINKS ─────────── */
    $(document).on('click', 'a[href^="#"]', function (e) {
        const target = $(this).attr('href');
        if (target === '#' || target.length < 2) return;

        const $target = $(target);
        if ($target.length === 0) return;

        e.preventDefault();

        const navH   = parseInt(
            getComputedStyle(document.documentElement)
                .getPropertyValue('--navbar-height')
        ) || 72;

        $('html, body').animate({
            scrollTop: $target.offset().top - navH
        }, 600, 'swing');

        // Close mobile menu if open
        closeMobileMenu();
    });

    /* ── 4. MOBILE HAMBURGER MENU ──────────────────────── */
    const $hamburger   = $('#hamburger');
    const $mobileMenu  = $('#mobileMenu');
    const $mobileOverlay = $('#mobileOverlay');

    $hamburger.on('click', function () {
        const isOpen = $mobileMenu.hasClass('open');
        if (isOpen) {
            closeMobileMenu();
        } else {
            openMobileMenu();
        }
    });

    $('#mobileMenuClose, #mobileOverlay').on('click', closeMobileMenu);

    $('.mobile-menu__link').on('click', closeMobileMenu);

    function openMobileMenu() {
        $hamburger.addClass('open').attr('aria-expanded', 'true');
        $mobileMenu.addClass('open').attr('aria-hidden', 'false');
        $mobileOverlay.addClass('visible');
        $('body').css('overflow', 'hidden');
    }

    function closeMobileMenu() {
        $hamburger.removeClass('open').attr('aria-expanded', 'false');
        $mobileMenu.removeClass('open').attr('aria-hidden', 'true');
        $mobileOverlay.removeClass('visible');
        $('body').css('overflow', '');
    }

    /* ── 5. TYPING EFFECT (Hero section) ───────────────── */
    const typingTexts  = [
        'Full-Stack Developer',
        'UI/UX Enthusiast',
        'Java EE Expert',
        'Problem Solver',
        'Digital Creator'
    ];
    let textIndex  = 0;
    let charIndex  = 0;
    let isDeleting = false;
    const $typingEl = $('#typingText');

    function typeText() {
        const current = typingTexts[textIndex];
        const speed   = isDeleting ? 60 : 110;

        if (isDeleting) {
            $typingEl.text(current.substring(0, charIndex - 1));
            charIndex--;
        } else {
            $typingEl.text(current.substring(0, charIndex + 1));
            charIndex++;
        }

        if (!isDeleting && charIndex === current.length) {
            // Pause before deleting
            setTimeout(function () { isDeleting = true; typeText(); }, 1800);
            return;
        }

        if (isDeleting && charIndex === 0) {
            isDeleting = false;
            textIndex  = (textIndex + 1) % typingTexts.length;
        }

        setTimeout(typeText, speed);
    }

    if ($typingEl.length) {
        setTimeout(typeText, 800);
    }

    /* ── 6. INTERSECTION OBSERVER — Scroll Animations ──── */
    // Animates elements into view using CSS classes
    const observerOptions = {
        threshold:  0.15,
        rootMargin: '0px 0px -60px 0px'
    };

    // --- Skill bars animation ---
    const skillBarObserver = new IntersectionObserver(function (entries) {
        entries.forEach(function (entry) {
            if (entry.isIntersecting) {
                const $bar = $(entry.target).find('.skill-bar__fill');
                $bar.each(function () {
                    const targetWidth = $(this).data('width') + '%';
                    setTimeout(function () {
                        $bar.css('width', targetWidth);
                    }, 200);
                });
                skillBarObserver.unobserve(entry.target);
            }
        });
    }, observerOptions);

    $('.skills__bars').each(function () {
        skillBarObserver.observe(this);
    });

    // --- Counter animation (stats numbers) ---
    const counterObserver = new IntersectionObserver(function (entries) {
        entries.forEach(function (entry) {
            if (entry.isIntersecting) {
                $(entry.target).find('.skills__stat-number').each(function () {
                    animateCounter($(this));
                });
                counterObserver.unobserve(entry.target);
            }
        });
    }, observerOptions);

    $('.skills__stats').each(function () {
        counterObserver.observe(this);
    });

    function animateCounter($el) {
        const target   = parseInt($el.data('target'), 10);
        const duration = 1500;
        const step     = target / (duration / 16);
        let current    = 0;

        const timer = setInterval(function () {
            current += step;
            if (current >= target) {
                $el.text(target);
                clearInterval(timer);
            } else {
                $el.text(Math.floor(current));
            }
        }, 16);
    }

    // --- General fade-in for data-aos elements (lightweight AOS replacement) ---
    const fadeObserver = new IntersectionObserver(function (entries) {
        entries.forEach(function (entry) {
            if (entry.isIntersecting) {
                const delay = $(entry.target).data('aos-delay') || 0;
                setTimeout(function () {
                    $(entry.target).addClass('aos-animate');
                }, parseInt(delay, 10));
                fadeObserver.unobserve(entry.target);
            }
        });
    }, { threshold: 0.1 });

    $('[data-aos]').each(function () {
        // Set initial hidden state via inline style
        const direction = $(this).data('aos');
        let transform   = 'translateY(30px)';
        if (direction === 'fade-left')  transform = 'translateX(40px)';
        if (direction === 'fade-right') transform = 'translateX(-40px)';
        if (direction === 'fade-up')    transform = 'translateY(40px)';

        $(this).css({
            opacity:    0,
            transform:  transform,
            transition: 'opacity 0.7s ease, transform 0.7s ease'
        });

        fadeObserver.observe(this);
    });

    // Add animate class styles via JS
    $('<style>')
        .text('.aos-animate { opacity: 1 !important; transform: none !important; }')
        .appendTo('head');

    /* ── 7. PROJECT FILTER TABS ─────────────────────────── */
    $(document).on('click', '.filter-btn', function () {
        const filter = $(this).data('filter');

        // Update active button
        $('.filter-btn').removeClass('active');
        $(this).addClass('active');

        // Filter cards
        $('.project-card').each(function () {
            const category = $(this).data('category');
            if (filter === 'all' || category === filter) {
                $(this).removeClass('hidden').css({
                    opacity: 0,
                    transform: 'scale(0.9)'
                });
                // Animate in
                setTimeout(function () {
                    $(this).css({
                        opacity: '',
                        transform: '',
                        transition: 'opacity 0.4s ease, transform 0.4s ease'
                    });
                }.bind(this), 10);
            } else {
                $(this).addClass('hidden');
            }
        });
    });

    /* ── 8. PROJECT MODALS ──────────────────────────────── */
    // openModal & closeModal are global (called from onclick in JSP)
    window.openModal = function (projectId) {
        const $modal = $('#modal-' + projectId);
        if ($modal.length === 0) return;

        $('#modalBackdrop').addClass('visible');
        $modal.addClass('visible');
        $('body').css('overflow', 'hidden');

        // Trap focus inside modal
        setTimeout(function () {
            $modal.find('.modal__close').trigger('focus');
        }, 100);
    };

    window.closeModal = function () {
        $('.modal').removeClass('visible');
        $('#modalBackdrop').removeClass('visible');
        $('body').css('overflow', '');
    };

    // Close modal on Escape key
    $(document).on('keydown.modal', function (e) {
        if (e.key === 'Escape') {
            closeModal();
            closeMobileMenu();
        }
    });

    /* ── 9. CONTACT FORM — Client-side Validation ───────── */
    const $form      = $('#contactForm');
    const $submitBtn = $('#submitBtn');
    const $charCount = $('#charCount');
    const $message   = $('#message');

    // --- Character counter ---
    $message.on('input', function () {
        const len     = $(this).val().length;
        const max     = 5000;
        const display = len + ' / ' + max;
        $charCount.text(display);

        if (len > max * 0.9) {
            $charCount.addClass('warning');
        } else {
            $charCount.removeClass('warning');
        }
    });

    // --- Real-time field validation (on blur) ---
    $('#name').on('blur', function () {
        validateField('name');
    });

    $('#email').on('blur', function () {
        validateField('email');
    });

    $('#subject').on('blur', function () {
        validateField('subject');
    });

    $message.on('blur', function () {
        validateField('message');
    });

    // Clear error on focus
    $('.form-input').on('focus', function () {
        const id = $(this).attr('id');
        clearFieldError(id);
    });

    // --- Form submit handler ---
    $form.on('submit', function (e) {
        e.preventDefault(); // Prevent default first

        let isValid = true;

        // Validate all fields
        if (!validateField('name'))    isValid = false;
        if (!validateField('email'))   isValid = false;
        if (!validateField('subject')) isValid = false;
        if (!validateField('message')) isValid = false;

        if (!isValid) {
            // Shake the form
            $form.addClass('form-shake');
            setTimeout(function () { $form.removeClass('form-shake'); }, 500);
            // Scroll to first error
            const $firstError = $form.find('.input-error').first();
            if ($firstError.length) {
                $('html, body').animate({
                    scrollTop: $firstError.offset().top - 120
                }, 400);
            }
            return false;
        }

        // All good — show loading state and submit
        $submitBtn.find('.btn__text').hide();
        $submitBtn.find('.btn__loading').show();
        $submitBtn.prop('disabled', true);

        // Submit the form for real (server-side processing)
        this.submit();
    });

    /**
     * Validates a single form field by its ID.
     * Sets/clears error state and message.
     * Returns true if valid, false if invalid.
     */
    function validateField(fieldId) {
        const $input = $('#' + fieldId);
        const value  = $input.val().trim();
        let error    = '';

        switch (fieldId) {
            case 'name':
                if (!value) {
                    error = 'Please enter your full name.';
                } else if (value.length > 100) {
                    error = 'Name must be under 100 characters.';
                }
                break;

            case 'email':
                if (!value) {
                    error = 'Please enter your email address.';
                } else if (!/^[A-Za-z0-9+_.\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$/.test(value)) {
                    error = 'Please enter a valid email (e.g. you@example.com).';
                } else if (value.length > 150) {
                    error = 'Email must be under 150 characters.';
                }
                break;

            case 'subject':
                if (!value) {
                    error = 'Please enter a subject.';
                } else if (value.length > 200) {
                    error = 'Subject must be under 200 characters.';
                }
                break;

            case 'message':
                if (!value) {
                    error = 'Please write your message.';
                } else if (value.length < 10) {
                    error = 'Message is too short (minimum 10 characters).';
                } else if (value.length > 5000) {
                    error = 'Message is too long (maximum 5000 characters).';
                }
                break;
        }

        if (error) {
            showFieldError(fieldId, error);
            return false;
        } else {
            showFieldSuccess(fieldId);
            return true;
        }
    }

    function showFieldError(fieldId, message) {
        const $input = $('#' + fieldId);
        const $error = $('#error-' + fieldId);
        $input.removeClass('input-success').addClass('input-error');
        $error.text(message);
    }

    function showFieldSuccess(fieldId) {
        const $input = $('#' + fieldId);
        const $error = $('#error-' + fieldId);
        $input.removeClass('input-error').addClass('input-success');
        $error.text('');
    }

    function clearFieldError(fieldId) {
        const $input = $('#' + fieldId);
        const $error = $('#error-' + fieldId);
        $input.removeClass('input-error input-success');
        $error.text('');
    }

    /* ── 10. TOAST NOTIFICATION ─────────────────────────── */
    // Global function callable from JSP inline onclick
    window.closeToast = function () {
        $('#toastNotification').removeClass('toast--visible');
        setTimeout(function () {
            $('#toastNotification').remove();
        }, 400);
    };

    // Auto-close toast after 6 seconds
    const $toast = $('#toastNotification');
    if ($toast.length) {
        // Scroll to contact section so user sees the feedback
        setTimeout(function () {
            const $contact = $('#contact');
            if ($contact.length) {
                $('html, body').animate({
                    scrollTop: $contact.offset().top - 80
                }, 600);
            }
        }, 300);

        // Auto-dismiss
        setTimeout(function () {
            window.closeToast();
        }, 6000);
    }

    /* ── 11. ADD FORM SHAKE ANIMATION STYLES ────────────── */
    $('<style>').text(`
        @keyframes formShake {
            0%,100% { transform: translateX(0); }
            20%     { transform: translateX(-8px); }
            40%     { transform: translateX(8px); }
            60%     { transform: translateX(-5px); }
            80%     { transform: translateX(5px); }
        }
        .form-shake {
            animation: formShake 0.5s cubic-bezier(0.4,0,0.2,1);
        }
    `).appendTo('head');

    /* ── 12. HERO PARTICLE DOTS (subtle background) ─────── */
    const $canvas    = document.getElementById('particles');
    if ($canvas) {
        const canvas  = $canvas;
        const ctx     = canvas.getContext('2d');
        let particles = [];

        function resizeCanvas() {
            canvas.width  = canvas.parentElement.offsetWidth;
            canvas.height = canvas.parentElement.offsetHeight;
        }

        function createParticle() {
            return {
                x:     Math.random() * canvas.width,
                y:     Math.random() * canvas.height,
                r:     Math.random() * 2 + 0.5,
                dx:    (Math.random() - 0.5) * 0.4,
                dy:    (Math.random() - 0.5) * 0.4,
                alpha: Math.random() * 0.4 + 0.1
            };
        }

        function initParticles() {
            particles = [];
            for (let i = 0; i < 50; i++) {
                particles.push(createParticle());
            }
        }

        function drawParticles() {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            particles.forEach(function (p) {
                ctx.beginPath();
                ctx.arc(p.x, p.y, p.r, 0, Math.PI * 2);
                ctx.fillStyle = 'rgba(155, 89, 182, ' + p.alpha + ')';
                ctx.fill();

                p.x += p.dx;
                p.y += p.dy;

                if (p.x < 0) p.x = canvas.width;
                if (p.x > canvas.width)  p.x = 0;
                if (p.y < 0) p.y = canvas.height;
                if (p.y > canvas.height) p.y = 0;
            });
            requestAnimationFrame(drawParticles);
        }

        resizeCanvas();
        initParticles();
        drawParticles();
        $(window).on('resize.particles', function () {
            resizeCanvas();
            initParticles();
        });
    }

    /* ── 13. YEAR IN FOOTER — handled by JSP EL already ── */

    console.log('%c✦ DijaPortfolio loaded — Code Zerra',
        'color: #9b59b6; font-weight:bold; font-size:14px;');

}); // end document.ready