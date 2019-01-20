// add placeholder to newsletter widget.
$("#txtNewsletterEmail").attr("placeholder", "youremail@example.com");

//
$('[data-toggle="tooltip"]').tooltip();


$(".blog-nav ul").each(function () {
    var $this = $(this);
    if ($this.find("li").length) {
        $this.parent().addClass("has-ul").append('<i class="fa fa-chevron-down nav-item-toggle"></i>');
    }
});

//
$(".blog-nav-toggle").on("click", function () {
    $(this).toggleClass("is-active");
    $(".blog-nav").slideToggle();
});


//
$(".nav-item-toggle").on("click", function () {
    $(this).toggleClass("is-active");
    $(this).parent().find("ul").toggleClass("is-active");
});

$(function () {
    // social networks
    var socialNetwork = $(".blog-social li a");
    for (i = 0; i < socialNetwork.length; ++i) {
        link = socialNetwork[i];

        if ($(link).attr("href") != "") {
            $(link).parent().css("display", "block");
        }
    }
});

// back up
$("#back-up").on('click', function (e) {
    e.preventDefault();
    $('html,body').animate({
        scrollTop: 0
    }, 700);
});


// slideshow
$("#widgetzone_slider .postlist ul").addClass("owl-carousel");

$('.owl-carousel').owlCarousel({
    items: 1,
    loop: true,
    nav: false,
    dots: false,
    responsiveClass: true,
    navSpeed: 700,
    autoplay: true,
    autoplayTimeout: 7000,
    autoplaySpeed: 700,

    responsive: {
        0: {
        },
        960: {
            stagePadding: 100,
            nav: true

        },
        1367: {
            stagePadding: 200,
            nav: true
        },
        1600: {
            stagePadding: 350,
            nav: true
        }
    },
    navText: ['<i class="fa fa-angle-left"></i>', '<i class="fa fa-angle-right"></i>']
});
$("#widgetzone_slider .postlist ul").show();


//
var simpleCap = $("label[for=simpleCaptchaValue]").parent();
simpleCap.hide();
$("#commentCaptcha").append(simpleCap.html());