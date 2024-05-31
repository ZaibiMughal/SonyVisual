<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model common\models\UserType */

$this->title = 'Update User Type: ' . $model->name;
$this->params['breadcrumbs'][] = ['label' => 'User Types', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->name, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Update';
?>
<div class="user-type-update">

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
