function dropdownFnc() {
  // Toggle dropdown content onclick
  document.getElementById("myDropdown").classList.toggle("show");
}

// Close dropdown onclick outside of dropdown content
window.onclick = function(event) {
  if(!event.target.matches('button')){
    var dropdowns = document.getElementsByClassName("dropdown-content");
    var i;
    for (i = 0; i < dropdowns.length; i++){
      var openDropdown = dropdowns[i];
      if(openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
}
