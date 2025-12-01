@php
    $width = 1011;
    $height = 638;
    $isFront = ($side ?? 'front') === 'front';
    $address = trim(implode(', ', array_filter([
        $senior->street ?? null,
        $senior->residence ?? null,
        $senior->barangay ?? null,
        $senior->city ?? null,
        $senior->province ?? null
    ])));
    $issueDate = optional($senior->created_at)->format('F d, Y');
    $dob = $senior->date_of_birth ? \Carbon\Carbon::parse($senior->date_of_birth)->format('F d, Y') : '';
    $gender = $senior->sex ?? '';
    $controlNo = $senior->osca_id ?? '';
    $fullName = trim($senior->first_name . ' ' . ($senior->middle_name ? $senior->middle_name . ' ' : '') . $senior->last_name);
    $photoUrl = $photoUrl ?? asset('images/default-profile.png');
@endphp

<style>
    .card-html {
        position: relative;
        width: {{ $width }}px;
        height: {{ $height }}px;
        background: #fff;
        border: 4px solid #b0438e;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
        font-family: Arial, Helvetica, sans-serif;
    }
    .header {
        position: absolute;
        left: 36px;
        right: 36px;
        top: 18px;
        height: 110px;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 48px;
        z-index: 1;
    }
    .header .logo {
        height: 90px;
        width: auto;
    }
    .header .title {
        text-align: center;
        line-height: 1.25;
    }
    .title .line1 {
        font-size: 16px;
        font-weight: 500;
    }
    .title .line2 {
        font-size: 20px;
        font-weight: 800;
        letter-spacing: 1px;
    }
    .title .line3 {
        font-size: 16px;
        font-weight: 500;
    }
    .title .line4 {
        font-size: 16px;
        font-weight: 500;
    }

    .photo-box {
        position: absolute;
        left: 30px;
        top: 150px;
        width: 300px;
        height: 300px;
        background: #f7f7f7;
        border: 3px solid #333;
        box-shadow: 6px 6px 0 #c9c9c9;
        display: flex;
        align-items: center;
        justify-content: center;
        z-index: 1;
    }
    .photo-box img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .label {
        font-size: 18px;
        color: #333;
        position: absolute;
        font-weight: 700;
        z-index: 1;
    }
    .bar {
        position: absolute;
        background: #ffddfb;
        border: 3px solid #cf6aa1;
        border-radius: 6px;
        height: 46px;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 0 12px;
        z-index: 1;
    }
    .bar .value {
        font-size: 20px;
        font-weight: 400;
        color: #000;
        letter-spacing: 0.3px;
        display: block;
        width: 100%;
        text-align: center;
    }
    .uppercase {
        text-transform: uppercase;
    }
    .bar.small {
        height: 42px;
    }
    .bar.small .value {
        font-size: 19px;
    }

    .address-label {
        left: 60px;
        top: 564px;
        width: 890px;
        text-align: center;
    }
    .address-bar {
        left: 60px;
        top: 506px;
        width: 890px;
    }

    .pink-ribbon {
        position: absolute;
        right: 0;
        bottom: 0;
        width: 540px;
        height: 240px;
        background: #f400d7ff;
        clip-path: polygon(100% 40%, 100% 100%, 0 100%);
        z-index: 0;
    }
    .pink-ribbon-light {
        position: absolute;
        right: 0;
        bottom: 0;
        width: 100%;
        height: 260px;
        background: #ffe3f5;
        clip-path: polygon(100% 35%, 100% 75%, 0 100%, 0 60%);
        z-index: 0;
    }
    .footer-note {
        position: absolute;
        left: 24px;
        bottom: 16px;
        font-size: 16px;
        font-weight: 600;
        color: #000;
        z-index: 1;
    }

    .control-label {
        left: 500px;
        top: 160px;
        width: 120px;
        text-align: right;
    }
    .control-bar {
        left: 640px;
        top: 140px;
        width: 320px;
    }
    .name-label {
        left: 370px;
        top: 270px;
        width: 600px;
        text-align: center;
    }
    .name-bar {
        left: 360px;
        top: 214px;
        width: 600px;
    }
    .dob-label {
        left: 370px;
        top: 365px;
        width: 600px;
        text-align: center;
    }
    .dob-bar {
        left: 360px;
        top: 309px;
        width: 600px;
    }
    .gender-label {
        padding-top: 10px;
        left: 375px;
        top: 444px;
        width: 200px;
        text-align: center;
    }
    .gender-bar {
        left: 360px;
        top: 400px;
        width: 200px;
    }
    .issue-label {
        right: 40px;
        top: 454px;
        width: 200px;
        text-align: center;
    }
    .issue-bar {
        right: 30px;
        top: 400px;
        width: 200px;
    }

    .benefits-box {
        position: absolute;
        left: 80px;
        right: 80px;
        top: 70px;
        bottom: 210px;
        background: #fff;
        border: 3px solid #cf6aa1;
        border-radius: 8px;
        padding: 18px 22px;
        z-index: 1;
    }
    .benefits-title {
        text-align: center;
        font-size: 22px;
        font-weight: 700;
        letter-spacing: 0.2px;
        margin-bottom: 10px;
    }
    .benefits-list {
        font-size: 18px;
        line-height: 1.4;
    }
    .sign-line {
        position: absolute;
        left: 120px;
        right: 120px;
        bottom: 130px;
        height: 2px;
        background: #000;
        z-index: 1;
    }
    .sign-text {
        position: absolute;
        left: 120px;
        right: 120px;
        bottom: 104px;
        text-align: center;
        font-size: 16px;
        z-index: 1;
    }
    .officers {
        position: absolute;
        left: 80px;
        right: 80px;
        bottom: 40px;
        display: flex;
        justify-content: space-between;
        font-size: 20px;
        font-weight: 800;
        text-transform: uppercase;
        text-decoration: underline;
        z-index: 1;
    }
    .officers span small {
        display: block;
        font-weight: 500;
        font-size: 14px;
        text-transform: none;
        text-decoration: none;
        margin-top: 4px;
        text-align: center;
    }
    .back .pink-ribbon {
        height: 320px;
        clip-path: polygon(100% 55%, 100% 100%, 0 100%);
    }
</style>

<div class="card-html {{ $isFront ? 'front' : 'back' }}">
    @if($isFront)
        <div class="header">
            <img src="{{ asset('images/LingayenSeal.png') }}" class="logo" alt="">
            <div class="title">
                <div class="line1">Republic of the Philippines</div>
                <div class="line2">MUNICIPALITY OF LINGAYEN</div>
                <div class="line3">Province of Pangasinan</div>
                <div class="line4">Office of the Senior Citizens Affairs</div>
            </div>
            <img src="{{ asset('images/DSWD.png') }}" class="logo" alt="">
        </div>

        <div class="photo-box">
            <img src="{{ $photoUrl }}" alt="">
        </div>
         <div class="pink-ribbon"></div>
        <div class="label control-label">Control No.:</div>
        <div class="bar control-bar"><span class="value">{{ $controlNo }}</span></div>

        <div class="label name-label">Name</div>
        <div class="bar name-bar"><span class="value uppercase">{{ $fullName }}</span></div>

        <div class="label dob-label">Date of Birth</div>
        <div class="bar dob-bar small"><span class="value">{{ $dob }}</span></div>

        <div class="label gender-label">Gender</div>
        <div class="bar gender-bar small"><span class="value uppercase">{{ $gender }}</span></div>

        <div class="label issue-label">Date of Issue</div>
        <div class="bar issue-bar small"><span class="value">{{ $issueDate }}</span></div>

        <div class="label address-label">Address</div>
        <div class="bar address-bar"><span class="value uppercase">{{ $address }}</span></div>

        <div class="footer-note">This Card is Non-Transferable and Valid Anywhere in the Country</div>
       
    @else
        <div class="pink-ribbon-light"></div>
        <div class="pink-ribbon"></div>
        <div class="benefits-box">
            <div class="benefits-title">BENEFITS AND PRIVILEGES UNDER Republic Act No. 9994</div>
            <div class="benefits-list">
                <div>* Free Medical and Dental, Diagnostic & Laboratory services in all government facilities.</div>
                <div>* 20% discount in purchase of medicines.</div>
                <div>* 20% discount on hotels, restaurants, recreation centers, etc.</div>
                <div>* 20% discount on theaters, cinema houses and concert halls, etc.</div>
                <div>* 20% discount in medical and dental services, diagnostics and laboratory fees in private facilities.</div>
                <div>* 20% discount in fare for domestic or sea travel and public land transportation.</div>
                <div>* 20% discount on funeral services.</div>
                <div style="margin-top:8px;">Only for the exclusive use of Senior Citizen, abuse of privileges is punishable by law.</div>
                <div>Persons and Corporations violating R.A. 9994 shall be penalized.</div>
            </div>
        </div>
        <div class="sign-line"></div>
        <div class="sign-text">Printed Name and Signature/Thumbmark</div>
        <div class="officers">
            <span>LUCIANO O. RAMOS<small>OSCA Head</small></span>
            <span>HON. JOSEFINA 'IDAY' V. CASTAÑEDA<small>Municipal Mayor</small></span>
        </div>

    @endif
</div>

@if(!($preview ?? false))
@else
    <style>
        body {
            margin: 0;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #eee;
        }
        .card-html {
            transform: translateZ(0);
        }
    </style>
@endif
