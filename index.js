$(window).scroll(function () {
    console.log('hello world');
    $('#primary-nav').toggleClass('scrolled', $(this).scrollTop() > 50);

});