const bookmark = () => {
  function classToggle () {
    this.classList.toggle('fas');
    this.classList.toggle('far');
  }

  document.querySelectorAll(".fa-bookmark").forEach((element) => {
    element.addEventListener("click", classToggle);
  });
}

export { bookmark };
