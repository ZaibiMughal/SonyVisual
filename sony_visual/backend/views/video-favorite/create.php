<?php

use yii\helpers\Html;

/** @var yii\web\View $this */
/** @var common\models\VideoFavorite $model */

$this->title = 'Create Video Favorite';
$this->params['breadcrumbs'][] = ['label' => 'Video Favorites', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="video-favorite-create">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
