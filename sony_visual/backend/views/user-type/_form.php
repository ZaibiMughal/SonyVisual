<?php

use kartik\widgets\ActiveForm;
use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model common\models\UserType */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="card border-secondary">
    <div class="card-header bg-secondary text-white">
        <h3 class="panel-title"><i class="fa fa-globe" aria-hidden="true"></i> <?= $this->title?></h3>
    </div>
    <div class="card-body">
<div class="user-type-form">

    <?php $form = ActiveForm::begin(); ?>

    <?= $form->field($model, 'name')->textInput(['maxlength' => true]) ?>

    <div class="form-group">
        <?= Html::submitButton('Save', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
    </div></div>
