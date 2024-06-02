<?php

/** @var yii\web\View $this */
/** @var yii\bootstrap4\ActiveForm $form */
/** @var \common\models\LoginForm $model */

use yii\bootstrap4\ActiveForm;
use yii\bootstrap4\Html;

$this->title = 'SonyVisual';
?>

<style>
    .center-content{
        text-align: center !important;
    }
</style>
<div class="site-login">
    <div class="mt-5 offset-lg-3 col-lg-6">
        <div class="row justify-content-center align-items-center">
            <img src="/images/logo.png" style="width: 16%; border-radius: 4px;">
        </div>

        <h1 class="center-content"><?= Html::encode($this->title) ?></h1>
        <br>
        <br>
        <br>
<!--        <p class="center-content">Please fill out the following fields to login:</p>-->

        <?php $form = ActiveForm::begin(['id' => 'login-form']); ?>

            <?= $form->field($model, 'email')->textInput(['autofocus' => true])->label('Phone | Email') ?>

            <?= $form->field($model, 'password')->passwordInput() ?>

            <?= $form->field($model, 'rememberMe')->checkbox() ?>

            <div class="form-group">
                <?= Html::submitButton('Login', ['class' => 'btn btn-secondary btn-block', 'name' => 'login-button']) ?>
            </div>

        <?php ActiveForm::end(); ?>
    </div>
</div>
