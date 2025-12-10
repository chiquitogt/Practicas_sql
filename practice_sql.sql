-- CTE example with JOIN

-- Este script SQL utiliza Common Table Expressions (CTE) para organizar y simplificar una consulta compleja.

/*  Tenemos las siguientes tablas:
    USERS(id, name)
    ORDERS(id, user_id, total, created_at)
    ORDER_ITEMS(id, order_id, product_name, qty, price)*/

WITH user_stats AS (  -- CTE para calcular estadísticas de usuarios
    SELECT  
        u.id AS user_id,    
        u.name,
        COUNT(DISTINCT o.id) AS total_orders,       -- Total de órdenes por usuario
        SUM(o.total) AS total_spent,                -- Total gastado por usuario
        SUM(oi.qty) AS total_items              -- Total de ítems comprados por usuario
    FROM USERS u        
    JOIN ORDERS o ON u.id = o.user_id           -- Unir usuarios con órdenes
    JOIN ORDER_ITEMS oi ON o.id = oi.order_id   -- Unir órdenes con ítems de órdenes
    WHERE strftime('%Y', o.created_at) = '2024' -- Filtrar órdenes del año 2024
    GROUP BY u.id, u.name                   -- Agrupar por usuario
)
SELECT 
    name,
    total_orders,
    total_spent,
    total_items
FROM user_stats
ORDER BY total_spent DESC       -- Ordenar por total comprado en orden descendente
LIMIT 5;                 -- Limitar a los top 5 usuarios que mas compraron