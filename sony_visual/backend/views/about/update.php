<?php

use yii\helpers\Html;

/** @var yii\web\View $this */
/** @var common\models\About $model */

$this->title = 'Update About: ' . $model->id;
$this->params['breadcrumbs'][] = ['label' => 'Abouts', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->id, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Update';
?>
<div class="about-update">

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
