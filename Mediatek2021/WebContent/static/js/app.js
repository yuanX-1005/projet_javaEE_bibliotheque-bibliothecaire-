/**
 * 
 */
  //ouverture de l'option 1
  function options1() {
    document.getElementById("form_option1").style.display = "block";
    document.getElementById("form_option2").style.display = "none";
    document.getElementById("form_option3").style.display = "none";
  }
  
  function options2() {
    document.getElementById("form_option2").style.display = "block";
    document.getElementById("form_option1").style.display = "none";
    document.getElementById("form_option3").style.display = "none";
  }

  function options3() {
    document.getElementById("form_option3").style.display = "block";
    document.getElementById("form_option1").style.display = "none";
    document.getElementById("form_option2").style.display = "none";
  }