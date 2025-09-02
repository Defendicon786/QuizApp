function initSidebar() {
  var toggles = document.querySelectorAll('.toggle-sidebar');
  var sidebar = document.querySelector('.sidebar');
  if (!toggles.length || !sidebar) return;

  toggles.forEach(function (toggle) {
    toggle.addEventListener('click', function (e) {
      e.preventDefault();
      sidebar.classList.toggle('open');
      sidebar.classList.toggle('collapsed');
    });
  });
}

if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', initSidebar);
} else {
  initSidebar();
}
