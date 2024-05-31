<?php

namespace frontend\models;

use common\models\PaymentType;
use Yii;
use yii\base\Model;
use common\models\User;

/**
 * Signup form
 */
class SignupForm extends Model
{
    public $first_name;
    public $last_name;
    public $email;
    public $cell_phone;
    public $password;
    public $user_type;


    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['first_name','last_name'], 'trim'],
            [['first_name','last_name'], 'required'],
            ['cell_phone', 'unique', 'targetClass' => User::class, 'message' => 'This cell phone has already been taken.'],
            [['first_name','last_name'], 'string', 'min' => 2, 'max' => 255],
            [['email'], 'trim'],
            [['email','cell_phone','user_type'], 'required'],
            ['email', 'email'],
            [['cell_phone','user_type'],'integer'],
            ['email', 'string', 'max' => 255],
            ['email', 'unique', 'targetClass' => User::class, 'message' => 'This email address has already been taken.'],

            ['password', 'required'],
            ['password', 'string', 'min' => Yii::$app->params['user.passwordMinLength']],
        ];
    }

    /**
     * Signs user up.
     *
     * @return bool whether the creating new account was successful and email was sent
     */
    public function signup()
    {
        if (!$this->validate()) {
            return null;
        }

        $user = new User();
        $user->first_name = $this->first_name;
        $user->last_name = $this->last_name;
        $user->email = $this->email;
        $user->cell_phone = $this->cell_phone;
        $user->updated_at = time();
        $user->updated_by = 1;
        $user->setPassword($this->password);
        $user->generateAuthKey();
        $user->generateEmailVerificationToken();

        if($user->validate()){
            return $user->save() && $this->sendEmail($user);
        } else {
            echo '<pre>';
            print_r($user->errors);
            exit;
        }

        return $user->save() && $this->sendEmail($user);
    }

    /**
     * Sends confirmation email to user
     * @param User $user user model to with email should be send
     * @return bool whether the email was sent
     */
    protected function sendEmail($user)
    {
        return true;
        return Yii::$app
            ->mailer
            ->compose(
                ['html' => 'emailVerify-html', 'text' => 'emailVerify-text'],
                ['user' => $user]
            )
            ->setFrom([Yii::$app->params['supportEmail'] => Yii::$app->name . ' robot'])
            ->setTo($this->email)
            ->setSubject('Account registration at ' . Yii::$app->name)
            ->send();
    }
}
