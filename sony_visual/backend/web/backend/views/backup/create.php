<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model common\models\Backup */

$this->title = 'Create Backup';
$this->params['breadcrumbs'][] = ['label' => 'Backups', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="backup-create">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
