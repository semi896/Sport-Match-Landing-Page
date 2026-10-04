'use strict';

const ICONOS = { futbol: 'ic_ball.png', basquet: 'ic_basket.png', tenis: 'ic_tennis.png', voley: 'ic_volley.png', running: 'ic_run.png' };
const COLORES = { futbol: '#dce9ff', basquet: '#ffe5d0', tenis: '#e6f4d7', voley: '#fff3cd', running: '#d6ede0' };
const DEPORTES = ['futbol', 'basquet', 'tenis', 'voley', 'running'];
const MAX_INICIAL = 6; 

let idioma = localStorage.getItem('idioma') || 'es';
let verTodas = false;
let dialogoActual = null;

const $ = (selector) => document.querySelector(selector);
const $$ = (selector) => document.querySelectorAll(selector);

function t(clave) {
  return (TEXTS[idioma] && TEXTS[idioma][clave]) || TEXTS.es[clave] || clave;
}

function normalizar(texto) {
  return texto.toLowerCase().normalize('NFD').replace(/[\u0300-\u036f]/g, '');
}

function franja(hora) {
  const h = parseInt(hora.split(':')[0], 10);
  if (h < 12) return 'manana';
  if (h < 18) return 'tarde';
  return 'noche';
}

function crearTarjeta(a, confirmada) {
  const llena = a.estado === 'llenos';
  let claseTag = 'tag--success';
  let textoTag = t('st_disponible');
  if (confirmada) {
    textoTag = t('st_confirmado');
  } else if (llena) {
    claseTag = 'tag--danger';
    textoTag = t('st_llenos');
  } else if (a.estado === 'espera') {
    claseTag = 'tag--warning';
    textoTag = t('st_espera');
  }

  let boton;
  if (confirmada) {
    boton = `<button class="btn btn--block" type="button" data-dialog="request">${t('btn_view_detail')}</button>`;
  } else if (llena) {
    boton = `<button class="btn btn--block" type="button" data-dialog="request">${t('btn_detail')}</button>`;
  } else {
    boton = `<button class="btn btn--primary btn--block" type="button" data-dialog="request">${t('btn_request')}</button>`;
  }

  const cuando = `${t('day_' + a.dia)} ${a.num}, ${a.hora}`;
  return `
    <article class="card activity">
      <div class="activity__top" style="background:${COLORES[a.deporte]}">
        <span class="tag ${claseTag}">${textoTag}</span>
        <img src="assets/img/${ICONOS[a.deporte]}" alt="" width="56" height="56">
      </div>
      <div class="activity__body">
        <h3>${a.titulo}</h3>
        <p class="activity__info">${cuando}<br>${a.lugar}</p>
        <div class="activity__row">
          <div>${t('card_spots')}<strong class="${llena ? 'full' : 'ok'}">${a.cupos} / ${a.total}</strong></div>
          <div style="text-align:right">${t('card_level')}<strong>${t('lvl_' + a.nivel)}</strong></div>
        </div>
        ${boton}
      </div>
    </article>`;
}

function leerFiltros() {
  return {
    texto: normalizar($('#q').value.trim()),
    deporte: $('#f-sport').value,
    distrito: $('#f-district').value,
    horario: $('#f-time').value,
    nivel: $('#f-level').value,
    soloDisponibles: $('#only-available').checked
  };
}

function hayFiltros(f) {
  return Boolean(f.texto || f.deporte || f.distrito || f.horario || f.nivel || f.soloDisponibles);
}

function filtrarActividades(f) {
  return ACTIVIDADES.filter((a) => {
    const contenido = normalizar([a.titulo, a.lugar, a.distrito, t('sport_' + a.deporte)].join(' '));
    if (f.texto && !contenido.includes(f.texto)) return false;
    if (f.deporte && a.deporte !== f.deporte) return false;
    if (f.distrito && a.distrito !== f.distrito) return false;
    if (f.nivel && a.nivel !== f.nivel) return false;
    if (f.horario && franja(a.hora) !== f.horario) return false;
    if (f.soloDisponibles && (a.estado === 'llenos' || a.cupos === 0)) return false;
    return true;
  });
}

function mostrarResultados() {
  const filtros = leerFiltros();
  const lista = filtrarActividades(filtros);
  const filtrando = hayFiltros(filtros);
  const visibles = (verTodas || filtrando) ? lista : lista.slice(0, MAX_INICIAL);

  $('#cards').innerHTML = visibles.length
    ? visibles.map((a) => crearTarjeta(a, false)).join('')
    : `<p class="empty">${t('no_results')}</p>`;

  $('#result-count').textContent = lista.length === 1
    ? t('count_one')
    : t('count_n').replace('{n}', lista.length);

  const boton = $('#show-all');
  boton.parentElement.hidden = filtrando || lista.length <= MAX_INICIAL;
  boton.textContent = verTodas ? t('show_less') : t('show_all');
  boton.setAttribute('aria-expanded', String(verTodas));
}

function mostrarDeportes() {
  $('#sports').innerHTML = DEPORTES.map((d) => `
    <button class="card sport-tile" type="button" data-sport="${d}">
      <span class="sport-tile__icon" style="background:${COLORES[d]}"><img src="assets/img/${ICONOS[d]}" alt="" width="48" height="48"></span>
      ${t('sport_' + d)}
    </button>`).join('');
}

function mostrarPanel() {
  const panel = $('#panel');
  panel.querySelectorAll('.activity').forEach((el) => el.remove());
  const html = PROXIMAS.map((id) => crearTarjeta(ACTIVIDADES.find((a) => a.id === id), true)).join('');
  panel.insertAdjacentHTML('afterbegin', html);
}

function aplicarIdioma(nuevo) {
  idioma = nuevo;
  localStorage.setItem('idioma', idioma);
  document.documentElement.lang = idioma;
  document.title = t('page_title');

  $$('[data-i18n]').forEach((el) => { el.textContent = t(el.dataset.i18n); });
  $$('[data-i18n-placeholder]').forEach((el) => { el.placeholder = t(el.dataset.i18nPlaceholder); });
  $$('[data-i18n-aria]').forEach((el) => { el.setAttribute('aria-label', t(el.dataset.i18nAria)); });

  $('#lang').value = idioma;
  $$('[data-lang]').forEach((b) => b.setAttribute('aria-pressed', String(b.dataset.lang === idioma)));

  mostrarDeportes();
  mostrarResultados();
  mostrarPanel();
  if (dialogoActual) abrirDialogo(dialogoActual);
}

function abrirDialogo(tipo) {
  const dialogo = $('#dialog');
  dialogoActual = tipo;
  $('#dlg-title').textContent = t('dlg_' + tipo + '_title');
  $('#dlg-text').textContent = t('dlg_' + tipo + '_text');
  if (!dialogo.open) dialogo.showModal();
}

function cerrarDialogo() {
  dialogoActual = null;
  $('#dialog').close();
}

function mostrarError(input, mensajeClave) {
  const error = $('#' + input.getAttribute('aria-describedby'));
  error.textContent = mensajeClave ? t(mensajeClave) : '';
  input.setAttribute('aria-invalid', mensajeClave ? 'true' : 'false');
  return !mensajeClave;
}

function validarFormulario() {
  const nombre = $('#c-name');
  const apellido = $('#c-surname');
  const telefono = $('#c-phone');
  const email = $('#c-email');
  const mensaje = $('#c-msg');
  const regexEmail = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  const resultados = [];

  resultados.push(mostrarError(nombre, nombre.value.trim() ? '' : 'err_required'));
  resultados.push(mostrarError(apellido, apellido.value.trim() ? '' : 'err_required'));

  const tel = telefono.value.replace(/\s/g, '');
  resultados.push(mostrarError(telefono, tel && !/^\d{9}$/.test(tel) ? 'err_phone' : ''));

  let errorEmail = '';
  if (!email.value.trim()) errorEmail = 'err_required';
  else if (!regexEmail.test(email.value.trim())) errorEmail = 'err_email';
  resultados.push(mostrarError(email, errorEmail));

  resultados.push(mostrarError(mensaje, mensaje.value.trim() ? '' : 'err_required'));
  return resultados.every(Boolean);
}

function iniciarEventos() {
  ['#q', '#f-sport', '#f-district', '#f-time', '#f-level', '#only-available'].forEach((id) => {
    $(id).addEventListener('input', mostrarResultados);
    $(id).addEventListener('change', mostrarResultados);
  });

  $('#search-form').addEventListener('submit', (e) => {
    e.preventDefault();
    mostrarResultados();
    $('#actividades').scrollIntoView();
  });

  $('#advanced-toggle').addEventListener('click', (e) => {
    const panel = $('#advanced');
    panel.hidden = !panel.hidden;
    e.currentTarget.setAttribute('aria-expanded', String(!panel.hidden));
  });

  $('#sports').addEventListener('click', (e) => {
    const boton = e.target.closest('[data-sport]');
    if (!boton) return;
    $('#f-sport').value = boton.dataset.sport;
    mostrarResultados();
    $('#actividades').scrollIntoView();
  });

  const alternarVista = (modoMapa) => {
    $('#results').classList.toggle('results--map', modoMapa);
    $('#view-list').setAttribute('aria-pressed', String(!modoMapa));
    $('#view-map').setAttribute('aria-pressed', String(modoMapa));
  };
  $('#view-list').addEventListener('click', () => alternarVista(false));
  $('#view-map').addEventListener('click', () => alternarVista(true));

  $('#show-all').addEventListener('click', () => {
    verTodas = !verTodas;
    mostrarResultados();
  });

  $('#lang').addEventListener('change', (e) => aplicarIdioma(e.target.value));
  $$('[data-lang]').forEach((b) => b.addEventListener('click', () => aplicarIdioma(b.dataset.lang)));

  const menu = $('#menu');
  const boton = $('#menu-toggle');
  boton.addEventListener('click', () => {
    const abierto = menu.classList.toggle('open');
    boton.setAttribute('aria-expanded', String(abierto));
  });
  menu.addEventListener('click', (e) => {
    if (e.target.closest('a')) {
      menu.classList.remove('open');
      boton.setAttribute('aria-expanded', 'false');
    }
  });

  document.addEventListener('click', (e) => {
    const disparador = e.target.closest('[data-dialog]');
    if (disparador) abrirDialogo(disparador.dataset.dialog);
  });
  $('#dlg-close').addEventListener('click', cerrarDialogo);
  $('#dialog').addEventListener('click', (e) => { if (e.target.id === 'dialog') cerrarDialogo(); }); // clic fuera
  $('#dialog').addEventListener('close', () => { dialogoActual = null; });

  const formulario = $('#contact-form');
  formulario.addEventListener('submit', (e) => {
    e.preventDefault();
    const ok = $('#form-ok');
    ok.hidden = true;
    if (validarFormulario()) {
      ok.textContent = t('c_ok');
      ok.hidden = false;
      formulario.reset();
    }
  });
  formulario.querySelectorAll('.field').forEach((campo) => {
    campo.addEventListener('input', () => { if (campo.getAttribute('aria-invalid') === 'true') mostrarError(campo, ''); });
  });

  const enlaces = $$('.nav__link');
  const secciones = ['inicio', 'actividades', 'organizadores', 'jugadores'].map((id) => document.getElementById(id));
  const observador = new IntersectionObserver((entradas) => {
    entradas.forEach((entrada) => {
      if (entrada.isIntersecting) {
        enlaces.forEach((l) => l.classList.toggle('active', l.getAttribute('href') === '#' + entrada.target.id));
      }
    });
  }, { rootMargin: '-40% 0px -55% 0px' });
  secciones.forEach((s) => observador.observe(s));
}

document.addEventListener('DOMContentLoaded', () => {
  $('#year').textContent = new Date().getFullYear();
  iniciarEventos();
  aplicarIdioma(idioma);
});
