<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model common\models\Backup */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="backup-form">

    <?php $form = ActiveForm::begin(); ?>

    <?= $form->field($model, 'backup_name')->textInput() ?>

    <?= $form->field($model, 'backup_done_on')->textInput() ?>

    <div class="form-group">
        <?= Html::submitButton('Save', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
