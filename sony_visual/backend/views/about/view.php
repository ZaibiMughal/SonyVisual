<?php

use yii\helpers\Html;
use yii\widgets\DetailView;

/** @var yii\web\View $this */
/** @var common\models\About $model */

$this->title = $model->id;
$this->params['breadcrumbs'][] = ['label' => 'About', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
\yii\web\YiiAsset::register($this);
?>
<div class="card border-secondary">
    <div class="card-header bg-secondary text-white">
        <h3 class="panel-title"><i class="fa fa-globe" aria-hidden="true"></i> <?= $this->title?></h3>
    </div>
    <div class="card-body">
<div class="about-view">

    <p>
        <?= Html::a('Update', ['update', 'id' => $model->id], ['class' => 'btn btn-primary']) ?>
        <?= Html::a('Delete', ['delete', 'id' => $model->id], [
            'class' => 'btn btn-danger',
            'data' => [
                'confirm' => 'Are you sure you want to delete this item?',
                'method' => 'post',
            ],
        ]) ?>
    </p>

    <?= DetailView::widget([
        'model' => $model,
        'attributes' => [
            'id',
            'description:html',
        ],
    ]) ?>

</div>
    </div>
</div>
