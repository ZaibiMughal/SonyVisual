<?php

use dosamigos\tinymce\TinyMce;
use yii\helpers\Html;
use kartik\form\ActiveForm;

/** @var yii\web\View $this */
/** @var common\models\About $model */
/** @var yii\widgets\ActiveForm $form */
?>
<div class="card border-secondary">
    <div class="card-header bg-secondary text-white">
        <h3 class="panel-title"><i class="fa fa-globe" aria-hidden="true"></i> <?= $this->title?></h3>
    </div>
    <div class="card-body">
<div class="about-form">

    <?php $form = ActiveForm::begin(); ?>

    <?= $form->field($model, 'description')->widget(TinyMce::className(), [
        'options' => ['rows' => 6],
        'language' => 'en',
        'clientOptions' => [
            'plugins' => [
//                "advlist autolink lists link charmap print preview anchor",
//                "searchreplace visualblocks code fullscreen",
//                "insertdatetime media table contextmenu paste"
            ],
//            'toolbar' => "undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | link image | bullist numlist outdent indent"
        ]
    ]);?>

<!--    <?//= $form->field($model, 'description')->textarea(['rows' => 6]) ?>-->

    <div class="form-group">
        <?= Html::submitButton('Save', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
    </div>
</div>