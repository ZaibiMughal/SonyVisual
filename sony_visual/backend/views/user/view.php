<?php

use common\models\User;
use yii\helpers\Html;
use yii\widgets\DetailView;

/* @var $this yii\web\View */
/* @var $model common\models\User */

$this->title = $model->getName();
$this->params['breadcrumbs'][] = ['label' => 'Users', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
\yii\web\YiiAsset::register($this);
?>
<div class="card border-secondary">
    <div class="card-header bg-secondary text-white">
        <h3 class="panel-title"><i class="fa fa-globe" aria-hidden="true"></i> <?= $this->title?></h3>
    </div>
    <div class="card-body">
<div class="user-view">
    <?php if(Yii::$app->user->getIdentity()->isSuperAdmin()){ ?>
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
            [
                'attribute' => 'full_name',
                'value' => function($model){
                    return $model->getName();
                },
            ],
            'email:email',
//            'cell_phone',
            [
                    'attribute' => 'status',
                    'value' => function($model){
                        return $model->getStatus();
                    },
            ],
            'created_at:datetime',
            'updated_at:datetime',
            [
                'attribute' => 'user_type',
                'value' => function(User $model){
                    return $model->getUserTypeName();
                },
            ],
//            [
//                'attribute' => 'updated_by',
//                'value' => function(User $model){
//                    return $model->getLastUpdatedBy();
//                },
//            ]
        ],
    ]) ?>

</div>
    </div>
</div>
