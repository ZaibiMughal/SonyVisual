<?php

use yii\helpers\Html;

/** @var yii\web\View $this */
/** @var common\models\VideoPost $model */

$this->title = 'Update Video Post: ' . $model->title;
$this->params['breadcrumbs'][] = ['label' => 'Video Posts', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->title, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Update';
?>
<div class="video-post-update">

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
