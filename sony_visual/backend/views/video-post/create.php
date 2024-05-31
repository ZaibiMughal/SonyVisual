<?php

use yii\helpers\Html;

/** @var yii\web\View $this */
/** @var common\models\VideoPost $model */

$this->title = 'Create Video Post';
$this->params['breadcrumbs'][] = ['label' => 'Video Posts', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="video-post-create">

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
