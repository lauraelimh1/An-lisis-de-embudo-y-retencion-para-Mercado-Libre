# Ana-lisis-de-embudo-y-retencion-para-Mercado-Libre - Bootcamp TripleTen
El proyecto consistió en un análisis profundo del comportamiento de los usuarios en la plataforma de MercadoLibre durante el periodo de enero a agosto de 2025. Como Analista de Producto, el enfoque se centró en mapear el viaje del usuario (Customer Journey) desde la primera visita hasta la compra final, identificando los puntos de abandono y evaluando la lealtad a largo plazo mediante el análisis de cohortes de retención.

## Objetivo del Proyecto
El propósito principal fue responder a dos preguntas críticas de negocio:

Conversión: ¿En qué etapa específica del proceso de compra perdemos la mayor cantidad de usuarios y cómo varía este comportamiento por país?

Retención: ¿Qué tan efectiva es la plataforma para mantener activos a los usuarios después de su registro inicial y en qué momento se produce el mayor desinterés?

## Habilidades Técnicas Aplicadas

* **SQL Avanzado (PostgreSQL):**
* Uso de CTEs (Common Table Expressions) para modularizar las etapas del embudo.
* Implementación de Left Joins complejos (uniones por usuario y país) para rastrear la progresión del usuario.
* **Funciones de agregación condicional (CASE WHEN) para calcular hitos de retención (D7, D14, D21, D28).
* Manipulación de fechas con DATE_TRUNC, TO_CHAR y MIN() para la creación de cohortes mensuales.

* **Análisis de Datos y Excel:**
* Procesamiento de resultados de queries para la generación de informes ejecutivos.
* Cálculo de variaciones porcentuales y simulación de escenarios de mejora.
  
## Hallazgos Principales

**Análisis del Embudo (Funnel)**
* El "Cuello de Botella": Se identificó que la mayor caída porcentual ocurre entre las etapas de "Select Item" y "Add to Cart", donde se pierde aproximadamente el 85.7% de los usuarios interesados. Esto sugiere fricción en la visualización del producto o dudas en la decisión de compra (precios, reseñas, costos de envío).

* Desempeño por País: Uruguay destaca como el país más eficiente con una tasa de conversión a compra del 4.55%, mientras que países como Brasil y Paraguay presentan las conversiones más bajas (menos del 1%).

* Conversión General: La tasa de conversión final del ecosistema analizado se sitúa en un 1.25%.

**Análisis de Retención**
* Ventana Crítica de 21 Días: Entre el 75% y 80% de los usuarios dejan de estar activos antes de los 21 días. Sin embargo, aquellos que superan este umbral tienen una probabilidad significativamente alta de convertirse en usuarios recurrentes hacia el día 28.

* Anomalía en Cohortes: Se detectó una caída drástica en la retención de la cohorte de agosto de 2025 (apenas 0.2% en D28), lo que indica un posible problema técnico en la aplicación o una baja calidad en el tráfico captado durante ese mes específico.

* Líderes en Retención: México y Perú muestran los mejores indicadores de retención a largo plazo, sirviendo como modelos para implementar sus estrategias en otros mercados.

## Recomendaciones Estratégicas
* Optimización de la ficha de producto: Implementar mejoras en la etapa "Add to Cart", facilitando la visualización de información relevante (tallas, costos de envío claros) para reducir el abandono del 85%.

* Estrategia de CRM Preventiva: Lanzar notificaciones personalizadas o incentivos (cupones) antes del día 21 tras el registro, para combatir la fuga masiva de usuarios en esa etapa.

* Auditoría Técnica: Realizar un análisis urgente sobre la cohorte de agosto para descartar fallos en el sistema o errores en la atribución de campañas de marketing.

## ​"Nota: Los scripts SQL incluidos fueron diseñados para una base de datos de Mercado Libre. Aunque la base de datos original es privada, el código muestra la lógica de extracción, limpieza y transformación utilizada para generar el resumen ejecutivo en Excel."
