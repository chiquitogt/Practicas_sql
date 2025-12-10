-- Índice para buscar órdenes por usuario
CREATE INDEX idx_orders_user_id ON ORDERS(user_id);

-- Índice compuesto para buscar por usuario y fecha
CREATE INDEX idx_orders_user_date ON ORDERS(user_id, created_at);

-- Índice para filtrar por fecha directamente
CREATE INDEX idx_orders_date ON ORDERS(created_at);


/* Explicacion de los índices creados: 

idx_orders_user_id → acelera consultas que filtran por usuario.

idx_orders_user_date → ideal para queries que combinan usuario + rango de fechas (ej. historial de compras).

idx_orders_date → útil para reportes globales por períodos. */
