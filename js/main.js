$(document).ready(mobileMenuWatcher)

function toggleMenu(element){
  if(element == "#tags-dropdown"){
    $('#category-dropdown').hide();
  }else{
    $('#tags-dropdown').hide();
  }
  $(element).toggle();
}

function mobileMenuWatcher() {
  $('.more_phone_select_menu').change(function() {
    window.location.href = $(this).val();
  });
}