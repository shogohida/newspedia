const initLikeBtn = () => {
  const likeBtn = document.querySelector("#like_button")
  if (likeBtn) {
    likeBtn.addEventListener("click", () => {
      const loadingCtn = document.querySelector(".loading-container")
      if (loadingCtn) loadingCtn.classList.add("loading")
      likeBtn.remove()
    })
  }
}


export { initLikeBtn }
