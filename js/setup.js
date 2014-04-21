(function() {
mathmlStart();
document.querySelector('#btn-add').addEventListener ('click', function () {
  document.querySelector('#add').removeAttribute('style');
  document.querySelector('#help').setAttribute('style', 'display:none;');
  document.querySelector('#main').setAttribute('style', 'display:none;');
});
document.querySelector('#btn-add-close').addEventListener ('click', function () {
  document.querySelector('#add').setAttribute('style', 'display:none;');
  document.querySelector('#help').setAttribute('style', 'display:none;');
  document.querySelector('#main').removeAttribute('style');
});
document.querySelector('#btn-add-done').addEventListener ('click', function () {
  document.querySelector('#add').setAttribute('style', 'display:none;');
  document.querySelector('#help').setAttribute('style', 'display:none;');
  document.querySelector('#main').removeAttribute('style');
  add_equation();
});
document.querySelector('#btn-help').addEventListener ('click', function () {
  document.querySelector('#add').setAttribute('style', 'display:none;');
  document.querySelector('#help').removeAttribute('style');
  document.querySelector('#main').setAttribute('style', 'display:none;');
});
document.querySelector('#btn-help-back').addEventListener ('click', function () {
  document.querySelector('#add').setAttribute('style', 'display:none;');
  document.querySelector('#help').setAttribute('style', 'display:none;');
  document.querySelector('#main').removeAttribute('style');
});
var textarea = document.getElementById("tex-input");
textarea.addEventListener('keyup', preview_equation, false);
var notebook = document.getElementById('tex-preview');
var new_preview = document.createElement('math');
new_preview.setAttribute('id', 'preview');
notebook.appendChild(new_preview);
})();
