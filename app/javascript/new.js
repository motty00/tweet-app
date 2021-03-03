window.addEventListener('load', () => {
  const newSubmit = document.getElementById("new");
  const newSend = document.getElementById("new-submit");


  newSubmit.addEventListener("input", () => {
    newSend.setAttribute("style", "background-color: skyblue")
  })
});
