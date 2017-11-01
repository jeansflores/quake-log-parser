// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree

$('.modal-reports').on('shown.bs.modal', function () {
  $('#myInput').trigger('focus')
});

$(document).ready(function(){

  $(function(){
    labelLog.val("");
  });

  var formLog = $(".form-log");
  var labelLog = $(".label-log");
  var submitLog = $(".submit-log");
  var selectLog = $(".select-log");

  selectLog.on('click',function(){
    labelLog.click();
  });

  labelLog.change(function(){
    submitLog.click();
  });

  console.log(labelLog);
});
