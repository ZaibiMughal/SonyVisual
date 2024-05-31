<?php

use kartik\select2\Select2;
use yii\bootstrap\Modal;
use yii\helpers\Html;
use yii\bootstrap\ActiveForm;
use kartik\widgets\DatePicker;


$formModel = new common\models\ReportAuth();

?>

<style>
    .help-block-error{
        color: red;
        text-align: left;
    }
</style>
    <div class="auth-form" style="text-align: left">

        <?php $form = ActiveForm::begin([
            'action' => '/site/add-report-auth',
            'fieldConfig' => [
                'template' => "{input}\n{hint}\n{error}",
            ],
        ]); ?>

        <div class="row justify-content-center align-items-center" style="text-align: center">
            <div class="col-md-6">
                <h1><strong>User Authentication</strong></h1>
                <br>
                <h5>Create Password</h5>

                <?= $form->field($formModel, 'user_id')->hiddenInput(['value' => Yii::$app->user->id])->label(false) ?>
                <?= $form->field($formModel, 'password')->passwordInput(['maxlength' => 255, 'placeholder' => 'Password']) ?>
                <?= $form->field($formModel, 'confirm_password')->passwordInput(['maxlength' => 255, 'placeholder' => 'Confirm Password']) ?>
            </div>
            <div class="col-md-12">
                <div class="form-group">
                    <?= Html::submitButton(Yii::t('app', 'Save'), ['class' => 'btn btn-success', 'style' => 'width: 10%']) ?>
                </div>
            </div>
        </div>
    </div>
<?php ActiveForm::end(); ?>
