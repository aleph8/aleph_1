<?php
/**
 * @link http://www.yiiframework.com/
 * @copyright Copyright (c) 2008 Yii Software LLC
 * @license http://www.yiiframework.com/license/
 */

namespace app\commands;

use app\models\User;
use yii\console\Controller;
use yii\helpers\Console;

class HelloController extends Controller
{
    /**
     * Creamos un usuario administrador apoyándonos en el acceso a consola;
     * usado para gestionar mediante comandos el acceso de administrador y usuario común
     */
    public function actionAdd($u,$p,$es,$em,$w)
    {   
        $_user = new User();
        $_user->username = $u;
        $_user->email = $em;
        $_user->especialist = $es;
        $_user->web = $w;

        $_user->created_at = time();
        $_user->updated_at = time();
        $_user->status = 10;
        $_user->admin = 'S';
        $_user->password_hash = Yii::$app->security->generatePasswordHash($p);
        $_user->auth_key = Yii::$app->security->generateRandomString();

        $_user -> save();
    }
}
