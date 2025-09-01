document.addEventListener('DOMContentLoaded', function () {
  var toggle = document.querySelector('.toggle-sidebar');
  var sidebar = document.querySelector('.sidebar');
  if (!toggle || !sidebar) return;
  toggle.addEventListener('click', function () {
    if (window.innerWidth <= 768) {
      sidebar.classList.toggle('open');
    } else {
      sidebar.classList.toggle('collapsed');
    }
  });
});
