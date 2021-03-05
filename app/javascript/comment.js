function click() {
  const comment = document.getElementById("comment");
  if (comment.getAttribute("data-load") != null) {
    return null;
  }
  comment.setAttribute("data-load", "true");
  comment.addEventListener("click", () => {
    $(".tweet-mains").toggle();
  })
};
setInterval(click, 1000);