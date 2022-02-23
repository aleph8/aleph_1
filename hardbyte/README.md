<p align="center">
    <a href="https://github.com/yiisoft" target="_blank">
        <img src="https://avatars0.githubusercontent.com/u/993323" height="100px">
    </a>
    <h1 align="center">Hardbyte</h1>
    <br>
</p>

Usada la plantilla básica ofrecida por Yii ya que era más óptimo emplear el frontend (vue) que en la plantilla advanced

TESTING
-------

Para ejecutar hardbyte es imprescindible ejecutar el siguiente comando: 

```plain

# php yii serve --port=8080
  
```

DIRECTORY STRUCTURE
-------------------

      assets/             ---------------------------------------> *
      commands/           comando de consola (realmente son controladores) usado en el desarrollo
      config/             contiene 'web.php' donde se ha habilitado URL manager para la gestión del enrutamiento.
                            además se establece la conexión con la base de datos (ver archivo 'db.php')
      controllers/        Controlador Site con acciones como 'login' o 'signup'
      mail/               ---------------------------------------> *
      models/             contains model classes.
      runtime/            ---------------------------------------> *
      vuejs/              Implementación íntegra del Frontend.
      tests/              ---------------------------------------> *
      vendor/             ---------------------------------------> *
      views/              contains view files for the Web application
      web/                ---------------------------------------> *
      
      *ver documentación de Yii

