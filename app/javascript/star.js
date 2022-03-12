function star (){
  const starCheck  = document.getElementById("star-check");
  starCheck.addEventListener('click', function() {
    if (starCheck.getAttribute("style") == "color:#ff0000;") {
      starCheck.removeAttribute("style", "color:#ff0000;")
    } else {
      starCheck.setAttribute("style", "color:#ff0000;")
    }
  })
};

window.addEventListener('load', star);