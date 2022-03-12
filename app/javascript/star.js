function star (){
  const starCheck  = document.getElementById("star-check");
  starCheck.addEventListener('click', function() {
    if (starCheck.getAttribute("style") == "background-color:blue;") {
      starCheck.removeAttribute("style", "background-color:blue;")
    } else {
      starCheck.setAttribute("style", "background-color:blue;")
    }
  })
};

window.addEventListener('load', star);