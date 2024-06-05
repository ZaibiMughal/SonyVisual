<?php

use yii\helpers\Html;

/** @var yii\web\View $this */
/** @var common\models\VideoFavorite $model */

$this->title = 'Update Video Favorite: ' . $model->id;
$this->params['breadcrumbs'][] = ['label' => 'Video Favorites', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->id, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Update';
?>
<div class="video-favorite-update">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
