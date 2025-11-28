@php
    $width = 1011; // CR80 ~300DPI width
    $height = 638; // CR80 ~300DPI height
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
    .card-html { position: relative; width: {{ $width }}px; height: {{ $height }}px; background:#fff; border: 4px solid #b0438e; box-shadow: 0 2px 8px rgba(0,0,0,0.15); font-family: Arial, Helvetica, sans-serif; }
    .header { position:absolute; left:48px; right:48px; top:24px; height:110px; display:flex; align-items:center; }
    .header .logo { height:74px; width:auto; }
    .header .title { flex:1; text-align:center; line-height:1.15; }
    .title .line1 { font-size:22px; font-weight:bold; }
    .title .line2 { font-size:30px; font-weight:bold; letter-spacing:1px; }
    .title .line3 { font-size:18px; }
    .title .line4 { font-size:22px; font-weight:bold; }

    .photo-box { position:absolute; left:120px; top:150px; width:270px; height:325px; background:#f7f7f7; border:2px solid #777; box-shadow: 6px 6px 0 #c9c9c9; display:flex; align-items:center; justify-content:center; }
    .photo-box img { width:100%; height:100%; object-fit:cover; }

    .label { font-size:16px; color:#333; position:absolute; }
    .bar { position:absolute; background:#ffc2d9; border:1px solid #c45f99; border-radius:6px; height:46px; display:flex; align-items:center; padding:0 12px; }
    .bar .value { font-size:22px; font-weight:bold; color:#000; letter-spacing:0.3px; }
    .bar.small { height:40px; }
    .bar.small .value { font-size:18px; }

    .address-label { left:120px; top:490px; }
    .address-bar { left:120px; top:514px; width:770px; }

    .pink-ribbon { position:absolute; right:0; bottom:0; width:520px; height:300px; background: linear-gradient(135deg, #ff7ab6 0%, #e31575 70%); clip-path: polygon(100% 0, 100% 100%, 0 100%); }
    .footer-note { position:absolute; left:120px; bottom:110px; font-size:16px; color:#000; }

    /* Field positions */
    .control-label { left:560px; top:128px; }
    .control-bar   { left:560px; top:152px; width:420px; }
    .name-label    { left:560px; top:205px; }
    .name-bar      { left:560px; top:229px; width:420px; }
    .dob-label     { left:560px; top:282px; }
    .dob-bar       { left:560px; top:306px; width:270px; }
    .gender-label  { left:560px; top:350px; }
    .gender-bar    { left:560px; top:374px; width:170px; }
    .issue-label   { left:745px; top:350px; }
    .issue-bar     { left:745px; top:374px; width:235px; }

    /* Back side */
    .benefits-box { position:absolute; left:80px; right:80px; top:70px; bottom:220px; background:#fff; border:4px solid #b0438e; border-radius:12px; padding:22px 26px; }
    .benefits-title { text-align:center; font-size:26px; font-weight:bold; margin-bottom:12px; }
    .benefits-list { font-size:20px; line-height:1.35; }
    .sign-line { position:absolute; left:120px; right:120px; bottom:170px; height:2px; background:#000; }
    .sign-text { position:absolute; left:120px; right:120px; bottom:140px; text-align:center; font-size:18px; }
    .officers { position:absolute; left:100px; right:100px; bottom:70px; display:flex; justify-content:space-between; font-size:24px; font-weight:bold; }
    .officers span small { display:block; font-weight:normal; font-size:18px; }
    .back .pink-ribbon { height:280px; }
</style>

<div class="card-html {{ $isFront ? 'front' : 'back' }}">
    @if($isFront)
        <div class="header">
            <img src="{{ asset('images/OSCA.png') }}" class="logo" alt="">
            <div class="title">
                <div class="line1">Republic of the Philippines</div>
                <div class="line2">MUNICIPALITY OF LINGAYEN</div>
                <div class="line3">Province of Pangasinan</div>
                <div class="line4">Office of the Senior Citizens Affairs</div>
            </div>
            <img src="{{ asset('images/DSWD_LOGO.png') }}" class="logo" alt="">
        </div>

        <div class="photo-box">
            <img src="{{ $photoUrl }}" alt="">
        </div>

        <div class="label control-label">Control No.:</div>
        <div class="bar control-bar"><span class="value">{{ $controlNo }}</span></div>

        <div class="label name-label">Name</div>
        <div class="bar name-bar"><span class="value">{{ strtoupper($fullName) }}</span></div>

        <div class="label dob-label">Date of Birth</div>
        <div class="bar dob-bar small"><span class="value">{{ $dob }}</span></div>

        <div class="label gender-label">Gender</div>
        <div class="bar gender-bar small"><span class="value">{{ strtoupper($gender) }}</span></div>

        <div class="label issue-label">Date of Issue</div>
        <div class="bar issue-bar small"><span class="value">{{ $issueDate }}</span></div>

        <div class="label address-label">Address</div>
        <div class="bar address-bar"><span class="value">{{ strtoupper($address) }}</span></div>

        <div class="footer-note">This Card is Non-Transferable and Valid Anywhere in the Country</div>
        <div class="pink-ribbon"></div>
    @else
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
            <span>HON. JOSEFINA “IDAY” V. CASTAÑEDA<small>Municipal Mayor</small></span>
        </div>
        <div class="pink-ribbon"></div>
    @endif
</div>

@if(!($preview ?? false))
    <!-- Embedded within wrapper -->
@else
    <style> body{ margin:0; height:100vh; display:flex; align-items:center; justify-content:center; background:#eee;} .card-html{transform: translateZ(0);} </style>
@endif
