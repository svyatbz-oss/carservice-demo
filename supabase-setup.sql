-- ============================================================
--  Carservice — Configuración de la base de datos (proyecto nuevo)
--  Pega y ejecuta todo esto en: Supabase → SQL Editor
--
--  Crea las tres tablas que usa la app y deja el acceso restringido
--  a usuarios con sesión iniciada. Es seguro ejecutarlo varias veces.
-- ============================================================

-- 1) PEDIDOS — una fila por pedido -----------------------------------------
create table if not exists pedido_items (
  id             text primary key,
  matricula      text,
  marca          text,
  pieza          text,
  proveedor      text,
  precio         numeric,
  descuento      numeric,
  fecha_pedido   text,
  estado         text,
  fecha_recibido text,
  updated_at     timestamptz default now()
);

-- 2) INSPECCIONES — una fila por coche (las piezas van en JSON dentro) ------
create table if not exists inspeccion_items (
  id                  text primary key,
  matricula           text,
  marca               text,
  cliente             text,
  bastidor            text,
  fecha_matriculacion text,
  creada              text,
  piezas              jsonb default '[]'::jsonb,
  updated_at          timestamptz default now()
);

-- Si ya tenías la tabla de una version anterior, esto le anade el campo nuevo.
alter table inspeccion_items add column if not exists cliente text;

-- 3) COPIAS DE SEGURIDAD — instantáneas con fecha para "restaurar" ----------
create table if not exists backups (
  id           bigint generated always as identity primary key,
  created_at   timestamptz default now(),
  etiqueta     text,
  pedidos      jsonb,
  inspecciones jsonb
);

-- 4) Seguridad: solo usuarios con sesión iniciada pueden leer y escribir ----
--    Sin esto, cualquiera con la URL podría ver o modificar los datos.
alter table pedido_items     enable row level security;
alter table inspeccion_items enable row level security;
alter table backups          enable row level security;

drop policy if exists "acceso autenticado" on pedido_items;
create policy "acceso autenticado" on pedido_items
  for all to authenticated using (true) with check (true);

drop policy if exists "acceso autenticado" on inspeccion_items;
create policy "acceso autenticado" on inspeccion_items
  for all to authenticated using (true) with check (true);

drop policy if exists "acceso autenticado" on backups;
create policy "acceso autenticado" on backups
  for all to authenticated using (true) with check (true);

-- ============================================================
--  Siguiente paso: crea el usuario del taller en
--  Authentication → Users → Add user  (activa "Auto Confirm User")
-- ============================================================
