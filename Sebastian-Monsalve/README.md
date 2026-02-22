# Propuesta Moisés Vega Molino

## Referentes
* Canvas by Instructure: Es un sistema de gestión de cursos completo, la evaluación entre pares viene incluida como parte de las tareas. Permite asignar revisiones automáticamente, usar rúbricas y configurar el anonimato, todo conectado a los grupos que ya esten dentro del curso. Sin embargo la evaluación no es su función principal, sino solo una característica más dentro de un ecosistema enorme, alendose de la idea inicial de una app móvil enfocada en calificar compañeros.

* TEAMMATES: Está diseñado específicamente para evaluación entre pares en trabajo. Se centra en medir cuánto aporta cada persona mediante preguntas que Se pueden personalizar, y genera reportes detallados para el profesor con opciones para controlar si se mantiene el anonimato. Se acerca más a la idea de una app dedicada exclusivamente a evaluar compañeros, aunque funciona como sistema web independiente y no como una app móvil que se integre con otras plataformas.

* Google Forms y Google Classroom: Ofrece una solución sencilla y flexible basada en formularios personalizados para recoger evaluaciones. Es fácil de poner en marcha y da total libertad para diseñar preguntas como se requiera, pero carece de asignación automática de evaluadores, gestión estructurada de grupos y generación avanzada de métricas. Esto lo deja con más trabajo manual y menos automatización comparado con lo que podría ofrecer una app especializada.

## Composición y diseño de la solución
Un posible enfoque seria una única aplicación móvil con dos tipos de usuario: profesor y estudiante. Esta decisión permite simplificar el desarrollo y mantener coherencia en la experiencia de uso. La diferenciación se manejaría mediante permisos según el rol, evitando duplicar funcionalidades y facilitando la integración con la plataforma de cursos existente.

## Descripción del flujo funcional
Se empieza desde el lado del profesor, este inicia sesión con su cuenta institucional de Microsoft. Una vez dentro, el sistema le muestra los proyectos que ya tiene creados. Desde ahí puede crear uno nuevo configurando los datos básicos, o entrar directamente a uno existente. Para armar los equipos, simplemente sube un archivo CSV con la lista de grupos; el sistema se encarga de revisar que esté bien formateado y guarda todo en la base de datos. Luego viene la parte de configurar la coevaluación: establece las fechas de inicio y cierre, elige si será anónima o identificada, define los criterios o rúbrica y selecciona el tipo de preguntas.
Por el lado del estudiante, el proceso es similar: entra con su cuenta Microsoft y el sistema le muestra solo los proyectos activos en los que participa, filtrando las coevaluaciones que estén abiertas en ese momento. Cuando elige una evaluación, la app detecta automáticamente a qué grupo pertenece y arma el formulario correspondiente. El estudiante va calificando a cada compañero según los criterios que definió el profesor y, al terminar, envía sus respuestas que quedan guardadas vinculadas al proyecto.
Cuando se cierra el plazo de evaluación, el sistema procesa automáticamente toda la información y calcula las métricas por estudiante y por grupo. El profesor entra a un panel de resultados donde puede ver estadísticas resumidas, promedios y reportes individuales que le ayudan a analizar cómo fue la contribución de cada uno en el trabajo en equipo.

## Justificación
Reazar que eduarod me resiva en su oficina mañana lunes
*
## Figma

![This is an alt text.](/image/Markdown-mark.svg "This is a sample image.")
You may be using [Markdown Live Preview](https://markdownlivepreview.com/).