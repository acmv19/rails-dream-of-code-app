document.addEventListener("DOMContentLoaded", () => {
  const headers = document.querySelectorAll(".trimester-header");

  headers.forEach((header) => {
    header.addEventListener("click", () => {
      const coursesList = header.nextElementSibling.nextElementSibling;
      if (coursesList && coursesList.classList.contains("courses-list")) {
        coursesList.style.display =
          coursesList.style.display === "none" ? "block" : "none";
      }
    });
  });
});
