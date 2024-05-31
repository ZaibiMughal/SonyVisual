<?php

use common\models\UserType;
use kartik\date\DatePicker;
use kartik\dynagrid\DynaGrid;
use kartik\grid\ActionColumn;
use yii\helpers\Html;
use yii\helpers\Url;

/* @var $this yii\web\View */
/* @var $searchModel common\models\UserTypeSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'User Types';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="user-type-index">

    <?php // echo $this->render('_search', ['model' => $searchModel]); ?>
    <?php

    $columns = [
        'name',
        [
            'attribute' => 'created',
            'value' => function(UserType $model){
                return $model->getFormattedDate();
            },
            'format' => 'raw',
            'filter' => DatePicker::widget([
                'attribute' => 'created',
                'model' => $searchModel,
                'removeButton' => false,
                'pickerButton' => false,
                'type' => DatePicker::TYPE_INPUT,
                'pluginOptions' => [
                    'autoclose' => true,
                    'format' => 'dd-M-yyyy',
                    'todayHighlight' => true
                ]
            ])
        ],
        [
            'class' => ActionColumn::className(),
            'template' => '{view}',
            'urlCreator' => function ($action, UserType $model, $key, $index, $column) {
                return Url::toRoute([$action, 'id' => $model->id]);
            }
        ],
    ];

    DynaGrid::begin([
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
//                'before' => Html::a('<i class="fa fa-plus" aria-hidden="true"></i> ' . Yii::t('app', 'Create'), ['create'],
//                    ['class' => 'btn btn-success']),
                'showFooter' => false,
            ],
            'toolbar' => [
                Html::a('<i class="fa fa-repeat" aria-hidden="true"></i> '.Yii::t('app', 'Reset Grid'), ['index'], ['class' => 'btn btn-info pull-right']),
            ],
        ],
        'options' => ['id' => 'user-type-grid'], // a unique identifier is important
    ]);
    DynaGrid::end();

    ?>


</div>
