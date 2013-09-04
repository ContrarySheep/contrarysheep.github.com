function toggleMenu(element){
  if(element == "#tags-dropdown"){
    $('#category-dropdown').hide();
  }else{
    $('#tags-dropdown').hide();
  }
  $(element).toggle();
}