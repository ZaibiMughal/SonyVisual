<?php

namespace common\models;

use common\models\PaymentType;
use Yii;
use yii\base\Model;
use common\models\User;

/**
 * Signup form
 *
 */
class ChangePasswordForm extends Model
{
    public $password;
    public $new_password;
    public $confirm_password;

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['password','new_password','confirm_password'], 'trim'],
            [['password','new_password','confirm_password'], 'required'],
            ['confirm_password', 'compare', 'compareAttribute' => 'new_password'],
            [['new_password','confirm_password'], 'string', 'min' => Yii::$app->params['user.passwordMinLength']],
        ];
    }

    public function attributeLabels()
    {
        return [
            'password' => 'Current Password',
        ];
    }


    /**
     * Signs user up.
     *
     * @return bool whether the creating new account was successful and email was sent
     */
    public function changePassword(User &$user)
    {
        if (!$this->validate()) {
            \Yii::$app->session->setFlash('alert_error', $this->getErrorSummary(true));
            return null;
        }
        if(!$user->validatePassword($this->password)){
            \Yii::$app->session->setFlash('alert_error', ["Current password is wrong!"]);
            return null;
        }
        $user->password = $this->new_password;
        $user->setPassword($this->new_password);
        if(!$user->validate()){
            \Yii::$app->session->setFlash('alert_error', $user->getErrorSummary(true));
            return null;
        }
        return $user->save();
    }
}
