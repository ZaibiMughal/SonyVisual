<?php

use yii\helpers\Html;
use yii\widgets\DetailView;

/* @var $this yii\web\View */
/* @var $model common\models\UserType */

$this->title = $model->name;
$this->params['breadcrumbs'][] = ['label' => 'User Types', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
\yii\web\YiiAsset::register($this);
?>
<div class="card border-secondary">
    <div class="card-header bg-secondary text-white">
        <h3 class="panel-title"><i class="fa fa-globe" aria-hidden="true"></i> <?= $this->title?></h3>
    </div>
    <div class="card-body">
<div class="user-type-view">
    <?php if(\common\models\UserType::isSuperAdmin($model->id) || false) { ?>
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
    <?php } ?>


    <?= DetailView::widget([
        'model' => $model,
        'attributes' => [
            'id',
            'name',
            'created:datetime',
        ],
    ]) ?>

</div>
    </div>
</div>
