# Carservice — Control de piezas para talleres

Aplicación web para llevar el control de las piezas de un taller, con dos secciones:

1. **Inspecciones** — anotas lo que el mecánico detecta en cada coche (matrícula,
   marca/modelo, bastidor y las piezas que necesita).
2. **Pedidos** — cuando llamas al proveedor, cada pieza pasa a ser un pedido real
   con proveedor, precio, descuento y fecha.

Con un botón **"Pedir"** la pieza salta de una sección a la otra con los datos ya
rellenados, y queda marcada como **"En pedido"** hasta que la confirmas.

Las inspecciones se agrupan por mes: las que aún tienen piezas por pedir
arrastran al mes actual para que no se queden enterradas, y cuando todas sus
piezas están pedidas pasan solas a **"Inspecciones hechas"**. Cada inspección
admite un **cliente** opcional (particular, seguro o concesionario), que se ve
también en las tarjetas de Pedidos.

Los precios se escriben **sin IVA**, como los pasa el proveedor, y la app
muestra el importe **con el 21% ya incluido** en cada pieza, en los totales y
en cada tarjeta.

Además: avisos de retraso, reclamación por WhatsApp, exportación a CSV/PDF y
copias de seguridad automáticas con restauración.

---

## Probarlo ahora mismo (sin instalar nada)

Abre la página y ya funciona. **En este modo los datos se guardan solo en tu
navegador**: no se comparten entre dispositivos y no hay que iniciar sesión.
Es perfecto para ver cómo funciona la app.

Para usarla de verdad en un taller (datos compartidos entre el móvil, el
ordenador del taller, etc.), sigue los pasos de abajo.

---

## Puesta en marcha para un taller (unos 10 minutos)

Cada taller usa su **propia** base de datos gratuita, así que tus datos son solo
tuyos: nadie más los ve.

### 1. Crear el proyecto en Supabase
1. Entra en https://supabase.com y crea una cuenta gratuita.
2. Pulsa **New project**, ponle un nombre (p. ej. `mi-taller`) y elige una
   contraseña para la base de datos (guárdala).
3. Espera 1–2 minutos a que se cree.

### 2. Crear las tablas
1. En el menú lateral, entra en **SQL Editor**.
2. Pega y ejecuta todo el contenido del archivo `supabase-setup.sql`
   (incluido en esta carpeta).

### 3. Crear el usuario del taller
1. Ve a **Authentication → Users → Add user**.
2. Pon un correo y una contraseña (serán las que use el taller para entrar).
3. **Importante:** activa **"Auto Confirm User"**, si no, no podrás iniciar sesión.

### 4. Conectar la app con tu base de datos
1. Ve a **Project Settings → API**.
2. Copia el **Project URL** y la clave **anon public**.
3. Ábrelos en `index.html`, casi al principio del `<script>`:

```js
const SUPABASE_URL = '';        // p.ej. 'https://xxxxxxxx.supabase.co'
const SUPABASE_ANON_KEY = '';   // la clave "anon public"
```

Pega ahí los dos valores. Al recargar, la app pedirá iniciar sesión con el
usuario que creaste.

### 5. Publicarlo como página web
Opciones gratuitas:
- **GitHub Pages**: sube la carpeta a un repositorio y actívalo en
  *Settings → Pages*. Deja el archivo `.nojekyll` que viene incluido.
- **Netlify** o **Vercel**: arrastra la carpeta y te dan una URL fija.

---

## Copias de seguridad

Con Supabase configurado, la app guarda una **copia automática cada día** y
mantiene las 30 últimas. Desde **"Copias de seguridad y restaurar"** puedes
crear una copia manual o restaurar cualquiera (antes de restaurar se guarda
otra del estado actual, por si acaso).

También puedes exportar a CSV en cualquier momento.

---

## Nota de seguridad

- La clave `anon public` está pensada para usarse en el navegador: **no** es la
  clave secreta. Aun así, no publiques nunca la `service_role`.
- Las tablas quedan protegidas: **solo** quien inicia sesión puede ver o
  modificar los datos. Sin la contraseña, la URL y la clave no sirven de nada.
- La contraseña del taller es compartida entre los que la usen: trátala como la
  llave del taller y cámbiala si alguien deja el equipo.

---

## Licencia

MIT — puedes usarlo, modificarlo y compartirlo libremente.
