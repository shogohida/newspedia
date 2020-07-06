const initLikeBtn = () => {
  const likeBtn = document.querySelector("#like_button")
  if (likeBtn) {
    likeBtn.addEventListener("click", () => {
      // const loadingCtn = document.querySelector(".loading-container")
      // if (loadingCtn) loadingCtn.classList.add("loading")
      // likeBtn.remove()
      // likeBtn.toggle()
      // likeBtn.innerHTML = "<%=j render 'likes/like', article: @article %>";
      // document.querySelector("#likes_number_<%= @article %>").innerHTML = "The number of likes: <%= @article.likes.count %>"
    })
  }
}

export { initLikeBtn }
