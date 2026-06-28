<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // If already logged in, redirect to dashboard
    if (session.getAttribute("loggedInUser") != null) {
        response.sendRedirect("dashboard");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TastyBites — Order Food Online, Discover Great Restaurants</title>
    <meta name="description" content="Order food online from the best South Indian restaurants in your city. Fast delivery, great taste. TastyBites - India's favourite food delivery app.">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        
        :root {
            --red:       #e23744;
            --red-dark:  #cb202d;
            --orange:    #ff6b35;
            --gray-bg:   #f8f8f8;
            --white:     #ffffff;
            --text:      #1c1c1c;
            --text-muted:#696969;
            --border:    #e8e8e8;
            --green:     #3d9b3d;
            --shadow:    0 2px 16px rgba(0,0,0,.08);
            --shadow-lg: 0 8px 32px rgba(0,0,0,.14);
        }

        html { scroll-behavior: smooth; }
        body { font-family: 'Inter', sans-serif; background: var(--white); color: var(--text); overflow-x: hidden; }

        /* ── Navbar ── */
        .navbar {
            position: sticky; top: 0; z-index: 1000;
            background: var(--white);
            border-bottom: 1px solid var(--border);
            box-shadow: 0 1px 4px rgba(0,0,0,.06);
        }
        .navbar-inner {
            max-width: 1200px; margin: 0 auto;
            padding: 0 20px;
            height: 64px;
            display: flex; align-items: center; justify-content: space-between; gap: 20px;
        }
        .logo { display: flex; align-items: center; gap: 10px; text-decoration: none; flex-shrink: 0; }
        .logo-icon { font-size: 28px; }
        .logo-text { font-size: 22px; font-weight: 900; color: var(--red); letter-spacing: -0.5px; }

        .location-btn {
            display: flex; align-items: center; gap: 8px;
            background: none; border: none; cursor: pointer;
            font-family: 'Inter', sans-serif;
            font-size: 13px; font-weight: 600; color: var(--text);
            padding: 8px 12px;
            border-radius: 8px;
            border: 1.5px solid var(--border);
            transition: all .2s;
            white-space: nowrap;
        }
        .location-btn:hover { border-color: var(--red); color: var(--red); }
        .location-btn i { color: var(--red); font-size: 14px; }

        .search-bar {
            flex: 1; max-width: 480px;
            display: flex; align-items: center;
            background: var(--gray-bg);
            border: 1.5px solid var(--border);
            border-radius: 10px;
            padding: 0 14px;
            gap: 10px;
            transition: all .2s;
        }
        .search-bar:focus-within { border-color: var(--red); background: var(--white); box-shadow: 0 0 0 3px rgba(226,55,68,.1); }
        .search-bar i { color: var(--text-muted); font-size: 15px; }
        .search-bar input {
            flex: 1; border: none; background: transparent;
            font-family: 'Inter', sans-serif; font-size: 14px;
            padding: 12px 0; outline: none; color: var(--text);
        }
        .search-bar input::placeholder { color: #b0b0b0; }

        .nav-actions { display: flex; align-items: center; gap: 12px; flex-shrink: 0; }
        .btn-login {
            padding: 9px 20px; border-radius: 8px;
            font-family: 'Inter', sans-serif; font-size: 14px; font-weight: 700;
            cursor: pointer; transition: all .2s; text-decoration: none;
            border: 2px solid var(--text);
            background: transparent; color: var(--text);
        }
        .btn-login:hover { border-color: var(--red); color: var(--red); }
        .btn-signup {
            padding: 9px 20px; border-radius: 8px;
            font-family: 'Inter', sans-serif; font-size: 14px; font-weight: 700;
            cursor: pointer; transition: all .2s; text-decoration: none;
            background: var(--red); color: #fff; border: 2px solid var(--red);
            box-shadow: 0 4px 12px rgba(226,55,68,.3);
        }
        .btn-signup:hover { background: var(--red-dark); border-color: var(--red-dark); transform: translateY(-1px); }

        /* ── Tab Bar ── */
        .tab-bar {
            background: var(--white);
            border-bottom: 1px solid var(--border);
        }
        .tab-bar-inner {
            max-width: 1200px; margin: 0 auto; padding: 0 20px;
            display: flex; gap: 0;
        }
        .tab-item {
            display: flex; align-items: center; gap: 8px;
            padding: 14px 24px; font-size: 14px; font-weight: 600;
            color: var(--text-muted); cursor: pointer;
            border-bottom: 3px solid transparent;
            transition: all .2s; text-decoration: none;
        }
        .tab-item.active { color: var(--red); border-bottom-color: var(--red); }
        .tab-item:hover { color: var(--red); }
        .tab-item i { font-size: 16px; }

        /* ── Hero Section ── */
        .hero {
            position: relative;
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 40%, #0f3460 100%);
            min-height: 380px;
            display: flex; align-items: center;
            overflow: hidden;
        }
        .hero::before {
            content: '';
            position: absolute; inset: 0;
            background: url('images/hero_banner.png') center/cover no-repeat;
            opacity: 0.35;
        }
        .hero-gradient {
            position: absolute; inset: 0;
            background: linear-gradient(90deg, rgba(10,10,30,.85) 0%, rgba(10,10,30,.4) 60%, transparent 100%);
        }
        .hero-content {
            position: relative; z-index: 2;
            max-width: 1200px; margin: 0 auto; padding: 60px 20px;
            width: 100%;
        }
        .hero h1 {
            font-size: 42px; font-weight: 900; color: var(--white);
            line-height: 1.15; margin-bottom: 12px;
            letter-spacing: -1px;
        }
        .hero h1 span { color: #ffd54f; }
        .hero p { font-size: 16px; color: rgba(255,255,255,.8); margin-bottom: 28px; }
        .hero-search {
            display: flex; align-items: center;
            background: var(--white);
            border-radius: 12px; overflow: hidden;
            box-shadow: 0 8px 32px rgba(0,0,0,.25);
            max-width: 560px;
        }
        .hero-search-loc {
            display: flex; align-items: center; gap: 8px;
            padding: 0 16px; border-right: 1.5px solid var(--border);
            font-size: 13px; font-weight: 600; color: var(--text);
            white-space: nowrap; cursor: pointer;
        }
        .hero-search-loc i { color: var(--red); }
        .hero-search input {
            flex: 1; padding: 16px; border: none; outline: none;
            font-family: 'Inter', sans-serif; font-size: 15px; color: var(--text);
        }
        .hero-search input::placeholder { color: #aaa; }
        .hero-search-btn {
            padding: 14px 20px; background: var(--red); border: none;
            color: #fff; font-size: 16px; cursor: pointer;
            transition: background .2s;
        }
        .hero-search-btn:hover { background: var(--red-dark); }

        /* ── Sections ── */
        .section { max-width: 1200px; margin: 0 auto; padding: 40px 20px; }
        .section-title { font-size: 24px; font-weight: 800; color: var(--text); margin-bottom: 6px; }
        .section-sub { font-size: 14px; color: var(--text-muted); margin-bottom: 24px; }

        /* ── Food Categories ── */
        .categories-grid {
            display: flex; gap: 20px; overflow-x: auto;
            padding-bottom: 12px; scrollbar-width: none;
        }
        .categories-grid::-webkit-scrollbar { display: none; }
        .category-card {
            display: flex; flex-direction: column; align-items: center; gap: 10px;
            flex-shrink: 0; cursor: pointer; text-decoration: none;
            transition: transform .2s;
        }
        .category-card:hover { transform: translateY(-4px); }
        .category-img {
            width: 100px; height: 100px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid transparent;
            transition: border-color .2s;
            box-shadow: var(--shadow);
        }
        .category-card:hover .category-img { border-color: var(--red); }
        .category-name { font-size: 13px; font-weight: 600; color: var(--text); text-align: center; }

        /* ── Promo Banner ── */
        .promo-banner {
            background: linear-gradient(135deg, #1a1a2e, #0f3460);
            border-radius: 16px;
            padding: 28px 36px;
            display: flex; justify-content: space-between; align-items: center;
            margin: 0 20px;
            overflow: hidden; position: relative;
        }
        .promo-banner::after {
            content: '🍛🍜🥘';
            position: absolute; right: 200px; font-size: 60px; opacity: .15;
            transform: rotate(-15deg);
        }
        .promo-text h3 { font-size: 28px; font-weight: 900; color: var(--white); }
        .promo-text p { font-size: 14px; color: rgba(255,255,255,.7); margin-top: 4px; }
        .promo-btn {
            padding: 12px 28px; background: var(--red); color: #fff;
            font-family: 'Inter', sans-serif; font-weight: 700; font-size: 14px;
            border: none; border-radius: 8px; cursor: pointer;
            text-decoration: none; white-space: nowrap;
            box-shadow: 0 4px 14px rgba(226,55,68,.4);
            transition: all .2s;
        }
        .promo-btn:hover { background: var(--red-dark); transform: translateY(-2px); }

        /* ── Restaurant Cards ── */
        .restaurants-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
            gap: 24px;
        }
        .rest-card {
            background: var(--white);
            border-radius: 16px;
            overflow: hidden;
            box-shadow: var(--shadow);
            border: 1px solid var(--border);
            transition: all .25s;
            text-decoration: none; color: var(--text);
            cursor: pointer;
        }
        .rest-card:hover { transform: translateY(-5px); box-shadow: var(--shadow-lg); }
        .rest-img-wrap { position: relative; height: 180px; overflow: hidden; }
        .rest-img {
            width: 100%; height: 100%; object-fit: cover;
            transition: transform .4s ease;
        }
        .rest-card:hover .rest-img { transform: scale(1.06); }
        .rest-badge {
            position: absolute; top: 12px; left: 0;
            background: var(--red); color: #fff;
            font-size: 11px; font-weight: 800;
            padding: 4px 10px; border-radius: 0 6px 6px 0;
            letter-spacing: .4px;
        }
        .rest-badge.gold { background: linear-gradient(90deg,#f7971e,#ffd200); color: #333; }
        .rest-time-badge {
            position: absolute; bottom: 10px; right: 10px;
            background: rgba(255,255,255,.95); color: var(--text);
            font-size: 11px; font-weight: 700;
            padding: 4px 10px; border-radius: 6px;
            box-shadow: 0 2px 8px rgba(0,0,0,.15);
        }
        .rest-info { padding: 14px 16px 16px; }
        .rest-header { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 4px; }
        .rest-name { font-size: 17px; font-weight: 800; color: var(--text); }
        .rest-rating {
            display: flex; align-items: center; gap: 4px;
            background: var(--green); color: #fff;
            font-size: 13px; font-weight: 800;
            padding: 3px 8px; border-radius: 6px;
            flex-shrink: 0;
        }
        .rest-cuisine { font-size: 13px; color: var(--text-muted); margin-bottom: 10px; }
        .rest-footer {
            display: flex; justify-content: space-between;
            padding-top: 10px; border-top: 1px solid var(--border);
            font-size: 13px;
        }
        .rest-min { color: var(--text-muted); }
        .rest-min strong { color: var(--text); }
        .rest-addr { color: var(--text-muted); font-size: 12px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 110px; }

        /* ── CTA Section ── */
        .cta-section {
            background: linear-gradient(135deg, #fff5f5, #fff0f0);
            border-radius: 20px;
            margin: 0 20px 40px;
            padding: 48px 40px;
            display: flex; align-items: center; justify-content: space-between;
            gap: 40px;
        }
        .cta-text h2 { font-size: 32px; font-weight: 900; color: var(--text); margin-bottom: 10px; }
        .cta-text p { font-size: 16px; color: var(--text-muted); line-height: 1.6; }
        .cta-buttons { display: flex; gap: 14px; margin-top: 24px; }
        .cta-btn-primary {
            padding: 14px 32px; background: var(--red); color: #fff;
            font-family: 'Inter', sans-serif; font-weight: 800; font-size: 15px;
            border-radius: 10px; text-decoration: none;
            box-shadow: 0 6px 20px rgba(226,55,68,.35);
            transition: all .2s;
        }
        .cta-btn-primary:hover { background: var(--red-dark); transform: translateY(-2px); }
        .cta-btn-outline {
            padding: 14px 32px; background: transparent; color: var(--red);
            font-family: 'Inter', sans-serif; font-weight: 700; font-size: 15px;
            border-radius: 10px; text-decoration: none;
            border: 2px solid var(--red);
            transition: all .2s;
        }
        .cta-btn-outline:hover { background: var(--red); color: #fff; }
        .cta-icons { font-size: 80px; opacity: .7; display: flex; gap: 10px; flex-shrink: 0; }

        /* ── Features ── */
        .features-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 24px;
        }
        .feature-card {
            background: var(--white);
            border: 1.5px solid var(--border);
            border-radius: 16px;
            padding: 28px 24px;
            text-align: center;
            transition: all .2s;
        }
        .feature-card:hover { border-color: var(--red); box-shadow: 0 4px 16px rgba(226,55,68,.1); }
        .feature-icon { font-size: 40px; margin-bottom: 16px; }
        .feature-title { font-size: 16px; font-weight: 800; margin-bottom: 8px; }
        .feature-desc { font-size: 14px; color: var(--text-muted); line-height: 1.5; }

        /* ── Footer ── */
        footer {
            background: #1c1c1c;
            color: #fff;
            padding: 50px 20px 24px;
        }
        .footer-inner { max-width: 1200px; margin: 0 auto; }
        .footer-top {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr 1fr;
            gap: 40px;
            padding-bottom: 36px;
            border-bottom: 1px solid rgba(255,255,255,.1);
        }
        .footer-logo { font-size: 24px; font-weight: 900; color: var(--red); margin-bottom: 12px; }
        .footer-desc { font-size: 13px; color: rgba(255,255,255,.5); line-height: 1.7; }
        .footer-col h4 { font-size: 14px; font-weight: 700; color: #fff; margin-bottom: 16px; }
        .footer-col a { display: block; font-size: 13px; color: rgba(255,255,255,.5); text-decoration: none; margin-bottom: 10px; transition: color .2s; }
        .footer-col a:hover { color: var(--red); }
        .footer-bottom {
            padding-top: 24px;
            display: flex; justify-content: space-between; align-items: center;
            font-size: 12px; color: rgba(255,255,255,.35);
        }
        .social-links { display: flex; gap: 14px; }
        .social-links a {
            width: 36px; height: 36px;
            background: rgba(255,255,255,.08);
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            color: rgba(255,255,255,.6); text-decoration: none;
            font-size: 15px; transition: all .2s;
        }
        .social-links a:hover { background: var(--red); color: #fff; }

        /* ── Animations ── */
        @keyframes fadeUp { from { opacity:0; transform:translateY(24px); } to { opacity:1; transform:translateY(0); } }
        .fade-up { opacity:0; animation: fadeUp .6s ease-out forwards; }
        .delay-1 { animation-delay: .1s; }
        .delay-2 { animation-delay: .2s; }
        .delay-3 { animation-delay: .3s; }
        .delay-4 { animation-delay: .4s; }

        /* ── Responsive ── */
        @media (max-width: 768px) {
            .hero h1 { font-size: 28px; }
            .features-grid { grid-template-columns: 1fr; }
            .footer-top { grid-template-columns: 1fr 1fr; }
            .cta-section { flex-direction: column; text-align: center; }
            .cta-icons { display: none; }
            .cta-buttons { justify-content: center; }
            .nav-actions .btn-login { display: none; }
            .location-btn { display: none; }
        }
    </style>
</head>
<body>

<!-- ══ NAVBAR ══════════════════════════════════════════════════════ -->
<nav class="navbar">
    <div class="navbar-inner">
        <a href="index.jsp" class="logo">
            <span class="logo-icon">🍔</span>
            <span class="logo-text">TastyBites</span>
        </a>

        <button class="location-btn">
            <i class="fa-solid fa-location-dot"></i>
            Chennai, Tamil Nadu
            <i class="fa-solid fa-chevron-down" style="font-size:11px;opacity:.6"></i>
        </button>

        <div class="search-bar">
            <i class="fa-solid fa-magnifying-glass"></i>
            <input type="text" placeholder="Search for restaurants, cuisine or a dish">
        </div>

        <div class="nav-actions">
            <a href="login" class="btn-login">Log in</a>
            <a href="register" class="btn-signup">Sign up</a>
        </div>
    </div>
</nav>

<!-- ══ TAB BAR ═════════════════════════════════════════════════════ -->
<div class="tab-bar">
    <div class="tab-bar-inner">
        <a href="#" class="tab-item active">
            <i class="fa-solid fa-moped"></i> Delivery
        </a>
        <a href="#" class="tab-item">
            <i class="fa-solid fa-utensils"></i> Dining Out
        </a>
        <a href="#" class="tab-item">
            <i class="fa-solid fa-moon"></i> Nightlife
        </a>
    </div>
</div>

<!-- ══ HERO ════════════════════════════════════════════════════════ -->
<section class="hero">
    <div class="hero-gradient"></div>
    <div class="hero-content fade-up">
        <h1>Order food online<br>from your <span>favourites</span></h1>
        <p>Discover the best restaurants in Chennai, Coimbatore & beyond</p>
        <div class="hero-search">
            <div class="hero-search-loc">
                <i class="fa-solid fa-location-dot"></i>
                Chennai
                <i class="fa-solid fa-chevron-down" style="font-size:11px;margin-left:4px;opacity:.5"></i>
            </div>
            <input type="text" placeholder="Search for restaurants or dishes...">
            <button class="hero-search-btn" onclick="location.href='register'">
                <i class="fa-solid fa-magnifying-glass"></i>
            </button>
        </div>
    </div>
</section>

<!-- ══ FOOD CATEGORIES ══════════════════════════════════════════════ -->
<div class="section fade-up delay-1">
    <h2 class="section-title">What's on your mind?</h2>
    <p class="section-sub">Inspiration for your next order</p>
    <div class="categories-grid">
        <a href="register" class="category-card">
            <img src="https://images.unsplash.com/photo-1589302168068-964664d93dc0?w=200&h=200&fit=crop&auto=format" class="category-img" alt="Biryani">
            <span class="category-name">Biryani</span>
        </a>
        <a href="register" class="category-card">
            <img src="https://images.unsplash.com/photo-1630851840633-f96999247032?w=200&h=200&fit=crop&auto=format" class="category-img" alt="Dosa">
            <span class="category-name">Dosa</span>
        </a>
        <a href="register" class="category-card">
            <img src="https://images.unsplash.com/photo-1589301760014-d929f3979dbc?w=200&h=200&fit=crop&auto=format" class="category-img" alt="Idli">
            <span class="category-name">Idli</span>
        </a>
        <a href="register" class="category-card">
            <img src="https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=200&h=200&fit=crop&auto=format" class="category-img" alt="Chicken">
            <span class="category-name">Chicken</span>
        </a>
        <a href="register" class="category-card">
            <img src="https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=200&h=200&fit=crop&auto=format" class="category-img" alt="Pizza">
            <span class="category-name">Pizza</span>
        </a>
        <a href="register" class="category-card">
            <img src="https://images.unsplash.com/photo-1567188040759-fb8a883dc6d8?w=200&h=200&fit=crop&auto=format" class="category-img" alt="South Indian">
            <span class="category-name">South Indian</span>
        </a>
        <a href="register" class="category-card">
            <img src="https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=200&h=200&fit=crop&auto=format" class="category-img" alt="Meals">
            <span class="category-name">Meals</span>
        </a>
        <a href="register" class="category-card">
            <img src="https://images.unsplash.com/photo-1559496417-e7f25cb247f3?w=200&h=200&fit=crop&auto=format" class="category-img" alt="Coffee">
            <span class="category-name">Filter Coffee</span>
        </a>
    </div>
</div>

<!-- ══ PROMO BANNER ═════════════════════════════════════════════════ -->
<div style="max-width:1200px;margin:0 auto;">
    <div class="promo-banner fade-up delay-2">
        <div class="promo-text">
            <h3>Get up to 50% OFF</h3>
            <p>On your first 3 orders — valid for new users only</p>
        </div>
        <a href="register" class="promo-btn">Claim Offer &nbsp;<i class="fa-solid fa-arrow-right"></i></a>
    </div>
</div>

<!-- ══ TOP RESTAURANTS ══════════════════════════════════════════════ -->
<div class="section fade-up delay-2">
    <h2 class="section-title">Popular Restaurants Near You</h2>
    <p class="section-sub">Order from the best South Indian restaurants in your city</p>

    <div class="restaurants-grid">

        <!-- Vasantha Bhavan -->
        <a href="register" class="rest-card">
            <div class="rest-img-wrap">
                <img src="images/vasantha_bhavan.png" class="rest-img" alt="Vasantha Bhavan"
                     onerror="this.src='https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=500&auto=format&fit=crop'">
                <span class="rest-badge gold">⭐ TOP RATED</span>
                <span class="rest-time-badge">20-30 mins</span>
            </div>
            <div class="rest-info">
                <div class="rest-header">
                    <span class="rest-name">Vasantha Bhavan</span>
                    <span class="rest-rating">4.5 <i class="fa-solid fa-star" style="font-size:10px"></i></span>
                </div>
                <p class="rest-cuisine">South Indian Vegetarian</p>
                <div class="rest-footer">
                    <span class="rest-min">Min. <strong>₹80</strong></span>
                    <span class="rest-addr"><i class="fa-solid fa-location-dot" style="color:var(--red);margin-right:3px;font-size:11px"></i>Mylapore, Chennai</span>
                </div>
            </div>
        </a>

        <!-- Saravana Bhavan -->
        <a href="register" class="rest-card">
            <div class="rest-img-wrap">
                <img src="images/saravana_bhavan.png" class="rest-img" alt="Saravana Bhavan"
                     onerror="this.src='https://images.unsplash.com/photo-1630851840633-f96999247032?w=500&auto=format&fit=crop'">
                <span class="rest-badge" style="background:#7c3aed">🏆 LEGEND</span>
                <span class="rest-time-badge">25-35 mins</span>
            </div>
            <div class="rest-info">
                <div class="rest-header">
                    <span class="rest-name">Saravana Bhavan</span>
                    <span class="rest-rating">4.7 <i class="fa-solid fa-star" style="font-size:10px"></i></span>
                </div>
                <p class="rest-cuisine">South Indian Tiffin & Meals</p>
                <div class="rest-footer">
                    <span class="rest-min">Min. <strong>₹100</strong></span>
                    <span class="rest-addr"><i class="fa-solid fa-location-dot" style="color:var(--red);margin-right:3px;font-size:11px"></i>Anna Nagar, Chennai</span>
                </div>
            </div>
        </a>

        <!-- Murugan Idli Shop -->
        <a href="register" class="rest-card">
            <div class="rest-img-wrap">
                <img src="images/murugan_idli.png" class="rest-img" alt="Murugan Idli Shop"
                     onerror="this.src='https://images.unsplash.com/photo-1589301760014-d929f3979dbc?w=500&auto=format&fit=crop'">
                <span class="rest-badge">🔥 TRENDING</span>
                <span class="rest-time-badge">15-25 mins</span>
            </div>
            <div class="rest-info">
                <div class="rest-header">
                    <span class="rest-name">Murugan Idli Shop</span>
                    <span class="rest-rating">4.8 <i class="fa-solid fa-star" style="font-size:10px"></i></span>
                </div>
                <p class="rest-cuisine">Idli, Dosa, South Indian Breakfast</p>
                <div class="rest-footer">
                    <span class="rest-min">Min. <strong>₹60</strong></span>
                    <span class="rest-addr"><i class="fa-solid fa-location-dot" style="color:var(--red);margin-right:3px;font-size:11px"></i>KK Nagar, Madurai</span>
                </div>
            </div>
        </a>

        <!-- Anjappar Chettinad -->
        <a href="register" class="rest-card">
            <div class="rest-img-wrap">
                <img src="images/anjappar.png" class="rest-img" alt="Anjappar"
                     onerror="this.src='https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=500&auto=format&fit=crop'">
                <span class="rest-badge" style="background:#d97706">🌶 SPICY HOT</span>
                <span class="rest-time-badge">35-45 mins</span>
            </div>
            <div class="rest-info">
                <div class="rest-header">
                    <span class="rest-name">Anjappar Chettinad</span>
                    <span class="rest-rating">4.4 <i class="fa-solid fa-star" style="font-size:10px"></i></span>
                </div>
                <p class="rest-cuisine">Chettinad Non-Veg, South Indian</p>
                <div class="rest-footer">
                    <span class="rest-min">Min. <strong>₹150</strong></span>
                    <span class="rest-addr"><i class="fa-solid fa-location-dot" style="color:var(--red);margin-right:3px;font-size:11px"></i>RS Puram, Coimbatore</span>
                </div>
            </div>
        </a>

        <!-- Junior Kuppanna -->
        <a href="register" class="rest-card">
            <div class="rest-img-wrap">
                <img src="https://images.unsplash.com/photo-1567188040759-fb8a883dc6d8?w=500&auto=format&fit=crop" class="rest-img" alt="Junior Kuppanna">
                <span class="rest-badge gold">⭐ TOP RATED</span>
                <span class="rest-time-badge">30-40 mins</span>
            </div>
            <div class="rest-info">
                <div class="rest-header">
                    <span class="rest-name">Junior Kuppanna</span>
                    <span class="rest-rating">4.6 <i class="fa-solid fa-star" style="font-size:10px"></i></span>
                </div>
                <p class="rest-cuisine">Kongu Nadu Cuisine, Biryani</p>
                <div class="rest-footer">
                    <span class="rest-min">Min. <strong>₹120</strong></span>
                    <span class="rest-addr"><i class="fa-solid fa-location-dot" style="color:var(--red);margin-right:3px;font-size:11px"></i>Gandhipuram, Coimbatore</span>
                </div>
            </div>
        </a>

        <!-- Biryani House -->
        <a href="register" class="rest-card">
            <div class="rest-img-wrap">
                <img src="https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=500&auto=format&fit=crop" class="rest-img" alt="Biryani House">
                <span class="rest-badge">🔥 TRENDING</span>
                <span class="rest-time-badge">25-35 mins</span>
            </div>
            <div class="rest-info">
                <div class="rest-header">
                    <span class="rest-name">Biryani House</span>
                    <span class="rest-rating">4.6 <i class="fa-solid fa-star" style="font-size:10px"></i></span>
                </div>
                <p class="rest-cuisine">Biryani, Mughlai</p>
                <div class="rest-footer">
                    <span class="rest-min">Min. <strong>₹100</strong></span>
                    <span class="rest-addr"><i class="fa-solid fa-location-dot" style="color:var(--red);margin-right:3px;font-size:11px"></i>T. Nagar, Chennai</span>
                </div>
            </div>
        </a>

        <!-- Chennai Express -->
        <a href="register" class="rest-card">
            <div class="rest-img-wrap">
                <img src="https://images.unsplash.com/photo-1630851840633-f96999247032?w=500&auto=format&fit=crop" class="rest-img" alt="Chennai Express">
                <span class="rest-badge" style="background:#059669">🌿 NEW</span>
                <span class="rest-time-badge">20-30 mins</span>
            </div>
            <div class="rest-info">
                <div class="rest-header">
                    <span class="rest-name">Chennai Express</span>
                    <span class="rest-rating">4.2 <i class="fa-solid fa-star" style="font-size:10px"></i></span>
                </div>
                <p class="rest-cuisine">South Indian, Street Food</p>
                <div class="rest-footer">
                    <span class="rest-min">Min. <strong>₹70</strong></span>
                    <span class="rest-addr"><i class="fa-solid fa-location-dot" style="color:var(--red);margin-right:3px;font-size:11px"></i>Ashok Nagar, Chennai</span>
                </div>
            </div>
        </a>

        <!-- Spice Garden -->
        <a href="register" class="rest-card">
            <div class="rest-img-wrap">
                <img src="https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=500&auto=format&fit=crop" class="rest-img" alt="Spice Garden">
                <span class="rest-badge" style="background:#7c3aed">🏆 LEGENDARY</span>
                <span class="rest-time-badge">30-40 mins</span>
            </div>
            <div class="rest-info">
                <div class="rest-header">
                    <span class="rest-name">Spice Garden</span>
                    <span class="rest-rating">4.3 <i class="fa-solid fa-star" style="font-size:10px"></i></span>
                </div>
                <p class="rest-cuisine">North Indian, Chinese, Tandoor</p>
                <div class="rest-footer">
                    <span class="rest-min">Min. <strong>₹100</strong></span>
                    <span class="rest-addr"><i class="fa-solid fa-location-dot" style="color:var(--red);margin-right:3px;font-size:11px"></i>Pondy Bazaar, Chennai</span>
                </div>
            </div>
        </a>

    </div>
</div>

<!-- ══ WHY TASTYBITES ════════════════════════════════════════════════ -->
<div class="section fade-up delay-3">
    <h2 class="section-title">Why choose TastyBites?</h2>
    <p class="section-sub">We make food ordering simple, fast and delicious</p>
    <div class="features-grid">
        <div class="feature-card">
            <div class="feature-icon">⚡</div>
            <h3 class="feature-title">Lightning Fast Delivery</h3>
            <p class="feature-desc">Average delivery time of 30 minutes. Real-time tracking so you always know where your food is.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">🌶️</div>
            <h3 class="feature-title">Authentic South Indian</h3>
            <p class="feature-desc">From crispy dosas to rich Chettinad curries — we bring the authentic taste of Tamil Nadu to your door.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">🔒</div>
            <h3 class="feature-title">Safe & Secure Payments</h3>
            <p class="feature-desc">Pay via UPI, Credit/Debit Card or Cash on Delivery. 100% secure transactions every time.</p>
        </div>
    </div>
</div>

<!-- ══ CTA SECTION ═══════════════════════════════════════════════════ -->
<div style="max-width:1200px;margin:0 auto 40px;">
    <div class="cta-section fade-up delay-4">
        <div class="cta-text">
            <h2>Hungry? Let's get<br>you sorted 🍛</h2>
            <p>Join thousands of food lovers in Chennai, Coimbatore and Madurai.<br>Create your account and order in minutes.</p>
            <div class="cta-buttons">
                <a href="register" class="cta-btn-primary">Create Free Account</a>
                <a href="login" class="cta-btn-outline">Sign In</a>
            </div>
        </div>
        <div class="cta-icons">🍔 🍛 🥘</div>
    </div>
</div>

<!-- ══ FOOTER ════════════════════════════════════════════════════════ -->
<footer>
    <div class="footer-inner">
        <div class="footer-top">
            <div>
                <div class="footer-logo">🍔 TastyBites</div>
                <p class="footer-desc">India's favourite online food ordering platform. Connecting hungry people with great restaurants across Tamil Nadu and beyond.</p>
                <div class="social-links" style="margin-top:20px">
                    <a href="#"><i class="fa-brands fa-instagram"></i></a>
                    <a href="#"><i class="fa-brands fa-twitter"></i></a>
                    <a href="#"><i class="fa-brands fa-facebook"></i></a>
                    <a href="#"><i class="fa-brands fa-youtube"></i></a>
                </div>
            </div>
            <div class="footer-col">
                <h4>Company</h4>
                <a href="#">About Us</a>
                <a href="#">Team</a>
                <a href="#">Careers</a>
                <a href="#">Blog</a>
                <a href="#">Contact</a>
            </div>
            <div class="footer-col">
                <h4>For Restaurants</h4>
                <a href="register">Partner with Us</a>
                <a href="#">Apps for You</a>
                <a href="#">Business</a>
                <a href="#">Advertise</a>
            </div>
            <div class="footer-col">
                <h4>Learn More</h4>
                <a href="#">Privacy</a>
                <a href="#">Security</a>
                <a href="#">Terms</a>
                <a href="#">Sitemap</a>
            </div>
        </div>
        <div class="footer-bottom">
            <span>© 2026 TastyBites Technologies Pvt. Ltd. All rights reserved.</span>
            <span>🇮🇳 India &nbsp;|&nbsp; English</span>
        </div>
    </div>
</footer>

<script>
    // Intersection Observer for scroll animations
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(e => { if (e.isIntersecting) e.target.style.animationPlayState = 'running'; });
    }, { threshold: 0.1 });
    document.querySelectorAll('.fade-up').forEach(el => {
        el.style.animationPlayState = 'paused';
        observer.observe(el);
    });

    // Search redirect
    document.querySelector('.hero-search input').addEventListener('keydown', (e) => {
        if (e.key === 'Enter') location.href = 'register';
    });
    document.querySelector('.search-bar input').addEventListener('keydown', (e) => {
        if (e.key === 'Enter') location.href = 'register';
    });
</script>

</body>
</html>
