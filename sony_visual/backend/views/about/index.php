<?php

use common\models\About;
use kartik\dynagrid\DynaGrid;
use yii\helpers\Html;
use yii\helpers\Url;
use yii\grid\ActionColumn;
use yii\grid\GridView;

/** @var yii\web\View $this */
/** @var common\models\AboutSearch $searchModel */
/** @var yii\data\ActiveDataProvider $dataProvider */

$this->title = 'About';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="about-index">

    <?php // echo $this->render('_search', ['model' => $searchModel]); ?>

    <?php
    $columns = [
//        ['class' => 'yii\grid\SerialColumn'],

        'id',
        'description:ntext',
        [
            'class' => ActionColumn::className(),
            'urlCreator' => function ($action, About $model, $key, $index, $column) {
                return Url::toRoute([$action, 'id' => $model->id]);
            }
        ],
    ];

    $dynagrid = DynaGrid::begin([
        'columns' => $columns,
        'theme' => 'panel-secondary',
        'showPersonalize' => true,
        'showFilter' => false,
        'allowFilterSetting' => false,
        'allowSortSetting' => false,
        'showSort' => false,
        'storage' => 'cookie',
        'gridOptions' => [
            'dataProvider' => $dataProvider,
            'filterModel' => $searchModel,
            'showPageSummary' => false,
            'responsive' => true,
            'floatHeader' => true,
            'pjax' => false,
            'panel' => [
                'heading' => '<h3 class="panel-title"><i class="fa fa-globe" aria-hidden="true"></i> '.$this->title.' </h3>',
                'before' => Html::a('<i class="fa fa-plus" aria-hidden="true"></i> ' . Yii::t('app', 'Create'), ['create'],
                    ['class' => 'btn btn-success']),
                'showFooter' => false,
            ],
            'toolbar' => [
                Html::a('<i class="fa fa-repeat" aria-hidden="true"></i> '.Yii::t('app', 'Reset Grid'), ['index'], ['class' => 'btn btn-info pull-right']),
            ],
        ],
        'options' => ['id' => 'user-grid'], // a unique identifier is important
    ]);
    DynaGrid::end();

  ?>


</div>
