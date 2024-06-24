SELECT
    op.order_id,
    op.add_to_cart_order,
    op.product_id,
    p.department_id,
    (
        SELECT department_id
        FROM order_products op2
        INNER JOIN products p2 ON op2.product_id = p2.product_id
        WHERE op2.order_id = op.order_id
          AND op2.add_to_cart_order = op.add_to_cart_order - 1
    ) AS prev_department_id
FROM
    order_products op
    INNER JOIN products p ON op.product_id = p.product_id
WHERE
    op.add_to_cart_order > 1  -- Considerar solo productos que no son el primero en la orden
    AND EXISTS (
        SELECT 1
        FROM order_products op2
        INNER JOIN products p2 ON op2.product_id = p2.product_id
        WHERE op2.order_id = op.order_id
          AND op2.add_to_cart_order = op.add_to_cart_order - 1
          AND p2.department_id <> p.department_id
    );

--new
WITH product_order AS (
    SELECT
        op.order_id,
        op.add_to_cart_order,
        op.product_id,
        p.department_id,
        d.department AS department,
        LAG(p.department_id, 1) OVER (PARTITION BY op.order_id ORDER BY op.add_to_cart_order) AS prev_department_id1,
        LAG(d.department, 1) OVER (PARTITION BY op.order_id ORDER BY op.add_to_cart_order) AS previous1,
        LAG(p.department_id, 2) OVER (PARTITION BY op.order_id ORDER BY op.add_to_cart_order) AS prev_department_id2,
        LAG(d.department, 2) OVER (PARTITION BY op.order_id ORDER BY op.add_to_cart_order) AS previous2,
        LAG(p.department_id, 3) OVER (PARTITION BY op.order_id ORDER BY op.add_to_cart_order) AS prev_department_id3,
        LAG(d.department, 3) OVER (PARTITION BY op.order_id ORDER BY op.add_to_cart_order) AS previous3,
        LAG(p.department_id, 4) OVER (PARTITION BY op.order_id ORDER BY op.add_to_cart_order) AS prev_department_id4,
        LAG(d.department, 4) OVER (PARTITION BY op.order_id ORDER BY op.add_to_cart_order) AS previous4
    FROM
        order_products op
        INNER JOIN products p ON op.product_id = p.product_id
        INNER JOIN departments d ON p.department_id = d.department_id
)
SELECT
    order_id,
    add_to_cart_order,
    product_id,
    department_id,
    department,
    COALESCE(previous1, 'Unknown') AS previous_department1,
    COALESCE(previous2, 'Unknown') AS previous_department2,
    COALESCE(previous3, 'Unknown') AS previous_department3,
    COALESCE(previous4, 'Unknown') AS previous_department4
FROM
    product_order
WHERE
    add_to_cart_order > 4  -- Considerar solo productos que no son los primeros 4 en la orden
    AND previous4 IS NOT NULL;  -- Filtrar aquellos productos que tienen los cuatro departamentos anteriores registrados
