# Klasse

Klasse es una plataforma para facilitar la gestion de cursos masivos en universidades, que posean grandes equipos docentes y donde la corrección de tareas y exámenes es un proceso manual y tedioso.

Originalmente la plataforma estará siendo utilizada en el curso IIC2133-PUC Estructuras de datos y algoritmos. En caso de querer probar la plataforma, contactar conmigo via Telegram [@cparedesr](https://t.me/cparedesr).

## Features

MVP (95% completado)

- [X] Permite a los estudiantes escanear y subir sus tareas y exámenes desde la misma aplicación.
- [X] Permite la autenticación de estudiantes y docentes con Google.
- [ ] Permite obtención de métricas en tiempo real sobre la cantidad de tareas y exámenes entregados por los estudiantes.

### Roadmap Priorizado

- Vinculacion Google Spreadsheet para facilitación de acceso.
- Envio de Correos y Correcciones a los estudiantes.
- Permitir repartición de correcciones entre equipos docentes.
- Vinculación con API Github Classroom para manejo de tareas.
- Evaluación de tareas y exámenes en la plataforma.

This is a Rails application, initially generated using [Potassium](https://github.com/platanus/potassium) by Platanus.

## Deployment

This project is pre-configured to be (easily) deployed to Heroku servers, but needs you to have the Potassium binary installed. If you don't, then run:

    $ gem install potassium

Then, make sure you are logged in to the Heroku account where you want to create the app and run

    $ potassium install heroku --force

this will create the app on heroku, create a pipeline and link the app to the pipeline.

You'll still have to manually log in to the heroku dahsboard, go to the new pipeline and 'configure automatic deploys' using Github
You can run the following command to open the dashboard in the pipeline page

    $ heroku pipelines:open

![Hint](https://cloud.githubusercontent.com/assets/313750/13019759/fa86c8ca-d1af-11e5-8869-cd2efb5513fa.png)

Remember to connect each stage to the corresponding branch:

1. Staging -> Master
2. Production -> Production

That's it. You should already have a running app and each time you push to the corresponding branch, the system will (hopefully) update accordingly.

