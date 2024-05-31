<?php

/** @var yii\web\View $this */
/** @var yii\bootstrap4\ActiveForm $form */
/** @var \frontend\models\SignupForm $model */

use kartik\form\ActiveForm;
use kartik\select2\Select2;
use yii\bootstrap4\Html;

$this->title = 'Signup';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="site-signup">
    <h1><?= Html::encode($this->title) ?></h1>

    <p>Please fill out the following fields to signup:</p>

    <div class="row">
        <div class="col-lg-5">
            <?php $form = ActiveForm::begin(['id' => 'form-signup']); ?>

                <?= $form->field($model, 'first_name')->textInput(['autofocus' => true]) ?>

                <?= $form->field($model, 'last_name')->textInput() ?>

                <?= $form->field($model, 'email') ?>

                <?= $form->field($model, 'cell_phone') ?>

                <?= $form->field($model, 'password')->passwordInput() ?>

                <?= $form->field($model, 'user_type')->dropDownList(\common\models\UserType::getUserTypeArray(false)) ?>

                <div class="form-group">
                    <?= Html::submitButton('Signup', ['class' => 'btn btn-primary', 'name' => 'signup-button']) ?>
                </div>

            <?php ActiveForm::end(); ?>
        </div>
    </div>
</div>
