-- CONSTRUCCIÓN DEL EMBUDO DE CONVERSIÓN
-- ==========================================

-- Construcción de CTEs y Cálculo de Conversión General
-- Objetivo: Medir usuarios únicos por etapa y su tasa de conversión respecto a la primera visita.

WITH cte_first_visit AS (
    SELECT DISTINCT user_id FROM mercadolibre_funnel
    WHERE event_name = 'first_visit' AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),
cte_select_item AS (
    SELECT DISTINCT user_id FROM mercadolibre_funnel
    WHERE event_name IN ('select_item','select_promotion') AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),
cte_add_to_cart AS (
    SELECT DISTINCT user_id FROM mercadolibre_funnel
    WHERE event_name = 'add_to_cart' AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),
cte_begin_checkout AS (
    SELECT DISTINCT user_id FROM mercadolibre_funnel
    WHERE event_name = 'begin_checkout' AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),
cte_add_shipping_info AS (
    SELECT DISTINCT user_id FROM mercadolibre_funnel
    WHERE event_name = 'add_shipping_info' AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),
cte_add_payment_info AS (
    SELECT DISTINCT user_id FROM mercadolibre_funnel
    WHERE event_name = 'add_payment_info' AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),
cte_purchase AS (
    SELECT DISTINCT user_id FROM mercadolibre_funnel
    WHERE event_name = 'purchase' AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),
funnel_counts AS (
    SELECT 
        COUNT(DISTINCT f.user_id) AS usuarios_first_visit,
        COUNT(DISTINCT s.user_id) AS usuarios_select_item,
        COUNT(DISTINCT c.user_id) AS usuarios_add_to_cart,
        COUNT(DISTINCT b.user_id) AS usuarios_begin_checkout,
        COUNT(DISTINCT sh.user_id) AS usuarios_add_shipping_info,
        COUNT(DISTINCT pa.user_id) AS usuarios_add_payment_info,
        COUNT(DISTINCT pu.user_id) AS usuarios_purchase
    FROM cte_first_visit f
    LEFT JOIN cte_select_item s         ON f.user_id = s.user_id
    LEFT JOIN cte_add_to_cart c         ON s.user_id = c.user_id
    LEFT JOIN cte_begin_checkout b      ON c.user_id = b.user_id
    LEFT JOIN cte_add_shipping_info sh  ON b.user_id = sh.user_id
    LEFT JOIN cte_add_payment_info pa   ON sh.user_id = pa.user_id
    LEFT JOIN cte_purchase pu           ON pa.user_id = pu.user_id
)
SELECT
    ROUND(usuarios_select_item * 100.0 / NULLIF(usuarios_first_visit, 0), 2) AS conversion_select_item,
    ROUND(usuarios_add_to_cart * 100.0 / NULLIF(usuarios_first_visit, 0), 2) AS conversion_add_to_cart,
    ROUND(usuarios_begin_checkout * 100.0 / NULLIF(usuarios_first_visit, 0), 2) AS conversion_begin_checkout,
    ROUND(usuarios_add_shipping_info * 100.0 / NULLIF(usuarios_first_visit, 0), 2) AS conversion_add_shipping_info,
    ROUND(usuarios_add_payment_info * 100.0 / NULLIF(usuarios_first_visit, 0), 2) AS conversion_add_payment_info,
    ROUND(usuarios_purchase * 100.0 / NULLIF(usuarios_first_visit, 0), 2) AS conversion_purchase
FROM funnel_counts;

-- Segmentación por País
-- Objetivo: Identificar en qué países hay mayor fricción en el proceso de compra.
-- (Este query utiliza la misma lógica anterior pero agrupando por columna 'country')

WITH
first_visit AS (
    SELECT DISTINCT user_id, country
    FROM mercadolibre_funnel
    WHERE event_name = 'first_visit'
      AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),


select_item AS (
    SELECT DISTINCT user_id, country
    FROM mercadolibre_funnel
    WHERE event_name IN ('select_item', 'select_promotion')
      AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),


add_to_cart AS (
    SELECT DISTINCT user_id, country
    FROM mercadolibre_funnel
    WHERE event_name = 'add_to_cart'
      AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),


begin_checkout AS (
    SELECT DISTINCT user_id, country
    FROM mercadolibre_funnel
    WHERE event_name = 'begin_checkout'
      AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),


add_shipping_info AS (
    SELECT DISTINCT user_id, country
    FROM mercadolibre_funnel
    WHERE event_name = 'add_shipping_info'
      AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),


add_payment_info AS (
    SELECT DISTINCT user_id, country
    FROM mercadolibre_funnel
    WHERE event_name = 'add_payment_info'
      AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),


purchase AS (
    SELECT DISTINCT user_id, country
    FROM mercadolibre_funnel
    WHERE event_name = 'purchase'
      AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),
funnel_counts AS (
    SELECT
        fv.country,
        COUNT(DISTINCT fv.user_id)   AS usuarios_first_visit,
        COUNT(DISTINCT si.user_id)   AS usuarios_select_item,
        COUNT(DISTINCT ac.user_id)   AS usuarios_add_to_cart,
        COUNT(DISTINCT bc.user_id)   AS usuarios_begin_checkout,
        COUNT(DISTINCT shi.user_id)  AS usuarios_add_shipping_info,
        COUNT(DISTINCT pay.user_id)  AS usuarios_add_payment_info,
        COUNT(DISTINCT p.user_id)    AS usuarios_purchase
    FROM first_visit fv
    LEFT JOIN select_item      si
        ON fv.user_id = si.user_id
       AND fv.country = si.country
    LEFT JOIN add_to_cart      ac
        ON fv.user_id = ac.user_id
       AND fv.country = ac.country
    LEFT JOIN begin_checkout   bc
        ON fv.user_id = bc.user_id
       AND fv.country = bc.country
    LEFT JOIN add_shipping_info shi
        ON fv.user_id = shi.user_id
       AND fv.country = shi.country
    LEFT JOIN add_payment_info pay
        ON fv.user_id = pay.user_id
       AND fv.country = pay.country
    LEFT JOIN purchase         p
        ON fv.user_id = p.user_id
       AND fv.country = p.country
    GROUP BY fv.country
)


SELECT
    country,
    usuarios_select_item * 100.0 / NULLIF(usuarios_first_visit, 0)
        AS conversion_select_item,
    usuarios_add_to_cart * 100.0 / NULLIF(usuarios_first_visit, 0)
        AS conversion_add_to_cart,
    usuarios_begin_checkout * 100.0 / NULLIF(usuarios_first_visit, 0)
        AS conversion_begin_checkout,
    usuarios_add_shipping_info * 100.0 / NULLIF(usuarios_first_visit, 0)
        AS conversion_add_shipping_info,
    usuarios_add_payment_info * 100.0 / NULLIF(usuarios_first_visit, 0)
        AS conversion_add_payment_info,
    usuarios_purchase * 100.0 / NULLIF(usuarios_first_visit, 0)
        AS conversion_purchase
FROM funnel_counts
ORDER BY conversion_purchase DESC;
