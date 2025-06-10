function initDarkMode(){
  if(!document.getElementById('dark-mode-style')){
    const link=document.createElement('link');
    link.rel='stylesheet';
    link.href='./assets/css/dark-mode.css';
    link.id='dark-mode-style';
    document.head.appendChild(link);
  }
  const navList=document.querySelector('.navbar .navbar-nav');
  const navContainer=document.querySelector('.navbar .container');
  if(!document.getElementById('darkModeToggle')){
    if(navList){
      const li=document.createElement('li');
      li.className='nav-item d-flex align-items-center';
      li.innerHTML='<div class="form-check form-switch mb-0">'+
                   '<input class="form-check-input" type="checkbox" id="darkModeToggle">'+
                   '</div>';
      navList.appendChild(li);
    } else if(navContainer){
      const div=document.createElement('div');
      div.className='d-flex align-items-center ml-auto';
      div.style.marginLeft='auto';
      div.innerHTML='<div class="form-check form-switch mb-0">'+
                    '<input class="form-check-input" type="checkbox" id="darkModeToggle">'+
                    '</div>';
      navContainer.appendChild(div);
    }
  }
  const toggle=document.getElementById('darkModeToggle');
  if(!toggle) return;
  function apply(d){
    if(d){document.body.classList.add('dark-mode');toggle.checked=true;}
    else{document.body.classList.remove('dark-mode');toggle.checked=false;}
  }
  toggle.addEventListener('change',function(){
    const en=toggle.checked;
    localStorage.setItem('darkMode',en?'on':'off');
    apply(en);
  });
  const saved=localStorage.getItem('darkMode');
  apply(saved==='on');
}
if(document.readyState==='loading'){
  document.addEventListener('DOMContentLoaded',initDarkMode);
}else{
  initDarkMode();
}
