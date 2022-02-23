<?php

namespace app\models;

class User extends \yii\db\ActiveRecord implements \yii\web\IdentityInterface
{

    //Con fines de gestión (Active Record) implementamos un método que nos devuelva el nombre de la tabla
    // a la que estamos accediendo.

    public static function tableName()
    {
        return '{{%user}}';
    }


    /**
     * Devuelve un objeto si encuentra al usuario en la base de datos; en el caso contario devuelve nada
     */
    public static function findIdentity($id)
    {
        return self::findOne($id);
    }

    public function getAuthKey()
    {
        return null;
    }

    /**
     * Igual que el anterior pero con la llave de autenticación
     */
    public static function findIdentityByAccessToken($token, $type = null)
    {
        return self::find()->andWhere(['auth_key' => $token])->one();
    }


    /**
     * Igual que el anterior pero con el email
     */
    public static function findByEmail($email)
    {
        return self::find()->andWhere(['email' => $email])->one();
    }

    public function validateAuthKey($authKey)
    {
        return false;
    }

    /**
     * Igual que el anterior pero con el nombre
     */
    public static function findByUsername($username)
    {
        return self::find()->andWhere(['username' => $username])->one();
    }

    /**
     * {@inheritdoc}
     */
    public function getId()
    {
        return $this->id;
    }


    /**
     * Comprueba la igualdad entre la contraseña insertada y el hash almacenado en la base de datos
     */
    public function validatePassword($password)
    {
        return \Yii::$app->security->validatePassword($password, $this->password_hash);
    }
}
