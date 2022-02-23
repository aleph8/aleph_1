<?php

namespace app\models;

use Yii;
use yii\base\Model;

/**
 *
 *  Registro del usuario : @Al3ph8 
 *
 */
class RegisterForm extends Model
{   
    // Variables rellenadas por el usuario en el frontend; son volcadas al modelo mediante el controlador 'site' que recibe la 
    // petición con los parámetros por el frontend

    public $email;
    public $username;
    public $password;
    public $especialist;
    public $web;
    public $user = null;



    private $_user = false;


    /**
     * @return array the validation rules.
     */
    public function rules()
    {
        return [
            // username and password are both required
            [['username', 'password','email','especialist','web'], 'required'],
        ];
    }

    /**
     * El método validate comprueba que los datos cumplan las normas de validación.
     * 
     *  Posteriormente ,gracias a Active Record, creamos un objeto que nos permita manipular la base de datos sin necesidad de consultas SQL
     *  (es bastante cómodo trabajar con la base de datos desde el framework directamente).
     * 
     *  Volcamos los datos recibidos. La contraseña la almacenamos encriptada mediante el método 'generatePasswordHash'
     *  Una vez heco esto, guardamos el usuario en la base de datos y devolvemos si se ha podido realizar la acción o no.
     */
    public function signup()
    {
        if ($this->validate()) {

                $_user = new User();
                $_user->username = $this->username;
                $_user->email = $this->email;
                $_user->especialist = $this->especialist;
                $_user->web = $this->web;
    
                $_user->created_at = time();
                $_user->updated_at = time();
                $_user->status = 10;
                $_user->admin = 'N';
                $_user->password_hash = Yii::$app->security->generatePasswordHash($this->password);
                $_user->auth_key = Yii::$app->security->generateRandomString();
    
                $this->user = $_user;
                
                $_user->save();

                return true;
            
        }
        return false;
    }

}