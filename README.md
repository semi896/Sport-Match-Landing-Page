
Landing page de "Sport Match", una plataforma web que conecta jugadores con actividades y eventos deportivos en Lima.
Proyecto del Trabajo Parcial del curso Arquitectura de Aplicaciones Web

Que incluye

- Header con navegación y selector de idioma (ES / EN).
- Hero con buscador y filtros (deporte, distrito, fecha/hora y nivel, más un filtro avanzado).
- Exploración por deporte: al hacer clic se filtran las actividades.
- Actividades cercanas en vista "Lista" o "Mapa", con botón "Ver todas".
- Secciones para "Jugadores" y para "Organizadores".
- Vista previa de actividades próximas y perfil deportivo.
- Formulario de contacto con validación y mensajes de error.
- Diseño responsive (escritorio, tablet y móvil).

 Tecnologías

- HTML5, CSS3 y JavaScript.
- Fuente Roboto (Google Fonts).

Estructura del proyecto

```
sport-match-landing/
├── index.html          Estructura de la página
├── css/
│   └── styles.css      Estilos (variables, componentes y responsive)
├── js/
│   ├── data.js         Actividades de ejemplo y textos ES/EN
│   └── main.js         Lógica de la página
└── assets/img/         Logo, escudo e íconos deportivos
```

 Guía de estilos usada

| Elemento              | Valor |
| Tipografía            | Roboto |
| Color primario        | `#0D6EFD` |
| Éxito / confirmación  | `#198754` |
| Error / cupos llenos  | `#DC3545` |
| Advertencia / en espera | `#FFC107` |
| Fondo y texto          | `#F8F9FA` y `#212529` |
| Títulos               | H1 32 px, H2 24 px |
| Texto y botones        | 16 px y 14 px |
| Bordes y espaciado    | Esquinas de 8 px y múltiplos de 8 px |

Accesibilidad e internacionalización

- HTML semántico (`header`, `nav`, `main`, `section`, `footer`) y enlace "Saltar al contenido".
- Campos con etiqueta, errores de formulario en texto y anunciados con `aria-live`.
- Los estados no dependen solo del color (llevan texto) y hay foco visible al navegar con teclado.
- Respeta la preferencia de movimiento reducido del sistema.
- El idioma elegido se guarda en el navegador (`localStorage`). Los títulos de las actividades de ejemplo están solo en español.


Pendiente (siguientes etapas)

Los botones "Iniciar sesión", "Registrarse" y "Solicitar Cupo" abren por ahora un mensaje informativo.
