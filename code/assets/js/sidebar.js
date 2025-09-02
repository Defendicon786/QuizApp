(function () {
  var toggles = document.querySelectorAll('.toggle-sidebar');
  var sidebar = document.querySelector('.sidebar');
  if (!toggles.length || !sidebar) return;

  toggles.forEach(function (toggle) {
    toggle.addEventListener('click', function () {
      if (window.innerWidth <= 768) {
        sidebar.classList.toggle('open');
      } else {
        sidebar.classList.toggle('collapsed');
      }
    });
  });
})();
