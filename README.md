# Ana-lisis-de-embudo-y-retencion-para-Mercado-Libre - Bootcamp TripleTen
El proyecto consistió en un análisis profundo del comportamiento de los usuarios en la plataforma de MercadoLibre durante el periodo de enero a agosto de 2025. Como Analista de Producto, el enfoque se centró en mapear el viaje del usuario (Customer Journey) desde la primera visita hasta la compra final, identificando los puntos de abandono y evaluando la lealtad a largo plazo mediante el análisis de cohortes de retención.

## Objetivo del Proyecto
El propósito principal fue responder a dos preguntas críticas de negocio:

Conversión: ¿En qué etapa específica del proceso de compra perdemos la mayor cantidad de usuarios y cómo varía este comportamiento por país?

Retención: ¿Qué tan efectiva es la plataforma para mantener activos a los usuarios después de su registro inicial y en qué momento se produce el mayor desinterés?

## Habilidades Técnicas Aplicadas
Para la ejecución se utilizaron las siguientes herramientas y técnicas:

* **SQL Avanzado (PostgreSQL):**
* **Uso de CTEs (Common Table Expressions) para modularizar las etapas del embudo.

* **Implementación de Left Joins complejos (uniones por usuario y país) para rastrear la progresión del usuario.

* **Funciones de agregación condicional (CASE WHEN) para calcular hitos de retención (D7, D14, D21, D28).

* **Manipulación de fechas con DATE_TRUNC, TO_CHAR y MIN() para la creación de cohortes mensuales.

* **Análisis de Datos y Excel:**

* **Procesamiento de resultados de queries para la generación de informes ejecutivos.

* **Cálculo de variaciones porcentuales y simulación de escenarios de mejora.

## ​"Nota: Los scripts SQL incluidos fueron diseñados para una base de datos de Mercado Libre. Aunque la base de datos original es privada, el código muestra la lógica de extracción, limpieza y transformación utilizada para generar el resumen ejecutivo en Excel."
