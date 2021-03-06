// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery-ui
//= require jquery.sliderAccess
//= require timepicker
//= require jquery_ujs
//= require jquery.tokeninput
//= require democracy
//= require fullcalendar
//= require gcal
//= require events
//= require charCount
//= require jquery.progressbar
//= require jquery.dataTables.min
//= require jquery.dataTables.columnFilter
//= require rails.validations
//= require jquery.quick-wizard
//= require jquery.elastic
//= require jquery.gbutton
//= require jqlplot/jquery.jqplot
//= require jqlplot/jqplot.pieRenderer
//= require jqlplot/jqplot.dateAxisRenderer
//= require jqlplot/jqplot.cursor
//= require jqlplot/jqplot.highlighter
//= require jquery.livequery
//= require proposals
//= require jquery.qtip
//= require feedback
//= require private_pub
//= require toastr
//= require countdown/index
//= require jquery.tagcloud
//= require jquery.switchbutton
//= require intro.js
//= require select2
//= require ckeditor/init
//= require underscore
//= require jquery.textntags
//= require paypal-button.min
//= require foundation
//= require foundation-datetimepicker
//= require foundation-patch
//= require list
//= require diff_match_patch
//= require jquery.appear
//= require init
//= require rails.validations
//= require rails.validations.simple_form
ClientSideValidations.selectors.validate_inputs += ', .select2-container:visible :input:enabled[data-validate]';
$(function(){ $(document).foundation(); });
