<?php

namespace app\controllers;

use Yii;
use yii\filters\AccessControl;
use yii\web\Controller;
use yii\web\Response;
use yii\filters\VerbFilter;
use app\models\LoginForm; //Usamos los modelos creados para que el controlador maneje las peticiones
use app\models\RegisterForm;  //Usamos los modelos creados para que el controlador maneje las peticiones
use yii\filters\Cors;
use app\models\ContactForm;

class SiteController extends Controller
{
    /**
     * {@inheritdoc}
     */
    public function behaviors()
    {
        return [
            'access' => [
                'class' => AccessControl::className(),
                'only' => ['logout'],
                'rules' => [
                    [
                        'actions' => ['logout'],
                        'allow' => true,
                        'roles' => ['@'],
                    ],
                ],
            ],
            'verbs' => [
                'class' => VerbFilter::className(),
                'actions' => [
                    'logout' => ['post'],
                ],
            ],
            'cors' => [
                'class' => Cors::class
            ],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function actions()
    {
        return [
            'error' => [
                'class' => 'yii\web\ErrorAction',
            ],
            'captcha' => [
                'class' => 'yii\captcha\CaptchaAction',
                'fixedVerifyCode' => YII_ENV_TEST ? 'testme' : null,
            ],
        ];
    }

    /**
     * Displays homepage.
     *
     * @return string
     */
    public function actionIndex()
    {
        return $this->render('index');
    }

    /**
     * 
     * Login: ver Registro; igual pero con menos parámetros.
     * 
     *  En este caso devolvemos el usuario para gestionar los tokens y las funcionalidades de la app
     * 
     */
    public function actionLogin()
    {

        Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;

        $model = new LoginForm();
        if ($model->load(Yii::$app->request->post(), '') && $model->login()) {
            Yii::$app->response->statusCode = 200;
            return $model->getUser();
        }

        Yii::$app->response->statusCode = 422;

        return[
            'errors' => $model ->errors
        ];

    }

    /**
     * Registro:
     * 
     * En primer lugar establecemos el formato de respuesta a JSON
     * 
     *  Creamos un nuevo registro (modelo) y mediante 'load' comprobamos que los elementos obtenidos
     *  de la petición son los correctos.
     * 
     *  Posteriormente 'ejecutamos' el método signup del modelo; si éste se ejecuta correctamente significa que todo ha ido bien
     *  en el registro: el usuario está registrado y lo devolvemos como parámetro.
     * 
     *  En el caso de que haya fallado alguna de las dos condiciones, o los datos no son los correcto o ha saltado algún error interno en la
     *  base de datos por igualdades entre claves única. Establecemos el código de estado a 422 y devolvemos los errores del modelo para mostrarlos
     *  por el frontend al usuario
     * 
     */


    public function actionAdmin(){
        return $this->render('admin');
    }

    
    public function actionSignup()
    {

        Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;

        $model = new RegisterForm();

        if ($model->load(Yii::$app->request->post(), '') && $model->signup()) {
            return $model->user;
        }


        Yii::$app->response->statusCode = 422;

        return[
            'errors' => $model->errors
        ];

    }

    /**
     * Logout action.
     *
     * @return Response
     */
    public function actionLogout()
    {
        Yii::$app->user->logout();

        return $this->goHome();
    }

    /**
     * Displays contact page.
     *
     * @return Response|string
     */
    public function actionContact()
    {
        $model = new ContactForm();
        if ($model->load(Yii::$app->request->post()) && $model->contact(Yii::$app->params['adminEmail'])) {
            Yii::$app->session->setFlash('contactFormSubmitted');

            return $this->refresh();
        }
        return $this->render('contact', [
            'model' => $model,
        ]);
    }

    /**
     * Displays about page.
     *
     * @return string
     */
    public function actionAbout()
    {
        return $this->render('about');
    }
}
