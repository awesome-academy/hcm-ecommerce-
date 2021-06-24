$(document).ready(function () {
  const success = document.getElementById("content-toast-success");
  let message = "";
  let type = "success"
  let title = ""
  if (success) {
    message = success.textContent;
    title = document.getElementById("title-toast-success").textContent;
  } else {
    const fail = document.getElementById("content-toast-fail");
    if (fail) {
      message = fail.textContent;
      type = "error"
      title = document.getElementById("title-toast-fail").textContent;
    }
  }
  if (message) {
    showToast(title, message, type)
  }

  function toast({ title = "", message = "", type = "success", duration = 3000 }) {
    var main = document.getElementById("custom-toast");
    if (main) {
      var toast = document.createElement("div");

      toast.classList.add("custom-toast", `toast--${type}`);
      var toastId = setTimeout(() => {
        main.removeChild(toast);
      }, duration + 1000);
      toast.onclick = function (e) {
        if (e.target.closest(".toast__close")) {
          main.removeChild(toast);
          clearTimeout(toastId);
        }
      };
      var delay = (duration / 1000).toFixed(2);
      toast.style.animation = `slideLeftIn ease 0.3s, fadeOut linear 1s ${delay}s forwards`
      toast.innerHTML = `
  <div class="toast__icon">
    <i class="far fa-check-circle"></i>
  </div>
  <div class="toast__body">
    <h3 class="toast__title">
      ${title}
    </h3>
    <p class="toast__msg">
      ${message}
    </p>
  </div>
  <div class="toast__close">
    <i class="fas fa-times"></i>
  </div>
  `;
      main.appendChild(toast);
    }
  }

  function showToast(title, message, type) {
    toast({
      title,
      message,
      type,
      duration: 2000,
    });
  }
})
