<?php

use common\models\Posts;
use common\models\User;
use kartik\dynagrid\DynaGrid;
use kartik\grid\ActionColumn;
use kartik\grid\GridView;
use kartik\select2\Select2;
use kartik\widgets\DatePicker;
use yii\helpers\ArrayHelper;
use yii\helpers\Html;
use yii\helpers\Url;
use yii\widgets\Pjax;
/* @var $this yii\web\View */
/* @var $searchModel common\models\UserSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Users';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="user-index">

    <?php // echo $this->render('_search', ['model' => $searchModel]); ?>


    <?php

    $columns = [
//            ['class' => 'yii\grid\SerialColumn'],

//        'id',
        [
            'attribute' => 'full_name',
            'value' => function(User $model){
                return $model->getName();
            },
        ],
        'email:email',
//        'cell_phone',
        [
            'attribute' => 'status',
            'value' => function(User $model){
                return $model->getStatus();
            },
            'format' => 'raw',
            'filter' => (new User())->getStatusArray(),
        ],
        [
            'attribute' => 'created_at',
            'value' => function(User $model){
                return $model->getFormattedDate();
            },
            'format' => 'raw',
            'filter' => DatePicker::widget([
                'attribute' => 'created_at',
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
//        [
//            'attribute' => 'updated_at',
//            'value' => function(User $model){
//                return $model->getFormattedUpdatedDate();
//            },
//            'format' => 'raw',
//            'filter' => DatePicker::widget([
//                'attribute' => 'updated_at',
//                'model' => $searchModel,
//                'removeButton' => false,
//                'pickerButton' => false,
//                'type' => DatePicker::TYPE_INPUT,
//                'pluginOptions' => [
//                    'autoclose' => true,
//                    'format' => 'dd-M-yyyy',
//                    'todayHighlight' => true
//                ]
//            ])
//        ],
//        [
//            'attribute' => 'updated_by',
//            'value' => function(User $model){
//                return $model->getLastUpdatedBy();
//            },
//            'format' => 'raw',
//            'filter' => Select2::widget([
//                'model' => $searchModel,
//                'attribute' => 'updated_by',
//                'data' => \common\models\User::getUserArray(true),
//                'options' => ['placeholder' => 'Select Updated By'],
//                'pluginOptions' => [
//                    'allowClear' => true
//                ],
//            ])
//        ],
        [
            'attribute' => 'user_type',
            'value' => function(User $model){
                return $model->getUserTypeName();
            },
            'format' => 'raw',
            'filter' => \common\models\UserType::getUserTypeArray(false)
        ],
        //'verification_token',
        [
            'class' => ActionColumn::className(),
            'template' => Yii::$app->user->identity->getGridRights(true),
            'urlCreator' => function ($action, User $model, $key, $index, $column) {
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
                'before' => Yii::$app->user->identity->isMasterUser() ? Html::a('<i class="fa fa-plus" aria-hidden="true"></i> ' . Yii::t('app', 'Create'), ['create'],
                    ['class' => 'btn btn-success']) : '',
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
