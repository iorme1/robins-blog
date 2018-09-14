// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require Chart.bundle
//= require chartkick
//= require jquery3
//= require ahoy
//= require popper
//= require bootstrap-sprockets
//= require turbolinks
//= require ckeditor/init
//= require_tree .

$(document).ready(function () {
  if (document.getElementsByClassName('speech-bubble-container')[0]) {
    setTimeout(function() {
        $('.speech-bubble-container').css("-ms-transform", "translateX(-150%)")
        $('.speech-bubble-container').css("-webkit-transform", "translateX(-150%)")
        $('.speech-bubble-container').css("-moz-transform", "translateX(-150%)")
        $('.speech-bubble-container').css("-o-transform", "translateX(-150%)")
        $('.speech-bubble-container').css("transform", "translateX(-150%)")
    }, 500);
  }
});
