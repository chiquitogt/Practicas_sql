CREATE TRIGGER update_order_total       -- Trigger para actualizar el total de la orden al insertar un ítem
AFTER INSERT ON ORDER_ITEMS
FOR EACH ROW        -- Para cada fila insertada en ORDER_ITEMS
BEGIN
    UPDATE ORDERS   -- Actualizar la tabla ORDERS
    SET total = (
        SELECT SUM(price * qty)
        FROM ORDER_ITEMS
        WHERE order_id = NEW.order_id
        -- Calcular el nuevo total sumando precio * cantidad de los ítems de la orden
    )
    WHERE id = NEW.order_id;        -- Actualizar la orden correspondiente
END;
