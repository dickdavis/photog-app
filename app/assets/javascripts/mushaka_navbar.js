function activateMenu () {
  let toggle = document.getElementById('js-navbar-toggle')
  let menu = document.getElementsByClassName('MushakaNavbar__navbar-menu')[0]

  toggle.addEventListener('click', toggleMenu)

  function toggleMenu (e) {
    e.preventDefault()
    menu.classList.toggle('MushakaNavbar__navbar-menu_opened')
  }
}
